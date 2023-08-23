/*
**	kentdb.f_clark_exist
*/
CREATE OR REPLACE FUNCTION kentdb.f_clark_exist (
	p_id_clark		kentdb.ref_clarks.id_clark%TYPE
) RETURNS BOOLEAN AS $f_clark_exist$

BEGIN
	RETURN(
		EXISTS(
			SELECT 1
				FROM kentdb.ref_clarks AS clarks
			WHERE 1=1
				AND clarks.flg_active
				AND clarks.id_clark = p_id_clark
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_clark_exist$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_clark_location
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clark_location (
	p_id_location		kentdb.ref_locations.id_location%TYPE,
	p_nb_latitude		kentdb.ref_clarks.nb_latitude%TYPE,
	p_nb_longitude		kentdb.ref_clarks.nb_longitude%TYPE
) RETURNS JSONB AS $f_get_clark_location$
DECLARE
	v_location	JSONB;
BEGIN
	IF ((SELECT kentdb.f_location_exist(p_id_location)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_LOCATION_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_location
				)
			)
		;
	END IF;

	SELECT kentdb.f_get_location(p_id_location)->'data'->'location' INTO v_location;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'latitude'	, p_nb_latitude,
				'longitude'	, p_nb_longitude,
				'place'		, v_location->'place',
				'address'	, v_location->'address'
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clark_location$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_clark_serial
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clark_serial (
	p_id_clark		kentdb.ref_clarks.id_clark%TYPE
) RETURNS TEXT AS $f_get_clark_serial$
DECLARE
	v_serial	TEXT;
BEGIN
	IF ((SELECT kentdb.f_clark_exist(p_id_clark)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_CLARK_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_clark
				)
			)
		;
	END IF;

	SELECT id_clark_serial INTO v_serial FROM kentdb.v_clark_serials AS serials WHERE serials.id_clark = p_id_clark LIMIT 1;

	RETURN (v_serial);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clark_serial$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_clark_latest_status
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clark_latest_status (
	p_id_clark		kentdb.ref_clarks.id_clark%TYPE
) RETURNS JSONB AS $f_get_clark_latest_status$
DECLARE
	v_status	JSONB;
	v_status_id	UUID;
	v_diff		FLOAT;
BEGIN
	IF ((SELECT kentdb.f_clark_exist(p_id_clark)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_CLARK_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_clark
				)
			)
		;
	END IF;

	SELECT statuses.id_status INTO v_status_id
	FROM kentdb.ref_statuses AS statuses
	WHERE statuses.id_clark = p_id_clark
	ORDER BY statuses.ts_updated_at DESC LIMIT 1;


	SELECT kentdb.f_get_status(v_status_id)->'data'->'status' INTO v_status;
	SELECT EXTRACT(EPOCH FROM AGE(NOW(), TO_TIMESTAMP(v_status->>'at', 'YYYY-MM-DD[T]HH24:MI:SS.USOF'))) INTO v_diff;

	IF v_diff > 900 THEN
		SELECT JSONB_BUILD_OBJECT (
			'id', GEN_RANDOM_UUID(),
			'idClark', p_id_clark,
			'type', 3,
			'details', '_Status_Connexion_Lost_',
			'at', NOW()
		) INTO v_status;
	ELSE
		IF v_status_id IS NULL THEN
			SELECT JSONB_BUILD_OBJECT (
				'id', GEN_RANDOM_UUID(),
				'idClark', p_id_clark,
				'type', 3,
				'details', '_Status_No_History_',
				'at', NOW()
			) INTO v_status;
		END IF;
	END IF;

	RETURN (v_status);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clark_latest_status$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_clark_statuses_ids
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clark_statuses_ids (
	p_id_clark		kentdb.ref_clarks.id_clark%TYPE
) RETURNS UUID[] AS $f_get_clark_statuses_ids$
DECLARE
	v_statuses_ids	UUID[];
BEGIN
	IF ((SELECT kentdb.f_clark_exist(p_id_clark)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_CLARK_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_clark
				)
			)
		;
	END IF;

	SELECT ARRAY_AGG(sub.id_status) INTO v_statuses_ids
	FROM (
		SELECT statuses.id_status
		FROM kentdb.ref_statuses AS statuses
		WHERE statuses.id_clark = p_id_clark
		GROUP BY statuses.ts_updated_at, statuses.id_status
		ORDER BY statuses.ts_updated_at DESC
	) AS sub;

	RETURN (v_statuses_ids);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clark_statuses_ids$
LANGUAGE plpgsql;
