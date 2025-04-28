FROM apache/airflow:2.9.0-python3.11

USER root

# Install system dependencies (only necessary packages)
RUN apt-get update && apt-get install -y \
    libsasl2-dev \
    gcc \
    libffi-dev \
    libkrb5-dev \
    && apt-get clean

# Still as root: copy configs and scripts
COPY configs/airflow.cfg /opt/airflow/airflow.cfg
COPY configs/webserver_config.py /opt/airflow/webserver_config.py
COPY entrypoint.sh /entrypoint.sh
COPY configs/init_connections.sh /init_connections.sh

RUN chmod +x /entrypoint.sh /init_connections.sh

# NOW switch to airflow user
USER airflow

# As airflow user: Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Finally set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
