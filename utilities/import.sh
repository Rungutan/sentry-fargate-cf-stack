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

echo
echo
echo "<< Dropping target database (if exists) and recreating it >>"
echo "Input target PASSWORD: "
psql  --host=$hostname --port=$port --username=$username --dbname=$database_name --password << EOF
SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = '${database_name}';

drop database IF EXISTS '${database_name}';
create database '${database_name}';
EOF

echo
echo
echo "<< Importing data into database >>"
echo "Input target PASSWORD: "
psql  --host=$hostname --port=$port --username=$username --dbname=$database_name --file=backup.sql --password

echo
echo
echo "Process finished successfully!"
echo
echo "Managed to import $(cat backup.sql | wc -l) SQL commands into target database!"
