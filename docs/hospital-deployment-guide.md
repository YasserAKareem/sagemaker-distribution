# Hospital AI/ML Platform - Deployment Guide

## 🏥 Overview

This guide provides step-by-step instructions for deploying a production-grade AI/ML platform designed specifically for hospital use, supporting 1,000+ concurrent users across multiple personas.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Architecture Overview](#architecture-overview)
3. [Hardware Requirements](#hardware-requirements)
4. [Installation Steps](#installation-steps)
5. [User Persona Configuration](#user-persona-configuration)
6. [Security & Compliance](#security--compliance)
7. [Monitoring & Operations](#monitoring--operations)
8. [Troubleshooting](#troubleshooting)

## Prerequisites

### Infrastructure

**Minimum Production Setup**:
- **Kubernetes Cluster**: 5 master + 15 worker nodes OR
- **Docker Swarm**: 3 manager + 12 worker nodes OR
- **Bare Metal**: 10-15 dedicated servers

**Hardware per Node** (Worker):
- CPU: 32+ cores (AMD EPYC or Intel Xeon)
- RAM: 128GB+
- Storage: 2TB NVMe SSD
- Network: 10Gbps
- GPU: 1-2x NVIDIA A100 40GB (for inference nodes)

**Network Requirements**:
- Static IP addresses
- VLAN support
- Firewall with policy routing
- Load balancer (hardware or software)

### Software

- **Docker**: 24.0+
- **Docker Compose**: V2+
- **Kubernetes**: 1.28+ (if using K8s)
- **NVIDIA Driver**: 535+ (for GPU nodes)
- **nvidia-docker2**: Latest

### Compliance

- HIPAA compliance policies documented
- Security audit completed
- Data protection officer assigned
- Incident response plan in place

## Architecture Overview

### Service Topology

```
Internet/Hospital Network
          ↓
   [Load Balancer] (:80, :443)
          ↓
   [Traefik/HAProxy]
          ↓
┌─────────────────────────────────────┐
│     [Keycloak SSO/RBAC]            │
└─────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────────────────────┐
│                Application Layer                         │
├──────────────────┬──────────────────┬───────────────────┤
│  Developer       │  Clinical        │  Management       │
│  Portal          │  Portal          │  Portal           │
│  - JupyterHub    │  - FHIR UI       │  - Grafana        │
│  - MLflow        │  - DICOM Viewer  │  - Metabase       │
│  - Gitea         │  - AI Assistant  │  - Reports        │
└──────────────────┴──────────────────┴───────────────────┘
          ↓
┌─────────────────────────────────────────────────────────┐
│                 AI/ML Services                           │
│  - vLLM (2-4 replicas) [Production LLM]                │
│  - Triton Inference Server [Medical Models]             │
│  - MLflow Model Registry                                │
│  - Apache Airflow [Workflows]                           │
└─────────────────────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────────────────────┐
│            Healthcare Integration                        │
│  - HAPI FHIR Server [Patient Data]                     │
│  - Orthanc DICOM [Medical Imaging]                     │
│  - HL7 Adapter [HIS Integration]                       │
└─────────────────────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────────────────────┐
│                   Data Layer                             │
│  - PostgreSQL Cluster (Primary + 2 Replicas)           │
│  - Redis Sentinel (3 nodes)                            │
│  - MinIO Distributed (4 nodes)                         │
│  - Elasticsearch (logs & search)                       │
└─────────────────────────────────────────────────────────┘
```

## Hardware Requirements

### Detailed Node Specification

#### GPU Nodes (4x) - AI/ML Inference

```yaml
Purpose: vLLM, Triton, Model Training
CPU: 2x AMD EPYC 7543 (32 cores, 64 threads each)
RAM: 512GB DDR4 ECC
GPU: 2x NVIDIA A100 80GB per node
Storage:
  - 2x 2TB NVMe SSD (RAID 1) - OS
  - 4x 4TB NVMe SSD (RAID 10) - Model cache
Network: 2x 10Gbps (bonded)
Cost: ~$30,000 per node
```

#### Database Nodes (3x) - PostgreSQL Cluster

```yaml
Purpose: PostgreSQL Primary + Replicas
CPU: 2x AMD EPYC 7453 (28 cores, 56 threads each)
RAM: 512GB DDR4 ECC
Storage:
  - 2x 1TB NVMe SSD (RAID 1) - OS
  - 8x 4TB NVMe SSD (RAID 10) - Database
Network: 2x 10Gbps (bonded)
Cost: ~$18,000 per node
```

#### Storage Nodes (4x) - MinIO Distributed

```yaml
Purpose: Object storage (models, images, artifacts)
CPU: 2x AMD EPYC 7413 (24 cores, 48 threads each)
RAM: 256GB DDR4 ECC
Storage:
  - 2x 1TB NVMe SSD (RAID 1) - OS
  - 12x 8TB SAS HDD (JBOD) - Object storage
Network: 2x 25Gbps (bonded)
Cost: ~$15,000 per node
```

#### Application Nodes (6x) - Web Services

```yaml
Purpose: JupyterHub, Keycloak, Grafana, APIs
CPU: 2x AMD EPYC 7443 (24 cores, 48 threads each)
RAM: 256GB DDR4 ECC
Storage:
  - 2x 1TB NVMe SSD (RAID 1) - OS
  - 2x 4TB NVMe SSD (RAID 1) - Application data
Network: 2x 10Gbps (bonded)
Cost: ~$12,000 per node
```

#### Management Nodes (2x) - Monitoring & Ops

```yaml
Purpose: Prometheus, Loki, Elasticsearch, Backups
CPU: 2x AMD EPYC 7413 (24 cores, 48 threads each)
RAM: 256GB DDR4 ECC
Storage:
  - 2x 1TB NVMe SSD (RAID 1) - OS
  - 8x 4TB NVMe SSD (RAID 10) - Logs & metrics
Network: 2x 10Gbps (bonded)
Cost: ~$15,000 per node
```

### Total Hardware Investment

```
Infrastructure Cost Breakdown:

Servers:
  - 4x GPU Nodes: $120,000
  - 3x Database Nodes: $54,000
  - 4x Storage Nodes: $60,000
  - 6x Application Nodes: $72,000
  - 2x Management Nodes: $30,000
  Total Servers: $336,000

Networking:
  - 2x Core Switches (10/25Gbps): $30,000
  - Cables, Transceivers, Patch Panels: $10,000
  Total Networking: $40,000

Infrastructure:
  - Racks (3x 42U): $15,000
  - PDUs, UPS (N+1): $25,000
  - Cooling (CRAC unit): $20,000
  Total Infrastructure: $60,000

Grand Total: $436,000

5-Year TCO:
  - Hardware: $436,000 (year 0)
  - Power/Cooling: $40,000/year
  - Maintenance: $20,000/year
  - Staff (2 FTE): $250,000/year
  Total 5-Year: $1,786,000
  Per User/Year: $357

vs AWS Cloud (5-year): ~$5,200,000
Savings: $3,414,000 (66% cost reduction)
```

## Installation Steps

### Phase 1: Infrastructure Setup (Week 1-2)

#### 1.1. Server Provisioning

```bash
# Install Ubuntu Server 22.04 LTS on all nodes
# Configure static IPs

# Example network configuration
cat > /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  ethernets:
    eth0:
      addresses: [10.0.1.10/24]
      gateway4: 10.0.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
    eth1:
      addresses: [10.0.2.10/24]
EOF

sudo netplan apply
```

#### 1.2. Docker Installation

```bash
# Install Docker on all nodes
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version
```

#### 1.3. NVIDIA GPU Setup (GPU Nodes Only)

```bash
# Install NVIDIA Driver
sudo apt-get update
sudo apt-get install -y nvidia-driver-535

# Install NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# Verify GPU access
docker run --rm --gpus all nvidia/cuda:12.0.0-base-ubuntu22.04 nvidia-smi
```

### Phase 2: Docker Swarm Setup (Week 2)

#### 2.1. Initialize Swarm

```bash
# On first manager node
docker swarm init --advertise-addr 10.0.1.10

# Note the join tokens shown

# On additional manager nodes
docker swarm join --token SWMTKN-1-XXXX 10.0.1.10:2377

# On worker nodes
docker swarm join --token SWMTKN-1-YYYY 10.0.1.10:2377

# Verify cluster
docker node ls
```

#### 2.2. Configure Node Labels

```bash
# Label GPU nodes
docker node update --label-add type=gpu gpu-node-1
docker node update --label-add type=gpu gpu-node-2
docker node update --label-add type=gpu gpu-node-3
docker node update --label-add type=gpu gpu-node-4

# Label database nodes
docker node update --label-add type=database db-node-1
docker node update --label-add type=database db-node-2
docker node update --label-add type=database db-node-3

# Label storage nodes
docker node update --label-add type=storage storage-node-1
docker node update --label-add type=storage storage-node-2
docker node update --label-add type=storage storage-node-3
docker node update --label-add type=storage storage-node-4
```

### Phase 3: Deploy Core Services (Week 3-4)

#### 3.1. Clone Repository

```bash
git clone https://github.com/YasserAKareem/sagemaker-distribution.git
cd sagemaker-distribution
```

#### 3.2. Configure Environment

```bash
# Copy environment template
cp .env.example .env.hospital

# Edit configuration
nano .env.hospital

# Key settings to change:
# - POSTGRES_PASSWORD
# - KEYCLOAK_ADMIN_PASSWORD
# - MINIO_ROOT_PASSWORD
# - Database credentials
# - SSL certificates path
# - Backup paths
```

#### 3.3. Deploy Services

```bash
# Deploy using hospital configuration
docker stack deploy -c docker-compose.hospital.yml hospital-ml

# Check deployment status
docker stack services hospital-ml

# Watch logs
docker service logs -f hospital-ml_keycloak
docker service logs -f hospital-ml_vllm-server-1
```

### Phase 4: Configure Keycloak (Week 4)

#### 4.1. Initial Keycloak Setup

```bash
# Access Keycloak admin console
open http://keycloak.hospital.local:8443/admin

# Login with admin credentials
# Default: admin / admin (CHANGE THIS!)
```

#### 4.2. Create Hospital Realm

```yaml
Realm Settings:
  Name: hospital
  Display Name: Hospital AI/ML Platform
  Enabled: true
  SSL Required: external requests
  Login Theme: hospital-theme
  Account Theme: hospital-theme
```

#### 4.3. Configure LDAP Integration

```yaml
User Federation → Add Provider → LDAP

Connection Settings:
  Edit Mode: READ_ONLY
  Vendor: Active Directory
  Connection URL: ldap://hospital-ad.local:389
  Bind DN: cn=admin,dc=hospital,dc=local
  Bind Credential: [your AD password]

LDAP Searching:
  Users DN: ou=users,dc=hospital,dc=local
  User Object Classes: person, organizationalPerson, user
  Username LDAP Attribute: sAMAccountName
```

#### 4.4. Create Roles

```yaml
Roles → Add Role:

1. developer
   Description: ML Engineers, Data Scientists
   Permissions: Full development access

2. management
   Description: Hospital Administrators
   Permissions: Read-only dashboards

3. operations
   Description: IT Staff, DevOps
   Permissions: Full system access

4. doctor
   Description: Physicians, Clinicians
   Permissions: Clinical data + AI inference

5. lab-staff
   Description: Laboratory Technicians
   Permissions: Lab data + image analysis

6. researcher
   Description: Clinical Researchers
   Permissions: De-identified data access

7. admin
   Description: Superuser
   Permissions: All access
```

#### 4.5. Create OAuth2 Clients

```yaml
Clients → Create:

1. jupyterhub-client:
   Client ID: jupyterhub
   Client Protocol: openid-connect
   Access Type: confidential
   Valid Redirect URIs: https://jupyter.hospital.local/hub/oauth_callback
   Web Origins: https://jupyter.hospital.local

2. grafana-client:
   Client ID: grafana
   Client Protocol: openid-connect
   Access Type: confidential
   Valid Redirect URIs: https://grafana.hospital.local/login/generic_oauth
   Web Origins: https://grafana.hospital.local

3. mlflow-client:
   Client ID: mlflow
   Client Protocol: openid-connect
   Access Type: confidential
   Valid Redirect URIs: https://mlflow.hospital.local/oauth_callback
   Web Origins: https://mlflow.hospital.local
```

### Phase 5: Healthcare Services Configuration (Week 5)

#### 5.1. FHIR Server Setup

```bash
# Access FHIR server
curl -X GET http://fhir.hospital.local:8082/fhir/metadata

# Create test patient
curl -X POST http://fhir.hospital.local:8082/fhir/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Patient",
    "identifier": [{
      "system": "http://hospital.local/patient-id",
      "value": "12345"
    }],
    "name": [{
      "family": "Doe",
      "given": ["John"]
    }],
    "gender": "male",
    "birthDate": "1970-01-01"
  }'
```

#### 5.2. DICOM Server Setup

```bash
# Access Orthanc web interface
open http://orthanc.hospital.local:8042

# Login: admin / admin (CHANGE THIS!)

# Configure PACS integration
curl -X PUT http://orthanc.hospital.local:8042/modalities/hospital-pacs \
  -H "Content-Type: application/json" \
  -d '{
    "AET": "HOSPITAL_PACS",
    "Host": "pacs.hospital.local",
    "Port": 4242,
    "Manufacturer": "Generic"
  }'

# Test connection
curl -X POST http://orthanc.hospital.local:8042/modalities/hospital-pacs/echo
```

### Phase 6: vLLM Model Deployment (Week 5-6)

#### 6.1. Download Medical LLM Models

```bash
# On GPU nodes, download models
docker exec hospital-vllm-1 bash -c "
  huggingface-cli login --token YOUR_HF_TOKEN
  huggingface-cli download mistralai/Mistral-7B-Instruct-v0.2
  huggingface-cli download epfl-llm/meditron-7b
"

# Verify models cached
docker exec hospital-vllm-1 ls /root/.cache/huggingface/hub
```

#### 6.2. Test vLLM Inference

```bash
# Test OpenAI-compatible API
curl -X POST http://vllm-1.hospital.local:8001/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "clinical-assistant",
    "prompt": "What are the symptoms of pneumonia?",
    "max_tokens": 200,
    "temperature": 0.7
  }'

# Expected response time: <100ms (with batching)
```

### Phase 7: User Persona Portals (Week 7-8)

#### 7.1. Developer Portal

```yaml
Services:
  - JupyterHub: https://jupyter.hospital.local
  - MLflow: https://mlflow.hospital.local
  - Gitea: https://git.hospital.local
  - API Docs: https://api.hospital.local/docs

Access Control:
  - Role: developer
  - Users: ~50 (ML engineers, data scientists)
  - Resources: GPU access, full ML stack
```

#### 7.2. Clinical Portal

```yaml
Services:
  - Clinical Dashboard: https://clinical.hospital.local
  - DICOM Viewer: https://dicom.hospital.local
  - AI Assistant: https://ai.hospital.local
  - Patient Data (FHIR): https://fhir.hospital.local

Access Control:
  - Role: doctor
  - Users: ~600 (physicians, clinicians)
  - Resources: Patient data (scoped), AI inference
```

#### 7.3. Management Portal

```yaml
Services:
  - Executive Dashboard: https://dashboard.hospital.local
  - Metabase BI: https://bi.hospital.local
  - Reports: https://reports.hospital.local

Access Control:
  - Role: management
  - Users: ~20 (administrators, executives)
  - Resources: Read-only analytics, ROI metrics
```

#### 7.4. Operations Portal

```yaml
Services:
  - Monitoring: https://grafana.hospital.local
  - Logs: https://logs.hospital.local
  - User Management: https://keycloak.hospital.local
  - Backups: https://backup.hospital.local

Access Control:
  - Role: operations
  - Users: ~30 (IT staff, DevOps)
  - Resources: Full system access, logs, alerts
```

## User Persona Configuration

### Developers (ML Engineers, Data Scientists)

**Profile**:
- Count: 50 users
- Primary Tools: JupyterHub, MLflow, Git
- Access Level: Full development, GPU resources

**Setup**:
```bash
# Create developer group in Keycloak
# Assign 'developer' role
# Configure JupyterHub spawner options:

c.KubeSpawner.profile_list = [
    {
        'display_name': 'Developer - GPU (A100)',
        'description': 'ML training with GPU access',
        'kubespawner_override': {
            'cpu_limit': 8,
            'mem_limit': '32G',
            'extra_resource_limits': {"nvidia.com/gpu": "1"},
        }
    },
    {
        'display_name': 'Developer - CPU Only',
        'description': 'Data analysis without GPU',
        'kubespawner_override': {
            'cpu_limit': 4,
            'mem_limit': '16G',
        }
    }
]
```

### Doctors (Physicians, Clinicians)

**Profile**:
- Count: 600 users
- Primary Tools: Clinical dashboard, DICOM viewer, AI assistant
- Access Level: Patient data (scoped), inference API

**Setup**:
```bash
# Create doctor group in Keycloak
# Configure FHIR server patient scope:

Patient Access Policy:
  - Doctors can only access patients assigned to them
  - Automatic audit logging on all access
  - Session timeout: 15 minutes
  - MFA required for PHI access
```

### Management (Hospital Administrators)

**Profile**:
- Count: 20 users
- Primary Tools: Grafana dashboards, Metabase BI
- Access Level: Read-only analytics

**Setup**:
```bash
# Create management group in Keycloak
# Configure Grafana dashboards:

Executive Dashboard:
  - Platform usage metrics
  - Cost tracking
  - User adoption
  - ROI calculations
  - Model performance
  - Compliance status
```

### Operations (IT Staff, DevOps)

**Profile**:
- Count: 30 users
- Primary Tools: Grafana, Prometheus, Loki, Keycloak Admin
- Access Level: Full system access

**Setup**:
```bash
# Create operations group in Keycloak
# Configure alerting:

PagerDuty Integration:
  - Critical: Page on-call engineer immediately
  - Warning: Slack notification
  - Info: Dashboard only

Alert Rules:
  - Service downtime > 1 minute
  - GPU utilization < 30% (underutilization)
  - GPU utilization > 95% (need scaling)
  - Database replication lag > 10s
  - Disk usage > 80%
```

### Lab Staff (Laboratory Technicians)

**Profile**:
- Count: 200 users
- Primary Tools: Lab dashboard, image analysis, batch inference
- Access Level: Lab data, inference API

**Setup**:
```bash
# Create lab-staff group in Keycloak
# Configure batch inference endpoint:

Lab Results Analysis:
  - Batch upload CSV files
  - Automatic ML prediction
  - Quality control flagging
  - Result export to LIS
```

### Researchers (Clinical Researchers)

**Profile**:
- Count: 100 users
- Primary Tools: JupyterHub, RStudio, data warehouse
- Access Level: De-identified patient data

**Setup**:
```bash
# Create researcher group in Keycloak
# Configure data de-identification:

Data Access Policy:
  - All PHI automatically de-identified
  - IRB approval required for data access
  - Data export approval workflow
  - Usage audit trail
```

## Security & Compliance

### HIPAA Compliance Checklist

- [ ] Access controls implemented (RBAC)
- [ ] Audit logging enabled for all PHI access
- [ ] Data encryption at rest (AES-256)
- [ ] Data encryption in transit (TLS 1.3)
- [ ] Automatic session timeout (15 minutes)
- [ ] Failed login attempt tracking
- [ ] Multi-factor authentication (MFA) enabled
- [ ] Regular security audits scheduled
- [ ] Incident response plan documented
- [ ] Business Associate Agreements (BAA) signed
- [ ] Data backup and recovery tested
- [ ] Disaster recovery plan in place
- [ ] Staff training on HIPAA completed

### Security Hardening

```bash
# 1. Change all default passwords
# 2. Enable SSL/TLS for all services
# 3. Configure firewall rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp   # SSH
sudo ufw allow 80/tcp   # HTTP
sudo ufw allow 443/tcp  # HTTPS
sudo ufw enable

# 4. Enable fail2ban
sudo apt-get install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# 5. Set up automated updates
sudo apt-get install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

## Monitoring & Operations

### Key Metrics to Monitor

```yaml
System Health:
  - CPU utilization per node
  - Memory usage per service
  - Disk I/O and latency
  - Network bandwidth
  - GPU utilization and temperature

Application Health:
  - vLLM request latency (p50, p95, p99)
  - vLLM throughput (requests/sec)
  - MLflow experiment creation rate
  - FHIR API response time
  - DICOM image retrieval time
  - Database query performance

User Experience:
  - Login success rate
  - Session duration
  - API error rate
  - Page load time
  - Concurrent user count

Compliance:
  - PHI access events
  - Failed authentication attempts
  - Data export requests
  - Audit log completeness
```

### Grafana Dashboard Examples

1. **Executive Dashboard** (Management)
   - Total users (by persona)
   - Platform usage trends
   - Cost per inference
   - ROI calculations
   - Model accuracy over time

2. **Operations Dashboard** (Operations)
   - Service health status
   - Resource utilization
   - Alert history
   - Backup status
   - Pending incidents

3. **Clinical Dashboard** (Doctors)
   - AI model availability
   - Average response time
   - Diagnostic accuracy
   - Patient data access logs

## Troubleshooting

### Common Issues

#### Issue 1: vLLM Server Not Responding

```bash
# Check GPU availability
docker exec hospital-vllm-1 nvidia-smi

# Check logs
docker service logs hospital-ml_vllm-server-1

# Restart service
docker service update --force hospital-ml_vllm-server-1

# If OOM, reduce GPU memory utilization
# Edit docker-compose: GPU_MEMORY_UTILIZATION=0.8
```

#### Issue 2: Keycloak SSO Login Fails

```bash
# Check Keycloak logs
docker service logs hospital-ml_keycloak

# Verify database connection
docker exec hospital-postgres psql -U mluser -d keycloak -c "SELECT COUNT(*) FROM realm;"

# Check LDAP connectivity
docker exec hospital-keycloak bash -c "ldapsearch -x -H ldap://hospital-ad.local:389 -D 'cn=admin,dc=hospital,dc=local' -w PASSWORD -b 'dc=hospital,dc=local'"
```

#### Issue 3: High Database Latency

```bash
# Check database stats
docker exec hospital-postgres psql -U mluser -d mlplatform -c "
  SELECT schemaname, tablename, pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
  FROM pg_tables
  ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
  LIMIT 10;
"

# Check slow queries
docker exec hospital-postgres psql -U mluser -d mlplatform -c "
  SELECT query, mean_exec_time, calls
  FROM pg_stat_statements
  ORDER BY mean_exec_time DESC
  LIMIT 10;
"

# Run VACUUM ANALYZE
docker exec hospital-postgres psql -U mluser -d mlplatform -c "VACUUM ANALYZE;"
```

## Maintenance Schedule

### Daily Tasks (Automated)
- [ ] Incremental backups (3 AM)
- [ ] Log rotation
- [ ] Health check reports
- [ ] Security scan

### Weekly Tasks
- [ ] Full backups (Sunday 2 AM)
- [ ] Restore test (verify backups work)
- [ ] Security updates
- [ ] Performance review

### Monthly Tasks
- [ ] Capacity planning review
- [ ] User access audit
- [ ] Compliance review
- [ ] Disaster recovery drill

### Quarterly Tasks
- [ ] HIPAA audit
- [ ] Security penetration test
- [ ] Hardware refresh evaluation
- [ ] User training sessions

## Support & Escalation

### Tier 1 Support (Help Desk)
- User account issues
- Password resets
- General questions
- Portal access issues

### Tier 2 Support (Operations Team)
- Service restarts
- Performance issues
- Minor configuration changes
- Monitoring alerts

### Tier 3 Support (Vendor/Specialists)
- Critical system failures
- Security incidents
- Major upgrades
- Architecture changes

### Emergency Contacts
- On-Call Engineer: [Phone]
- Security Team: [Phone]
- Vendor Support: [Phone]
- Hospital IT Director: [Phone]

---

**Document Version**: 2.0
**Last Updated**: 2026-03-16
**Deployment Type**: Hospital Production
**Compliance**: HIPAA
**License**: Apache 2.0
