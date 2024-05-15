#!/bin/bash

db=$POSTGRES_DB
user=$POSTGRES_USER

execute_sql() {
  local sql_file="$1"
  psql -U "$user" -d "$db" -f "$sql_file"
}

for sql_file in "./indexations"/*.sql; do
  echo "Applying indexation from $sql_file"
  execute_sql "$sql_file"
done

echo "Indexation completed."