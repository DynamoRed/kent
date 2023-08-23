/*
**	kentdb.f_status_exist
*/
CREATE OR REPLACE FUNCTION kentdb.f_status_exist (
	p_id_status		kentdb.ref_statuses.id_status%TYPE
) RETURNS BOOLEAN AS $f_status_exist$

BEGIN
	RETURN(
		EXISTS(
			SELECT 1
				FROM kentdb.ref_statuses AS statuses
			WHERE 1=1
				AND statuses.flg_active
				AND statuses.id_status = p_id_status
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_status_exist$
LANGUAGE plpgsql;



/*
**	kentdb.f_status_type_exist
*/
CREATE OR REPLACE FUNCTION kentdb.f_status_type_exist (
	p_id_status_type		kentdb.lov_statuses_types.id_status_type%TYPE
) RETURNS BOOLEAN AS $f_status_type_exist$

BEGIN
	RETURN(
		EXISTS(
			SELECT 1
				FROM kentdb.lov_statuses_types AS statuses_types
			WHERE 1=1
				AND statuses_types.flg_active
				AND statuses_types.id_status_type = p_id_status_type
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_status_type_exist$
LANGUAGE plpgsql;
