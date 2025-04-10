CREATE OR REPLACE FUNCTION find_loudest_swarm(location_filter_id INTEGER DEFAULT NULL)
RETURNS TABLE (
    swarm_id INTEGER,
    swarm_name TEXT,
    total_volume NUMERIC,
    swarm_location_id INTEGER
) 
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.id AS swarm_id,
        s.name AS swarm_name,
        SUM(so.volume)::NUMERIC AS total_volume,
        s.location_id
    FROM swarm s
    JOIN dinosaur d ON s.id = d.current_swarm_id
    JOIN dino_type dt ON d.dino_type_id = dt.id
    JOIN dinotype_to_sound dts ON dt.id = dts.dinotype_id
    JOIN sound so ON dts.sound_id = so.id
    WHERE 
        (location_filter_id IS NULL OR s.location_id = location_filter_id)
    GROUP BY s.id, s.name, s.location_id
    ORDER BY total_volume DESC
    LIMIT 1;
END;
$$ 
LANGUAGE plpgsql;