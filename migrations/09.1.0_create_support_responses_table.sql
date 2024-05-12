CREATE TABLE IF NOT EXISTS SupportResponses (
    ResponseID SERIAL PRIMARY KEY,
    RequestID INT REFERENCES SupportRequests(RequestID),
    Header TEXT,
    Body TEXT,
    Date DATE
);

INSERT INTO Users (Name, Email, PhoneNumber, WalletID, SubscribeTypeID)
SELECT
    CONCAT('User', RANDOM() * 1000000),    
    CONCAT('user', RANDOM() * 1000000, '@mail.com'), 
    CAST(RANDOM() * 1000000000 AS TEXT),
    (SELECT WalletID FROM Wallets ORDER BY RANDOM() LIMIT 1) AS WalletID,
    (SELECT SubscribeTypeID FROM SubscribeTypes ORDER BY RANDOM() LIMIT 1) AS SubscribeTypeID
FROM generate_series(1, 100000);
