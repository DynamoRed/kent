/*
**	kentdb.f_location_exist
*/
CREATE OR REPLACE FUNCTION kentdb.f_location_exist (
	p_id_location		kentdb.ref_locations.id_location%TYPE
) RETURNS BOOLEAN AS $f_location_exist$

BEGIN
	RETURN(
		EXISTS(
			SELECT 1
				FROM kentdb.ref_locations AS locations
			WHERE 1=1
				AND locations.flg_active
				AND locations.id_location = p_id_location
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_location_exist$
LANGUAGE plpgsql;
