CREATE TABLE IF NOT EXISTS Orders (
    OrderID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(UserID),
    ScooterID INT REFERENCES Scooters(ScooterID),
    Cost INT,
    CommonPromocodeID INT REFERENCES CommonPromoCodes(PromocodeID),
    UniquePromocodeID INT REFERENCES UniquePromoCodes(PromocodeID),
    RouteID INT REFERENCES Routes(RouteID)
);

INSERT INTO Orders (UserID, ScooterID, Cost, CommonPromocodeID, UniquePromocodeID, RouteID)
SELECT
    (SELECT UserID FROM Users WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS UserID,
    (SELECT ScooterID FROM Scooters WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS ScooterID,
    FLOOR(RANDOM() * 100)::int AS Cost,
    (SELECT PromocodeID FROM CommonPromoCodes WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS CommonPromocodeID,
    (SELECT PromocodeID FROM UniquePromoCodes WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS UniquePromocodeID,
    (SELECT RouteID FROM Routes WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS RouteID
FROM generate_series(1, 10000) as gen;
