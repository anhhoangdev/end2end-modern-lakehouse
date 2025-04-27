# 🏗️ Modern Data Platform - CDC + Spark Lakehouse

A modern data platform stack built from scratch.  
This system captures changes from source databases, streams them through Kafka, and transforms them into a Lakehouse architecture with Apache Spark, Hudi, and dbt.

---

## 📦 Project Structure

| Layer | Technology | Role |
|:------|:-----------|:-----|
| Data Ingestion | PostgreSQL + Kafka Connect + Kafka | Capture CDC (Change Data Capture) streams |
| Data Streaming | Kafka + Schema Registry + AKHQ | Streaming backbone with schema enforcement |
| SQL Gateway | Kyuubi + Spark | Multi-tenant SQL service over Spark |
| Data Storage | Apache Hudi | Incremental data lake storage format |
| Orchestration | Apache Airflow | DAG-based ETL orchestration |
| Monitoring | AKHQ, Spark UI | Cluster and data monitoring tools |

---

## 🚀 Services Overview

### 1. Postgres
- Source database for CDC.
- Logical replication enabled for Kafka Connect.

### 2. Kafka Stack
- **Zookeeper**: Broker coordination and metadata management.
- **Kafka Broker**: Message streaming backbone.
- **Kafka Connect**: CDC ingestion framework.
- **Schema Registry**: Enforces data contracts (schemas) on Kafka topics.
- **AKHQ**: Web UI to monitor Kafka topics and consumers.

### 3. Kyuubi + Spark
- **Kyuubi**: SQL Gateway service.
- **Spark Master/Workers**: Compute backend for executing heavy transformations.

### 4. Hudi Lakehouse
- Hudi tables store CDC data efficiently with upsert and time-travel capabilities.

### 5. Airflow
- Pipeline orchestration: from CDC ingestion to Spark dbt transformation.

---

## 🛠️ Deployment Architecture

```
+---------------------+
|     Postgres        |
+---------------------+
          |
          |  (CDC via Debezium Source Connector)
          ↓
+---------------------+        +------------------+
|      Kafka          | <----> |   Schema Registry |
+---------------------+        +------------------+
          |
          | (Stream CDC Events)
          ↓
+---------------------+
|       AKHQ          | (Monitoring Kafka)
+---------------------+
          ↓
+---------------------+
|      Kyuubi         |
| (SQL Gateway)       |
+---------------------+
          ↓
+---------------------+
|      Spark          |
| (Master + Workers)  |
+---------------------+
          ↓
+---------------------+
|       Hudi Tables   |
| (Incremental Storage)|
+---------------------+
          ↓
+---------------------+
|      Airflow        |
| (Orchestration DAGs) |
+---------------------+
```

---

## 🏗️ Setup Steps

### 1. Pre-requisites
- Docker + Docker Compose installed
- Basic understanding of Kafka, Spark, and dbt

### 2. Spin up core infrastructure

```bash
docker-compose up -d
```

Services included:
- Postgres
- Zookeeper
- Kafka Broker
- Schema Registry
- Kafka Connect
- AKHQ
- Kyuubi
- Spark Master/Workers
- MinIO (optional for S3-like Hudi storage)

### 3. Create Kafka Connect Topics
(Topics needed: `connect-configs`, `connect-offsets`, `connect-status` with `cleanup.policy=compact`.)

### 4. Configure Connectors
- Setup Debezium source connector to capture Postgres changes.

### 5. Setup dbt
- Use dbt-spark adapter to connect via Kyuubi.
- Create transformation models.

### 6. Orchestrate Workflows
- Build Airflow DAGs to schedule CDC ingestion, Spark transformation, and Hudi ingestion.

---

## ⚙️ Key Configs

### Kafka Connect Worker Config

```properties
offset.storage.topic=connect-offsets
config.storage.topic=connect-configs
status.storage.topic=connect-status
```

### Kyuubi Configuration (`kyuubi-defaults.conf`)

```properties
kyuubi.engine.share.level=USER
kyuubi.engine.spark.master=spark://spark-master:7077
kyuubi.engine.spark.deployMode=client
```

(For Kubernetes: `k8s://https://<kubernetes-api-server>` instead.)

---

## 📊 Monitoring

- **AKHQ**: http://localhost:8080
- **Spark UI**: http://localhost:4040 (driver UI) or http://localhost:8088 (if using YARN)
- **Kyuubi UI**: http://localhost:10009 (optional if enabled)

---

## 🧠 Key Learnings Captured

- **Zookeeper** manages cluster coordination for Kafka (not data contracts).
- **Schema Registry** manages data contracts and schema compatibility.
- **Kafka Connect** needs internal topics with `compact` policy to persist state safely.
- **Kyuubi** is a smart client that submits Spark jobs to Standalone Master, YARN, or Kubernetes — not a part of Spark cluster control plane.
- **Hudi** allows efficient upserts and time-travel data lakes.
- **Airflow** orchestrates ingestion and transformation flows.

---

## 📈 Future Improvements

- Migrate Spark runtime from Standalone to Kubernetes for elastic scaling.
- Implement Fine-grained Authentication/Authorization on Kyuubi.
- Enable Kafka Connect Sink Connectors to directly write to Hudi or Delta Lake.
- Setup Monitoring (Prometheus + Grafana) for Kafka, Spark, Hudi, Kyuubi.

---

## ✨ Final Words

> **Today we built the engine. Tomorrow we'll race it to the cloud. 🚀**

---

# 🚀 Let's Build The Future.

---

# 🧹 TODO (Optional Enhancements)
- [ ] Implement Kyuubi session isolation by user
- [ ] Integrate with MinIO for external Hudi tables
- [ ] Add backup strategy for Kafka topics and schemas
- [ ] Upgrade to Spark 3.5.x + Iceberg table format support

---

# 🛡 License
MIT License

---

# ✨ Author
Built with ❤️ and madness by [anhhoangdev].
