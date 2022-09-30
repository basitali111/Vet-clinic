/*Queries that provide answers to the questions from all projects.*/

 SELECT * FROM animals WHERE name LIKE '%mon';
 SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31';
 SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
 SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
 SELECT name, escape_attempts FROM animals WHERE weight_kg> 10.5;
 SELECT * FROM animals WHERE neutered = TRUE;
 SELECT * FROM animals WHERE name != 'Gabumon';
 SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

  -- 2nd task

-- part 1
BEGIN;
-- try rolback
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update species column to pokemon for all animals without species.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
-- Verify that change was made and persists after commit.
SELECT * FROM animals;

-- part 2
BEGIN;
DELETE FROM animals;
ROLLBACK
SELECT * FROM animals;

-- part 3
BEGIN;
DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';

SAVEPOINT deletion;

UPDATE animals 
SET weight_kg = weight_kg * -1;
ROLLBACK TO deletion;

UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;
SELECT * FROM animals;
