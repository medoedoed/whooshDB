CREATE TABLE IF NOT EXISTS SupportResponses (
    ResponseID SERIAL PRIMARY KEY,
    RequestID INT REFERENCES SupportRequests(RequestID),
    Header TEXT,
    Body TEXT,
    Date DATE
);

INSERT INTO SupportResponses (RequestID, Header, Body, Date)
SELECT
    (SELECT RequestID FROM SupportRequests WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS RequestID,
    CONCAT('Header: ', FLOOR(RANDOM() * 1000000)),
    CONCAT('Body: ', FLOOR(RANDOM() * 1000000)),
    TIMESTAMP '2004-04-06 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-04-06 00:00:00')
FROM generate_series(1, 10000) as gen ;
