/*
** lov_informations
*/
INSERT INTO kentdb.lov_informations (ll_key, ll_value)
VALUES
('sql_version', '1.0.0-stable'),
('owner', 'Raphaël H.B.'),
('product', 'Kent');



/*
** ref_locations
*/
INSERT INTO kentdb.ref_locations (ll_place, nb_address_number, ll_address_street, ll_address_city, nb_address_postal, ll_address_country)
VALUES
('École Élémentaire Eugène Varlin', 1, 'Rue de l''Église', 'Claye-Souilly', 77410, 'France'),
('Collège Les Tilleuls', 2, 'Rue des Longues Raies', 'Claye-Souilly', 77410, 'France'),
('Mairie', 1, 'Allée André Benoist', 'Claye-Souilly', 77410, 'France'),
('Gymnase Henri Loison', 44, 'Rue de Bourgogne', 'Claye-Souilly', 77410, 'France'),
('Centre Commercial', 3, 'Rue de Paris', 'Claye-Souilly', 77410, 'France'),
('Parcours Sportif', 7, 'Place du Canal', 'Claye-Souilly', 77410, 'France'),
('Boulodrome', 24, 'Allée André Benoist', 'Claye-Souilly', 77410, 'France'),
('Carrefour', 1, 'N3', 'Claye-Souilly', 77410, 'France'),
('Le mASque DE COEUR', 9, 'Hameau des Peupliers', 'Claye-Souilly', 77410, 'France'),
('Lidl', 8, 'Rue Ernest Sarron', 'Claye-Souilly', 77410, 'France'),
('Lycée Professionnel Le Champ de Claye', 71, 'Avenue Pasteur', 'Claye-Souilly', 77410, 'France'),
('Dentiste Duguet Frederic', 1, 'Rue Denis Papin', 'Claye-Souilly', 77410, 'France'),
('Aquatic Club', 1, 'Allée de la Piscine', 'Claye-Souilly', 77410, 'France'),
('BNP Paribas', 9, 'Rue Jean-Jaurès', 'Claye-Souilly', 77410, 'France'),
('Parc Buffon', 1, 'Rue du Maréchal Joffre', 'Claye-Souilly', 77410, 'France'),
('Paroisse', 16, 'Avenue Aristide Briand', 'Claye-Souilly', 77410, 'France'),
('Éduc Atouts', 2, 'Rue Eugène Varlin', 'Claye-Souilly', 77410, 'France'),
('Inspection de l''Education Nationale', 1, 'Rue des Vignes', 'Claye-Souilly', 77410, 'France'),
('Centre Administratif', 3, 'Allée André Benoist', 'Claye-Souilly', 77410, 'France');



/*
** ref_clarks
*/
INSERT INTO kentdb.ref_clarks (id_clark, id_location, nb_latitude, nb_longitude)
VALUES
('875f6eb1-271b-4080-93c5-966987577a0d', 1, 48.94510950668107, 2.690558829020307),
('dccfd740-a683-4ecb-9f35-5e464bb44f04', 2, 48.94018358030428, 2.682354605566633),
('96251b09-ffce-4601-8b39-5b29b7ae94fa', 3, 48.94608273692533, 2.6883015075460026),
('88a1cdbc-17bd-4947-92a0-07d8151b1560', 4, 48.93700447695811, 2.6780137970598714),
('2a255c51-cba1-4fb6-ab7d-1aa89821ab78', 5, 48.94739384637721, 2.66363446395677),
('a1698e8a-528d-40e7-b67c-b869dae5b7bb', 6, 48.94843268162652, 2.6899440659543643),
('41b78707-37e6-47e1-a5fa-983c760878db', 7, 48.9485165539944, 2.68710935473172),
('e87b9234-65b3-4b70-8f1a-21a8b159d352', 8, 48.947959172105215, 2.6626967272147666),
('c63a2b1e-fccb-4e87-9252-019df9380a1a', 9, 48.94227048135107, 2.6686487588742738),
('9dd42d3e-8f2c-49ce-8240-1092b3f94436', 10, 48.951992636608935, 2.6672480460531216),
('a8a378d7-68ab-42b5-965b-0a6a9a6bf352', 11, 48.937707154639284, 2.6769040728321296),
('f57d4d88-0dfe-4411-aaae-4c3f4f1e9db4', 12, 48.939832741259245, 2.6783681379526367),
('8c1232c7-bdde-42b3-8f8e-946e47eb1c7f', 13, 48.94119227678837, 2.68099424808331),
('3e1c5725-9a63-4a88-9297-cde146d5d5a7', 14, 48.94502387260695, 2.683751547688113),
('b774b9c0-6d6b-4046-976a-24b95ea8ca45', 15, 48.944646510386775, 2.6895263211494815),
('85a0c635-9d6a-46f6-8b0d-dbb64b7b7d1a', 16, 48.94499204685168, 2.6920234651234685),
('76b6e65a-72f0-45f4-a692-4fe2c99c6f4a', 17, 48.94129257631872, 2.6919461420130877),
('4c8e4efb-7e2d-421d-a9d0-438907b91805', 18, 48.93852011705078, 2.686926192480873),
('30e28870-91da-4507-b2b0-aa0e7ea5a04b', 19, 48.94653443987929, 2.6881128565295334);



/*
** lov_statuses_types
*/
INSERT INTO kentdb.lov_statuses_types (id_status_type, ll_status_type)
VALUES
(0, 'FUNCTIONAL'),
(1, 'MINOR_ERROR'),
(2, 'MAJOR_ERROR'),
(3, 'OFFLINE');



/*
** ref_statuses
*/
INSERT INTO kentdb.ref_statuses (id_clark, id_status_type, ll_status_details)
VALUES
('41b78707-37e6-47e1-a5fa-983c760878db', 0, '_Status_Commissioning_'),
('875f6eb1-271b-4080-93c5-966987577a0d', 0, '_Status_Commissioning_'),
('dccfd740-a683-4ecb-9f35-5e464bb44f04', 0, '_Status_Commissioning_'),
('96251b09-ffce-4601-8b39-5b29b7ae94fa', 0, '_Status_Commissioning_'),
('88a1cdbc-17bd-4947-92a0-07d8151b1560', 0, '_Status_Commissioning_'),
('2a255c51-cba1-4fb6-ab7d-1aa89821ab78', 0, '_Status_Commissioning_'),
('a1698e8a-528d-40e7-b67c-b869dae5b7bb', 0, '_Status_Commissioning_'),
('e87b9234-65b3-4b70-8f1a-21a8b159d352', 0, '_Status_Commissioning_'),
('c63a2b1e-fccb-4e87-9252-019df9380a1a', 0, '_Status_Commissioning_'),
('9dd42d3e-8f2c-49ce-8240-1092b3f94436', 0, '_Status_Commissioning_'),
('a8a378d7-68ab-42b5-965b-0a6a9a6bf352', 0, '_Status_Commissioning_'),
('f57d4d88-0dfe-4411-aaae-4c3f4f1e9db4', 0, '_Status_Commissioning_'),
('8c1232c7-bdde-42b3-8f8e-946e47eb1c7f', 0, '_Status_Commissioning_'),
('3e1c5725-9a63-4a88-9297-cde146d5d5a7', 0, '_Status_Commissioning_'),
('b774b9c0-6d6b-4046-976a-24b95ea8ca45', 0, '_Status_Commissioning_'),
('85a0c635-9d6a-46f6-8b0d-dbb64b7b7d1a', 0, '_Status_Commissioning_'),
('76b6e65a-72f0-45f4-a692-4fe2c99c6f4a', 0, '_Status_Commissioning_'),
('4c8e4efb-7e2d-421d-a9d0-438907b91805', 0, '_Status_Commissioning_'),
('30e28870-91da-4507-b2b0-aa0e7ea5a04b', 0, '_Status_Commissioning_');
