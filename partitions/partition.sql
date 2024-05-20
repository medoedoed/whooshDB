create table orders_demo
(
    OrderID           SERIAL PRIMARY KEY,
    UserID            INT REFERENCES Users (UserID),
    ScooterID         INT REFERENCES Scooters (ScooterID),
    Cost              INT,
    CommonPromocodeID INT REFERENCES CommonPromoCodes (PromocodeID),
    UniquePromocodeID INT REFERENCES UniquePromoCodes (PromocodeID),
    RouteID           INT REFERENCES Routes (RouteID)
) partition by range(cost);

create table cost050 (like orders_demo including indexes);
create table cost50100 (like orders_demo including indexes);

alter table orders_demo attach partition cost050 for values from (0) to (50);
alter table orders_demo attach partition cost50100 for values from (50) to (101);

insert into orders_demo select * from orders;

create index orders_demo_index on orders_demo(userId, routeid, cost);

alter table orders rename to orders_old;
alter table orders_demo rename to orders;


