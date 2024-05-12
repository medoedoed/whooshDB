CREATE TABLE IF NOT EXISTS UniquePromoCodes (
    PromocodeID SERIAL PRIMARY KEY,
    Discount INT,
    Used BOOLEAN,
    Body VARCHAR(15)
);

INSERT INTO UniquePromoCodes (Discount, Used, Body)
SELECT
    FLOOR(RANDOM() * 50) AS Discount,
    CASE WHEN RANDOM() < 0.5 THEN TRUE ELSE FALSE END AS Used,
    SUBSTRING(MD5(RANDOM()::TEXT), 1, 15) AS Body
FROM generate_series(1, 100000);
