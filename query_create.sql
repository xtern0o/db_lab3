CREATE TYPE GENDER AS ENUM('m', 'f');

CREATE TABLE sound(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'какой-то звук' NOT NULL UNIQUE,
    volume SMALLINT NOT NULL CONSTRAINT zero_to_hundred CHECK (volume >= 0 AND volume <= 100)
);

CREATE TABLE diet(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE swarm(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    location_id INTEGER REFERENCES location(id) ON DELETE CASCADE
);

CREATE TABLE action(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE biom(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);



CREATE TABLE dino_type(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    habitat_biom_id INTEGER REFERENCES biom(id) ON DELETE SET NULL
);

CREATE TABLE location(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'какая-то локация' NOT NULL,
    biom_id INTEGER NOT NULL REFERENCES biom(id) ON DELETE CASCADE,
    parent_location_id INTEGER REFERENCES location(id)  ON DELETE CASCADE,
    CONSTRAINT parent_location_no_self_ref CHECK (parent_location_id <> id)
);

CREATE TABLE dinosaur(
    id SERIAL PRIMARY KEY,
    name TEXT DEFAULT 'безымянный динозавр' NOT NULL,
    gender GENDER NOT NULL,
    age INTEGER DEFAULT 0 CONSTRAINT positive CHECK (age >= 0),
    dino_type_id INTEGER REFERENCES dino_type(id) ON DELETE CASCADE,
    current_swarm_id INTEGER REFERENCES swarm(id) ON DELETE SET NULL,
    parent_dino_id INTEGER REFERENCES dinosaur(id) ON DELETE SET NULL,
    current_location_id INTEGER REFERENCES location(id) ON DELETE SET NULL,
    CONSTRAINT parent_dino_no_self_ref CHECK (parent_dino_id <> id)

);



CREATE TABLE dino_to_action(
    dino_id INTEGER REFERENCES dinosaur(id) ON DELETE CASCADE,
    action_id INTEGER REFERENCES action(id) ON DELETE CASCADE
);

CREATE TABLE dinotype_to_sound(
    dinotype_id INTEGER REFERENCES dino_type(id) ON DELETE CASCADE,
    sound_id INTEGER REFERENCES sound(id) ON DELETE CASCADE
);

CREATE TABLE dinotype_to_diet(
    dinotype_id INTEGER REFERENCES dino_type(id) ON DELETE CASCADE,
    diet_id INTEGER REFERENCES diet(id) ON DELETE CASCADE
);