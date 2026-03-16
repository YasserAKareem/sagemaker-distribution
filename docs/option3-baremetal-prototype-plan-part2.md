# Option 3: Bare Metal/VMs - Implementation Plan (Part 2)
## Phases 5-7, Work Breakdown Structure, Business Processes & Use Cases

**Continuation of**: option3-baremetal-prototype-plan.md

---

## Phase 5: Application Deployment (Weeks 6-10)

### Objectives
- Deploy and configure all ML services
- Integrate services with authentication
- Test end-to-end workflows
- Performance tuning

### Week 6-7: Core ML Services

#### 5.1 JupyterHub Configuration

**Create JupyterHub Config**:

```python
# configs/jupyterhub_config.py

c = get_config()

# Basic configuration
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8000
c.JupyterHub.bind_url = 'http://0.0.1.10:8000'

# Database configuration (PostgreSQL)
c.JupyterHub.db_url = 'postgresql://mluser:mlpassword123@10.0.1.20:5432/jupyterhub'

# Spawner configuration (DockerSpawner)
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

# Docker image for notebooks
c.DockerSpawner.image = 'jupyter/tensorflow-notebook:latest'

# Network configuration
c.DockerSpawner.network_name = 'hospital-network'

# GPU access
c.DockerSpawner.extra_create_kwargs = {
    'user': '1000'
}

# Resource limits
c.DockerSpawner.mem_limit = '4G'
c.DockerSpawner.cpu_limit = 2.0

# Persistent storage
c.DockerSpawner.volumes = {
    'jupyterhub-user-{username}': '/home/jovyan/work'
}

# User profiles (CPU vs GPU notebooks)
c.Spawner.profile_list = [
    {
        'display_name': 'Data Science (CPU Only)',
        'description': 'Standard notebook with CPU resources',
        'default': True,
        'kubespawner_override': {
            'image': 'jupyter/datascience-notebook:latest',
            'mem_limit': '2G',
            'cpu_limit': 1.0
        }
    },
    {
        'display_name': 'Machine Learning (GPU)',
        'description': 'TensorFlow/PyTorch with GPU support',
        'kubespawner_override': {
            'image': 'jupyter/tensorflow-notebook:latest',
            'mem_limit': '8G',
            'cpu_limit': 4.0,
            'extra_resource_limits': {"nvidia.com/gpu": "1"}
        }
    }
]

# Authentication (dummy for prototype)
c.JupyterHub.authenticator_class = 'dummy'
c.DummyAuthenticator.password = 'test123'

# Admin users
c.Authenticator.admin_users = {'admin', 'mleng1'}
c.Authenticator.allowed_users = {'user1', 'user2', 'mleng1', 'mleng2'}

# Idle server culling (shut down after 2 hours idle)
c.JupyterHub.services = [
    {
        'name': 'idle-culler',
        'admin': True,
        'command': [
            'python3',
            '-m', 'jupyterhub_idle_culler',
            '--timeout=7200'
        ],
    }
]
```

**Deploy JupyterHub**:

```bash
# On GPU Node (VM1)
cd /home/mlplatform/hospital-aiml-platform
docker-compose up -d jupyterhub

# Verify
docker logs jupyterhub
curl http://10.0.1.10:8000

# Access JupyterHub
# Open browser: http://10.0.1.10:8000
# Login: admin / test123
```

#### 5.2 MLflow Deployment

**MLflow is already defined in docker-compose.yml**. Additional setup:

```bash
# On App Node (VM3)
docker-compose up -d mlflow

# Wait for service to start
sleep 30

# Create initial experiment
curl -X POST http://10.0.1.30:5000/api/2.0/mlflow/experiments/create \
  -H "Content-Type: application/json" \
  -d '{"name": "Default", "artifact_location": "s3://mlflow-artifacts/default"}'

# Verify MLflow
curl http://10.0.1.30:5000/health

# Access MLflow UI
# Open browser: http://10.0.1.30:5000
```

#### 5.3 Airflow Deployment

**Create Sample DAG**:

```python
# dags/sample_ml_pipeline.py

from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'aiml-platform',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'sample_ml_pipeline',
    default_args=default_args,
    description='Sample ML pipeline',
    schedule_interval=timedelta(days=1),
)

def load_data():
    """Load data from source"""
    print("Loading data...")
    # Implement data loading logic
    return True

def preprocess_data():
    """Preprocess data"""
    print("Preprocessing data...")
    # Implement preprocessing logic
    return True

def train_model():
    """Train ML model"""
    print("Training model...")
    # Implement training logic
    return True

def evaluate_model():
    """Evaluate model"""
    print("Evaluating model...")
    # Implement evaluation logic
    return True

# Define tasks
task_load = PythonOperator(
    task_id='load_data',
    python_callable=load_data,
    dag=dag,
)

task_preprocess = PythonOperator(
    task_id='preprocess_data',
    python_callable=preprocess_data,
    dag=dag,
)

task_train = PythonOperator(
    task_id='train_model',
    python_callable=train_model,
    dag=dag,
)

task_evaluate = PythonOperator(
    task_id='evaluate_model',
    python_callable=evaluate_model,
    dag=dag,
)

# Define task dependencies
task_load >> task_preprocess >> task_train >> task_evaluate
```

**Deploy Airflow**:

```bash
# On App Node (VM3)
cd /home/mlplatform/hospital-aiml-platform

# Generate Fernet key for Airflow
python3 -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
# Add to .env file: AIRFLOW_FERNET_KEY=<generated_key>

# Deploy
docker-compose up -d airflow-webserver airflow-scheduler

# Verify
docker logs airflow-webserver
curl http://10.0.1.30:8080/health

# Access Airflow UI
# Open browser: http://10.0.1.30:8080
# Login: admin / admin123
```

### Week 8-9: Model Serving & Inference

#### 5.4 vLLM Server Setup

**Download Models**:

```bash
# On GPU Node (VM1)

# Create model cache directory
sudo mkdir -p /data/vllm-models
sudo chown -R 1000:1000 /data/vllm-models

# Start vLLM service
cd /home/mlplatform/hospital-aiml-platform
docker-compose up -d vllm-server

# Monitor download progress (models are downloaded on first start)
docker logs -f vllm-server

# This will download Mistral-7B-Instruct (14GB)
# Takes 10-30 minutes depending on internet speed

# Once download complete, verify service
curl http://10.0.1.10:8001/v1/models

# Test inference
curl -X POST http://10.0.1.10:8001/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "mistralai/Mistral-7B-Instruct-v0.2",
    "prompt": "What are the symptoms of pneumonia?",
    "max_tokens": 100,
    "temperature": 0.7
  }'
```

#### 5.5 Triton Inference Server (Optional)

**For serving traditional ML models (scikit-learn, TensorFlow, PyTorch)**:

```bash
# On GPU Node (VM1)

# Create model repository
sudo mkdir -p /data/triton-models
sudo chown -R 1000:1000 /data/triton-models

# Add Triton to docker-compose.yml
cat >> /home/mlplatform/hospital-aiml-platform/docker-compose.yml <<'EOF'

  triton-server:
    image: nvcr.io/nvidia/tritonserver:23.11-py3
    container_name: triton-server
    hostname: triton
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.10:8002:8000"  # HTTP
      - "10.0.1.10:8003:8001"  # gRPC
      - "10.0.1.10:8004:8002"  # Metrics
    volumes:
      - /data/triton-models:/models
    command: tritonserver --model-repository=/models --strict-model-config=false
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
        limits:
          memory: 8G
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/v2/health/ready"]
      interval: 30s
      timeout: 10s
      retries: 5
EOF

# Deploy Triton
docker-compose up -d triton-server

# Verify
curl http://10.0.1.10:8002/v2/health/ready
```

### Week 10: Monitoring Integration

#### 5.6 Grafana Dashboard Setup

**Import Pre-Built Dashboards**:

```bash
# On App Node (VM3)

# Access Grafana
# http://10.0.1.30:3000

# Import dashboards (via UI or API)
# 1. Node Exporter Full (Dashboard ID: 1860)
curl -X POST http://admin:admin123@10.0.1.30:3000/api/dashboards/import \
  -H "Content-Type: application/json" \
  -d '{
    "dashboard": {
      "id": null,
      "uid": null,
      "title": "Node Exporter Full"
    },
    "overwrite": false,
    "inputs": [
      {
        "name": "DS_PROMETHEUS",
        "type": "datasource",
        "pluginId": "prometheus",
        "value": "Prometheus"
      }
    ]
  }'

# 2. NVIDIA DCGM Exporter (Dashboard ID: 12239)
# 3. PostgreSQL Database (Dashboard ID: 9628)
# 4. MinIO Dashboard (Dashboard ID: 13021)

# Or manually import via UI:
# Dashboards → Import → Enter ID → Load → Select Prometheus → Import
```

**Create Custom Dashboard for ML Platform**:

```json
{
  "dashboard": {
    "title": "Hospital AI/ML Platform Overview",
    "panels": [
      {
        "title": "Active JupyterHub Sessions",
        "targets": [
          {
            "expr": "count(jupyterhub_active_users)"
          }
        ],
        "type": "stat"
      },
      {
        "title": "MLflow Experiments (Last 24h)",
        "targets": [
          {
            "expr": "increase(mlflow_experiments_total[24h])"
          }
        ],
        "type": "graph"
      },
      {
        "title": "vLLM Request Latency (p95)",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, vllm_request_duration_seconds)"
          }
        ],
        "type": "graph"
      },
      {
        "title": "GPU Utilization",
        "targets": [
          {
            "expr": "DCGM_FI_DEV_GPU_UTIL"
          }
        ],
        "type": "gauge"
      }
    ]
  }
}
```

---

## Phase 6: Integration & Testing (Weeks 10-12)

### Objectives
- End-to-end testing of all services
- Load testing (10-20 concurrent users)
- Security testing
- Documentation of procedures

### Week 10-11: Integration Testing

#### 6.1 Service Integration Tests

**Test Plan**:

```yaml
Test Suite 1: Data Flow
  Test 1.1: Upload data to MinIO
    - Upload CSV file to MinIO bucket
    - Verify file accessible via S3 API
    - Expected: 200 OK, file listed

  Test 1.2: Connect Jupyter to MinIO
    - Launch Jupyter notebook
    - Read file from MinIO using boto3
    - Expected: Data loads successfully

  Test 1.3: Log experiment to MLflow
    - Train simple model in Jupyter
    - Log metrics to MLflow
    - Expected: Experiment appears in MLflow UI

Test Suite 2: ML Workflow
  Test 2.1: Train model in Jupyter
    - Load dataset
    - Train scikit-learn model
    - Save model to MLflow
    - Expected: Model registered in MLflow

  Test 2.2: Deploy model with vLLM
    - Download model weights
    - Start vLLM server
    - Send inference request
    - Expected: Response with prediction

  Test 2.3: Airflow DAG execution
    - Trigger sample ML pipeline DAG
    - Monitor task execution
    - Expected: All tasks succeed

Test Suite 3: Monitoring
  Test 3.1: Prometheus metrics collection
    - Check Prometheus targets
    - Query GPU metrics
    - Expected: All targets UP, metrics available

  Test 3.2: Grafana dashboards
    - Open each dashboard
    - Verify data displayed
    - Expected: Dashboards populate with data

  Test 3.3: Alert testing
    - Simulate high GPU temperature
    - Verify alert triggered
    - Expected: Alert fires, notification sent
```

**Execute Integration Tests**:

```bash
# Create test script
cat > /home/mlplatform/test-integration.sh <<'EOF'
#!/bin/bash

echo "==== Hospital AI/ML Platform Integration Tests ===="

# Test 1: Service Health Checks
echo "\n[Test 1] Service Health Checks"
services=("postgres:10.0.1.20:5432" "redis:10.0.1.20:6379" "minio:10.0.1.20:9000" "mlflow:10.0.1.30:5000" "jupyterhub:10.0.1.10:8000" "vllm:10.0.1.10:8001" "grafana:10.0.1.30:3000" "prometheus:10.0.1.30:9090")

for service in "${services[@]}"; do
  name=$(echo $service | cut -d':' -f1)
  host=$(echo $service | cut -d':' -f2-3)

  if nc -zv $host 2>&1 | grep -q "succeeded"; then
    echo "✓ $name is UP"
  else
    echo "✗ $name is DOWN"
  fi
done

# Test 2: MinIO S3 API
echo "\n[Test 2] MinIO S3 API"
echo "test data" > /tmp/test-file.txt
aws s3 --endpoint-url http://10.0.1.20:9000 cp /tmp/test-file.txt s3://datasets/test-file.txt
if [ $? -eq 0 ]; then
  echo "✓ File uploaded to MinIO"
else
  echo "✗ MinIO upload failed"
fi

# Test 3: PostgreSQL Connection
echo "\n[Test 3] PostgreSQL Connection"
PGPASSWORD=mlpassword123 psql -h 10.0.1.20 -U mluser -d mlplatform -c "SELECT version();" > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✓ PostgreSQL connection successful"
else
  echo "✗ PostgreSQL connection failed"
fi

# Test 4: vLLM Inference
echo "\n[Test 4] vLLM Inference"
response=$(curl -s -X POST http://10.0.1.10:8001/v1/completions \
  -H "Content-Type: application/json" \
  -d '{"model": "mistralai/Mistral-7B-Instruct-v0.2", "prompt": "Hello", "max_tokens": 10}')

if echo "$response" | grep -q "choices"; then
  echo "✓ vLLM inference working"
else
  echo "✗ vLLM inference failed"
fi

# Test 5: MLflow API
echo "\n[Test 5] MLflow API"
curl -s http://10.0.1.30:5000/api/2.0/mlflow/experiments/list | grep -q "experiments"
if [ $? -eq 0 ]; then
  echo "✓ MLflow API responsive"
else
  echo "✗ MLflow API failed"
fi

# Test 6: Prometheus Metrics
echo "\n[Test 6] Prometheus Metrics"
curl -s http://10.0.1.30:9090/-/healthy | grep -q "Prometheus"
if [ $? -eq 0 ]; then
  echo "✓ Prometheus healthy"
else
  echo "✗ Prometheus unhealthy"
fi

echo "\n==== Integration Tests Complete ===="
EOF

chmod +x /home/mlplatform/test-integration.sh
./test-integration.sh
```

#### 6.2 Load Testing

**JupyterHub Load Test** (10 concurrent users):

```python
# load-test-jupyter.py

import concurrent.futures
import requests
import time

JUPYTERHUB_URL = "http://10.0.1.10:8000"
NUM_USERS = 10

def launch_notebook(user_id):
    """Simulate user launching notebook"""
    start_time = time.time()

    # Login
    session = requests.Session()
    response = session.post(
        f"{JUPYTERHUB_URL}/hub/login",
        data={"username": f"user{user_id}", "password": "test123"}
    )

    if response.status_code != 200:
        return f"User {user_id}: Login failed"

    # Spawn notebook server
    response = session.post(f"{JUPYTERHUB_URL}/hub/spawn")

    # Wait for server to start (timeout 60s)
    for _ in range(60):
        response = session.get(f"{JUPYTERHUB_URL}/user/user{user_id}/api/status")
        if response.status_code == 200:
            break
        time.sleep(1)

    elapsed = time.time() - start_time
    return f"User {user_id}: Notebook started in {elapsed:.2f}s"

# Run load test
with concurrent.futures.ThreadPoolExecutor(max_workers=NUM_USERS) as executor:
    futures = [executor.submit(launch_notebook, i) for i in range(NUM_USERS)]

    for future in concurrent.futures.as_completed(futures):
        print(future.result())
```

**vLLM Load Test** (100 requests/second):

```python
# load-test-vllm.py

import asyncio
import aiohttp
import time
from statistics import mean, median

VLLM_URL = "http://10.0.1.10:8001/v1/completions"
NUM_REQUESTS = 1000
CONCURRENT_REQUESTS = 100

async def send_request(session, request_id):
    """Send inference request"""
    start_time = time.time()

    payload = {
        "model": "mistralai/Mistral-7B-Instruct-v0.2",
        "prompt": f"Request {request_id}: What is machine learning?",
        "max_tokens": 50
    }

    try:
        async with session.post(VLLM_URL, json=payload) as response:
            await response.json()
            latency = time.time() - start_time
            return {"id": request_id, "latency": latency, "status": response.status}
    except Exception as e:
        return {"id": request_id, "latency": -1, "status": "error", "error": str(e)}

async def run_load_test():
    """Run load test"""
    async with aiohttp.ClientSession() as session:
        tasks = [send_request(session, i) for i in range(NUM_REQUESTS)]

        # Send requests in batches
        results = []
        for i in range(0, NUM_REQUESTS, CONCURRENT_REQUESTS):
            batch = tasks[i:i+CONCURRENT_REQUESTS]
            batch_results = await asyncio.gather(*batch)
            results.extend(batch_results)
            print(f"Completed {i+len(batch)}/{NUM_REQUESTS} requests")

    # Calculate statistics
    successful = [r for r in results if r["status"] == 200]
    latencies = [r["latency"] for r in successful]

    print("\n==== Load Test Results ====")
    print(f"Total requests: {NUM_REQUESTS}")
    print(f"Successful: {len(successful)}")
    print(f"Failed: {NUM_REQUESTS - len(successful)}")
    print(f"Success rate: {len(successful)/NUM_REQUESTS*100:.2f}%")
    print(f"Mean latency: {mean(latencies):.3f}s")
    print(f"Median latency: {median(latencies):.3f}s")
    print(f"Min latency: {min(latencies):.3f}s")
    print(f"Max latency: {max(latencies):.3f}s")

# Run
asyncio.run(run_load_test())
```

### Week 11-12: Security & Documentation

#### 6.3 Security Hardening

**Security Checklist**:

```bash
# 1. Change all default passwords
# - PostgreSQL: mluser password
# - MinIO: root credentials
# - Grafana: admin password
# - Airflow: admin password
# - JupyterHub: admin password

# 2. Enable HTTPS (Let's Encrypt or self-signed)
# Already done in Phase 1

# 3. Configure firewall rules (already done)
sudo ufw status

# 4. Enable audit logging
# For PostgreSQL
docker exec -it postgres psql -U mluser -d mlplatform -c "ALTER SYSTEM SET log_statement = 'all';"
docker restart postgres

# 5. Implement backup scripts
cat > /home/mlplatform/backup.sh <<'EOF'
#!/bin/bash
BACKUP_DIR="/data/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Backup PostgreSQL
docker exec postgres pg_dumpall -U mluser | gzip > $BACKUP_DIR/postgres_$DATE.sql.gz

# Backup MinIO (sync to backup location)
docker exec minio mc mirror local/mlflow-artifacts /backup/minio/mlflow-artifacts

# Backup Grafana dashboards
curl -s http://admin:admin123@10.0.1.30:3000/api/dashboards/home | gzip > $BACKUP_DIR/grafana_$DATE.json.gz

# Rotate old backups (keep last 7 days)
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete

echo "Backup completed: $DATE"
EOF

chmod +x /home/mlplatform/backup.sh

# Schedule daily backups
(crontab -l 2>/dev/null; echo "0 2 * * * /home/mlplatform/backup.sh") | crontab -
```

---

## Phase 7: Documentation & Handoff (Weeks 12-14)

### Objectives
- Complete all documentation
- Create runbooks
- Train team members
- Prepare production roadmap

### Week 12-13: Documentation

#### 7.1 Architecture Documentation

**Already created**:
- hospital-architecture.md
- competitive-landscape-aws-vs-opensource.md
- RFP-Hospital-AIML-Platform.md

**Add**:
- option3-baremetal-prototype-plan.md (this document)

#### 7.2 Runbooks

**Example Runbook: Restart Service**:

```markdown
# Runbook: Restart Service

## Symptoms
- Service not responding
- High error rate
- Memory leak suspected

## Diagnosis
1. Check service logs:
   ```bash
   docker logs <service_name>
   ```

2. Check resource usage:
   ```bash
   docker stats <service_name>
   ```

3. Check service health:
   ```bash
   curl http://<service_endpoint>/health
   ```

## Resolution
1. Restart service:
   ```bash
   docker-compose restart <service_name>
   ```

2. If restart fails, force recreate:
   ```bash
   docker-compose up -d --force-recreate <service_name>
   ```

3. Verify service is running:
   ```bash
   docker ps | grep <service_name>
   docker logs -f <service_name>
   ```

## Prevention
- Monitor resource usage (Grafana)
- Set up alerts for high memory/CPU
- Review service logs regularly
```

### Week 13-14: Training & Handoff

#### 7.3 Training Plan

**Developer Training** (2 days):

**Day 1: Platform Overview**
- 9:00 AM: Architecture overview (Tech Lead)
- 10:00 AM: JupyterHub hands-on (ML Engineer)
- 11:00 AM: MLflow experiment tracking (ML Engineer)
- 2:00 PM: vLLM inference API (ML Engineer)
- 3:00 PM: Airflow DAGs (DevOps)

**Day 2: Advanced Topics**
- 9:00 AM: Model deployment workflows (ML Engineer)
- 10:00 AM: Monitoring and troubleshooting (DevOps)
- 11:00 AM: Security best practices (DevOps)
- 2:00 PM: Use case walkthroughs (ML Engineer)
- 3:00 PM: Q&A and hands-on practice

---

## Work Breakdown Structure (WBS)

### WBS Level 1: Major Phases

```
Hospital AI/ML Platform Prototype (Option 3)
├── 1.0 Pre-Work
├── 2.0 Infrastructure Setup
├── 3.0 UI/UX Design
├── 4.0 VM Configuration
├── 5.0 Docker Orchestration
├── 6.0 Application Deployment
├── 7.0 Integration & Testing
├── 8.0 Documentation & Handoff
└── 9.0 Production Planning
```

### WBS Level 2: Detailed Tasks

```
1.0 Pre-Work (Weeks -2 to 0)
  1.1 Requirements Gathering
    1.1.1 Stakeholder interviews
    1.1.2 Use case definition
    1.1.3 Success criteria
    1.1.4 Project charter
  1.2 Hardware/VM Procurement
    1.2.1 Technical specifications
    1.2.2 Vendor selection
    1.2.3 Purchase approval
    1.2.4 Delivery and setup
  1.3 Team Formation
    1.3.1 Role definitions
    1.3.2 Recruitment (if needed)
    1.3.3 Onboarding
  1.4 Development Environment
    1.4.1 Local machine setup
    1.4.2 Collaboration tools
    1.4.3 Git repository
    1.4.4 Documentation wiki

2.0 Infrastructure Setup (Weeks 1-3)
  2.1 VM Provisioning
    2.1.1 Cloud VM setup (AWS/Azure/GCP)
    2.1.2 Networking configuration
    2.1.3 Security groups/firewalls
  2.2 Operating System Setup
    2.2.1 Ubuntu installation
    2.2.2 System updates
    2.2.3 User accounts
    2.2.4 Storage mounting
  2.3 Docker Installation
    2.3.1 Docker Engine
    2.3.2 Docker Compose
    2.3.3 NVIDIA drivers (GPU node)
    2.3.4 Container toolkit
  2.4 Networking & Security
    2.4.1 Firewall rules
    2.4.2 SSL certificates
    2.4.3 DNS configuration
  2.5 Shared Storage
    2.5.1 MinIO deployment
    2.5.2 PostgreSQL deployment
    2.5.3 Redis deployment
    2.5.4 Git server (Gitea)

3.0 UI/UX Design System (Weeks 2-4)
  3.1 Design Principles
    3.1.1 Design philosophy
    3.1.2 Persona-centric approach
    3.1.3 Accessibility requirements
  3.2 Visual Design
    3.2.1 Color palette
    3.2.2 Typography
    3.2.3 Iconography
    3.2.4 Branding guidelines
  3.3 Component Library
    3.3.1 Layout components
    3.3.2 Form components
    3.3.3 Data display components
    3.3.4 Feedback components
  3.4 Portal Wireframes
    3.4.1 Developer portal
    3.4.2 Clinical portal
    3.4.3 Management portal
  3.5 Frontend Implementation
    3.5.1 React project setup
    3.5.2 Component development
    3.5.3 API integration
    3.5.4 Testing

4.0 VM Configuration (Weeks 3-5)
  4.1 GPU Node Configuration
    4.1.1 NVIDIA driver setup
    4.1.2 GPU monitoring
    4.1.3 CUDA toolkit
  4.2 Database Node Configuration
    4.2.1 PostgreSQL tuning
    4.2.2 Redis configuration
    4.2.3 Backup scripts
  4.3 Application Node Configuration
    4.3.1 Traefik reverse proxy
    4.3.2 Shared volumes
  4.4 Monitoring Setup
    4.4.1 Prometheus deployment
    4.4.2 Node exporters
    4.4.3 Grafana deployment
    4.4.4 Dashboard import

5.0 Docker Orchestration (Weeks 4-6)
  5.1 Docker Compose Files
    5.1.1 Master compose file
    5.1.2 Service definitions
    5.1.3 Network configuration
    5.1.4 Volume management
  5.2 Service Dependencies
    5.2.1 Health checks
    5.2.2 Startup order
    5.2.3 Restart policies
  5.3 Configuration Management
    5.3.1 Environment variables
    5.3.2 Config files
    5.3.3 Secrets management

6.0 Application Deployment (Weeks 6-10)
  6.1 Core ML Services
    6.1.1 JupyterHub deployment
    6.1.2 MLflow deployment
    6.1.3 Airflow deployment
  6.2 Model Serving
    6.2.1 vLLM server deployment
    6.2.2 Model downloads
    6.2.3 Triton server (optional)
  6.3 Integration
    6.3.1 Service authentication
    6.3.2 API integration
    6.3.3 Data flow testing
  6.4 Monitoring Integration
    6.4.1 Service metrics
    6.4.2 Dashboard creation
    6.4.3 Alert rules

7.0 Integration & Testing (Weeks 10-12)
  7.1 Integration Testing
    7.1.1 Service health checks
    7.1.2 Data flow tests
    7.1.3 ML workflow tests
  7.2 Load Testing
    7.2.1 JupyterHub load test
    7.2.2 vLLM load test
    7.2.3 Performance analysis
  7.3 Security Testing
    7.3.1 Vulnerability scan
    7.3.2 Penetration testing
    7.3.3 Security hardening
  7.4 User Acceptance Testing
    7.4.1 Developer UAT
    7.4.2 Use case validation
    7.4.3 Feedback collection

8.0 Documentation & Handoff (Weeks 12-14)
  8.1 Architecture Documentation
    8.1.1 System architecture
    8.1.2 Network diagrams
    8.1.3 Service catalog
  8.2 Operational Documentation
    8.2.1 Runbooks
    8.2.2 Troubleshooting guides
    8.2.3 Backup procedures
  8.3 User Documentation
    8.3.1 User guides (per persona)
    8.3.2 API documentation
    8.3.3 Tutorial notebooks
  8.4 Training
    8.4.1 Developer training
    8.4.2 Operations training
    8.4.3 Stakeholder demos

9.0 Production Planning (Week 14+)
  9.1 Lessons Learned
    9.1.1 Technical challenges
    9.1.2 What worked well
    9.1.3 What to improve
  9.2 Production Roadmap
    9.2.1 Kubernetes migration plan
    9.2.2 High availability design
    9.2.3 Scalability plan
  9.3 Budget Planning
    9.3.1 Hardware requirements
    9.3.2 Staffing needs
    9.3.3 Ongoing costs
  9.4 Go/No-Go Decision
    9.4.1 Stakeholder review
    9.4.2 Executive approval
    9.4.3 Production kickoff
```

---

## Business Process Mapping

### Process 1: Model Development Lifecycle

```
┌─────────────────────────────────────────────────────────┐
│ 1. Problem Definition                                   │
│    - Stakeholder identifies need                        │
│    - Business case approval                             │
│    - Success criteria defined                           │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 2. Data Collection                                      │
│    - Identify data sources (EHR, PACS, LIS)            │
│    - Data extraction (HL7, FHIR)                       │
│    - Store in MinIO (s3://datasets/)                   │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 3. Data Exploration (JupyterHub)                       │
│    - Launch notebook                                    │
│    - Load data from MinIO                              │
│    - EDA (Exploratory Data Analysis)                   │
│    - Data quality assessment                           │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 4. Data Preprocessing (Airflow DAG)                    │
│    - Clean data                                        │
│    - Feature engineering                               │
│    - Train/validation/test split                       │
│    - Save processed data to MinIO                      │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 5. Model Training (JupyterHub + MLflow)                │
│    - Select algorithm                                   │
│    - Hyperparameter tuning                             │
│    - Train model                                       │
│    - Log metrics to MLflow                             │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 6. Model Evaluation                                     │
│    - Test set evaluation                               │
│    - Cross-validation                                  │
│    - Compare with baseline                             │
│    - Bias/fairness analysis                            │
└──────────────────┬──────────────────────────────────────┘
                   │
                   ├──No──► Return to Step 5 (iterate)
                   │
                   Yes
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 7. Model Deployment                                     │
│    - Register model in MLflow                          │
│    - Deploy to Triton/vLLM                             │
│    - Create inference API                              │
│    - Configure monitoring                              │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 8. Model Monitoring (Grafana)                          │
│    - Track prediction latency                          │
│    - Monitor model drift                               │
│    - Alert on anomalies                                │
│    - Retraining trigger                                │
└─────────────────────────────────────────────────────────┘
```

### Process 2: Clinical AI Inference Workflow

```
┌─────────────────────────────────────────────────────────┐
│ 1. Clinical Event                                       │
│    - New chest X-ray ordered                            │
│    - Image sent from PACS to DICOM server (Orthanc)    │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 2. Image Preprocessing                                  │
│    - Resize to 512x512                                 │
│    - Normalize pixel values                            │
│    - Anonymize DICOM tags                              │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 3. AI Inference (Triton Server)                        │
│    - Load pneumonia detection model                     │
│    - Run inference                                     │
│    - Generate prediction (probability + location)       │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 4. Result Validation                                    │
│    - Confidence threshold check (>0.90)                 │
│    - Flag for radiologist review if uncertain           │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 5. Clinical UI Display                                  │
│    - Show image with AI annotations                     │
│    - Display confidence score                          │
│    - Suggest differential diagnoses                     │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 6. Radiologist Review                                   │
│    - Radiologist accepts/rejects AI finding             │
│    - Add notes and final diagnosis                      │
│    - Sign report                                       │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│ 7. Feedback Loop                                        │
│    - Log radiologist decision                           │
│    - Store for model retraining                        │
│    - Update model performance metrics                   │
└─────────────────────────────────────────────────────────┘
```

---

## Use Case Implementation

### Use Case 1: Chest X-Ray Pneumonia Detection

**Goal**: Detect pneumonia from chest X-ray images to assist radiologists

**Stakeholders**:
- Radiologists (primary users)
- Emergency department physicians
- Hospital operations (workload management)

**Implementation Steps**:

#### Step 1: Data Collection (Week 6)

```python
# notebooks/01_xray_data_collection.ipynb

import boto3
from pydicom import dcmread
import pandas as pd

# Connect to MinIO
s3 = boto3.client(
    's3',
    endpoint_url='http://10.0.1.20:9000',
    aws_access_key_id='minioadmin',
    aws_secret_access_key='minioadmin123'
)

# Download MIMIC-CXR dataset (or use hospital data)
# For prototype, use public dataset: NIH Chest X-Ray Dataset
# 112,120 frontal-view chest X-rays from 30,805 patients

# Download metadata
url = "https://nihcc.app.box.com/v/ChestXray-NIHCC"
# Download images and labels

# Upload to MinIO
s3.upload_file(
    'chest_xray_images.zip',
    'datasets',
    'chest-xray/images.zip'
)
```

#### Step 2: Data Preprocessing (Week 7)

```python
# notebooks/02_xray_preprocessing.ipynb

import cv2
import numpy as np
from sklearn.model_selection import train_test_split

# Load image
img = cv2.imread('chest_xray/image001.jpg', cv2.IMREAD_GRAYSCALE)

# Resize to 512x512
img_resized = cv2.resize(img, (512, 512))

# Normalize
img_normalized = img_resized / 255.0

# Augmentation (for training)
from albumentations import (
    Compose, RandomBrightnessContrast, Rotate, HorizontalFlip
)

augmentations = Compose([
    RandomBrightnessContrast(p=0.5),
    Rotate(limit=10, p=0.5),
    HorizontalFlip(p=0.5)
])

img_augmented = augmentations(image=img_normalized)['image']

# Split data
train_df, val_df = train_test_split(metadata_df, test_size=0.2, stratify=metadata_df['label'])
```

#### Step 3: Model Training (Week 8)

```python
# notebooks/03_xray_model_training.ipynb

import torch
import torch.nn as nn
import torchvision.models as models
import mlflow

# Start MLflow run
mlflow.set_tracking_uri("http://10.0.1.30:5000")
mlflow.set_experiment("chest-xray-pneumonia")

with mlflow.start_run():
    # Load pre-trained model
    model = models.resnet50(pretrained=True)

    # Modify for binary classification
    model.fc = nn.Linear(model.fc.in_features, 1)

    # Train
    criterion = nn.BCEWithLogitsLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.001)

    for epoch in range(10):
        # Training loop
        train_loss = train_epoch(model, train_loader, criterion, optimizer)
        val_loss, val_acc = evaluate(model, val_loader, criterion)

        # Log to MLflow
        mlflow.log_metric("train_loss", train_loss, step=epoch)
        mlflow.log_metric("val_loss", val_loss, step=epoch)
        mlflow.log_metric("val_accuracy", val_acc, step=epoch)

    # Save model
    mlflow.pytorch.log_model(model, "model")

    # Log parameters
    mlflow.log_param("model_architecture", "resnet50")
    mlflow.log_param("learning_rate", 0.001)
    mlflow.log_param("epochs", 10)
```

#### Step 4: Model Deployment (Week 9)

```python
# Export model for Triton Inference Server

import torch.onnx

# Load trained model from MLflow
model_uri = "runs:/<run_id>/model"
model = mlflow.pytorch.load_model(model_uri)

# Export to ONNX
dummy_input = torch.randn(1, 3, 512, 512)
torch.onnx.export(
    model,
    dummy_input,
    "/data/triton-models/chest_xray_pneumonia/1/model.onnx",
    input_names=['input'],
    output_names=['output'],
    dynamic_axes={'input': {0: 'batch_size'}, 'output': {0: 'batch_size'}}
)

# Create model config
config = """
name: "chest_xray_pneumonia"
platform: "onnxruntime_onnx"
max_batch_size: 8
input [
  {
    name: "input"
    data_type: TYPE_FP32
    dims: [ 3, 512, 512 ]
  }
]
output [
  {
    name: "output"
    data_type: TYPE_FP32
    dims: [ 1 ]
  }
]
"""

with open("/data/triton-models/chest_xray_pneumonia/config.pbtxt", "w") as f:
    f.write(config)
```

#### Step 5: Inference API (Week 9)

```python
# api/chest_xray_inference.py

from fastapi import FastAPI, File, UploadFile
import cv2
import numpy as np
import requests

app = FastAPI()

TRITON_URL = "http://10.0.1.10:8002/v2/models/chest_xray_pneumonia/infer"

@app.post("/predict")
async def predict_pneumonia(file: UploadFile = File(...)):
    """Predict pneumonia from chest X-ray image"""

    # Read image
    contents = await file.read()
    nparr = np.frombuffer(contents, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_GRAYSCALE)

    # Preprocess
    img_resized = cv2.resize(img, (512, 512))
    img_normalized = img_resized / 255.0
    img_input = np.expand_dims(img_normalized, axis=0).astype(np.float32)

    # Inference
    payload = {
        "inputs": [
            {
                "name": "input",
                "shape": [1, 3, 512, 512],
                "datatype": "FP32",
                "data": img_input.tolist()
            }
        ]
    }

    response = requests.post(TRITON_URL, json=payload)
    result = response.json()

    # Parse output
    probability = result["outputs"][0]["data"][0]
    prediction = "Pneumonia" if probability > 0.5 else "Normal"

    return {
        "prediction": prediction,
        "confidence": float(probability),
        "threshold": 0.5
    }
```

#### Step 6: Clinical UI Integration (Week 10)

```jsx
// frontend/src/pages/RadiologyDashboard.jsx

import React, { useState } from 'react';
import { Upload, Image, Alert } from '@mui/material';

const RadiologyDashboard = () => {
  const [image, setImage] = useState(null);
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);

  const handleUpload = async (file) => {
    setLoading(true);

    const formData = new FormData();
    formData.append('file', file);

    const response = await fetch('http://10.0.1.10:8005/predict', {
      method: 'POST',
      body: formData
    });

    const data = await response.json();
    setResult(data);
    setLoading(false);
  };

  return (
    <div>
      <h2>Chest X-Ray AI Assistant</h2>

      <Upload onChange={(e) => handleUpload(e.target.files[0])} />

      {image && <Image src={image} alt="Chest X-Ray" />}

      {result && (
        <Alert severity={result.prediction === "Pneumonia" ? "warning" : "success"}>
          <strong>AI Prediction:</strong> {result.prediction}<br />
          <strong>Confidence:</strong> {(result.confidence * 100).toFixed(1)}%
        </Alert>
      )}
    </div>
  );
};
```

### Use Case 2: Sepsis Early Warning System

*(Similar implementation structure, detailed in production phase)*

### Use Case 3: Readmission Risk Prediction

*(Similar implementation structure, detailed in production phase)*

---

## Lessons Learned & Production Readiness

### Prototype Lessons Learned

**What Worked Well**:
1. ✅ Docker Compose simplicity enabled rapid iteration
2. ✅ Starting with 3 VMs kept costs low ($2K/month vs $15K/month AWS)
3. ✅ Open-source stack avoided licensing fees
4. ✅ Hands-on learning built deep understanding
5. ✅ Small team (3-5 people) moved quickly

**Challenges Encountered**:
1. ⚠️ Manual scaling is time-consuming
2. ⚠️ No built-in high availability
3. ⚠️ Monitoring requires manual setup
4. ⚠️ Backup/restore is manual
5. ⚠️ SSL certificate management is complex

**Technical Debt**:
1. 🔧 Dummy authentication (needs Keycloak)
2. 🔧 No automated backups
3. 🔧 No disaster recovery plan
4. 🔧 Limited monitoring alerts
5. 🔧 No load balancing

### Production Readiness Checklist

**Before moving to production (Option 1/2)**:

- [ ] Kubernetes/Swarm cluster deployed
- [ ] High availability configured (3+ nodes per service)
- [ ] Keycloak SSO with LDAP/AD integration
- [ ] Automated backup and tested restore
- [ ] Comprehensive monitoring (Prometheus, Grafana, Loki)
- [ ] Alert rules and PagerDuty integration
- [ ] Load testing (1,000+ concurrent users)
- [ ] Security audit and penetration test
- [ ] HIPAA compliance review
- [ ] Disaster recovery drills
- [ ] Documentation complete (runbooks, user guides)
- [ ] Team trained (developers, operations, support)
- [ ] Stakeholder approval and go-live plan

**Estimated Timeline**:
- Prototype (Option 3): 12-16 weeks
- Production (Option 1): Additional 12-16 weeks
- **Total**: 24-32 weeks (6-8 months)

---

**Document Status**: Complete
**Version**: 1.0
**Last Updated**: 2026-03-16
**Authors**: Hospital AI/ML Platform Team
**License**: Internal Use Only
