#!/bin/sh
set -e

while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
mix ecto.create
mix ecto.migrate

exec mix phx.server
