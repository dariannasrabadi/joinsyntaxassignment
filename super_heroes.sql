-- hero table
CREATE TABLE heroes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    alias VARCHAR(200)
);

-- hero identity data
INSERT INTO heroes (name, alias) 
VALUES ('Superman', 'Clark Kent'),
('Batman', 'Bruce Wayne'),
('Professor X', 'Charles Xavier'),
('Wolverine', 'Logan'),
('Cyclops', 'Scott Summers');

-- powers table
CREATE TABLE powers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    description VARCHAR(255)
);

-- powers data
INSERT INTO powers (name, description)
VALUES 
('Flight', 'Can fly'), 
('Telekinesis', 'Can physically move things with the mind'), 
('Healing Factor', 'Heals at an accelerated rate'),
('Super Strength', 'Abnormally physically strong'),
('Super Intelligence', 'Way, way, way smarter than the average bear'),
('Telepathy', 'Can communicate mentally with another being'),
('Laser Vision', 'Emits energy beams from the eyes'),
('Super Speed', 'Faster than a speeding bullet');

-- Create junction table
CREATE TABLE heroes_powers (
    id SERIAL PRIMARY KEY,
    hero_id INT REFERENCES heroes,
    power_id INT REFERENCES powers,
    power_level INT
);

-- Now, assign powers to heroes
INSERT INTO heroes_powers (hero_id, power_id, power_level)
VALUES 
(1,1,5), (1,4,5), (1,7,1), (1,8,3),
(2,5,5), (2,4,4), (2,8,1),
(3,2,4), (3,6,5), (3,5,5),
(4,3,5), (4,4,2),
(5,4,2), (5,7,5), (5,8,1);


SELECT * FROM heroes;
SELECT * FROM powers;
SELECT * FROM heroes_powers;


--QUESTIONS & ANSWERS:


-- 1. How many powers are there?

	SELECT count(powers.id) AS "Number of Unique Powers"
	FROM powers;	

-- 2. List all heroes and their powers. It's okay that heroes appear multiple times.

	SELECT heroes.name, powers.name AS "super power"
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	ORDER BY heroes.name;

-- 3. Find all of Professor X's powers.

	SELECT heroes.name, powers.name AS "super power"
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	WHERE heroes.name = 'Professor X';

-- 4. Add a new super power. 

	INSERT INTO powers (name, description)
	VALUES ('Rich', 'Has enough money to do/research/develop anything physically/theoretically possible');

-- 5. Add this power to an existing hero.

	INSERT INTO heroes_powers (hero_id, power_id, power_level)
	VALUES (2, 9, 5);

-- 6. Which heroes have laser vision? Include their name and alias.

	SELECT heroes.name, heroes.alias, powers.name AS "super power"
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	WHERE powers.name = 'Laser Vision';
	
-- 7. How many can fly? A twist on the above...

	SELECT count(powers.name) AS "Heroes who can Fly"
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	WHERE powers.name = 'Flight';

-- 8. What is the average super strength power level?

	SELECT avg(heroes_powers.power_level) AS "Average Super Strength Level"
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	WHERE powers.name = 'Super Strength';

-- 9. Show all the information for heroes with super strength power level over 2.

	SELECT heroes.name, powers.name AS "super power", heroes_powers.power_level
	FROM heroes
	JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
	JOIN powers ON powers.id = heroes_powers.power_id
	WHERE powers.name = 'Super Strength' AND heroes_powers.power_level > 2;

-- 10. Find the average power level for all powers. Include the power name and descriptions.

	
	SELECT powers.name AS "super power", powers.description, avg(heroes_powers.power_level) AS "Average Super Strength Level"
	FROM powers
	JOIN heroes_powers ON powers.id = heroes_powers.power_id
	GROUP BY powers.name, powers.description;

