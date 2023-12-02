#!/bin/bash
# Docker entrypoint script.

# Just mapping some generic db env to pg specific ones.
export PGHOST="$DBHOST"
export PGDATABASE="$DATABASE_NAME"
export PGUSER="$DBUSER"
export PGPASSWORD="$DBPASSWORD"
export PGPORT="$DBPORT"

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  echo "Database $PGDATABASE created."
fi

bin="/app/bin/avance"
eval "$bin eval \"Avance.Release.migrate\""

# start the elixir application
exec "$bin" "start"