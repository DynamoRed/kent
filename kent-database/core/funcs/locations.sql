/*
**	kentdb.f_get_locations
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_locations (
) RETURNS JSONB AS $f_get_locations$
DECLARE
	v_locations	JSONB;
BEGIN
	SELECT
		COALESCE(
			JSONB_AGG(
				(SELECT kentdb.f_get_location(locations.id_location))->'data'->'location'
			),
			JSONB_BUILD_ARRAY()
		) INTO v_locations
	FROM kentdb.ref_locations AS locations
	WHERE 1=1
		AND locations.flg_active;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'locations'	, v_locations
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_locations$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_location
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_location (
	p_id_location	kentdb.ref_locations.id_location%TYPE
) RETURNS JSONB AS $f_get_location$
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
					'id'	, p_id_location
				)
			)
		;
	END IF;

	SELECT
		JSONB_BUILD_OBJECT(
			'id', locations.id_location,
			'place', locations.ll_place,
			'address', JSONB_BUILD_OBJECT(
				'number', locations.nb_address_number,
				'street', locations.ll_address_street,
				'city', locations.ll_address_city,
				'postal', locations.nb_address_postal,
				'country', locations.ll_address_country
			)
		) INTO v_location
	FROM kentdb.ref_locations AS locations
	WHERE 1=1
		AND locations.flg_active
		AND locations.id_location = p_id_location;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'location'	, v_location
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_location$
LANGUAGE plpgsql;



/*
**	kentdb.f_delete_location
*/
CREATE OR REPLACE FUNCTION kentdb.f_delete_location (
	p_id_location	kentdb.ref_locations.id_location%TYPE
) RETURNS JSONB AS $f_delete_location$
DECLARE
	v_ins	INTEGER	:= 0;
	v_upd	INTEGER	:= 0;
	v_del	INTEGER	:= 0;
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

	UPDATE kentdb.ref_locations AS locations
	SET
		flg_active = FALSE,
		ts_updated_at = CURRENT_TIMESTAMP(1)
	WHERE  1=1
		AND locations.flg_active
		AND locations.id_location = p_id_location;
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'additional'  , JSONB_BUILD_OBJECT (
				'id'       	, p_id_location
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_delete_location$
LANGUAGE plpgsql;
