CREATE TABLE IF NOT EXISTS SupportRequests(
    RequestID SERIAL PRIMARY KEY,
    Header    TEXT,
    Body      TEXT,
    Date      DATE,
    Solved    BOOLEAN,
    UserID    INT REFERENCES Users (UserID)
);

INSERT INTO SupportRequests (Header, Body, Date, Solved, UserID)
SELECT
    CONCAT('Request #', FLOOR(RANDOM() * 1000000)),
    CONCAT('Body', FLOOR(RANDOM() * 1000000)),
    TIMESTAMP '2004-04-06 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-04-06 00:00:00'),
    FALSE,
    (SELECT UserID FROM Users WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1, 10000) as gen;
