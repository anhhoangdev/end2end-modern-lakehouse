#!/bin/bash

# Load environment variables
if [ -f /opt/airflow/airflow.cfg ]; then
  echo "Using custom airflow.cfg"
fi

# Setup initial Airflow database if needed
airflow db upgrade

# (Optional) Initialize connections if the script exists
if [ -f /init_connections.sh ]; then
  echo "Running init_connections.sh..."
  bash /init_connections.sh
fi

# Auto-create Admin User if it doesn't exist
echo "Checking if admin user exists..."
airflow users list | grep "${AIRFLOW_ADMIN_USERNAME}" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Admin user not found. Creating..."
  airflow users create \
    --username "${AIRFLOW_ADMIN_USERNAME}" \
    --firstname "${AIRFLOW_ADMIN_FIRSTNAME}" \
    --lastname "${AIRFLOW_ADMIN_LASTNAME}" \
    --role Admin \
    --email "${AIRFLOW_ADMIN_EMAIL}" \
    --password "${AIRFLOW_ADMIN_PASSWORD}"
else
  echo "Admin user already exists. Skipping creation."
fi

# Start airflow webserver and scheduler
echo "Starting Airflow webserver..."
airflow webserver &

echo "Starting Airflow scheduler..."
exec airflow scheduler
