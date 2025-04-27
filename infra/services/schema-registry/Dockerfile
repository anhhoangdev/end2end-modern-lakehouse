FROM confluentinc/cp-schema-registry:7.3.2

USER root
COPY configs/schema-registry.properties /tmp/schema-registry.properties

# Script nhỏ để copy sau entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
