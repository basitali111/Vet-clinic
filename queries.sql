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

-- part 4 questions

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) 
FROM animals
WHERE escape_attempts != 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts) FROM animals;
-- What is the minimum and maximum weight of each type of animal?
SELECT MAX(escape_attempts)
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN 'Jan 1,1990' AND 'Dec 31,2000'
GROUP BY species;

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Wednesday queries */
SELECT name FROM animals JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT animals.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT animals.name AS animal_name, owners.full_name AS owner_name FROM owners LEFT JOIN animals ON owners.id = owner_id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT owners.full_name AS owner, animals.name AS digimon_animals FROM animals JOIN owners ON owner_id = owners.id WHERE species_id = 2 AND owners.full_name = 'Jennifer Orwell';
SELECT owners.full_name AS owner, animals.name AS non_escape_attempts FROM animals JOIN owners ON owner_id = owners.id WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
SELECT COUNT(animals.name) AS number_of_animals, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY number_of_animals DESC LIMIT 1;


SELECT animals.name AS animals_seen, vets.name AS vet, visits.visit_date AS date FROM animals JOIN visits ON animal_id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1

SELECT COUNT(DISTINCT animals.name) AS total_animals, COUNT(DISTINCT animals.species_id) AS types_seen, vets.name AS vet FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

SELECT vets.name AS vet_name, species.name FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name AS animals, vets.name As vet_name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE visit_date BETWEEN DATE '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';

SELECT animals.name, COUNT(visit_date) AS number_of_visits FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY number_of_visits DESC LIMIT 1;

SELECT animals.name AS animal, visits.visit_date AS v_date FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY visit_date ASC LIMIT 1;

SELECT animals.name AS animal, animals.date_of_birth,
animals.escape_attempts, animals.neutered, 
animals.weight_kg, species.name AS species,
owners.full_name AS owner, vets.name AS vet_name, vets.age,
vets.date_of_graduation AS grad_day,
visits.visit_date FROM animals
JOIN visits ON  animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(visits.animals_id) FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
JOIN specializations ON specializations.species_id = vets.id
WHERE specializations.species_id != animals.species_id
GROUP BY vets.name;

SELECT species.name, COUNT(animals.species_id) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.species_id) DESC
LIMIT 1;






