INSERT INTO sound (name, volume) VALUES 
    ('гогот', 70),
    ('крик', 90);

INSERT INTO diet (name) VALUES 
    ('трава'), 
    ('хищник'), 
    ('падальщик'), 
    ('водоросли');


INSERT INTO action (name) VALUES 
    ('плавать'), 
    ('кричать'), 
    ('гоготать'),
    ('услышать'),
    ('изгибаться');

INSERT INTO biom (name) VALUES 
    ('лес'), 
    ('озеро'), 
    ('океан'), 
    ('река'), 
    ('пляж');

INSERT INTO dino_type (name, habitat_biom_id) VALUES 
    ('утконосый', 2), 
    ('страшный', 1),
    ('человек', 1);

INSERT INTO location (name, parent_location_id, biom_id) VALUES 
    ('тайга', NULL, 1), 
    ('крутой пляж', 1, 5), 
    ('лагуна с утнконосами', 2, 2);

INSERT INTO swarm (name, location_id) VALUES 
    ('крутая стая', 1), 
    ('пустая стая', 1),
    ('Grant party', 2);

INSERT INTO dinosaur (name, gender, age, dino_type_id, current_swarm_id, parent_dino_id, current_location_id) VALUES 
    (DEFAULT, 'f', 30, 2, 1, NULL, 1),
    ('максим', 'm', 19, 1, 1, 1, 3),
    ('еще утконос', 'm', 4430, 2, 1, 2, 2),
    ('Грант', 'm', 20, 3, 2, 3, 2),
    ('Грант2', 'm', 20, 3, 1, 3, 2),
    ('Гран4т', 'm', 20, 3, 1, 3, 2);

INSERT INTO dino_to_action (dino_id, action_id) VALUES
    (1, 1),
    (1, 3),
    (2, 3),
    (3, 2),
    (4, 4);

INSERT INTO dinotype_to_sound (dinotype_id, sound_id) VALUES
    (1, 1),
    (2, 2);

INSERT INTO dinotype_to_diet (dinotype_id, diet_id) VALUES
    (1, 1),
    (1, 4),
    (2, 2),
    (2, 3);