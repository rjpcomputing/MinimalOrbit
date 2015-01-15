-- ----------------------------------------------------------------------------
-- Initial import script used to populate a SQLite3 database
-- with the minimum structure used by MinimalREST.
--
-- Author:	Ryan Pusztai <ryan.pusztai@gentex.com>
-- Date:	03/17/2014
--
-- Notes:
--		03/17/2014 - Initial Release
-- ----------------------------------------------------------------------------
-- Do this to create a new database
-- $ sqlite3 <file_name>.db
-- Use this file like this
-- $ sqlite3 <file_name>.db < schema.sql

DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS user;

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- Main Worker Tables ---------------------------------------------------------
--
CREATE TABLE movie (
	id						INTEGER PRIMARY KEY,
	created_at				TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at				TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	name					TEXT NOT NULL,
	description				TEXT NOT NULL,
	CONSTRAINT unique_name UNIQUE ( name )
);

CREATE TABLE user (
	id					INTEGER PRIMARY KEY,
	created_at			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	firstname			TEXT NOT NULL,
	lastname			TEXT NOT NULL,
	username			TEXT NOT NULL,
	is_admin			BOOLEAN NOT NULL DEFAULT 0,
	is_locked			BOOLEAN NOT NULL DEFAULT 0,
	rest_write_enabled	BOOLEAN NOT NULL DEFAULT 0
);

-- DEFAULT DATA ---------------------------------------------------------------
--
INSERT INTO user (id, created_at, updated_at, firstname, lastname, username, is_admin, is_locked, rest_write_enabled) VALUES
	( 1, '2015-01-14 10:14:08', '2015-01-14 10:14:08', 'Peter', 'Griffin', 'peter.griffin', 1, 0, 1 ),
	( 2, '2015-01-14 14:23:21', '2015-01-14 14:23:21', 'Lois', 'Griffin', 'lois.griffin', 0, 0, 1 ),
	( 3, '2015-01-14 13:24:51', '2015-01-14 13:24:51', 'Stewie', 'Griffin', 'stewie.griffin', 0, 0, 0 );

INSERT INTO movie (id, created_at, name, description) VALUES
	( 1, '2007-09-23 10:29:41',	'Blue Harvest', 								'"Blue Harvest" is the hour-long premiere of the sixth season of the Fox animated comedy series Family Guy and the first part of the series'' trilogy Laugh It Up, Fuzzball. It originally aired on September 23, 2007. The episode is a retelling and parody of the 1977 blockbuster film, Star Wars, recasting the show''s characters into Star Wars roles. The plot follows Peter as he retells the story of Star Wars while the electricity is out in their house.' ),
	( 2, '2010-05-23 04:54:23',	'Something, Something, Something, Dark Side',	'"Something, Something, Something, Dark Side" is the 20th episode of the eighth season of the animated comedy series Family Guy and part of the series'' trilogy Laugh It Up, Fuzzball. This was produced for Season 6. It originally aired on Fox in the United States on May 23, 2010. The episode is a retelling and parody of the film The Empire Strikes Back, recasting characters from Family Guy into roles from the film.' ),
	( 3, '2014-03-18 16:12:33', 'It''s a Trap!',								'"It''s a Trap!" is the double-episode season finale of the ninth season of the animated series Family Guy and the final part of the series'' trilogy Laugh It Up, Fuzzball. The episode aired on Fox in the United States on May 22, 2011. It retells the story of Return of the Jedi as "Blue Harvest" did with Star Wars and "Something, Something, Something, Dark Side" did with The Empire Strikes Back by recasting characters from Family Guy into roles from the film.' );

COMMIT;
