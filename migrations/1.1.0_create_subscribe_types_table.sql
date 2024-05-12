CREATE TABLE IF NOT EXISTS SubscribeTypes (
    SubscribeTypeID SERIAL PRIMARY KEY,
    CostPerMinute INT,
    CostForStanding INT,
    FreeStandingTime INT,
    StartCost INT
);

INSERT INTO SubscribeTypes (CostPerMinute, CostForStanding, FreeStandingTime, StartCost)
SELECT
    FLOOR(RANDOM() * 10) AS CostPerMinute,
    FLOOR(RANDOM() * 5) AS CostForStanding,
    FLOOR(RANDOM() * 60) AS FreeStandingTime,
    FLOOR(RANDOM() * 20) AS StartCost
FROM generate_series(1, 5);