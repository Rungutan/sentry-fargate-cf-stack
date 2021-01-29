#!/usr/bin/env bash

set -e

if [ ! -f "backup.sql" ]; then
    echo "The expected file to be imported (backup.sql) is not present in the current directory!"
    exit 1
fi

if ! psql --version COMMAND &> /dev/null
then
    echo "PSQL could not be found. Please make sure you have the PostgreSQL client installed https://www.postgresql.org/download/"
    exit
fi


read -p "Input target HOSTNAME: " hostname

read -p "Input target PORT [default = 5432]: " port
port=${port:-5432}

read -p "Input target DATABASE NAME [default = sentry]: " database_name
database_name=${database_name:-sentry}

read -p "Input target USERNAME [default = sentry]: " username
username=${username:-sentry}

echo "Input target PASSWORD: "
psql  --host=$hostname --port=$port --username=$username --dbname=$database_name --file=backup.sql --password

echo "Managed to import $(cat backup.sql | wc -l) SQL commands into target database"
