CREATE TABLE project (
	project SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR NOT NULL UNIQUE,
	email VARCHAR NOT NULL
);

CREATE TABLE milestone (
	milestone SERIAL PRIMARY KEY NOT NULL,
	project INTEGER REFERENCES project NOT NULL,
	name VARCHAR NOT NULL,
	due DATE,
	UNIQUE(project, name)
);

CREATE TABLE bug_status (
	bug_status SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO bug_status (name) VALUES ('open');
INSERT INTO bug_status (name) VALUES ('resolved');
INSERT INTO bug_status (name) VALUES ('wontfix');

CREATE TABLE bug (
	bug SERIAL PRIMARY KEY NOT NULL,
	project INTEGER REFERENCES project NOT NULL,
	milestone INTEGER REFERENCES milestone,
	bug_status INTEGER REFERENCES bug_status NOT NULL DEFAULT 1,

	title VARCHAR NOT NULL,
	description VARCHAR NOT NULL
	created TIMESTAMP NOT NULL DEFAULT NOW(),
	created_by VARCHAR NOT NULL
);

CREATE bug_comment (
	bug_comment SERIAL PRIMARY KEY NOT NULL,
	bug INTEGER REFERENCES bug NOT NULL,

	created TIMESTAMP NOT NULL DEFAULT NOW(),
	created_by VARCHAR NOT NULL,
	text VARCHAR NOT NULL
);
