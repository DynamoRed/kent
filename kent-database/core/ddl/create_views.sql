/*
** v_clark_serials
*/
CREATE VIEW kentdb.v_clark_serials AS
	SELECT
		clark.id_clark AS id_clark,
		'CLA' || substring(regexp_replace(clark.id_clark::text, '[^0-9]', '', 'g'), 1, 8) AS id_clark_serial
	FROM kentdb.ref_clarks AS clark
	WHERE clark.flg_active;
