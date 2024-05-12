CREATE TABLE IF NOT EXISTS SupportResponses (
    ResponseID SERIAL PRIMARY KEY,
    RequestID INT REFERENCES SupportRequests(RequestID),
    Header VARCHAR(255),
    Body TEXT,
    Date TIMESTAMP
);

INSERT INTO Users (Name, Email, PhoneNumber, WalletID, SubscribeTypeID)
SELECT
    (SELECT RequestID FROM SupportRequests ORDER BY RANDOM() LIMIT 1) AS WalletID,
    CONCAT('Header ', RANDOM() * 1000000),
    CONCAT('Body: ', RANDOM() * 1000000),
    (SELECT WalletID FROM Wallets ORDER BY RANDOM() LIMIT 1) AS WalletID,
    NOW() + INTERVAL RAND() * 30 * INTERVAL '1 day'
FROM generate_series(1, 100000);
