/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    (5, 'Charmander', '2020-02-08', 0, False, -11),
    (6, 'Plantmon', '2021-11-15', 2, True, -5.7),
    (7, 'Squirtle', '1993-04-02', 3, False, -12.13),
    (8, 'Angemon', '2005-06-12', 1, True, -45),
    (9, 'Boarmon', '2005-06-07', 7, True, 20.4),
    (10, 'Blossom', '1998-10-13', 3, True, 17),
    (11,'Ditto', '2022-05-14', 4, True, 22);


-- Insert data into owners table
INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into species table
INSERT INTO species (name) VALUES
  ('Pokemon'),
  ('Digimon');

-- Update animals with species_id based on name
UPDATE animals
SET species_id = (CASE WHEN name ILIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon') END);

-- Update animals with owner_id based on owner's full_name
UPDATE animals
SET owner_id = (CASE WHEN owner_id IS NULL THEN
(SELECT id FROM owners WHERE full_name = 'Sam Smith')
ELSE owner_id END)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');
