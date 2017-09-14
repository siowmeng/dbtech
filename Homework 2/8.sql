-- Exercise 8

-- Languages Table
-- This table is constructed to allow the organisation to define the supported languages as times go.
-- The two-character code is the unique identifier of row (hence the primary key) and lang_name must be unique and not null.

CREATE TABLE languages (
   lang_code CHAR(2) PRIMARY KEY,
   lang_name TEXT NOT NULL UNIQUE
);

-- Tours Table
-- This table stores the tour information (name, start date and end date), all of the columns must not be NULL.
-- We have to use another integer ID to be the unique identifier of rows (Primary Key) since the tour name, start date and end date can all be repeated (since there can be more than one same tour which starts/ends on the same date).

CREATE TABLE tours (
   id INTEGER PRIMARY KEY,
   name TEXT NOT NULL,
   startdate DATE NOT NULL,
   enddate DATE NOT NULL
);

-- Guides Table
-- This table stores the guide's forename and surname. The names must not be NULL.
-- We have to use an integer ID to be the unique identifier of rows (Primary Key) since there may be more than 1 guide with the same name.

CREATE TABLE guides (
   id INTEGER PRIMARY KEY,
   forename TEXT NOT NULL,
   surname TEXT NOT NULL
);

-- Participant Table
-- This table stores the customer's information (forename, surname and email). The two names columns must not be NULL but email column can be NULL (since there may be customer that doesn't have an email address).
-- We have to use an integer ID to be the unique identifier of rows (Primary Key) since there may be more than 1 customer with the same name.

CREATE TABLE participants (
   id INTEGER PRIMARY KEY,
   forename TEXT NOT NULL,
   surname TEXT NOT NULL,
   email TEXT
);

-- GuideLanguages Table
-- This table maps the guide (guide_id column) to his/her spoken languages (lang_code column). The two columns are the foreign keys referring to the GUIDES and LANGUAGES tables.
-- The combination of (GUIDE_ID, SPOKEN_LANGUAGE) can uniquely identify a row. Hence the two columns can be used as PRIMARY KEY.

CREATE TABLE guidelanguages (
   guide_id INTEGER REFERENCES guides (id),
   spoken_language TEXT REFERENCES languages (lang_code),
   PRIMARY KEY (guide_id, spoken_language)
);

-- TourGuides Table
-- This table maps the tour (tour_id column) to the respective guide (guide_id column). The two columns are the foreign keys referring to the TOURS and GUIDES tables.
-- The combination of (TOUR_ID, GUIDE_ID) can uniquely identify a row. Hence the two columns can be used as PRIMARY KEY.

CREATE TABLE tourguides (
   tour_id INTEGER REFERENCES tours (id),
   guide_id INTEGER REFERENCES guides (id),
   PRIMARY KEY (tour_id, guide_id)
);

-- TourParticipants Table
-- This table maps the participant (participant_id column) to the respective tour (tour_id column). The two columns are the foreign keys referring to the PARTICIPANTS and TOURS tables.
-- The columns CURRENCY, AMOUNT, PAYMENT_STATUS, PAYMENT_DUEDATE is defined in this table instead of TOURS table. This is because the travel agency may charge different rate and impose different payment due date to each participant joining the same tour.
-- CURRENCY (a 3-character currency code) is allowed to be NULL when default currency (e.g. GBP) is used.
-- PAYMENT_DUEDATE is allowed to be NULL when there is no due date imposed (e.g. balance has been fully paid).
-- AMOUNT is a decimal number (with 2 decimal places). The amount column is defined to be less than 10 million. AMOUNT must not be NULL and must be greater or equal to 0.
-- PAYMENT_STATUS must not be NULL and the value can only be 'paid' or 'unpaid'.
-- A participant can join more than 1 tour and the combination of (PARTICIPANT_ID, TOUR_ID) can uniquely identify a row. Hence the two columns can be used as PRIMARY KEY.

CREATE TABLE tourparticipants (
   tour_id INTEGER REFERENCES tours (id),
   participant_id INTEGER REFERENCES participants (id),
   currency CHAR(3),
   amount DECIMAL(9, 2) NOT NULL CHECK (amount >= 0),
   payment_status TEXT NOT NULL CHECK (payment_status IN ('paid', 'unpaid')),
   payment_duedate DATE,
   PRIMARY KEY (tour_id, participant_id)
);

-- The following SQL codes insert sample data to the tables

INSERT INTO
   languages (lang_code, lang_name)
VALUES
   ('EN', 'English'),
   ('MN', 'Mongolian'),
   ('PL', 'Polish'),
   ('RU', 'Russian'),
   ('ES', 'Spanish'),
   ('PR', 'Portuguese');

INSERT INTO
   tours (id, name, startdate, enddate)
VALUES 
   (1, 'Picturesque Polish Ponds', '2017-05-01', '2017-05-05'),
   (2, 'Marvellous Mongolian Mountains', '2017-06-14', '2017-06-30');

INSERT INTO
   guides (id, forename, surname)
VALUES
   (1, 'Andrew', 'Brown'),
   (2, 'Teresa', 'Kowalska'),
   (3, 'Rachel', 'Diaz');

INSERT INTO
   participants (id, forename, surname, email)
VALUES
   (1, 'Hanna', 'Edison', 'hanna.edison.137@gmail.com'),
   (2, 'Sue', 'Clark', 'sue@sueclark.uk'),
   (3, 'Gordon', 'Ryan', 'gr@halfbiolife.com'),
   (4, 'Harry', 'Potter', 'hp@harrypotter.com'),
   (5, 'Hermione', 'Granger', 'cutehermione@gmail.com'),
   (6, 'Ron', 'Weasley', 'ron@machoweasley.com');

INSERT INTO
   guidelanguages (guide_id, spoken_language)
VALUES
   (1, 'EN'),
   (1, 'MN'),
   (1, 'PL'),
   (2, 'EN'),
   (2, 'PL'),
   (2, 'RU'),
   (3, 'ES'),
   (3, 'PR'),
   (3, 'RU'),
   (3, 'MN');

INSERT INTO
   tourguides (tour_id, guide_id)
VALUES
   (1, 1),
   (1, 2),
   (2, 3),
   (2, 1);

INSERT INTO
   tourparticipants (tour_id, participant_id, currency, amount, payment_status, payment_duedate)
VALUES
   (1, 1, 'GBP', '750', 'paid', NULL),
   (1, 2, 'GBP', '750', 'unpaid', '2016-12-31'),
   (1, 3, 'GBP', '750', 'paid', NULL),
   (2, 4, 'GBP', '2000', 'paid', NULL),
   (2, 5, 'GBP', '2100', 'unpaid', '2017-01-01'),
   (2, 6, 'GBP', '1950', 'paid', NULL);
