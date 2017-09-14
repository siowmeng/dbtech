-- Exercise 7

-- The two tables HUMANS and MARRIAGES are implemented as per the blog
-- All columns cannot be NULL except BIRTHDATE (some citizens may not have birthdate records) and DIVORCE_DATE
-- SEX must be either 'male' or 'female'
-- PARTNER_1_ID and PARTNER_2_ID are foreign keys that refer to the ID in HUMANS table
-- Final Result: The records inserted contains 1 person, Flint Stone (id = 8)

CREATE TABLE humans (
   id INTEGER PRIMARY KEY,
   forename TEXT NOT NULL,
   surname TEXT NOT NULL,
   birthdate DATE,
   sex text NOT NULL CHECK (sex IN ('male', 'female'))
);

CREATE TABLE marriages (
   id INTEGER PRIMARY KEY,
   partner_1_id INTEGER REFERENCES humans (id),
   partner_2_id INTEGER REFERENCES humans (id),
   marriage_date DATE NOT NULL,
   divorce_date DATE CHECK (divorce_date >= marriage_date),
   CHECK (partner_1_id <> partner_2_id)
);

INSERT INTO 
   humans (id, forename, surname, birthdate, sex)
VALUES
   (1, 'Adam', 'Smith', '1978-02-13', 'male'),
   (2, 'Evelyn', 'Cheng', '1981-11-02', 'female'),
   (3, 'Zoe', 'Saldana', '1989-07-29', 'female'),
   (4, 'Aaron', 'McDonald', '1990-05-01', 'male'),
   (5, 'Clint', 'Tan', '1977-12-25', 'male'),
   (6, 'Doreen', 'McCarthy', '1990-09-07', 'female'),
   (7, 'Yvonne', 'Sanders', '1971-04-21', 'female'),
   (8, 'Flint', 'Stone', '1969-06-16', 'male');

INSERT INTO
   marriages (id, partner_1_id, partner_2_id, marriage_date, divorce_date)
VALUES
   (1, 8, 7, '1990-09-09', '2010-10-10'),
   (2, 8, 1, '2010-11-11', NULL),
   (3, 3, 4, '2013-01-16', NULL),
   (4, 2, 5, '2011-07-23', NULL);

/*
id;forename;surname;birthdate;sex
1;"Adam";"Smith";"1978-02-13";"male"
2;"Evelyn";"Cheng";"1981-11-02";"female"
3;"Zoe";"Saldana";"1989-07-29";"female"
4;"Aaron";"McDonald";"1990-05-01";"male"
5;"Clint";"Tan";"1977-12-25";"male"
6;"Doreen";"McCarthy";"1990-09-07";"female"
7;"Yvonne";"Sanders";"1971-04-21";"female"
8;"Flint";"Stone";"1969-06-16";"male"

id;partner_1_id;partner_2_id;marriage_date;divorce_date
1;8;7;"1990-09-09";"2010-10-10"
2;8;1;"2010-11-11";""
3;3;4;"2013-01-16";""
4;2;5;"2011-07-23";""
*/