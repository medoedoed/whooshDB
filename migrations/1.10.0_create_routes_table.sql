CREATE TABLE IF NOT EXISTS Routes (
    RouteID SERIAL PRIMARY KEY,
    StartDate TIMESTAMP,
    EndTime TIMESTAMP,
    RoutePath Path,
    MovementTime TIMESTAMP,
    StandTime TIMESTAMP
);

INSERT INTO Routes (StartDate, EndTime, RoutePath, MovementTime, StandTime)
SELECT
    NOW() - INTERVAL '1 day' + random() * INTERVAL '365 days', 
    NOW() + random() * INTERVAL '365 days', 
    md5(random()::text),
    NOW() - random() * INTERVAL '30 minutes',
    NOW() + random() * INTERVAL '30 minutes' 
FROM generate_series(1, 100000);