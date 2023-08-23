/*
**	kentdb.f_get_centered_coords
*/
CREATE OR REPLACE FUNCTION kentdb.f_get_centered_coords (
) RETURNS JSONB AS $f_get_centered_coords$
DECLARE
	v_coords	JSONB;
BEGIN
	SELECT
		JSONB_BUILD_OBJECT('lat', ST_X(sub.center), 'lng', ST_Y(sub.center)) INTO v_coords
	FROM (
		SELECT
			ST_AsText(ST_Centroid(ST_MakeEnvelope(min_lat, min_lng, max_lat, max_lng, 4326))) AS center
		FROM (
			SELECT
				MIN(clarks.nb_latitude) AS min_lat,
				MAX(clarks.nb_latitude) AS max_lat,
				MIN(clarks.nb_longitude) AS min_lng,
				MAX(clarks.nb_longitude) AS max_lng
			FROM kentdb.ref_clarks AS clarks
		) AS bounding_box
	) AS sub;

	RETURN (
		JSONB_BUILD_OBJECT (
			'info'          , 'execok'
			, 'data'  , JSONB_BUILD_OBJECT (
				'coords'	, v_coords
			)
		)
	);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN RAISE EXCEPTION 'ERROR_NO_DATA_FOUND';
		WHEN CASE_NOT_FOUND THEN RAISE EXCEPTION 'ERROR_CASE_STATEMENT_NOT_FOUND';
		WHEN OTHERS THEN RAISE;
END;

	$f_get_centered_coords$
LANGUAGE plpgsql;
