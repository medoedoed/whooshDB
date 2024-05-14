CREATE TABLE IF NOT EXISTS Routes (
    RouteID SERIAL PRIMARY KEY,
    StartTime DATE,
    EndTime DATE,
    MovementTime DATE,
    RoutePath TEXT,
    StandTime DATE
);

INSERT INTO Routes (StartTime, MovementTime, RoutePath, EndTime,  StandTime)
SELECT
    TIMESTAMP '2004-04-06 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-04-06 00:00:00') as st,
    RANDOM() * (TIMESTAMP '2000-01-01 00:59:59' - TIMESTAMP '2000-01-01 00:00:00') as mt,
    md5(random()::text),

    RANDOM() * (TIMESTAMP '2000-01-01 00:05:00' - TIMESTAMP '2000-01-01-00:00:00') as stand
FROM generate_series(1, 10000);
