#!/bin/bash
set -e

# ------------------------------------------------------------------
# 0. (If MariaDB runs in its own container you can remove all the
#    mysqld &  / wait lines; keep them only when you embed MariaDB
#    in the same image – not recommended for production.)
# ------------------------------------------------------------------

# ---------- schema + user bootstrap (idempotent) ------------------


echo "💬 Checking if Hive schema is already there…"
sleep 15

TABLE_EXISTS=$(mysql -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" \
               -D"${MYSQL_DATABASE}" -N -s -e "SHOW TABLES LIKE 'CTLGS';")

if [ -z "$TABLE_EXISTS" ]; then
  echo "📦 Schema not found – running schematool -initSchema"
  /opt/hive/bin/schematool -dbType mysql -initSchema --verbose
else
  echo "✅ Schema already present – skipping schematool"
fi

# ---------- start metastore in foreground -------------------------
echo "🚀 Starting Hive Metastore Thrift server…"
exec hive --service metastore
