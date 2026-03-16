# 🎯 Open Source AI/ML Platform - 100% AWS-Free Alternative

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-brightgreen.svg)](docker-compose.yml)
[![Open Source](https://img.shields.io/badge/Open%20Source-100%25-success.svg)](docs/open-source-alternative-landscape.md)

## 📖 Overview

This repository provides a **100% open-source alternative** to AWS SageMaker Distribution that can be deployed entirely on your local laptop using Docker Compose. No cloud account needed, no recurring costs, complete data privacy.

### What This Project Offers

✅ **Complete ML/AI Platform** - Everything from development to deployment
✅ **Zero Cloud Costs** - Run entirely on your hardware
✅ **Full Data Privacy** - Your data never leaves your machine
✅ **No Vendor Lock-in** - 100% open-source tools
✅ **One-Command Deploy** - `docker-compose up -d`
✅ **Production-Ready** - Battle-tested components

## 🚀 Quick Start

### Prerequisites

- Docker 24.0+ with Docker Compose V2
- 16GB RAM minimum (32GB+ recommended)
- 50GB free disk space
- Optional: NVIDIA GPU for acceleration

### Deploy in 30 Seconds

```bash
# Start all services
docker-compose up -d

# Check status
docker-compose ps
```

### Access Your Platform

| Service | URL | Purpose |
|---------|-----|---------|
| **JupyterLab** | http://localhost:8888 | Primary Development IDE |
| **MLflow** | http://localhost:5000 | Experiment Tracking |
| **Airflow** | http://localhost:8080 | Workflow Orchestration |
| **Grafana** | http://localhost:3001 | Monitoring Dashboards |
| **MinIO** | http://localhost:9001 | Object Storage (S3-compatible) |

**Default credentials**: See [Deployment Guide](docs/DEPLOYMENT_GUIDE.md#access-services)

## 📊 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Local Docker Environment                  │
├─────────────────────────────────────────────────────────────┤
│  Development     │  JupyterLab, VS Code Server, Terminal    │
│  ML Platform     │  MLflow, Airflow, BentoML, Feast         │
│  LLM Runtime     │  Ollama (Llama, Mistral, CodeLlama)      │
│  Data Layer      │  PostgreSQL, Redis, MinIO (S3)           │
│  Monitoring      │  Prometheus, Grafana                     │
│  Frameworks      │  PyTorch, TensorFlow, Scikit-learn       │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Use Cases

### 1. **Local ML Development**
Develop and train models on your laptop without cloud costs.

### 2. **Educational & Research**
Learn ML/AI with production-grade tools, no AWS account needed.

### 3. **Data Privacy & Compliance**
Keep sensitive data on-premises (GDPR, HIPAA, SOC2 compliant).

### 4. **Prototyping & Experimentation**
Iterate quickly without worrying about cloud costs.

### 5. **Offline AI Development**
Work on AI projects without internet connectivity.

## 📦 What's Inside?

### Core Components

#### **Development Environment**
- **JupyterLab 4.5+** - Full-featured data science IDE
- **VS Code Server** - Browser-based VS Code
- **Jupyter AI** - AI assistance in notebooks

#### **ML Platform (SageMaker Alternative)**
- **MLflow** - Experiment tracking & model registry
- **Apache Airflow** - Workflow orchestration (replaces SageMaker Pipelines)
- **BentoML** - Model serving (replaces SageMaker Inference)
- **Feast** - Feature store (replaces SageMaker Feature Store)

#### **LLM & GenAI (Bedrock Alternative)**
- **Ollama** - Local LLM runtime with Llama 3.3, Mistral, CodeLlama
- **LangChain** - LLM orchestration framework
- **Jupyter AI** - AI coding assistant

#### **Data Infrastructure (AWS Services Alternative)**
- **MinIO** - S3-compatible object storage (replaces Amazon S3)
- **PostgreSQL 16** - Relational database (replaces RDS)
- **Redis 7** - Cache & message queue (replaces ElastiCache)

#### **Monitoring (CloudWatch Alternative)**
- **Prometheus** - Metrics collection
- **Grafana** - Visualization dashboards
- **Traefik** - Reverse proxy & load balancing

#### **ML/AI Frameworks**
- PyTorch 2.6+
- TensorFlow 2.18+
- Keras 3.13+
- Scikit-learn 1.7+
- XGBoost 2.1+
- AutoGluon 1.5+

## 📚 Documentation

### Getting Started
- **[Deployment Guide](docs/DEPLOYMENT_GUIDE.md)** - Complete setup and configuration
- **[Welcome Notebook](notebooks/welcome.ipynb)** - Interactive tutorial

### Architecture & Analysis
- **[AWS AI/ML Landscape Analysis](docs/aws-ai-ml-landscape.md)** - Deep dive into AWS SageMaker architecture
- **[Open Source Alternative Landscape](docs/open-source-alternative-landscape.md)** - Component-by-component alternatives

### Configuration
- **[docker-compose.yml](docker-compose.yml)** - Main deployment configuration
- **[.env.example](.env.example)** - Environment variable templates

## 🔄 Migrating from AWS SageMaker

### Key Changes

| AWS Service | Open Source Alternative | Migration Effort |
|------------|------------------------|------------------|
| SageMaker Notebooks | JupyterLab | ✅ Easy - Compatible API |
| SageMaker Training | Native frameworks | ✅ Easy - Standard training code |
| SageMaker Experiments | MLflow | ✅ Easy - Similar concepts |
| SageMaker Pipelines | Apache Airflow | ⚠️ Medium - Different DAG syntax |
| SageMaker Inference | BentoML | ⚠️ Medium - Different deployment |
| Amazon S3 | MinIO | ✅ Easy - S3-compatible API |
| Amazon Bedrock | Ollama | ⚠️ Medium - Local LLM setup |

### Migration Steps

1. **Replace boto3 S3 with MinIO** - Change endpoint URL
2. **Replace SageMaker SDK with MLflow** - Log experiments directly
3. **Convert Pipelines to Airflow DAGs** - Rewrite workflow logic
4. **Update inference code for BentoML** - Create Bento services
5. **Test locally** - Validate all workflows

See [Deployment Guide](docs/DEPLOYMENT_GUIDE.md#migrating-from-aws-sagemaker) for detailed instructions.

## 🎓 Example: Simple ML Workflow

```python
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Set MLflow tracking
mlflow.set_tracking_uri("http://mlflow:5000")
mlflow.set_experiment("iris_classification")

# Load data
iris = load_iris()
X_train, X_test, y_train, y_test = train_test_split(
    iris.data, iris.target, test_size=0.2, random_state=42
)

# Train with MLflow tracking
with mlflow.start_run():
    # Train model
    clf = RandomForestClassifier(n_estimators=100, random_state=42)
    clf.fit(X_train, y_train)

    # Evaluate
    y_pred = clf.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)

    # Log to MLflow
    mlflow.log_param("n_estimators", 100)
    mlflow.log_metric("accuracy", accuracy)
    mlflow.sklearn.log_model(clf, "model")

    print(f"Model trained with accuracy: {accuracy:.4f}")
```

View results in MLflow UI: http://localhost:5000

## 🔧 Management

### Start/Stop Services

```bash
# Start all services
docker-compose up -d

# Stop all services (keeps data)
docker-compose down

# Stop and remove all data
docker-compose down -v

# Restart specific service
docker-compose restart mlflow

# View logs
docker-compose logs -f jupyter
```

### Backup & Restore

```bash
# Backup volumes
docker run --rm -v ml-jupyter-data:/data -v $(pwd):/backup \
    alpine tar czf /backup/jupyter-backup.tar.gz /data

# Restore volumes
docker run --rm -v ml-jupyter-data:/data -v $(pwd):/backup \
    alpine tar xzf /backup/jupyter-backup.tar.gz -C /
```

## 💡 Advanced Features

### GPU Acceleration

Enable NVIDIA GPU support:

```yaml
# In docker-compose.yml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu]
```

See [Deployment Guide](docs/DEPLOYMENT_GUIDE.md#gpu-support) for setup instructions.

### Custom Models

Add your own models to Ollama:

```bash
docker-compose exec ollama ollama pull deepseek-coder:6.7b
docker-compose exec ollama ollama list
```

### Production Deployment

Scale to multi-node with:
- **Docker Swarm** - Built-in orchestration
- **Kubernetes** - Convert with kompose
- **Cloud VMs** - Deploy on any cloud provider

## 🔒 Security

### Default Credentials (⚠️ Change for Production)

- JupyterLab: No password (token disabled)
- Airflow: admin / admin
- Grafana: admin / admin
- MinIO: minioadmin / minioadmin

See [Deployment Guide](docs/DEPLOYMENT_GUIDE.md#security-considerations) for hardening instructions.

## 📊 Comparison: AWS vs Open Source

| Aspect | AWS SageMaker | Open Source Platform |
|--------|--------------|---------------------|
| **Cost** | Pay-per-use | Free (hardware only) |
| **Data Privacy** | AWS has access | Complete control |
| **Customization** | Limited | Full control |
| **Offline Use** | ❌ Requires internet | ✅ Works offline |
| **Learning Curve** | AWS-specific | Standard tools |
| **Scalability** | Unlimited ($$) | Hardware limited |
| **Vendor Lock-in** | ⚠️ AWS-specific APIs | ✅ Portable |

## 🤝 Contributing

Contributions welcome! This is a community-driven alternative to proprietary ML platforms.

### Areas for Contribution

- Additional ML framework integrations
- Pre-built Grafana dashboards
- Example notebooks and tutorials
- Documentation improvements
- Performance optimizations
- Bug fixes and testing

## 📄 License

Apache 2.0 License - Same as the original Amazon SageMaker Distribution.

## 🙏 Acknowledgments

This project stands on the shoulders of giants:

- **JupyterLab** - Project Jupyter
- **MLflow** - Databricks
- **Apache Airflow** - Apache Software Foundation
- **PyTorch** - Meta AI
- **TensorFlow** - Google
- **Ollama** - Ollama Team
- **MinIO** - MinIO, Inc.
- All other open-source projects included

## 🆘 Support & Community

- **Documentation**: See [docs/](docs/)
- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions

## 🌟 Why This Project?

The AWS SageMaker Distribution is an excellent product, but:

1. **Requires AWS account** - Not everyone wants/needs cloud
2. **Recurring costs** - Can be expensive for experimentation
3. **Data privacy concerns** - Sensitive data in the cloud
4. **Vendor lock-in** - AWS-specific APIs and services
5. **Internet dependency** - Can't work offline

This project provides a **local-first alternative** using 100% open-source tools that you can:

✅ Deploy on your laptop in minutes
✅ Use without any cloud account
✅ Keep your data completely private
✅ Run offline without internet
✅ Customize to your exact needs
✅ Scale to production when ready

## 🗺️ Roadmap

- [ ] Add Ray for distributed computing
- [ ] Add Kubeflow Pipelines integration
- [ ] Add Apache Spark cluster
- [ ] Add DVC for data versioning
- [ ] Add pre-built Grafana dashboards
- [ ] Add model monitoring with Evidently
- [ ] Add AutoML with AutoGluon integration
- [ ] Add vector database (Milvus/Weaviate)
- [ ] Add Kubernetes deployment manifests
- [ ] Add CI/CD pipeline examples

---

**Made with ❤️ by the Open Source ML Community**

**No AWS account required | No cloud costs | Complete data privacy | 100% open source**

Star ⭐ this repo if you find it useful!
