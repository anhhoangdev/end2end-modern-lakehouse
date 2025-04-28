FROM confluentinc/cp-kafka-connect:7.3.2

# Copy Debezium connectors
COPY ../../kafka-connect-plugins/debezium-connector-postgres /usr/share/java/debezium-connector-postgres

COPY configs/ /etc/kafka-connect/

# 🔥 ADD: Copy scripts properly
COPY scripts/ /etc/kafka-connect/scripts/

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3:latest
