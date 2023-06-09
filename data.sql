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


INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id)
VALUES
  (1, 1), -- William Tatcher specializes in Pokemon
  (3, 1), -- Stephanie Mendez specializes in Pokemon
  (3, 2), -- Stephanie Mendez specializes in Digimon
  (4, 2); -- Jack Harkness specializes in Digimon

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
  (1, 1, '2020-05-24'), -- Agumon visited William Tatcher
  (1, 3, '2020-07-22'), -- Agumon visited Stephanie Mendez
  (2, 4, '2021-02-02'), -- Gabumon visited Jack Harkness
  (3, 2, '2020-01-05'), -- Pikachu visited Maisy Smith
  (3, 2, '2020-03-08'), -- Pikachu visited Maisy Smith
  (3, 2, '2020-05-14'), -- Pikachu visited Maisy Smith
  (4, 3, '2021-05-04'), -- Devimon visited Stephanie Mendez
  (5, 4, '2021-02-24'), -- Charmander visited Jack Harkness
  (6, 2, '2019-12-21'), -- Plantmon visited Maisy Smith
  (6, 1, '2020-08-10'), -- Plantmon visited William Tatcher
  (6, 2, '2021-04-07'), -- Plantmon visited Maisy Smith
  (7, 3, '2019-09-29'), -- Squirtle visited Stephanie Mendez
  (8, 4, '2020-10-03'), -- Angemon visited Jack Harkness
  (8, 4, '2020-11-04'), -- Angemon visited Jack Harkness
  (9, 2, '2019-01-24'), -- Boarmon visited Maisy Smith
  (9, 2, '2019-05-15'), -- Boarmon visited Maisy Smith
  (9, 2, '2020-02-27'), -- Boarmon visited Maisy Smith
  (9, 2, '2020-08-03'), -- Boarmon visited Maisy Smith
  (10, 3, '2020-05-24'), -- Blossom visited Stephanie Mendez
  (10, 1, '2021-01-11'); -- Blossom visited William Tatcher