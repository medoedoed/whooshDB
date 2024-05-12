CREATE TABLE IF NOT EXISTS UsedCommonPromoCodes (
    UserID INT REFERENCES Users(UserID),
    PromocodeID INT REFERENCES CommonPromoCodes(PromocodeID),
    PRIMARY KEY (UserID, PromocodeID)
);

INSERT INTO UsedCommonPromoCodes (UserID, PromocodeID)
SELECT
    id,
    FLOOR(RANDOM() * (SELECT MAX(PromocodeID) FROM CommonPromoCodes)) + 1
FROM generate_series(1, 100000) AS id;
