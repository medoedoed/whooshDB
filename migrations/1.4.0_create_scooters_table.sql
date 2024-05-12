CREATE TABLE IF NOT EXISTS Scooters (
    ScooterID SERIAL PRIMARY KEY,
    ScooterNumber VARCHAR(10) UNIQUE,
    Longitude DOUBLE PRECISION,
    Latitude DOUBLE PRECISION,
    Available BOOLEAN,
    CurrentCharge INT
);

INSERT INTO Scooters (ScooterNumber, Longitude, Latitude, Available, CurrentCharge)
SELECT
    CONCAT('NUM', FLOOR(RANDOM() * 1000)) AS ScooterNumber,
    RANDOM() * 180 - 90 AS Longitude,
    RANDOM() * 90 - 45 AS Latitude,
    CASE WHEN RANDOM() < 0.5 THEN TRUE ELSE FALSE END AS Available,
    FLOOR(RANDOM() * 100) AS CurrentCharge
FROM generate_series(1, 100000);