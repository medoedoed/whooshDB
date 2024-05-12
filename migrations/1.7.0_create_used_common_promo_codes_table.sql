CREATE TABLE IF NOT EXISTS UsedCommonPromoCodes (
    UserID INT REFERENCES Users(UserID),
    PromocodeID INT REFERENCES CommonPromoCodes(PromocodeID),
    PRIMARY KEY (UserID, PromocodeID)
);

INSERT INTO UsedCommonPromoCodes (UserID, PromocodeID)
SELECT
    (SELECT UserID FROM Users ORDER BY RANDOM() LIMIT 1) AS UserID,
    (SELECT PromocodeID FROM CommonPromoCodes ORDER BY RANDOM() LIMIT 1) AS PromocodeID
FROM generate_series(1, 100000);
