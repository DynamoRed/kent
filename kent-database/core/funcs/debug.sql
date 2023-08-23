/*
**	kentdb.f_debug_refresh_statuses
*/
CREATE OR REPLACE FUNCTION kentdb.f_debug_refresh_statuses (
) RETURNS JSONB AS $f_debug_refresh_statuses$
DECLARE
	v_upd		INTEGER	:= 0;
BEGIN
	UPDATE kentdb.ref_statuses AS statuses
	SET ts_updated_at = NOW();
	GET DIAGNOSTICS v_upd = ROW_COUNT;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'inserted'    , 0
			, 'updated'     , v_upd
			, 'deleted'     , 0
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_debug_refresh_statuses$
LANGUAGE plpgsql;
