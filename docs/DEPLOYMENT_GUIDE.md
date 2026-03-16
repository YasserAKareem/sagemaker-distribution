# Open Source AI/ML Platform - Local Deployment Guide

## 🚀 Quick Start

Deploy a complete, 100% open-source AI/ML platform on your local laptop using Docker Compose.

**Alternative to**: AWS SageMaker Distribution (no cloud costs, complete data privacy)

### Prerequisites

- **Docker**: 24.0+ with Docker Compose V2
- **Hardware**: 16GB RAM minimum (32GB+ recommended)
- **Storage**: 50GB free space (100GB+ for models)
- **OS**: Linux, macOS, or Windows with WSL2
- **Optional**: NVIDIA GPU with nvidia-docker2 for GPU acceleration

### One-Command Deployment

```bash
# Clone repository (if not already cloned)
git clone https://github.com/YasserAKareem/sagemaker-distribution.git
cd sagemaker-distribution

# Start all services
docker-compose up -d

# Check status
docker-compose ps
```

That's it! 🎉

## 📊 Access Services

After starting, access these services:

| Service | URL | Credentials | Purpose |
|---------|-----|-------------|---------|
| **JupyterLab** | http://localhost:8888 | None (token disabled) | Primary IDE |
| **VS Code Server** | http://localhost:8443 | admin / admin | Alternative IDE |
| **MLflow** | http://localhost:5000 | None | Experiment tracking |
| **Apache Airflow** | http://localhost:8080 | admin / admin | Workflow orchestration |
| **Grafana** | http://localhost:3001 | admin / admin | Monitoring dashboards |
| **MinIO Console** | http://localhost:9001 | minioadmin / minioadmin | Object storage |
| **Prometheus** | http://localhost:9090 | None | Metrics collection |
| **BentoML** | http://localhost:3000 | None | Model serving |
| **Ollama API** | http://localhost:11434 | None | Local LLM inference |

## 📚 What's Included?

### Development Environments
- ✅ **JupyterLab 4.5+** - Full-featured data science IDE
- ✅ **VS Code Server** - Browser-based VS Code
- ✅ **Terminal access** - Full shell access

### ML/AI Frameworks
- ✅ **PyTorch 2.6+** - Deep learning framework
- ✅ **TensorFlow 2.18+** - ML platform
- ✅ **Scikit-learn** - Traditional ML
- ✅ **XGBoost** - Gradient boosting
- ✅ **LightGBM** - Fast gradient boosting
- ✅ **AutoGluon** - AutoML toolkit

### ML Platform Services
- ✅ **MLflow** - Experiment tracking & model registry (replaces SageMaker Experiments)
- ✅ **Apache Airflow** - Workflow orchestration (replaces SageMaker Pipelines)
- ✅ **BentoML** - Model serving (replaces SageMaker Inference)
- ✅ **Feast** - Feature store (replaces SageMaker Feature Store)

### Data Services
- ✅ **PostgreSQL 16** - Relational database
- ✅ **Redis 7** - In-memory cache
- ✅ **MinIO** - S3-compatible object storage (replaces Amazon S3)

### LLM & GenAI
- ✅ **Ollama** - Local LLM runtime (replaces Amazon Bedrock)
- ✅ **LangChain** - LLM orchestration framework
- ✅ **Jupyter AI** - AI assistance in notebooks

### Monitoring & Observability
- ✅ **Prometheus** - Metrics collection (replaces CloudWatch)
- ✅ **Grafana** - Visualization dashboards
- ✅ **Traefik** - Reverse proxy & load balancer

## 🎯 Getting Started Tutorial

### 1. Open JupyterLab

```bash
# Open browser to http://localhost:8888
# No password needed (token disabled for local development)
```

Open the **welcome.ipynb** notebook in the `notebooks/` folder.

### 2. Test the Platform

The welcome notebook includes tests for:
- PyTorch & TensorFlow
- MLflow experiment tracking
- MinIO object storage
- Ollama local LLM
- Sample ML pipeline

### 3. Create Your First ML Experiment

```python
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris

# Set MLflow tracking server
mlflow.set_tracking_uri("http://mlflow:5000")
mlflow.set_experiment("my_experiment")

# Train and log model
with mlflow.start_run():
    iris = load_iris()
    clf = RandomForestClassifier()
    clf.fit(iris.data, iris.target)

    mlflow.log_param("n_estimators", 100)
    mlflow.log_metric("accuracy", 0.95)
    mlflow.sklearn.log_model(clf, "model")
```

View the experiment in MLflow UI: http://localhost:5000

### 4. Use Local LLM (Ollama)

```python
import requests

response = requests.post(
    "http://ollama:11434/api/generate",
    json={
        "model": "codellama:7b-instruct",
        "prompt": "Write a Python function to calculate fibonacci numbers"
    }
)
print(response.json()["response"])
```

### 5. Store Data in MinIO (S3-compatible)

```python
import boto3

s3 = boto3.client(
    's3',
    endpoint_url='http://minio:9000',
    aws_access_key_id='minioadmin',
    aws_secret_access_key='minioadmin'
)

# Upload file
s3.upload_file('data.csv', 'datasets', 'data.csv')

# List objects
objects = s3.list_objects_v2(Bucket='datasets')
```

## 🔧 Configuration

### Environment Variables

Edit `docker-compose.yml` to customize:

```yaml
environment:
  - MLFLOW_TRACKING_URI=http://mlflow:5000
  - MINIO_ENDPOINT=http://minio:9000
  - OLLAMA_HOST=http://ollama:11434
```

### GPU Support

For NVIDIA GPU acceleration:

1. Install nvidia-docker2:
```bash
# Ubuntu/Debian
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

2. Uncomment GPU sections in `docker-compose.yml`

3. Restart services:
```bash
docker-compose down
docker-compose up -d
```

### Persistent Data

Data is stored in Docker volumes:

```bash
# List volumes
docker volume ls | grep ml-

# Backup a volume
docker run --rm -v ml-jupyter-data:/data -v $(pwd):/backup \
    alpine tar czf /backup/jupyter-backup.tar.gz /data

# Restore a volume
docker run --rm -v ml-jupyter-data:/data -v $(pwd):/backup \
    alpine tar xzf /backup/jupyter-backup.tar.gz -C /
```

## 🛠️ Management Commands

### Start Services

```bash
# Start all services
docker-compose up -d

# Start specific service
docker-compose up -d jupyter mlflow

# Start with logs
docker-compose up
```

### Stop Services

```bash
# Stop all services (keeps data)
docker-compose down

# Stop and remove volumes (deletes data)
docker-compose down -v
```

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f jupyter

# Last 100 lines
docker-compose logs --tail=100 mlflow
```

### Restart Services

```bash
# Restart all
docker-compose restart

# Restart one service
docker-compose restart jupyter
```

### Update Services

```bash
# Pull latest images
docker-compose pull

# Recreate containers
docker-compose up -d --force-recreate
```

### Shell Access

```bash
# Jupyter container
docker-compose exec jupyter bash

# MLflow container
docker-compose exec mlflow bash

# Postgres container
docker-compose exec postgres psql -U mluser -d mlplatform
```

## 🔍 Monitoring

### Check Service Health

```bash
# All services
docker-compose ps

# Specific service
docker inspect ml-jupyter

# Resource usage
docker stats
```

### Grafana Dashboards

1. Open Grafana: http://localhost:3001
2. Login: admin / admin
3. Add Prometheus data source: http://prometheus:9090
4. Import dashboards from Grafana Labs

### Prometheus Metrics

Access Prometheus: http://localhost:9090

Example queries:
```promql
# Container CPU usage
container_cpu_usage_seconds_total

# Memory usage
container_memory_usage_bytes

# MLflow requests
mlflow_requests_total
```

## 🚢 Deployment Options

### Single Machine (Development)

Current setup - perfect for:
- Local development
- Prototyping
- Learning
- Small datasets

### Multi-Node (Production)

For production workloads:

1. **Docker Swarm**:
```bash
docker swarm init
docker stack deploy -c docker-compose.yml ml-platform
```

2. **Kubernetes**:
```bash
# Convert to k8s manifests
kompose convert -f docker-compose.yml

# Deploy
kubectl apply -f .
```

3. **Cloud VMs**:
Deploy on any cloud provider (AWS EC2, Azure VM, GCP Compute Engine)

## 📖 Migrating from AWS SageMaker

### Code Changes Required

1. **Replace boto3 S3 calls with MinIO**:
```python
# Before (AWS)
import boto3
s3 = boto3.client('s3')

# After (MinIO)
import boto3
s3 = boto3.client(
    's3',
    endpoint_url='http://minio:9000',
    aws_access_key_id='minioadmin',
    aws_secret_access_key='minioadmin'
)
```

2. **Replace SageMaker SDK with MLflow**:
```python
# Before (SageMaker)
from sagemaker.sklearn import SKLearn
estimator = SKLearn(...)
estimator.fit(...)

# After (MLflow)
import mlflow
with mlflow.start_run():
    model.fit(X_train, y_train)
    mlflow.sklearn.log_model(model, "model")
```

3. **Replace SageMaker Pipelines with Airflow**:
```python
# Create DAG in dags/my_pipeline.py
from airflow import DAG
from airflow.operators.python import PythonOperator

with DAG('ml_pipeline', ...) as dag:
    task1 = PythonOperator(task_id='train', ...)
    task2 = PythonOperator(task_id='evaluate', ...)
    task1 >> task2
```

## 🔒 Security Considerations

### Default Credentials

**⚠️ Change these for production!**

- JupyterLab: No password (set JUPYTER_TOKEN)
- Airflow: admin / admin
- Grafana: admin / admin
- MinIO: minioadmin / minioadmin
- PostgreSQL: mluser / mlpassword

### Enable Authentication

1. **JupyterLab**:
```yaml
command: start-notebook.sh --NotebookApp.token='your-secure-token'
```

2. **Airflow** - Set strong password during init

3. **MinIO** - Change root credentials in environment

### Network Security

- Services exposed only on localhost
- Use Traefik for SSL/TLS in production
- Configure firewall rules for external access

## ❓ Troubleshooting

### Services Won't Start

```bash
# Check Docker
docker --version
docker-compose --version

# Check disk space
df -h

# Check logs
docker-compose logs
```

### Out of Memory

```bash
# Check memory usage
docker stats

# Increase Docker memory limit
# Docker Desktop: Settings → Resources → Memory
```

### Port Conflicts

If ports are already in use, edit `docker-compose.yml`:

```yaml
ports:
  - "8889:8888"  # Changed from 8888:8888
```

### Ollama Models Not Downloading

```bash
# Manually pull models
docker-compose exec ollama ollama pull codellama:7b-instruct
docker-compose exec ollama ollama pull llama3.3:latest
```

### PostgreSQL Connection Failed

```bash
# Wait for initialization
docker-compose logs postgres

# Check health
docker-compose exec postgres pg_isready -U mluser
```

## 📚 Additional Resources

### Documentation

- [AWS AI/ML Landscape Analysis](docs/aws-ai-ml-landscape.md)
- [Open Source Alternative Landscape](docs/open-source-alternative-landscape.md)

### External Links

- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [Apache Airflow Documentation](https://airflow.apache.org/docs/)
- [Ollama Documentation](https://ollama.ai/docs)
- [BentoML Documentation](https://docs.bentoml.com/)
- [Feast Documentation](https://docs.feast.dev/)

## 🤝 Contributing

This is an open-source alternative to AWS SageMaker Distribution. Contributions welcome!

## 📄 License

Apache 2.0 License - Same as the original SageMaker Distribution project.

## 🆘 Support

- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions
- **Community**: Join our Slack/Discord

---

**Made with ❤️ by the Open Source ML Community**

**No AWS account required | No cloud costs | Complete data privacy | 100% open source**
