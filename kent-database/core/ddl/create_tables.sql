/*
** lov_informations
*/
DROP TABLE IF EXISTS kentdb.lov_informations CASCADE;
CREATE TABLE kentdb.lov_informations (
	ll_key			TEXT			NOT NULL	,
	ll_value		TEXT			NOT NULL
);

ALTER TABLE kentdb.lov_informations ADD CONSTRAINT pk_informations PRIMARY KEY ( ll_key );



/*
** ref_locations
*/
DROP TABLE IF EXISTS kentdb.ref_locations CASCADE;
CREATE TABLE kentdb.ref_locations (
	id_location			SERIAL			NOT NULL										,
	ll_place			TEXT			NOT NULL										,
	nb_address_number	INTEGER			NOT NULL										,
	ll_address_street	TEXT			NOT NULL										,
	ll_address_city		TEXT			NOT NULL										,
	nb_address_postal	INTEGER			NOT NULL	CHECK (nb_address_postal > 9999)	,
	ll_address_country	TEXT			NOT NULL										,
	ts_created_at		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP			,
	ts_updated_at		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP			,
	flg_active			BOOLEAN			NOT NULL	DEFAULT TRUE
);

ALTER TABLE kentdb.ref_locations ADD CONSTRAINT pk_location PRIMARY KEY ( id_location );



/*
** ref_clarks
*/
DROP TABLE IF EXISTS kentdb.ref_clarks CASCADE;
CREATE TABLE kentdb.ref_clarks (
    id_clark		UUID			NOT NULL	DEFAULT GEN_RANDOM_UUID()						,
	id_location		INTEGER			NOT NULL													,
	nb_latitude		NUMERIC			NOT NULL													,
	nb_longitude	NUMERIC			NOT NULL													,
	ts_expiration	TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP + INTERVAL '1 year'	,
	ts_created_at	TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP						,
	ts_updated_at	TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP						,
	flg_active		BOOLEAN			NOT NULL	DEFAULT TRUE
);

ALTER TABLE kentdb.ref_clarks ADD CONSTRAINT pk_clark PRIMARY KEY ( id_clark );
ALTER TABLE kentdb.ref_clarks ADD CONSTRAINT fk_clark_location FOREIGN KEY ( id_location ) REFERENCES kentdb.ref_locations( id_location ) ON DELETE CASCADE ON UPDATE CASCADE;



/*
** lov_statuses_types
*/
DROP TABLE IF EXISTS kentdb.lov_statuses_types CASCADE;
CREATE TABLE kentdb.lov_statuses_types (
	id_status_type		INTEGER			NOT NULL					,
	ll_status_type		TEXT			NOT NULL					,
	flg_active			BOOLEAN			NOT NULL	DEFAULT TRUE
);

ALTER TABLE kentdb.lov_statuses_types ADD CONSTRAINT pk_status_type PRIMARY KEY ( id_status_type );



/*
** ref_statuses
*/
DROP TABLE IF EXISTS kentdb.ref_statuses CASCADE;
CREATE TABLE kentdb.ref_statuses (
    id_status			UUID			NOT NULL	DEFAULT GEN_RANDOM_UUID()	,
    id_clark			UUID			NOT NULL								,
	id_status_type		INTEGER			NOT NULL								,
	ll_status_details	TEXT													,
	ts_created_at		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	,
	ts_updated_at		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	,
	flg_active			BOOLEAN			NOT NULL	DEFAULT TRUE
);

ALTER TABLE kentdb.ref_statuses ADD CONSTRAINT pk_status PRIMARY KEY ( id_status );
ALTER TABLE kentdb.ref_statuses ADD CONSTRAINT fk_status_clark FOREIGN KEY ( id_clark ) REFERENCES kentdb.ref_clarks( id_clark ) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE kentdb.ref_statuses ADD CONSTRAINT fk_status_status_type FOREIGN KEY ( id_status_type ) REFERENCES kentdb.lov_statuses_types( id_status_type ) ON DELETE CASCADE ON UPDATE CASCADE;
