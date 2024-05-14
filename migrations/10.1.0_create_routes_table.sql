CREATE TABLE IF NOT EXISTS Routes (
    RouteID SERIAL PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    MovementTime TIME,
    StandTime TIME,
    RoutePath TEXT
);

INSERT INTO Routes (StartDate, EndDate, MovementTime, StandTime, RoutePath)
SELECT
    random_start_date as StartDate,
    random_start_date + (random_movement_time || ' seconds')::interval + (random_stand_time || ' seconds')::interval as EndDate,
    (random_movement_time || ' seconds')::interval::time as MovementTime,
    (random_stand_time || ' seconds')::interval::time as StandTime,
    md5(random()::text)
FROM (
         SELECT
             TIMESTAMP '2004-04-06 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-04-06 00:00:00') as random_start_date,
             FLOOR(RANDOM() * 3600) as random_movement_time,
             FLOOR(RANDOM() * 300) as random_stand_time
         FROM generate_series(1, 10000)
     ) AS subquery;
