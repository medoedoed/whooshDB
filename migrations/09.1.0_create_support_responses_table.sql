CREATE TABLE IF NOT EXISTS SupportResponses (
    ResponseID SERIAL PRIMARY KEY,
    RequestID INT REFERENCES SupportRequests(RequestID),
    Header TEXT,
    Body TEXT,
    Date DATE
);

INSERT INTO Users (Name, Email, PhoneNumber, WalletID, SubscribeTypeID)
SELECT
    (SELECT RequestID FROM SupportRequests ORDER BY RANDOM() LIMIT 1) AS WalletID,
    CONCAT('Header ', RANDOM() * 1000000),
    CONCAT('Body: ', RANDOM() * 1000000),
    (SELECT WalletID FROM Wallets ORDER BY RANDOM() LIMIT 1) AS WalletID,
    TIMESTAMP '2004-04-06 00:00:00' + RANDOM() * (TIMESTAMP '2024-01-01 00:00:00' - TIMESTAMP '2004-04-06 00:00:00')
FROM generate_series(1, 100000);
