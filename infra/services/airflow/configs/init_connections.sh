#!/bin/bash

# Wait for a bit if needed (for other services to start)
sleep 10

# Create Airflow connection for Kyuubi
airflow connections add 'kyuubi_default' \
    --conn-type 'hive_cli' \
    --conn-host 'kyuubi' \
    --conn-port '10009' \
    --conn-schema 'default'

echo "Kyuubi connection created."
