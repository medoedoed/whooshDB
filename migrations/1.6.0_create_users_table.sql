CREATE TABLE IF NOT EXISTS Users (
    UserID SERIAL PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Email VARCHAR(20) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    WalletID INT REFERENCES Wallets(WalletID),
    SubscribeTypeID INT REFERENCES SubscribeTypes(SubscribeTypeID)
);

INSERT INTO Users (Name, Email, PhoneNumber, WalletID, SubscribeTypeID)
SELECT
    CONCAT('User', RANDOM() * 100000) AS Name,
    CONCAT('user', RANDOM() * 100000, '@mail.com') AS Email,
    CONCAT('+', RANDOM() * 100000000) AS PhoneNumber,
    (SELECT WalletID FROM Wallets ORDER BY RANDOM() LIMIT 1) AS WalletID,
    (SELECT SubscribeTypeID FROM SubscribeTypes ORDER BY RANDOM() LIMIT 1) AS SubscribeTypeID
FROM generate_series(1, 100000);
