#!/bin/bash

# Wait for Kafka broker to be ready
echo "⏳ Waiting for Kafka broker..."
sleep 10

echo "🚀 Creating Kafka Connect internal topics..."

KAFKA_TOPICS_SCRIPT=/usr/bin/kafka-topics  # or adjust if kafka-topics.sh is elsewhere
BROKER=${BOOTSTRAP_SERVERS:-kafka:9092}

# Create connect-offsets
$KAFKA_TOPICS_SCRIPT --bootstrap-server $BROKER --create --if-not-exists \
  --topic connect-offsets --partitions 25 --replication-factor 1 --config cleanup.policy=compact

# Create connect-configs
$KAFKA_TOPICS_SCRIPT --bootstrap-server $BROKER --create --if-not-exists \
  --topic connect-configs --partitions 1 --replication-factor 1 --config cleanup.policy=compact

# Create connect-status
$KAFKA_TOPICS_SCRIPT --bootstrap-server $BROKER --create --if-not-exists \
  --topic connect-status --partitions 5 --replication-factor 1 --config cleanup.policy=compact

echo "✅ Kafka Connect topics ready."
