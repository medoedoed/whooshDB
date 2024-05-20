CREATE TABLE IF NOT EXISTS Users (
    UserID SERIAL PRIMARY KEY,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL,
    PhoneNumber TEXT NOT NULL,
    WalletID INT REFERENCES Wallets(WalletID),
    SubscribeTypeID INT REFERENCES SubscribeTypes(SubscribeTypeID)
);

INSERT INTO Users (Name, Email, PhoneNumber, WalletID, SubscribeTypeID)
SELECT
    CONCAT('User', FLOOR(RANDOM() * 100000)) AS Name,
    CONCAT('user', FLOOR(RANDOM() * 100000), '@mail.com') AS Email,
    CONCAT('+', FLOOR(RANDOM() * 10000000)) AS PhoneNumber,
    (SELECT WalletID FROM Wallets WHERE gen IS NOT NULL ORDER BY RANDOM() OFFSET FLOOR(RANDOM() * (SELECT COUNT(*) FROM Wallets)) LIMIT 1) AS WalletID,
    (SELECT SubscribeTypeID FROM SubscribeTypes WHERE gen IS NOT NULL ORDER BY RANDOM() LIMIT 1) AS SubscribeTypeID
FROM generate_series(1, 10000) as gen;
