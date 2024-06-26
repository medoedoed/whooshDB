#!/bin/bash

#target_version=$WHOOSHPOSTGRES_VERSION
user=$POSTGRES_USER
db=$POSTGRES_DB

if [ -z "$user" ]; then
    user="postgres"
fi

if [ -z "$db" ]; then
    db="postgres"
fi

for file in $( find /migrations -type f | sort ); do
    # version=$(basename "$file" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1)
    #  provided coecho "[LOG] Running version $version"
    # if [[ "$version" <= "$target_version" ]]; then
        echo "Executing migration: $file"
        psql -U "$user" -d "$db" -f "$file"
    # fi
done

if [[ $INDEXATION == true ]]; then
  ./indexations/indexation.sh
fi

if [[ $PARTITION_ORDERS == true ]]; then
  psql -U "$user" -d "$db" -f ./partitions/partition.sql
fi

psql -U "$user" -d "$db" -c "CREATE ROLE reader"
psql -U "$user" -d "$db" -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader"

psql -U "$user" -d "$db" -c "CREATE ROLE writer"
psql -U "$user" -d "$db" -c "GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO writer"

psql -U "$user" -d "$db" -c "CREATE USER analytic LOGIN"
psql -U "$user" -d "$db" -c "GRANT SELECT ON TABLE Users TO analytic"

psql -U "$user" -d "$db" -c "CREATE ROLE super NOLOGIN"
psql -U "$user" -d "$db" -c "GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO super"

OLDIFS="$IFS"
export IFS=","

for pguser in $USERS; do
    psql -U "$user" -d "$db" -c "CREATE USER $pguser"
    psql -U "$user" -d "$db" -c "GRANT reader TO $pguser"
done

if [[ $DO_BACKUP == true ]]; then
  psql -U "$user" -d "$db" -f ./backup/plan.sh
fi


export IFS="$OLDIFS"