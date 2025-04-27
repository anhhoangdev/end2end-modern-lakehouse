FROM postgres:15

COPY configs/init.sql /docker-entrypoint-initdb.d/
COPY configs/postgres.env /docker-entrypoint-initdb.d/
