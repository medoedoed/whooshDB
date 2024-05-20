CREATE INDEX IF NOT EXISTS orders_index
ON orders(userId, routeid, cost)