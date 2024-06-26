CREATE TABLE IF NOT EXISTS Wallets (
    WalletID SERIAL PRIMARY KEY,
    Data JSON
);

INSERT INTO Wallets (Data)
SELECT JSON_BUILD_OBJECT(
    'balance', FLOOR(RANDOM() * 100000)
) AS Data
FROM generate_series(1, 10000);
