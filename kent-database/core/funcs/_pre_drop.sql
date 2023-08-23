/*
**  Coords
*/
DROP FUNCTION IF EXISTS kentdb.f_get_centered_coords() CASCADE;

/*
**	Clarks
*/
DROP FUNCTION IF EXISTS kentdb.f_clark_exist(uuid) CASCADE; -- id_clark

DROP FUNCTION IF EXISTS kentdb.f_get_clarks() CASCADE;
DROP FUNCTION IF EXISTS kentdb.f_get_clark(uuid) CASCADE; -- id_clark
DROP FUNCTION IF EXISTS kentdb.f_get_clark_location(uuid) CASCADE; -- id_clark
DROP FUNCTION IF EXISTS kentdb.f_get_clark_serial(uuid) CASCADE; -- id_clark
DROP FUNCTION IF EXISTS kentdb.f_get_clark_latest_status(uuid) CASCADE; -- id_clark
DROP FUNCTION IF EXISTS kentdb.f_get_clark_statuses_ids(uuid) CASCADE; -- id_clark

-- DROP FUNCTION IF EXISTS kentdb.f_create_clark(integer, numeric, numeric) CASCADE; -- id_location, nb_latitude, nb_longitude

-- DROP FUNCTION IF EXISTS kentdb.f_update_clark(uuid, integer, numeric, numeric) CASCADE; -- id_clark, id_location, nb_latitude, nb_longitude
-- DROP FUNCTION IF EXISTS kentdb.f_update_clark_location(uuid, integer) CASCADE; -- id_clark, id_location
-- DROP FUNCTION IF EXISTS kentdb.f_update_clark_latitude(uuid, numeric) CASCADE; -- id_clark, nb_latitude
-- DROP FUNCTION IF EXISTS kentdb.f_update_clark_longitude(uuid, numeric) CASCADE; -- id_clark, nb_longitude
DROP FUNCTION IF EXISTS kentdb.f_update_clark_expiration(uuid, timestamp) CASCADE; -- id_clark, ts_expiration
DROP FUNCTION IF EXISTS kentdb.f_update_clark_replacement_status(uuid) CASCADE; -- id_clark

DROP FUNCTION IF EXISTS kentdb.f_delete_clark(uuid) CASCADE; -- id_clark

/*
**	Locations
*/
DROP FUNCTION IF EXISTS kentdb.f_location_exist(integer) CASCADE; -- id_location

DROP FUNCTION IF EXISTS kentdb.f_get_locations() CASCADE;
DROP FUNCTION IF EXISTS kentdb.f_get_location(integer) CASCADE; -- id_location

-- DROP FUNCTION IF EXISTS kentdb.f_create_location(text, integer, text, text, integer, text) CASCADE; -- ll_place, nb_address_number, ll_address_street, ll_address_city, nb_address_postal, ll_address_country

-- DROP FUNCTION IF EXISTS kentdb.f_update_location(integer, text, integer, text, text, integer, text) CASCADE; -- id_location, ll_place, nb_address_number, ll_address_street, ll_address_city, nb_address_postal, ll_address_country
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_place(integer, text) CASCADE; -- id_location, ll_place
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_address_number(integer, integer) CASCADE; -- id_location, nb_address_number
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_address_street(integer, text) CASCADE; -- id_location, ll_address_street
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_address_city(integer, text) CASCADE; -- id_location, ll_address_city
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_address_postal(integer, integer) CASCADE; -- id_location, nb_address_postal
-- DROP FUNCTION IF EXISTS kentdb.f_update_location_address_country(integer, text) CASCADE; -- id_location, ll_address_country

DROP FUNCTION IF EXISTS kentdb.f_delete_location(integer) CASCADE; -- id_location

/*
**	Statuses
*/
DROP FUNCTION IF EXISTS kentdb.f_status_exist(uuid) CASCADE; -- id_status
DROP FUNCTION IF EXISTS kentdb.f_status_type_exist(integer) CASCADE; -- id_status_type

DROP FUNCTION IF EXISTS kentdb.f_get_statuses() CASCADE;
DROP FUNCTION IF EXISTS kentdb.f_get_statuses(uuid) CASCADE; -- id_clark
DROP FUNCTION IF EXISTS kentdb.f_get_status(uuid) CASCADE; -- id_status
DROP FUNCTION IF EXISTS kentdb.f_get_status_types() CASCADE;
DROP FUNCTION IF EXISTS kentdb.f_get_status_type(integer) CASCADE; -- id_status_type

DROP FUNCTION IF EXISTS kentdb.f_create_status(uuid, integer, text) CASCADE; -- id_clark, id_status_type, ll_status_details
-- DROP FUNCTION IF EXISTS kentdb.f_create_status_type(integer, text) CASCADE; -- id_status_type, ll_status_type

-- DROP FUNCTION IF EXISTS kentdb.f_update_status(uuid, uuid, integer, text) CASCADE; -- id_status, id_clark, id_status_type, ll_status_details
-- DROP FUNCTION IF EXISTS kentdb.f_update_status_clark(uuid, uuid) CASCADE; -- id_status, id_clark
-- DROP FUNCTION IF EXISTS kentdb.f_update_status_status_type(uuid, integer) CASCADE; -- id_status, id_status_type
-- DROP FUNCTION IF EXISTS kentdb.f_update_status_status_details(uuid, text) CASCADE; -- id_status, ll_status_details

-- DROP FUNCTION IF EXISTS kentdb.f_update_status_type(integer, integer, text) CASCADE; -- id_status_type, id_status_type, ll_status_type
-- DROP FUNCTION IF EXISTS kentdb.f_update_status_type_id(integer, integer) CASCADE; -- id_status_type, id_status_type
-- DROP FUNCTION IF EXISTS kentdb.f_update_status_type_ll(integer, text) CASCADE; -- id_status_type, ll_status_type

DROP FUNCTION IF EXISTS kentdb.f_delete_status(uuid) CASCADE; -- id_status
DROP FUNCTION IF EXISTS kentdb.f_delete_status_type(integer) CASCADE; -- id_status_type


/*
**  Debug
*/
DROP FUNCTION IF EXISTS kentdb.f_debug_refresh_statuses() CASCADE;
