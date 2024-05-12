CREATE TABLE IF NOT EXISTS CommonPromoCodes (
    PromocodeID SERIAL PRIMARY KEY,
    Discount INT,
    Body TEXT,
    Date TIMESTAMP
);

INSERT INTO CommonPromoCodes (Discount, Body, Date)
SELECT
    FLOOR(RANDOM() * 50) AS Discount,
    SUBSTRING(MD5(RANDOM()::TEXT), 1, 15) AS Body,
    CURRENT_TIMESTAMP - INTERVAL '1' DAY * (RANDOM() * 365) AS Date
FROM generate_series(1, 100000);
