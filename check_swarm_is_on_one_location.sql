CREATE OR REPLACE FUNCTION check_swarm_location()
RETURNS TRIGGER 
AS $$
BEGIN
    IF NEW.current_swarm_id IS NOT NULL THEN
        IF NEW.current_location_id != (SELECT location_id FROM swarm WHERE id = NEW.current_swarm_id) THEN
            RAISE EXCEPTION 'Динозавр "%" не может присоединиться к стае "%": локация стаи - "%", текущая локация динозавра - "%"',
                NEW.name,
                (SELECT name FROM swarm WHERE id = NEW.current_swarm_id),
                (SELECT name FROM location WHERE id = (SELECT location_id FROM swarm WHERE id = NEW.current_swarm_id)),
                (SELECT name FROM location WHERE id = NEW.current_location_id);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER enforce_swarm_location
BEFORE INSERT OR UPDATE OF current_swarm_id, current_location_id 
ON dinosaur
FOR EACH ROW 
EXECUTE FUNCTION check_swarm_location();