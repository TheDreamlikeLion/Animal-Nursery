USE Humans_Friends;

CREATE TABLE cats (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE dogs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE hamsters (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE horses (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE camels (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE donkeys (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

INSERT INTO cats (animal_name,commands, date_of_birth) VALUES 
	('vasya', 'meow', '2021-02-01'),
	('kolya', 'meow, stand', '2019-12-12'),
    ('garfild', 'meow, sit', '2020-01-02'),
    ('musya', 'meow', '2023-03-03'),
    ('dusya', 'meow', '2018-06-06');
   
INSERT INTO dogs (animal_name,commands, date_of_birth) VALUES 
	('lessy', 'sit, stand, voice', '2021-02-01'),
	('garik', 'sit', '2019-12-12'),
    ('pushok', 'give hand', '2020-01-02'),
    ('astra', 'get ball', '2023-03-03'),
    ('tankist', 'voice', '2018-06-06');
    
INSERT INTO hamsters (animal_name,commands, date_of_birth) VALUES 
	('ham1', 'sit', '2021-02-01'),
	('ham2', 'sit, voice', '2019-12-12'),
    ('deadham', 'stand', '2020-01-02'),
    ('deadpool', 'sit', '2023-03-03'),
    ('svin', 'sleep', '2018-06-06');
    
INSERT INTO horses (animal_name,commands, date_of_birth) VALUES 
	('zorro', 'galop', '2021-02-01'),
	('pegas', 'apport', '2019-12-12'),
    ('konik', 'voice', '2020-01-02'),
    ('butsefal', 'die', '2023-03-03'),
    ('last', 'sleep', '2018-06-06');
    
INSERT INTO camels (animal_name,commands, date_of_birth) VALUES 
	('cam', 'go', '2021-02-01'),
	('came', 'stop', '2019-12-12'),
    ('lemac', 'die', '2020-01-02'),
    ('sleepy', 'sleep', '2023-03-03'),
    ('fast', 'gogogo', '2018-06-06');
    
INSERT INTO donkeys (animal_name,commands, date_of_birth) VALUES 
	('don', 'eat', '2021-02-01'),
	('key', 'go', '2019-12-12'),
    ('horn', 'sleep', '2020-01-02'),
    ('donk', 'die', '2023-03-03'),
    ('bull', 'eeeaaa', '2018-06-06');
    
TRUNCATE camels;

INSERT INTO horses (animal_name, commands, date_of_birth)
SELECT animal_name, commands, date_of_birth
FROM donkeys;

DROP TABLE donkeys;

RENAME TABLE horses TO horses_donkeys;

CREATE TABLE young_animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE,
    age TEXT
);


DELIMITER $$
CREATE FUNCTION age_animal (date_b DATE)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE res TEXT DEFAULT '';
	SET res = CONCAT(
            TIMESTAMPDIFF(YEAR, date_b, CURDATE()),
            ' years ',
            TIMESTAMPDIFF(MONTH, date_b, CURDATE()) % 12,
            ' month'
        );
	RETURN res;
END $$
DELIMITER ;

INSERT INTO young_animals (animal_name, commands, date_of_birth, age)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth)
FROM cats
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth)
FROM dogs
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth)
FROM hamsters
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth)
FROM horses_donkeys
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM cats
WHERE TIMESTAMPDIFF(YEAR, cat.date_of_birth, CURDATE()) IN (1, 2, 3);

DELETE FROM dogs
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3;

DELETE FROM hamsters
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3;

DELETE FROM horses_donkeys
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3;

CREATE TABLE animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE,
    age TEXT,
    animal_type ENUM('cats','dogs','hamsters', 'horses_donkeys', 'young_animals') NOT NULL
);

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth), 'cats'
FROM cats;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth), 'dogs'
FROM dogs;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth), 'hamsters'
FROM hamsters;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth), 'horses_donkeys'
FROM horses_donkeys;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, age_animal(date_of_birth), 'young_animals'
FROM young_animals;
