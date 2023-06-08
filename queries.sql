/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Starting the transaction
START TRANSACTION;

-- Updating the species column to "unspecified"
UPDATE animals SET species = 'unspecified';

-- Verifying the change
SELECT * FROM animals;

-- Rolling back the transaction
ROLLBACK;

-- Verifying that the species column went back to the state before the transaction
SELECT * FROM animals;


-- Starting the transaction
START TRANSACTION;

-- Updating the species column to "digimon" for animals whose name ends in "mon"
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Updating the species column to "pokemon" for animals without a species already set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verifying the changes
SELECT * FROM animals;

-- Committing the transaction
COMMIT;

-- Verifying that changes persist after commit
SELECT * FROM animals;

-- Starting the transaction
START TRANSACTION;

-- Deleting all records from the animals table
DELETE FROM animals;

-- Verifying the deletion
SELECT * FROM animals;

-- Rolling back the transaction
ROLLBACK;

-- Verifying if all records still exist after rollback
SELECT * FROM animals;

-- Starting the transaction
START TRANSACTION;

-- Deleting all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Creating a savepoint
SAVEPOINT my_savepoint;

-- Updating all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rolling back to the savepoint
ROLLBACK TO my_savepoint;

-- Updating all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Committing the transaction
COMMIT;


SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS non_escape_animals FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;

SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;