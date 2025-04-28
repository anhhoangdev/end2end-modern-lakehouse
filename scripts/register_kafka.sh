#!/bin/bash

# Get the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Target connector files relative to the script directory
CONNECTORS_DIR="$SCRIPT_DIR/../infra/services/kafka-connect/connectors"

# Loop through all JSON files
for cfg in "$CONNECTORS_DIR"/*.json; do
    [ ! -f "$cfg" ] && continue

    echo "Registering $(basename "$cfg")…"

    curl -s -X POST http://localhost:8083/connectors \
        -H "Content-Type: application/json" \
        --data @"$cfg" || true
done

echo "Connector registration script finished."
