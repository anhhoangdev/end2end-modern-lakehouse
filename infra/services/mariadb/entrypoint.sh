#!/bin/bash
set -e

# Start MariaDB server in the background
docker-entrypoint.sh mysqld &

# Wait for MariaDB to be ready
echo "💬 Waiting for MariaDB to start..."
sleep 10

# Use environment variables correctly
echo "⚡ Setting up database and user..."
mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

    FLUSH PRIVILEGES;
EOSQL

echo "✅ MariaDB initialization done!"

# Bring MariaDB back to foreground
wait
