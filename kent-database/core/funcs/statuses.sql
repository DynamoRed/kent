/*
**	kentdb.f_get_statuses
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_statuses (
) RETURNS JSONB AS $f_get_statuses$
DECLARE
	v_statuses	JSONB;
BEGIN
	SELECT
		COALESCE(
			JSONB_AGG(
				(SELECT kentdb.f_get_status(statuses.id_status))->'data'->'status'
			),
			JSONB_BUILD_ARRAY()
		) INTO v_statuses
	FROM kentdb.ref_statuses AS statuses
	WHERE 1=1
		AND statuses.flg_active;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'statuses'	, v_statuses
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_statuses$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_statuses
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_statuses (
	p_id_clark	kentdb.ref_clarks.id_clark%TYPE
) RETURNS JSONB AS $f_get_statuses$
DECLARE
	v_statuses_ids UUID[];
	v_statuses	JSONB;
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

	SELECT kentdb.f_get_clark_statuses_ids(p_id_clark) INTO v_statuses_ids;

	SELECT COALESCE(
		JSONB_AGG(sub.status),
		JSONB_BUILD_ARRAY()
	) INTO v_statuses
	FROM (
		SELECT
			(SELECT kentdb.f_get_status(statuses.id_status))->'data'->'status' AS status
		FROM kentdb.ref_statuses AS statuses
		WHERE 1=1
			AND ARRAY_POSITION((SELECT kentdb.f_get_clark_statuses_ids(p_id_clark)), statuses.id_status) IS NOT NULL
			AND statuses.flg_active
		GROUP BY statuses.ts_updated_at, statuses.id_status
		ORDER BY statuses.ts_updated_at DESC
	) AS sub;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'statuses'	, v_statuses
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_statuses$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_status
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_status (
	p_id_status	kentdb.ref_statuses.id_status%TYPE
) RETURNS JSONB AS $f_get_status$
DECLARE
	v_status	JSONB;
BEGIN
	IF ((SELECT kentdb.f_status_exist(p_id_status)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_STATUS_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'	, p_id_status
				)
			)
		;
	END IF;

	SELECT
		JSONB_BUILD_OBJECT(
			'id', statuses.id_status,
			'idClark', statuses.id_clark,
			'type', statuses.id_status_type,
			'details', statuses.ll_status_details,
			'at', statuses.ts_updated_at
		) INTO v_status
	FROM kentdb.ref_statuses AS statuses
	WHERE 1=1
		AND statuses.flg_active
		AND statuses.id_status = p_id_status;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'status'	, v_status
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_status$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_status_types
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_status_types (
) RETURNS JSONB AS $f_get_status_types$
DECLARE
	v_status_types	JSONB;
BEGIN
	SELECT
		COALESCE(
			JSONB_AGG(
				(SELECT kentdb.f_get_status(status_types.id_status_type))->'data'->'statusType'
			),
			JSONB_BUILD_ARRAY()
		) INTO v_status_types
	FROM kentdb.lov_statuses_types AS status_types
	WHERE 1=1
		AND status_types.flg_active;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'statusTypes'	, v_status_types
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_status_types$
LANGUAGE plpgsql;



/*
**	kentdb.f_get_status_type
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_status_type (
	p_id_status_type	kentdb.lov_statuses_types.id_status_type%TYPE
) RETURNS JSONB AS $f_get_status_type$
DECLARE
	v_status_type	JSONB;
BEGIN
	IF ((SELECT kentdb.f_status_type_exist(p_id_status_type)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_STATUS_TYPE_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'	, p_id_status_type
				)
			)
		;
	END IF;

	SELECT
		JSONB_BUILD_OBJECT(
			'id', status_types.id_status_type,
			'label', status_types.ll_status_type
		) INTO v_status_type
	FROM kentdb.lov_statuses_types AS status_types
	WHERE 1=1
		AND status_types.flg_active
		AND status_types.id_status_type = p_id_status_type;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'statusType'	, v_status_type
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_status_type$
LANGUAGE plpgsql;



/*
**	cnrpdb.f_create_status
*/
CREATE OR REPLACE FUNCTION kentdb.f_create_status (
	p_id_clark			kentdb.ref_statuses.id_clark%TYPE			,
	p_id_status_type	kentdb.ref_statuses.id_status_type%TYPE		,
	p_ll_status_details	kentdb.ref_statuses.ll_status_details%TYPE
) RETURNS JSONB AS $f_create_status$
DECLARE
	v_ins		INTEGER	:= 0;
	v_upd		INTEGER	:= 0;
	v_del		INTEGER	:= 0;

	v_status	JSONB;
	v_id_status UUID;
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

	IF ((SELECT kentdb.f_status_type_exist(p_id_status_type)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_STATUS_TYPE_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_status_type
				)
			)
		;
	END IF;

	SELECT kentdb.f_get_clark_latest_status(p_id_clark) INTO v_status;

	IF v_status->>'details' <> p_ll_status_details THEN
		INSERT INTO kentdb.ref_statuses (id_clark, id_status_type, ll_status_details)
		VALUES (
			p_id_clark,
			p_id_status_type,
			p_ll_status_details
		) RETURNING id_status INTO v_id_status;
		GET DIAGNOSTICS v_ins = ROW_COUNT;
	ELSE
		UPDATE kentdb.ref_statuses AS statuses SET ts_updated_at = NOW() WHERE statuses.id_status = (v_status->>'id')::UUID;
		GET DIAGNOSTICS v_upd = ROW_COUNT;
		v_id_status := (v_status->>'id')::UUID;
	END IF;

	SELECT kentdb.f_get_status(v_id_status)->'data'->'status' INTO v_status;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'data'  		, JSONB_BUILD_OBJECT (
				'status'		, v_status
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_create_status$
LANGUAGE plpgsql;



/*
**	kentdb.f_delete_status
*/
CREATE OR REPLACE FUNCTION kentdb.f_delete_status (
	p_id_status	kentdb.ref_statuses.id_status%TYPE
) RETURNS JSONB AS $f_delete_status$
DECLARE
	v_ins	INTEGER	:= 0;
	v_upd	INTEGER	:= 0;
	v_del	INTEGER	:= 0;
BEGIN
	IF ((SELECT kentdb.f_status_exist(p_id_status)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_STATUS_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_status
				)
			)
		;
	END IF;

	UPDATE kentdb.ref_statuses AS statuses
	SET
		flg_active = FALSE,
		ts_updated_at = CURRENT_TIMESTAMP(1)
	WHERE  1=1
		AND statuses.flg_active
		AND statuses.id_status = p_id_status;
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'additional'  , JSONB_BUILD_OBJECT (
				'id'       	, p_id_status
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_delete_status$
LANGUAGE plpgsql;



/*
**	kentdb.f_delete_status_type
*/
CREATE OR REPLACE FUNCTION kentdb.f_delete_status_type (
	p_id_status_type	kentdb.lov_statuses_types.id_status_type%TYPE
) RETURNS JSONB AS $f_delete_status_type$
DECLARE
	v_ins	INTEGER	:= 0;
	v_upd	INTEGER	:= 0;
	v_del	INTEGER	:= 0;
BEGIN
	IF ((SELECT kentdb.f_status_type_exist(p_id_status_type)) <> TRUE) THEN
		RAISE EXCEPTION '{!}%{!}',
			JSONB_BUILD_OBJECT (
				'info'          , 'execko'
				, 'code'		, 404
				, 'error'		, 'ERROR_STATUS_TYPE_DOES_NOT_EXIST'
				, 'additional'	, JSONB_BUILD_OBJECT (
					'id'		, p_id_status_type
				)
			)
		;
	END IF;

	UPDATE kentdb.lov_statuses_types AS status_types
	SET
		flg_active = FALSE,
		ts_updated_at = CURRENT_TIMESTAMP(1)
	WHERE  1=1
		AND status_types.flg_active
		AND status_types.id_status_type = p_id_status_type;
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , v_ins
			, 'updated'     , v_upd
			, 'deleted'     , v_del
			, 'additional'  , JSONB_BUILD_OBJECT (
				'id'       	, p_id_status_type
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_delete_status_type$
LANGUAGE plpgsql;
