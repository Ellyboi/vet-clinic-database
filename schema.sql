/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
USE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL,
);

-- Create owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  age INTEGER,
  date_of_graduation DATE
);

ALTER TABLE animals ADD CONSTRAINT animals_pk PRIMARY KEY (id);

CREATE TABLE specializations (
  vet_id INTEGER,
  species_id INTEGER,
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  animal_id INTEGER,
  vet_id INTEGER,
  visit_date DATE,
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);

--WEEK 2 DAY 1
--PREPARATION OF TABLES
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

DROP TABLE IF EXISTS visits;

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);

ALTER TABLE owners ALTER COLUMN age DROP NOT NULL;

--POSSIBLE SOLUTIONS FOR OPTIMIZING EXECITION TIME
CREATE INDEX visits_by_animal_id_asc ON visits(animal_id ASC);
CREATE INDEX visits_by_vet_id_asc ON visits(vet_id ASC);
CREATE INDEX owners_email_asc ON owners(email ASC);

CREATE INDEX visits_where_vet_id_1 ON visits(vet_id) WHERE vet_id = 1;
CREATE INDEX visits_where_vet_id_2 ON visits(vet_id) WHERE vet_id = 2;
CREATE INDEX visits_where_vet_id_3 ON visits(vet_id) WHERE vet_id = 3;
CREATE INDEX visits_where_vet_id_4 ON visits(vet_id) WHERE vet_id = 4;

--PARTITION SOLUTION FOR 2ND QUERY
CREATE TABLE visits_partitioned (
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY(id, vet_id)
) PARTITION BY RANGE (vet_id);

-- CREATE PARTITION TABLE
CREATE TABLE visits_partition_1 PARTITION OF visits_partitioned FOR VALUES FROM (1) TO (2);
CREATE TABLE visits_partition_2 PARTITION OF visits_partitioned FOR VALUES FROM (2) TO (3);
CREATE TABLE visits_partition_3 PARTITION OF visits_partitioned FOR VALUES FROM (3) TO (4);
CREATE TABLE visits_partition_4 PARTITION OF visits_partitioned FOR VALUES FROM (4) TO (MAXVALUE);

