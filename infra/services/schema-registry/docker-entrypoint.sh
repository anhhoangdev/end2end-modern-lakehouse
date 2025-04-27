#!/bin/bash
cp /tmp/schema-registry.properties /etc/schema-registry/schema-registry.properties
exec /etc/confluent/docker/run
