# -----------------------------------
# Main Targets
# -----------------------------------

build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

restart: down build up

logs:
	docker compose logs -f

ps:
	docker compose ps

clean:
	docker compose down -v --remove-orphans

prune:
	docker system prune -af --volumes

# -----------------------------------
# Build Specific Services
# -----------------------------------

build-postgres:
	docker compose build postgres

build-kafka:
	docker compose build kafka

build-kafka-connect:
	docker compose build kafka-connect

build-akhq:
	docker compose build akhq

build-zookeeper:
	docker compose build zookeeper

build-schema-registry:
	docker compose build schema-registry

# -----------------------------------
# Register Connectors (example)
# -----------------------------------

register-northwind-connector:
	curl -X POST http://localhost:8083/connectors \
	-H "Content-Type: application/json" \
	-d @services/kafka-connect/connectors/register-northwind-connector.json
