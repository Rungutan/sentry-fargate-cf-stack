#!/usr/bin/env bash

set -e

if [ -f "backup.sql" ]; then
    echo "A file with the name backup.sql already  exists in the current folder. Please delete or rename it first!"
    exit 1
fi

if ! pg_dump --version COMMAND &> /dev/null
then
    echo "PG_DUMP could not be found. Please make sure you have the PostgreSQL client installed https://www.postgresql.org/download/"
    exit
fi


read -p "Input source HOSTNAME: " hostname

read -p "Input source PORT [default = 5432]: " port
port=${port:-5432}

read -p "Input source DATABASE NAME [default = sentry]: " database_name
database_name=${database_name:-sentry}

read -p "Input source USERNAME [default = sentry]: " username
username=${username:-sentry}

echo "Input source PASSWORD"
pg_dump  --host=$hostname --port=$port --username=$username --password $database_name > backup.sql

echo "Managed to export $(cat backup.sql | wc -l) SQL commands in file backup.sql"
