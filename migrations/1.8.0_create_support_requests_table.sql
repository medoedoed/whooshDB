CREATE TABLE IF NOT EXISTS SupportRequests (
    RequestID SERIAL PRIMARY KEY,
    Header VARCHAR(255),
    Body TEXT,
    Date TIMESTAMP,
    Solved BOOLEAN,
    UserID INT REFERENCES Users(UserID)
);

INSERT INTO SupportRequests (Header, Body, Date, Solved, UserID)
SELECT
    CONCAT('Request #', RANDOM() * 1000000),
    NOW() + INTERVAL RAND() * 30 * INTERVAL '1 day',
    CONCAT('Body', RANDOM() * 1000000)
    FALSE,
    (SELECT UserID FROM Users ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1, 100000);
