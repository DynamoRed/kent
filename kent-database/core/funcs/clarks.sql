/*
**	kentdb.f_get_clarks
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clarks (
) RETURNS JSONB AS $f_get_clarks$
DECLARE
	v_clarks	JSONB;
BEGIN
	SELECT
		COALESCE(
			JSONB_AGG(
				(SELECT kentdb.f_get_clark(clarks.id_clark))->'data'->'clark'
			),
			JSONB_BUILD_ARRAY()
		) INTO v_clarks
	FROM kentdb.ref_clarks AS clarks
	WHERE 1=1
		AND clarks.flg_active;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'clarks'	, v_clarks
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clarks$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_clark
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_clark (
	p_id_clark	kentdb.ref_clarks.id_clark%TYPE
) RETURNS JSONB AS $f_get_clark$
DECLARE
	v_clark	JSONB;
BEGIN
	IF ((SELECT kentdb.f_clark_exist(p_id_clark)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_CLARK_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'	, p_id_clark
				)
			)
		;
	END IF;

	SELECT
		JSONB_BUILD_OBJECT(
			'id', clarks.id_clark,
			'serial', (SELECT kentdb.f_get_clark_serial(clarks.id_clark)),
			'status', (SELECT kentdb.f_get_clark_latest_status(clarks.id_clark)),
			'location', (SELECT kentdb.f_get_clark_location(clarks.id_location, clarks.nb_latitude, clarks.nb_longitude))->'data',
			'expiration', clarks.ts_expiration
		) INTO v_clark
	FROM kentdb.ref_clarks AS clarks
	WHERE 1=1
		AND clarks.flg_active
		AND clarks.id_clark = p_id_clark;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'clark'	, v_clark
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_clark$
LANGUAGE plpgsql;



/*
**  kentdb.f_update_clark_expiration
*/
CREATE OR REPLACE FUNCTION kentdb.f_update_clark_expiration (
	p_id_clark			kentdb.ref_clarks.id_clark%TYPE			,
	p_ts_expiration		kentdb.ref_clarks.ts_expiration%TYPE
) RETURNS JSONB AS $f_update_clark_expiration$
DECLARE
	v_ins		INTEGER	:= 0;
	v_upd		INTEGER	:= 0;
	v_del		INTEGER	:= 0;

	v_clark	JSONB;
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

	UPDATE kentdb.ref_clarks AS clarks SET ts_expiration = p_ts_expiration WHERE clarks.id_clark = p_id_clark;
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	SELECT kentdb.f_get_clark(p_id_clark)->'data'->'clark' INTO v_clark;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'data'  		, JSONB_BUILD_OBJECT (
				'clark'		, v_clark
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_update_clark_expiration$
LANGUAGE plpgsql;



/*
**  kentdb.f_update_clark_replacement_status
*/
CREATE OR REPLACE FUNCTION kentdb.f_update_clark_replacement_status (
	p_id_clark			kentdb.ref_statuses.id_clark%TYPE
) RETURNS JSONB AS $f_update_clark_replacement_status$
DECLARE
	v_ins		INTEGER	:= 0;
	v_upd		INTEGER	:= 0;
	v_del		INTEGER	:= 0;

	v_clark		JSONB;
	v_query		JSONB;
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

	SELECT kentdb.f_update_clark_expiration(p_id_clark, NOW()) INTO v_query;
	v_ins := v_ins + (v_query->'inserted')::integer;
	v_upd := v_upd + (v_query->'updated')::integer;
	v_del := v_del + (v_query->'deleted')::integer;

	SELECT kentdb.f_create_status(p_id_clark, 0, '_Status_Pads_Replacement_')->'data'->'status' INTO v_query;
	v_ins := v_ins + (v_query->'inserted')::integer;
	v_upd := v_upd + (v_query->'updated')::integer;
	v_del := v_del + (v_query->'deleted')::integer;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'data'  		, JSONB_BUILD_OBJECT (
				'clark'		, v_clark
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_update_clark_replacement_status$
LANGUAGE plpgsql;



/*
**	kentdb.f_delete_clark
*/
CREATE OR REPLACE FUNCTION kentdb.f_delete_clark (
	p_id_clark	kentdb.ref_clarks.id_clark%TYPE
) RETURNS JSONB AS $f_delete_clark$
DECLARE
	v_ins	INTEGER	:= 0;
	v_upd	INTEGER	:= 0;
	v_del	INTEGER	:= 0;
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

	UPDATE kentdb.ref_clarks AS clarks
	SET
		flg_active = FALSE,
		ts_updated_at = CURRENT_TIMESTAMP(1)
	WHERE  1=1
		AND clarks.flg_active
		AND clarks.id_clark = p_id_clark;
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'additional'  , JSONB_BUILD_OBJECT (
				'id'       	, p_id_clark
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_delete_clark$
LANGUAGE plpgsql;
