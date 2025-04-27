#!/bin/bash

for cfg in infra/services/kafka-connect/connectors/*.json; do
    [ ! -f "$cfg" ] && continue &&
    echo Registering "$(basename "$cfg")"… &&
    curl -s -X POST http://localhost:8083/connectors \
    -H "Content-Type: application/json" \
    --data @"$cfg" || true;
done &&||