# Option 3: Bare Metal/VMs - Prototype Implementation Plan
## Deep Dive Step-by-Step Guide for Development Team

**Document Purpose**: Comprehensive implementation plan for building an AI/ML platform prototype using Bare Metal/VMs deployment (Option 3), designed for the development team to learn and establish know-how before production deployment.

**Target Audience**: Development team, DevOps engineers, ML engineers
**Timeline**: 12-16 weeks (3-4 months) for complete prototype
**Deployment Model**: Bare Metal / Virtual Machines (no Kubernetes/Swarm initially)

---

## Table of Contents

1. [Overview & Philosophy](#1-overview--philosophy)
2. [Phase 0: Pre-Work (Weeks -2 to 0)](#phase-0-pre-work-weeks--2-to-0)
3. [Team Structure & Roles](#team-structure--roles)
4. [Phase 1: Infrastructure Setup (Weeks 1-3)](#phase-1-infrastructure-setup-weeks-1-3)
5. [Phase 2: UI/UX Design System (Weeks 2-4)](#phase-2-uiux-design-system-weeks-2-4)
6. [Phase 3: VM Configuration (Weeks 3-5)](#phase-3-vm-configuration-weeks-3-5)
7. [Phase 4: Docker Orchestration (Weeks 4-6)](#phase-4-docker-orchestration-weeks-4-6)
8. [Phase 5: Application Deployment (Weeks 6-10)](#phase-5-application-deployment-weeks-6-10)
9. [Phase 6: Integration & Testing (Weeks 10-12)](#phase-6-integration--testing-weeks-10-12)
10. [Phase 7: Documentation & Handoff (Weeks 12-14)](#phase-7-documentation--handoff-weeks-12-14)
11. [Work Breakdown Structure (WBS)](#work-breakdown-structure-wbs)
12. [Business Process Mapping](#business-process-mapping)
13. [Use Case Implementation](#use-case-implementation)
14. [Lessons Learned & Production Readiness](#lessons-learned--production-readiness)

---

## 1. Overview & Philosophy

### Why Start with Option 3 (Bare Metal/VMs)?

**Learning Objectives**:
1. **Understand the fundamentals**: Learn how each component works before abstracting with orchestration
2. **Hands-on experience**: Gain deep knowledge of Docker, networking, storage, and service dependencies
3. **Troubleshooting skills**: Develop debugging skills without orchestration complexity
4. **Architecture understanding**: Understand service interactions, data flows, and scaling challenges
5. **Production preparation**: Build confidence before moving to Kubernetes/Swarm (Option 1/2)

**Philosophy**:
- Start simple, add complexity gradually
- Focus on learning, not production perfection
- Document everything for knowledge transfer
- Fail fast, iterate quickly
- Build minimum viable prototype first

### Prototype vs. Production

| Aspect | Prototype (Option 3) | Production (Option 1/2) |
|--------|---------------------|------------------------|
| **Deployment** | 3-5 VMs, manual deployment | 19+ servers, automated |
| **Users** | 10-20 developers | 1,000+ all personas |
| **High Availability** | Single instance | Clustered (HA) |
| **Orchestration** | Docker Compose | Kubernetes/Swarm |
| **Monitoring** | Basic (Grafana) | Enterprise (full stack) |
| **Security** | Development-grade | HIPAA-compliant |
| **Backup** | Manual | Automated, tested |
| **Timeline** | 12-16 weeks | 21-26 weeks |
| **Cost** | $20K-$30K | $436K+ |
| **Purpose** | Learn & validate | Production hospital use |

---

## Phase 0: Pre-Work (Weeks -2 to 0)

### Objectives
- Secure budget and approvals
- Procure hardware/VMs
- Assemble team
- Set up development environment
- Plan architecture

### 0.1 Requirements Gathering

**Week -2: Business Requirements**

```yaml
Activities:
  - Conduct stakeholder interviews (2 days)
  - Document use cases (3 days)
  - Define success criteria (2 days)
  - Create project charter (2 days)
  - Get executive sign-off (1 day)

Deliverables:
  - Requirements document (10-15 pages)
  - Use case catalog (5-10 use cases)
  - Success criteria (KPIs, metrics)
  - Project charter (budget, timeline, scope)
  - Approved project plan
```

**Template: Requirements Document**

```markdown
# AI/ML Platform Prototype - Requirements Document

## 1. Business Objectives
- Enable development team to build and deploy ML models
- Establish technical foundation for production platform
- Validate architecture and technology choices
- Train team on AI/ML infrastructure

## 2. Functional Requirements
### Must Have (Phase 1)
- [ ] JupyterHub for notebook development
- [ ] MLflow for experiment tracking
- [ ] Model serving (Triton or BentoML)
- [ ] Object storage (MinIO)
- [ ] PostgreSQL database
- [ ] Basic authentication

### Should Have (Phase 2)
- [ ] Apache Airflow for workflows
- [ ] vLLM for LLM inference
- [ ] Grafana monitoring
- [ ] Git server (Gitea)

### Nice to Have (Phase 3)
- [ ] Keycloak SSO
- [ ] FHIR server (healthcare integration)
- [ ] Advanced monitoring (Prometheus, Loki)

## 3. Non-Functional Requirements
- Support 10-20 concurrent users
- API response time < 500ms (95th percentile)
- 99% uptime during business hours
- Backup data daily
- Document all procedures

## 4. Technical Constraints
- Budget: $20K-$30K for hardware/VMs
- Timeline: 12-16 weeks
- Team size: 3-5 people
- Skills: Python, Docker, Linux, basic ML

## 5. Success Criteria
- 3 working use cases demonstrated
- Team trained on all components
- Documentation complete (architecture, runbooks)
- Production roadmap defined
- Stakeholder approval for Phase 2 (production)
```

### 0.2 Hardware/VM Procurement

**Week -1: Infrastructure Planning**

**Option A: Physical Servers (Recommended for learning)**

```yaml
Minimum Configuration (3 servers):

Server 1: GPU Node (ML Training/Inference)
  CPU: AMD Ryzen 9 5950X (16 cores) or Intel i9-12900K
  RAM: 64GB DDR4
  GPU: 1x NVIDIA RTX 4090 (24GB) or A4000 (16GB)
  Storage:
    - 512GB NVMe SSD (OS)
    - 2TB NVMe SSD (models, data)
  Network: 1Gbps Ethernet
  Cost: ~$3,000-$5,000

Server 2: Database & Storage Node
  CPU: AMD Ryzen 7 5800X (8 cores) or Intel i7-12700
  RAM: 32GB DDR4
  Storage:
    - 256GB NVMe SSD (OS)
    - 4TB SATA SSD (database, object storage)
  Network: 1Gbps Ethernet
  Cost: ~$1,500-$2,500

Server 3: Application Node
  CPU: AMD Ryzen 5 5600X (6 cores) or Intel i5-12600K
  RAM: 32GB DDR4
  Storage:
    - 256GB NVMe SSD (OS)
    - 1TB SATA SSD (applications)
  Network: 1Gbps Ethernet
  Cost: ~$1,200-$2,000

Networking:
  - Managed switch (8-port Gigabit): $150
  - Cables, rack mount (optional): $200

Total Hardware Cost: $6,000-$10,000
```

**Option B: Cloud VMs (Easier to start, higher ongoing cost)**

```yaml
Cloud Provider: AWS, Azure, or GCP

VM 1: GPU Instance
  AWS: g5.2xlarge (1x A10G GPU, 8 vCPU, 32GB RAM)
  Azure: NC6s_v3 (1x V100 GPU, 6 vCPU, 112GB RAM)
  GCP: n1-standard-8 + 1x T4 GPU
  Cost: ~$1.00-$2.00/hour = $720-$1,440/month

VM 2: Database Instance
  AWS: m5.2xlarge (8 vCPU, 32GB RAM)
  Azure: D8s_v3 (8 vCPU, 32GB RAM)
  GCP: n2-standard-8
  Storage: 2TB SSD
  Cost: ~$0.40/hour = $288/month + storage ($200)

VM 3: Application Instance
  AWS: m5.xlarge (4 vCPU, 16GB RAM)
  Azure: D4s_v3 (4 vCPU, 16GB RAM)
  GCP: n2-standard-4
  Storage: 500GB SSD
  Cost: ~$0.20/hour = $144/month + storage ($50)

Total Monthly Cost: ~$1,900-$2,200/month
12-Week Prototype Cost: ~$6,000-$7,000
```

**Decision Matrix**:

| Factor | Physical Servers | Cloud VMs | Winner |
|--------|-----------------|-----------|--------|
| **Upfront Cost** | High ($6K-$10K) | Low ($0) | 🏆 Cloud |
| **Monthly Cost** | Low ($50-$100) | High ($2K) | 🏆 Physical |
| **Learning Value** | High (hardware setup) | Medium | 🏆 Physical |
| **Flexibility** | Low (fixed specs) | High (resize anytime) | 🏆 Cloud |
| **Time to Deploy** | 2-4 weeks (shipping) | 1 hour | 🏆 Cloud |
| **Production Similarity** | High (on-premise) | Low (hybrid) | 🏆 Physical |

**Recommendation**: **Start with Cloud VMs** for speed, switch to physical servers once architecture is validated (Week 6-8).

### 0.3 Team Formation

**Week -1: Team Assembly**

**Required Roles** (3-5 people):

```yaml
Role 1: Tech Lead / Solutions Architect (1 person)
  Responsibilities:
    - Overall architecture design
    - Technology selection and evaluation
    - Code reviews and standards
    - Stakeholder communication
    - Production planning

  Required Skills:
    - 5+ years software engineering
    - Distributed systems experience
    - Docker/containerization (expert)
    - ML infrastructure knowledge
    - Leadership and communication

  Time Commitment: 100% (40 hours/week)

Role 2: ML Engineer / Data Scientist (1-2 people)
  Responsibilities:
    - Use case development
    - Model training and deployment
    - JupyterHub and MLflow setup
    - Model serving configuration
    - User acceptance testing

  Required Skills:
    - 3+ years ML/DS experience
    - Python, PyTorch/TensorFlow
    - Jupyter notebooks
    - ML deployment experience
    - Healthcare domain (nice to have)

  Time Commitment: 100% (40 hours/week)

Role 3: DevOps / Infrastructure Engineer (1 person)
  Responsibilities:
    - VM provisioning and configuration
    - Docker and networking setup
    - Monitoring and logging
    - Backup and disaster recovery
    - Security hardening

  Required Skills:
    - 3+ years DevOps experience
    - Linux system administration
    - Docker, Docker Compose
    - Networking (TCP/IP, DNS, firewalls)
    - Infrastructure as Code (Ansible, Terraform)

  Time Commitment: 100% (40 hours/week)

Role 4: Full-Stack Developer (1 person, optional)
  Responsibilities:
    - UI/UX for portals
    - API development
    - Frontend development (React/Vue)
    - Integration work
    - Documentation

  Required Skills:
    - 3+ years web development
    - React or Vue.js
    - REST API development
    - TypeScript/JavaScript
    - UI/UX design basics

  Time Commitment: 50-100% (20-40 hours/week)

Role 5: Product Owner / Stakeholder Rep (1 person, part-time)
  Responsibilities:
    - Requirements clarification
    - Use case validation
    - Stakeholder feedback
    - Go/no-go decisions
    - Budget approval

  Required Skills:
    - Healthcare domain knowledge
    - Product management experience
    - Technical understanding (basic)
    - Stakeholder management

  Time Commitment: 25% (10 hours/week)
```

**Team Structure**:

```
                    Product Owner
                          |
                    Tech Lead
                          |
        ┌─────────────────┼─────────────────┐
        |                 |                 |
    ML Engineer      DevOps Eng      Full-Stack Dev
        |                 |                 |
    (Use Cases)    (Infrastructure)      (UIs)
```

### 0.4 Development Environment Setup

**Week 0: Environment Preparation**

**For Each Team Member**:

```bash
# 1. Install required software on local machines

# Operating System: Ubuntu 22.04 LTS or macOS

# Docker Desktop
# - Download from docker.com
# - Verify: docker --version (24.0+)

# Docker Compose
# - Included with Docker Desktop
# - Verify: docker-compose --version (v2.0+)

# Python 3.10+
sudo apt-get install python3.10 python3-pip

# Git
sudo apt-get install git

# Visual Studio Code
# - Download from code.visualstudio.com
# - Install extensions:
#   - Docker
#   - Remote - SSH
#   - Python
#   - Jupyter
#   - YAML

# Infrastructure tools
pip install ansible docker-py

# 2. Set up SSH keys for team collaboration
ssh-keygen -t ed25519 -C "your_email@hospital.com"
# Share public keys with Tech Lead for server access

# 3. Join collaboration tools
# - Slack channel: #ai-ml-platform-dev
# - Jira board: Hospital-AIML
# - Git repository: github.com/hospital/ai-ml-platform
# - Documentation wiki: Confluence or Notion

# 4. Review architecture documents
# - Read: hospital-architecture.md
# - Read: competitive-landscape-aws-vs-opensource.md
# - Read: RFP-Hospital-AIML-Platform.md
```

**Shared Development Infrastructure**:

```bash
# Set up shared tools (Tech Lead responsibility)

# 1. Git Repository
# - GitHub/GitLab organization
# - Repository: ai-ml-platform-prototype
# - Branches: main, develop, feature/*

# 2. Project Management
# - Jira board with sprints (2-week sprints)
# - Backlog grooming weekly
# - Sprint planning bi-weekly

# 3. Communication
# - Slack workspace
# - Daily standup (15 min, 9:00 AM)
# - Weekly architecture review (1 hour, Friday)

# 4. Documentation
# - Confluence or Notion workspace
# - Architecture diagrams (draw.io, Lucidchart)
# - API documentation (Swagger/OpenAPI)
# - Runbooks and troubleshooting guides
```

### 0.5 Architecture Planning

**Week 0: Architecture Design**

**High-Level Architecture (Prototype)**:

```
┌──────────────────────────────────────────────────────────┐
│                   Internet / VPN                          │
└────────────────────────┬─────────────────────────────────┘
                         │
                         ▼
                ┌────────────────┐
                │  Load Balancer │ (Traefik or Nginx)
                │   (Optional)   │
                └────────┬───────┘
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   VM 1      │  │   VM 2      │  │   VM 3      │
│  GPU Node   │  │ Database    │  │ Application │
│             │  │   Node      │  │    Node     │
├─────────────┤  ├─────────────┤  ├─────────────┤
│ - JupyterHub│  │ - PostgreSQL│  │ - MLflow UI │
│ - vLLM      │  │ - Redis     │  │ - Grafana   │
│ - Triton    │  │ - MinIO     │  │ - Gitea     │
│             │  │             │  │ - Airflow   │
└─────────────┘  └─────────────┘  └─────────────┘
         │               │               │
         └───────────────┴───────────────┘
                         │
                    (Shared Network:
                     10.0.1.0/24)
```

**Service Inventory**:

| Service | VM Assignment | Port | Purpose | Priority |
|---------|---------------|------|---------|----------|
| **JupyterHub** | VM1 (GPU) | 8000 | Notebook development | P0 (Must Have) |
| **vLLM** | VM1 (GPU) | 8001 | LLM inference | P1 (Should Have) |
| **Triton** | VM1 (GPU) | 8002 | Model serving | P1 (Should Have) |
| **PostgreSQL** | VM2 (DB) | 5432 | Primary database | P0 (Must Have) |
| **Redis** | VM2 (DB) | 6379 | Caching | P1 (Should Have) |
| **MinIO** | VM2 (DB) | 9000 | Object storage | P0 (Must Have) |
| **MLflow** | VM3 (App) | 5000 | Experiment tracking | P0 (Must Have) |
| **Grafana** | VM3 (App) | 3000 | Monitoring | P1 (Should Have) |
| **Prometheus** | VM3 (App) | 9090 | Metrics | P1 (Should Have) |
| **Airflow** | VM3 (App) | 8080 | Workflows | P2 (Nice to Have) |
| **Gitea** | VM3 (App) | 3001 | Git server | P2 (Nice to Have) |
| **Traefik** | VM3 (App) | 80/443 | Load balancer | P2 (Nice to Have) |

**Network Design**:

```yaml
Network Configuration:

Subnet: 10.0.1.0/24
Gateway: 10.0.1.1

VM1 (GPU Node):
  IP: 10.0.1.10
  Hostname: gpu-node-1.hospital.local
  DNS: gpu-node-1

VM2 (Database Node):
  IP: 10.0.1.20
  Hostname: db-node-1.hospital.local
  DNS: db-node-1

VM3 (Application Node):
  IP: 10.0.1.30
  Hostname: app-node-1.hospital.local
  DNS: app-node-1

DNS Records (local /etc/hosts or internal DNS):
  10.0.1.10  gpu-node-1 jupyter.hospital.local vllm.hospital.local
  10.0.1.20  db-node-1 postgres.hospital.local minio.hospital.local
  10.0.1.30  app-node-1 mlflow.hospital.local grafana.hospital.local

Firewall Rules:
  - Allow 22/tcp (SSH) from office network
  - Allow 80/tcp, 443/tcp (HTTP/HTTPS) from office network
  - Allow all traffic between VMs (10.0.1.0/24)
  - Deny all other inbound traffic
```

---

## Team Structure & Roles

### Detailed Role Definitions

#### Tech Lead / Solutions Architect

**Daily Responsibilities**:
- 9:00 AM: Daily standup (facilitate)
- 9:15 AM: Review pull requests and code changes
- 10:00 AM: Architecture design and documentation
- 2:00 PM: Unblock team members (troubleshooting, decisions)
- 4:00 PM: Stakeholder updates (async or meeting)

**Weekly Responsibilities**:
- Monday: Sprint planning (2 hours)
- Wednesday: Architecture review session (1 hour)
- Friday: Sprint retrospective (1 hour)
- Friday: Production planning meeting (1 hour)

**Key Deliverables**:
- Architecture diagrams (updated weekly)
- Technical decisions log (ADRs - Architecture Decision Records)
- Sprint reports (velocity, burndown)
- Risk register (updated weekly)

#### ML Engineer / Data Scientist

**Daily Responsibilities**:
- 9:00 AM: Daily standup
- 9:30 AM: Use case development (model training, experiments)
- 2:00 PM: Code ML pipelines, test deployments
- 4:00 PM: Document findings, update notebooks

**Weekly Responsibilities**:
- Tuesday: Use case demo (show progress to team)
- Thursday: ML platform testing (JupyterHub, MLflow)
- Friday: Knowledge sharing session (30 min presentation)

**Key Deliverables**:
- 3 working use cases (trained models)
- Jupyter notebooks (documented experiments)
- Model deployment scripts
- Use case validation reports

#### DevOps / Infrastructure Engineer

**Daily Responsibilities**:
- 9:00 AM: Daily standup
- 9:30 AM: Infrastructure provisioning, configuration
- 11:00 AM: Monitor system health, respond to alerts
- 2:00 PM: Automation scripts (Ansible, Docker Compose)
- 4:00 PM: Update runbooks, documentation

**Weekly Responsibilities**:
- Monday: Backup verification (test restore)
- Wednesday: Security hardening tasks
- Friday: Infrastructure review (capacity, performance)

**Key Deliverables**:
- VM provisioning scripts (Terraform/Ansible)
- Docker Compose configurations
- Monitoring dashboards (Grafana)
- Runbooks (operations procedures)
- Backup/restore documentation

#### Full-Stack Developer

**Daily Responsibilities**:
- 9:00 AM: Daily standup
- 9:30 AM: UI development (React components)
- 2:00 PM: API development (FastAPI/Flask)
- 4:00 PM: Integration testing

**Weekly Responsibilities**:
- Tuesday: UI/UX review with stakeholders
- Thursday: API documentation updates
- Friday: Frontend testing and bug fixes

**Key Deliverables**:
- Portal UIs (Developer, Clinical, Management)
- REST APIs (model serving, data access)
- Frontend components library
- API documentation (Swagger)

---

## Phase 1: Infrastructure Setup (Weeks 1-3)

### Objectives
- Provision VMs or physical servers
- Install operating system and base software
- Configure networking
- Set up Docker and container runtime
- Establish bastion host for remote access

### Week 1: VM Provisioning

#### Day 1-2: Cloud VM Setup (if using cloud)

**AWS Example**:

```bash
# 1. Create VPC and networking (Tech Lead + DevOps)
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=hospital-aiml-vpc}]'

# Note VPC ID from output
VPC_ID="vpc-xxxxx"

# Create subnet
aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --availability-zone us-east-1a

# Create internet gateway
aws ec2 create-internet-gateway
IGW_ID="igw-xxxxx"
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID

# Configure route table
aws ec2 create-route-table --vpc-id $VPC_ID
RTB_ID="rtb-xxxxx"
aws ec2 create-route --route-table-id $RTB_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID

# Create security group
aws ec2 create-security-group --group-name hospital-aiml-sg --description "AI/ML Platform Security Group" --vpc-id $VPC_ID
SG_ID="sg-xxxxx"

# Allow SSH, HTTP, HTTPS from office IP
OFFICE_IP="1.2.3.4/32"  # Replace with your office public IP
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr $OFFICE_IP
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr $OFFICE_IP
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 443 --cidr $OFFICE_IP

# Allow all traffic within VPC
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol -1 --source-group $SG_ID

# 2. Launch VM1 (GPU instance)
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type g5.2xlarge \
  --key-name hospital-key \
  --security-group-ids $SG_ID \
  --subnet-id subnet-xxxxx \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":100,"VolumeType":"gp3"}},{"DeviceName":"/dev/sdb","Ebs":{"VolumeSize":500,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=gpu-node-1}]' \
  --private-ip-address 10.0.1.10

# 3. Launch VM2 (Database instance)
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type m5.2xlarge \
  --key-name hospital-key \
  --security-group-ids $SG_ID \
  --subnet-id subnet-xxxxx \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":100,"VolumeType":"gp3"}},{"DeviceName":"/dev/sdb","Ebs":{"VolumeSize":2000,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=db-node-1}]' \
  --private-ip-address 10.0.1.20

# 4. Launch VM3 (Application instance)
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type m5.xlarge \
  --key-name hospital-key \
  --security-group-ids $SG_ID \
  --subnet-id subnet-xxxxx \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":100,"VolumeType":"gp3"}},{"DeviceName":"/dev/sdb","Ebs":{"VolumeSize":500,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=app-node-1}]' \
  --private-ip-address 10.0.1.30

# 5. Allocate and associate Elastic IPs
aws ec2 allocate-address --domain vpc
# Note allocation ID
aws ec2 associate-address --instance-id i-xxxxx --allocation-id eipalloc-xxxxx

# Repeat for other VMs if external access needed
```

**Verification**:

```bash
# SSH into each VM
ssh -i hospital-key.pem ubuntu@<elastic-ip-vm1>
ssh -i hospital-key.pem ubuntu@<elastic-ip-vm2>
ssh -i hospital-key.pem ubuntu@<elastic-ip-vm3>

# Verify networking
ping 10.0.1.10  # GPU node
ping 10.0.1.20  # DB node
ping 10.0.1.30  # App node
```

#### Day 3-5: Operating System Setup

**On Each VM** (run these commands):

```bash
# 1. Update system
sudo apt-get update
sudo apt-get upgrade -y

# 2. Set hostname
sudo hostnamectl set-hostname gpu-node-1  # or db-node-1, app-node-1

# 3. Configure /etc/hosts (on all VMs)
sudo tee -a /etc/hosts <<EOF
10.0.1.10 gpu-node-1 jupyter.hospital.local vllm.hospital.local
10.0.1.20 db-node-1 postgres.hospital.local minio.hospital.local
10.0.1.30 app-node-1 mlflow.hospital.local grafana.hospital.local airflow.hospital.local
EOF

# 4. Install essential tools
sudo apt-get install -y \
  build-essential \
  curl \
  wget \
  git \
  vim \
  htop \
  net-tools \
  iptables \
  ufw \
  ntp

# 5. Configure NTP (time synchronization)
sudo timedatectl set-ntp on

# 6. Set up non-root user for Docker (security best practice)
sudo adduser mlplatform
sudo usermod -aG sudo mlplatform
sudo su - mlplatform

# 7. Mount additional storage (if using separate disks)
# List disks
lsblk

# Format second disk (/dev/nvme1n1 or /dev/sdb)
sudo mkfs.ext4 /dev/nvme1n1

# Create mount point
sudo mkdir -p /data

# Mount disk
sudo mount /dev/nvme1n1 /data

# Add to /etc/fstab for persistent mount
echo '/dev/nvme1n1 /data ext4 defaults 0 0' | sudo tee -a /etc/fstab

# Verify
df -h
```

#### Day 5-7: Docker Installation

**On All VMs**:

```bash
# 1. Install Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 2. Add user to docker group (no sudo needed)
sudo usermod -aG docker $USER
newgrp docker

# 3. Install Docker Compose V2
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 4. Verify installation
docker --version
# Expected: Docker version 24.0.x

docker-compose --version
# Expected: Docker Compose version v2.24.0

# 5. Test Docker
docker run hello-world
# Should download and run successfully

# 6. Configure Docker daemon (increase log retention, resource limits)
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "5"
  },
  "data-root": "/data/docker",
  "storage-driver": "overlay2"
}
EOF

# 7. Restart Docker
sudo systemctl restart docker
sudo systemctl enable docker

# 8. Verify daemon config
docker info | grep "Storage Driver"
# Should show: overlay2
```

**GPU Node Only (VM1): NVIDIA Driver & Container Toolkit**

```bash
# 1. Install NVIDIA drivers
sudo apt-get install -y nvidia-driver-535

# Reboot required
sudo reboot

# After reboot, verify
nvidia-smi
# Should show GPU information (e.g., A10G, RTX 4090)

# 2. Install NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2

# 3. Restart Docker
sudo systemctl restart docker

# 4. Verify GPU access from Docker
docker run --rm --gpus all nvidia/cuda:12.0.0-base-ubuntu22.04 nvidia-smi
# Should show GPU information inside container
```

### Week 2: Networking & Security

#### Day 8-10: Firewall Configuration

**On All VMs**:

```bash
# 1. Configure UFW (Uncomplicated Firewall)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Allow SSH from office network
OFFICE_IP="1.2.3.4"  # Replace with your office public IP
sudo ufw allow from $OFFICE_IP to any port 22 proto tcp

# 3. Allow inter-VM communication
sudo ufw allow from 10.0.1.0/24

# 4. VM-specific rules

# GPU Node (VM1): Allow JupyterHub, vLLM
sudo ufw allow from $OFFICE_IP to any port 8000 proto tcp  # JupyterHub
sudo ufw allow from $OFFICE_IP to any port 8001 proto tcp  # vLLM

# DB Node (VM2): PostgreSQL, MinIO (only from VMs)
sudo ufw allow from 10.0.1.0/24 to any port 5432 proto tcp  # PostgreSQL
sudo ufw allow from 10.0.1.0/24 to any port 9000 proto tcp  # MinIO

# App Node (VM3): Web services
sudo ufw allow from $OFFICE_IP to any port 80 proto tcp     # HTTP
sudo ufw allow from $OFFICE_IP to any port 443 proto tcp    # HTTPS
sudo ufw allow from $OFFICE_IP to any port 3000 proto tcp   # Grafana
sudo ufw allow from $OFFICE_IP to any port 5000 proto tcp   # MLflow

# 5. Enable firewall
sudo ufw enable

# 6. Verify rules
sudo ufw status numbered
```

#### Day 10-12: SSL/TLS Certificates

**Option A: Self-Signed Certificates (Development)**

```bash
# On App Node (VM3) - will act as reverse proxy

# 1. Generate self-signed certificate
sudo mkdir -p /data/certs
cd /data/certs

sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
  -keyout hospital.key \
  -out hospital.crt \
  -subj "/C=US/ST=State/L=City/O=Hospital/CN=*.hospital.local"

# 2. Distribute to all VMs for trust
sudo cp hospital.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

# 3. Verify
ls -l /data/certs/
# Should see hospital.key and hospital.crt
```

**Option B: Let's Encrypt (If using public domain)**

```bash
# Skip for prototype, use in production
```

### Week 3: Shared Storage & Git Repository

#### Day 13-15: MinIO Object Storage

**On DB Node (VM2)**:

```bash
# 1. Create data directories
sudo mkdir -p /data/minio/{data,config}
sudo chown -R 1000:1000 /data/minio

# 2. Create docker-compose.yml for MinIO
cat > /home/mlplatform/docker-compose-minio.yml <<'EOF'
version: '3.9'

services:
  minio:
    image: minio/minio:latest
    container_name: minio
    restart: unless-stopped
    ports:
      - "9000:9000"
      - "9001:9001"
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin123
    volumes:
      - /data/minio/data:/data
    command: server /data --console-address ":9001"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3

networks:
  default:
    name: hospital-network
    driver: bridge
EOF

# 3. Start MinIO
docker-compose -f docker-compose-minio.yml up -d

# 4. Verify MinIO is running
docker ps
curl http://localhost:9000/minio/health/live
# Should return 200 OK

# 5. Access MinIO console
# Open browser: http://10.0.1.20:9001
# Login: minioadmin / minioadmin123

# 6. Create buckets via API
docker exec -it minio mc alias set local http://localhost:9000 minioadmin minioadmin123
docker exec -it minio mc mb local/mlflow-artifacts
docker exec -it minio mc mb local/jupyter-notebooks
docker exec -it minio mc mb local/datasets
docker exec -it minio mc mb local/models

# 7. Verify buckets
docker exec -it minio mc ls local/
```

#### Day 15-17: PostgreSQL Database

**On DB Node (VM2)**:

```bash
# 1. Create data directory
sudo mkdir -p /data/postgres
sudo chown -R 999:999 /data/postgres

# 2. Create docker-compose.yml for PostgreSQL
cat > /home/mlplatform/docker-compose-postgres.yml <<'EOF'
version: '3.9'

services:
  postgres:
    image: postgres:16-alpine
    container_name: postgres
    restart: unless-stopped
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: mluser
      POSTGRES_PASSWORD: mlpassword123
      POSTGRES_DB: mlplatform
      PGDATA: /var/lib/postgresql/data/pgdata
    volumes:
      - /data/postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U mluser"]
      interval: 10s
      timeout: 5s
      retries: 5

networks:
  default:
    name: hospital-network
    external: true
EOF

# 3. Start PostgreSQL
docker-compose -f docker-compose-postgres.yml up -d

# 4. Verify PostgreSQL is running
docker exec -it postgres psql -U mluser -d mlplatform -c "SELECT version();"
# Should show PostgreSQL 16.x

# 5. Create databases for services
docker exec -it postgres psql -U mluser -d postgres <<'EOSQL'
CREATE DATABASE mlflow;
CREATE DATABASE jupyterhub;
CREATE DATABASE airflow;
GRANT ALL PRIVILEGES ON DATABASE mlflow TO mluser;
GRANT ALL PRIVILEGES ON DATABASE jupyterhub TO mluser;
GRANT ALL PRIVILEGES ON DATABASE airflow TO mluser;
EOSQL

# 6. Verify databases
docker exec -it postgres psql -U mluser -c "\l"
```

#### Day 17-19: Git Server (Gitea)

**On App Node (VM3)**:

```bash
# 1. Create data directory
sudo mkdir -p /data/gitea
sudo chown -R 1000:1000 /data/gitea

# 2. Create docker-compose.yml for Gitea
cat > /home/mlplatform/docker-compose-gitea.yml <<'EOF'
version: '3.9'

services:
  gitea:
    image: gitea/gitea:1.21
    container_name: gitea
    restart: unless-stopped
    ports:
      - "3001:3000"
      - "2222:22"
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=10.0.1.20:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=mluser
      - GITEA__database__PASSWD=mlpassword123
    volumes:
      - /data/gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro

networks:
  default:
    name: hospital-network
    external: true
EOF

# 3. Create Gitea database
ssh mlplatform@10.0.1.20 "docker exec -it postgres psql -U mluser -d postgres -c 'CREATE DATABASE gitea;'"

# 4. Start Gitea
docker-compose -f docker-compose-gitea.yml up -d

# 5. Access Gitea web interface
# Open browser: http://10.0.1.30:3001
# Complete initial setup:
#   - Database type: PostgreSQL
#   - Host: 10.0.1.20:5432
#   - User: mluser
#   - Password: mlpassword123
#   - Database: gitea

# 6. Create admin user
# Use web interface to create admin account

# 7. Create organization and repositories
# - Organization: Hospital-AI-ML
# - Repositories:
#   - platform-infrastructure
#   - ml-models
#   - notebooks
#   - documentation
```

---

## Phase 2: UI/UX Design System (Weeks 2-4)

### Objectives
- Define design principles
- Create component library
- Design portal layouts
- Establish branding (colors, fonts, logos)
- Create wireframes and mockups

### Week 2-3: Design System Development

#### 2.1 Design Principles

**Hospital AI/ML Platform Design Philosophy**:

```yaml
Principles:
  1. **Simplicity First**:
     - Minimize cognitive load
     - Clear navigation hierarchy
     - Consistent patterns
     - Progressive disclosure (advanced features hidden initially)

  2. **Persona-Centric**:
     - Each persona has dedicated portal
     - Role-appropriate UI complexity
     - Doctors: Simple, quick access
     - Developers: Feature-rich, technical
     - Management: Executive dashboards

  3. **Accessibility**:
     - WCAG 2.1 Level AA compliance
     - Keyboard navigation
     - Screen reader support
     - High contrast mode
     - Responsive (desktop, tablet, mobile)

  4. **Healthcare-Friendly**:
     - Clinical color scheme (blues, whites)
     - Medical iconography
     - HIPAA-compliant UI (no PHI in URLs, logs)
     - Audit trail for all actions

  5. **Performance**:
     - Fast load times (<3s)
     - Optimistic UI updates
     - Skeleton screens during load
     - Lazy loading for heavy components
```

#### 2.2 Color Palette

```css
/* Primary Colors (Blues - Trust, Healthcare) */
--color-primary-100: #E3F2FD;  /* Lightest blue */
--color-primary-300: #64B5F6;  /* Light blue */
--color-primary-500: #2196F3;  /* Primary blue */
--color-primary-700: #1976D2;  /* Dark blue */
--color-primary-900: #0D47A1;  /* Darkest blue */

/* Accent Colors (Teal - Medical Technology) */
--color-accent-300: #4DB6AC;   /* Light teal */
--color-accent-500: #009688;   /* Teal */
--color-accent-700: #00796B;   /* Dark teal */

/* Semantic Colors */
--color-success: #4CAF50;      /* Green - success states */
--color-warning: #FF9800;      /* Orange - warnings */
--color-error: #F44336;        /* Red - errors */
--color-info: #2196F3;         /* Blue - informational */

/* Neutral Colors */
--color-gray-100: #F5F5F5;     /* Background */
--color-gray-300: #E0E0E0;     /* Borders */
--color-gray-500: #9E9E9E;     /* Secondary text */
--color-gray-700: #616161;     /* Primary text */
--color-gray-900: #212121;     /* Headers */

/* Text Colors */
--color-text-primary: #212121;
--color-text-secondary: #757575;
--color-text-disabled: #BDBDBD;
--color-text-inverse: #FFFFFF;
```

#### 2.3 Typography

```css
/* Font Families */
--font-family-sans: 'Inter', 'Roboto', -apple-system, BlinkMacSystemFont, sans-serif;
--font-family-mono: 'Fira Code', 'Consolas', 'Monaco', monospace;

/* Font Sizes */
--font-size-xs: 0.75rem;   /* 12px */
--font-size-sm: 0.875rem;  /* 14px */
--font-size-base: 1rem;    /* 16px */
--font-size-lg: 1.125rem;  /* 18px */
--font-size-xl: 1.25rem;   /* 20px */
--font-size-2xl: 1.5rem;   /* 24px */
--font-size-3xl: 1.875rem; /* 30px */
--font-size-4xl: 2.25rem;  /* 36px */

/* Font Weights */
--font-weight-regular: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
--font-weight-bold: 700;

/* Line Heights */
--line-height-tight: 1.25;
--line-height-normal: 1.5;
--line-height-relaxed: 1.75;
```

#### 2.4 Component Library

**React Component Structure**:

```jsx
// src/components/Button/Button.jsx

import React from 'react';
import './Button.css';

export const Button = ({
  children,
  variant = 'primary',
  size = 'medium',
  disabled = false,
  loading = false,
  onClick,
  ...props
}) => {
  const className = `btn btn-${variant} btn-${size} ${disabled ? 'btn-disabled' : ''} ${loading ? 'btn-loading' : ''}`;

  return (
    <button
      className={className}
      disabled={disabled || loading}
      onClick={onClick}
      {...props}
    >
      {loading && <span className="btn-spinner" />}
      {children}
    </button>
  );
};

// Variants: primary, secondary, success, danger, ghost
// Sizes: small, medium, large
```

```css
/* src/components/Button/Button.css */

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 6px;
  font-weight: var(--font-weight-medium);
  transition: all 0.2s ease;
  cursor: pointer;
  border: none;
  outline: none;
}

.btn-primary {
  background-color: var(--color-primary-500);
  color: white;
}

.btn-primary:hover {
  background-color: var(--color-primary-700);
}

.btn-medium {
  padding: 10px 20px;
  font-size: var(--font-size-base);
}

.btn-loading {
  opacity: 0.7;
  cursor: not-allowed;
}
```

**Component Catalog**:

1. **Layout Components**:
   - `<Page>` - Full page wrapper
   - `<Header>` - Top navigation bar
   - `<Sidebar>` - Left sidebar navigation
   - `<Content>` - Main content area
   - `<Footer>` - Bottom footer

2. **Navigation Components**:
   - `<NavBar>` - Top navigation
   - `<NavItem>` - Navigation link
   - `<Breadcrumbs>` - Breadcrumb trail
   - `<Tabs>` - Tab navigation

3. **Form Components**:
   - `<Input>` - Text input
   - `<Select>` - Dropdown select
   - `<Checkbox>` - Checkbox
   - `<Radio>` - Radio button
   - `<FileUpload>` - File upload
   - `<DatePicker>` - Date picker

4. **Data Display Components**:
   - `<Table>` - Data table
   - `<Card>` - Content card
   - `<Badge>` - Status badge
   - `<Avatar>` - User avatar
   - `<Chart>` - Chart component (wrapper for Chart.js)

5. **Feedback Components**:
   - `<Alert>` - Alert message
   - `<Toast>` - Toast notification
   - `<Modal>` - Modal dialog
   - `<Spinner>` - Loading spinner
   - `<Progress>` - Progress bar

#### 2.5 Portal Wireframes

**Developer Portal Layout**:

```
┌──────────────────────────────────────────────────────────────┐
│  [Logo] Hospital AI/ML Platform    [User: John] [Logout]    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐  ┌────────────────────────────────────────┐  │
│  │  Nav     │  │                                        │  │
│  │          │  │  Dashboard                             │  │
│  │ •Home    │  │                                        │  │
│  │ •Notebook│  │  ┌───────────┬───────────┬──────────┐ │  │
│  │ •Models  │  │  │ Active    │ Models    │ GPU      │ │  │
│  │ •Data    │  │  │ Notebooks │ Trained   │ Usage    │ │  │
│  │ •Jobs    │  │  │    12     │    45     │   67%    │ │  │
│  │ •Docs    │  │  └───────────┴───────────┴──────────┘ │  │
│  │          │  │                                        │  │
│  └──────────┘  │  Recent Experiments (MLflow)           │  │
│                │  ┌─────────────────────────────────┐   │  │
│                │  │ Exp Name | Accuracy | Status   │   │  │
│                │  │ chest-xr │  0.94    │ ✓        │   │  │
│                │  │ sepsis   │  0.87    │ Running  │   │  │
│                │  └─────────────────────────────────┘   │  │
│                │                                        │  │
│                │  [Launch JupyterHub] [View MLflow]    │  │
│                └────────────────────────────────────────┘  │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Clinical Portal Layout (Doctors)**:

```
┌──────────────────────────────────────────────────────────────┐
│  [Logo] Clinical AI Assistant       [Dr. Smith] [Logout]    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐  ┌────────────────────────────────────────┐  │
│  │  Quick   │  │                                        │  │
│  │  Access  │  │  Patient Dashboard                     │  │
│  │          │  │                                        │  │
│  │ •Patients│  │  Patient ID: 12345                     │  │
│  │ •Images  │  │  Name: John Doe | Age: 65 | M          │  │
│  │ •Labs    │  │                                        │  │
│  │ •AI Help │  │  ┌─────────────────────────────────┐   │  │
│  │          │  │  │ AI-Assisted Diagnosis           │   │  │
│  │          │  │  │ Chest X-Ray Analysis:           │   │  │
│  │          │  │  │ • Pneumonia detected (94%)     │   │  │
│  │          │  │  │ • Location: Right lower lobe   │   │  │
│  │          │  │  │ [View Image] [Get Second Op]   │   │  │
│  │          │  │  └─────────────────────────────────┘   │  │
│  └──────────┘  │                                        │  │
│                │  Recent Labs                           │  │
│                │  • WBC: 12.5 (↑ High)                  │  │
│                │  • CRP: 45 (↑ High)                    │  │
│                │                                        │  │
│                │  [Order Test] [Consult AI]            │  │
│                └────────────────────────────────────────┘  │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Management Portal Layout (Executives)**:

```
┌──────────────────────────────────────────────────────────────┐
│  [Logo] Executive Dashboard        [Admin] [Logout]          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  KPIs                                                 │   │
│  │  ┌──────────┬──────────┬──────────┬──────────┐       │   │
│  │  │ Platform │ Active   │ Models   │ Cost     │       │   │
│  │  │ Uptime   │ Users    │ Deployed │ Savings  │       │   │
│  │  │ 99.8%    │ 156      │ 12       │ $45K/mo  │       │   │
│  │  └──────────┴──────────┴──────────┴──────────┘       │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Usage Trends (Past 30 Days)                         │   │
│  │  [Line Chart: User Activity Over Time]               │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  ROI Analysis                                         │   │
│  │  • Diagnostic accuracy: +15%                          │   │
│  │  • Time saved: 120 hrs/week                           │   │
│  │  • Cost avoidance: $3.2M (5-year)                     │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Week 4: Frontend Implementation

#### 4.1 Project Setup

```bash
# On Development Machine

# 1. Create React project
npx create-react-app hospital-aiml-frontend
cd hospital-aiml-frontend

# 2. Install dependencies
npm install \
  react-router-dom \
  axios \
  @mui/material \
  @emotion/react \
  @emotion/styled \
  chart.js \
  react-chartjs-2 \
  date-fns \
  lodash

# 3. Project structure
mkdir -p src/{components,pages,services,hooks,utils,styles}

# src/
#   components/     # Reusable UI components
#   pages/          # Page components (Developer, Clinical, Management)
#   services/       # API clients
#   hooks/          # Custom React hooks
#   utils/          # Utility functions
#   styles/         # Global styles, themes
```

#### 4.2 Component Development

**Example: Developer Dashboard Page**

```jsx
// src/pages/DeveloperDashboard.jsx

import React, { useState, useEffect } from 'react';
import { Card, Button, Grid, Typography } from '@mui/material';
import { MLflowService } from '../services/mlflow';
import { ExperimentList } from '../components/ExperimentList';
import { ResourceUsage } from '../components/ResourceUsage';

export const DeveloperDashboard = () => {
  const [experiments, setExperiments] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchExperiments();
  }, []);

  const fetchExperiments = async () => {
    try {
      const data = await MLflowService.listExperiments();
      setExperiments(data);
    } catch (error) {
      console.error('Failed to fetch experiments:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="dashboard">
      <Typography variant="h4" gutterBottom>
        Developer Dashboard
      </Typography>

      <Grid container spacing={3}>
        <Grid item xs={12} md={4}>
          <Card>
            <Typography variant="h6">Active Notebooks</Typography>
            <Typography variant="h3">12</Typography>
          </Card>
        </Grid>

        <Grid item xs={12} md={4}>
          <Card>
            <Typography variant="h6">Models Trained</Typography>
            <Typography variant="h3">45</Typography>
          </Card>
        </Grid>

        <Grid item xs={12} md={4}>
          <Card>
            <Typography variant="h6">GPU Usage</Typography>
            <Typography variant="h3">67%</Typography>
          </Card>
        </Grid>

        <Grid item xs={12}>
          <Card>
            <Typography variant="h5">Recent Experiments</Typography>
            <ExperimentList experiments={experiments} loading={loading} />
          </Card>
        </Grid>

        <Grid item xs={12}>
          <Card>
            <Typography variant="h5">Resource Usage</Typography>
            <ResourceUsage />
          </Card>
        </Grid>
      </Grid>

      <div className="actions">
        <Button
          variant="contained"
          color="primary"
          onClick={() => window.location.href = 'http://jupyter.hospital.local:8000'}
        >
          Launch JupyterHub
        </Button>
        <Button
          variant="outlined"
          onClick={() => window.location.href = 'http://mlflow.hospital.local:5000'}
        >
          View MLflow
        </Button>
      </div>
    </div>
  );
};
```

---

## Phase 3: VM Configuration (Weeks 3-5)

### Objectives
- Configure each VM for its specific role
- Set up monitoring agents
- Configure log shipping
- Implement backup scripts
- Performance tuning

### Week 3-4: Service-Specific Configuration

#### 3.1 GPU Node (VM1) Configuration

```bash
# On GPU Node (VM1)

# 1. NVIDIA Persistence Daemon (keeps driver loaded)
sudo systemctl enable nvidia-persistenced
sudo systemctl start nvidia-persistenced

# 2. GPU monitoring
docker run -d \
  --restart=unless-stopped \
  --gpus all \
  --name=dcgm-exporter \
  -p 9400:9400 \
  nvcr.io/nvidia/k8s/dcgm-exporter:2.6.0-2.6.10-ubuntu20.04

# 3. Resource limits in Docker daemon
sudo tee -a /etc/docker/daemon.json <<'EOF'
{
  "default-runtime": "nvidia",
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
EOF

sudo systemctl restart docker

# 4. Install CUDA toolkit (for local development)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-0-local_12.0.0-525.60.13-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda

# 5. Verify
nvidia-smi
nvcc --version
```

#### 3.2 Database Node (VM2) Configuration

```bash
# On Database Node (VM2)

# 1. PostgreSQL tuning parameters (based on 32GB RAM)
# Note: These will be applied in docker-compose later
cat > /home/mlplatform/postgres-custom.conf <<'EOF'
# Memory Settings
shared_buffers = 8GB
effective_cache_size = 24GB
maintenance_work_mem = 2GB
work_mem = 64MB

# Checkpoint Settings
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100

# Parallel Query Settings
max_worker_processes = 8
max_parallel_workers_per_gather = 4
max_parallel_workers = 8

# Logging
logging_collector = on
log_directory = 'pg_log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_statement = 'mod'  # Log all DDL/DML
log_duration = on
log_min_duration_statement = 1000  # Log queries > 1s

# Connection Settings
max_connections = 200
EOF

# 2. Redis configuration
cat > /home/mlplatform/redis.conf <<'EOF'
# Network
bind 0.0.0.0
protected-mode yes
port 6379

# Memory
maxmemory 4gb
maxmemory-policy allkeys-lru

# Persistence
save 900 1
save 300 10
save 60 10000
appendonly yes
appendfilename "appendonly.aof"

# Replication (for future HA)
# replicaof 10.0.1.21 6379

# Security
requirepass redis123
EOF

# 3. MinIO configuration (already done in Phase 1)
# No additional config needed
```

#### 3.3 Application Node (VM3) Configuration

```bash
# On Application Node (VM3)

# 1. Install Traefik (reverse proxy)
cat > /home/mlplatform/docker-compose-traefik.yml <<'EOF'
version: '3.9'

services:
  traefik:
    image: traefik:v2.10
    container_name: traefik
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "8080:8080"  # Dashboard
    command:
      - "--api.dashboard=true"
      - "--api.insecure=true"  # For prototype only
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /data/certs:/certs:ro

networks:
  default:
    name: hospital-network
    external: true
EOF

docker-compose -f docker-compose-traefik.yml up -d

# 2. Verify Traefik dashboard
curl http://localhost:8080/dashboard/

# 3. Create shared volumes directory
sudo mkdir -p /data/{mlflow,grafana,prometheus,airflow}
sudo chown -R 1000:1000 /data/{mlflow,grafana,prometheus,airflow}
```

### Week 4-5: Monitoring & Logging

#### 4.1 Prometheus Setup

**On App Node (VM3)**:

```bash
# 1. Create Prometheus configuration
cat > /home/mlplatform/prometheus.yml <<'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  # Prometheus itself
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # Node exporters (system metrics)
  - job_name: 'node-exporter'
    static_configs:
      - targets:
          - '10.0.1.10:9100'  # GPU node
          - '10.0.1.20:9100'  # DB node
          - '10.0.1.30:9100'  # App node

  # GPU metrics (DCGM Exporter on GPU node)
  - job_name: 'dcgm-exporter'
    static_configs:
      - targets: ['10.0.1.10:9400']

  # PostgreSQL exporter
  - job_name: 'postgres-exporter'
    static_configs:
      - targets: ['10.0.1.20:9187']

  # MinIO metrics
  - job_name: 'minio'
    metrics_path: /minio/v2/metrics/cluster
    static_configs:
      - targets: ['10.0.1.20:9000']

  # Docker metrics (cAdvisor)
  - job_name: 'cadvisor'
    static_configs:
      - targets:
          - '10.0.1.10:8090'
          - '10.0.1.20:8090'
          - '10.0.1.30:8090'
EOF

# 2. Create Prometheus docker-compose
cat > /home/mlplatform/docker-compose-prometheus.yml <<'EOF'
version: '3.9'

services:
  prometheus:
    image: prom/prometheus:v2.48.0
    container_name: prometheus
    restart: unless-stopped
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - /data/prometheus:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--storage.tsdb.retention.time=30d'

networks:
  default:
    name: hospital-network
    external: true
EOF

# 3. Start Prometheus
docker-compose -f docker-compose-prometheus.yml up -d

# 4. Verify Prometheus
curl http://localhost:9090/-/healthy
# Open browser: http://10.0.1.30:9090
```

#### 4.2 Node Exporter (System Metrics)

**On All VMs**:

```bash
# Install node_exporter on each VM
docker run -d \
  --name=node-exporter \
  --restart=unless-stopped \
  --net=host \
  --pid=host \
  -v "/:/host:ro,rslave" \
  prom/node-exporter:v1.7.0 \
  --path.rootfs=/host

# Verify
curl http://localhost:9100/metrics
```

#### 4.3 Grafana Setup

**On App Node (VM3)**:

```bash
# 1. Create Grafana docker-compose
cat > /home/mlplatform/docker-compose-grafana.yml <<'EOF'
version: '3.9'

services:
  grafana:
    image: grafana/grafana:10.2.0
    container_name: grafana
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin123
      - GF_INSTALL_PLUGINS=grafana-piechart-panel
    volumes:
      - /data/grafana:/var/lib/grafana
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.grafana.rule=Host(`grafana.hospital.local`)"
      - "traefik.http.services.grafana.loadbalancer.server.port=3000"

networks:
  default:
    name: hospital-network
    external: true
EOF

# 2. Start Grafana
docker-compose -f docker-compose-grafana.yml up -d

# 3. Access Grafana
# Open browser: http://grafana.hospital.local:3000 or http://10.0.1.30:3000
# Login: admin / admin123 (change password on first login)

# 4. Add Prometheus data source
# Navigate to: Configuration → Data Sources → Add data source
# Select: Prometheus
# URL: http://10.0.1.30:9090
# Click: Save & Test

# 5. Import dashboards
# Navigate to: Dashboards → Import
# Import these dashboard IDs:
#   - 1860: Node Exporter Full
#   - 12239: NVIDIA DCGM Exporter
#   - 9628: PostgreSQL Database
#   - 13021: MinIO Dashboard
```

---

## Phase 4: Docker Orchestration (Weeks 4-6)

### Objectives
- Create unified Docker Compose files
- Implement service dependencies
- Configure health checks
- Set up auto-restart policies
- Volume management

### Week 5: Unified Docker Compose

#### 4.1 Master Docker Compose File

**Create Master Compose File** (combines all services):

```bash
# On Tech Lead's Machine

# Create project structure
mkdir -p hospital-aiml-platform/{configs,scripts,docs}
cd hospital-aiml-platform

# Create master docker-compose.yml
cat > docker-compose.yml <<'EOF'
version: '3.9'

#
# Hospital AI/ML Platform - Prototype Deployment
# Option 3: Bare Metal / VMs
#
# Deployment Instructions:
# 1. Deploy database services first: docker-compose up -d postgres redis minio
# 2. Wait 30s, then deploy ML services: docker-compose up -d mlflow jupyterhub
# 3. Deploy monitoring: docker-compose up -d prometheus grafana
# 4. Deploy remaining services: docker-compose up -d
#

services:
  # ========================================
  # DATABASE LAYER (VM2: 10.0.1.20)
  # ========================================

  postgres:
    image: postgres:16-alpine
    container_name: postgres
    hostname: postgres
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.20:5432:5432"
    environment:
      POSTGRES_USER: mluser
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-mlpassword123}
      POSTGRES_DB: mlplatform
      PGDATA: /var/lib/postgresql/data/pgdata
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./configs/postgres-custom.conf:/etc/postgresql/postgresql.conf:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U mluser"]
      interval: 10s
      timeout: 5s
      retries: 5
    deploy:
      resources:
        limits:
          memory: 8G

  redis:
    image: redis:7-alpine
    container_name: redis
    hostname: redis
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.20:6379:6379"
    command: redis-server /usr/local/etc/redis/redis.conf
    volumes:
      - redis-data:/data
      - ./configs/redis.conf:/usr/local/etc/redis/redis.conf:ro
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5
    deploy:
      resources:
        limits:
          memory: 4G

  minio:
    image: minio/minio:latest
    container_name: minio
    hostname: minio
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.20:9000:9000"
      - "10.0.1.20:9001:9001"
    environment:
      MINIO_ROOT_USER: ${MINIO_ROOT_USER:-minioadmin}
      MINIO_ROOT_PASSWORD: ${MINIO_ROOT_PASSWORD:-minioadmin123}
    volumes:
      - minio-data:/data
    command: server /data --console-address ":9001"
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 30s
      timeout: 20s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 2G

  # ========================================
  # ML SERVICES LAYER (VM1: 10.0.1.10 + VM3: 10.0.1.30)
  # ========================================

  mlflow:
    image: ghcr.io/mlflow/mlflow:v2.9.0
    container_name: mlflow
    hostname: mlflow
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.30:5000:5000"
    environment:
      MLFLOW_BACKEND_STORE_URI: postgresql://mluser:${POSTGRES_PASSWORD:-mlpassword123}@10.0.1.20:5432/mlflow
      MLFLOW_DEFAULT_ARTIFACT_ROOT: s3://mlflow-artifacts
      AWS_ACCESS_KEY_ID: ${MINIO_ROOT_USER:-minioadmin}
      AWS_SECRET_ACCESS_KEY: ${MINIO_ROOT_PASSWORD:-minioadmin123}
      MLFLOW_S3_ENDPOINT_URL: http://10.0.1.20:9000
    command: >
      mlflow server
      --backend-store-uri postgresql://mluser:${POSTGRES_PASSWORD:-mlpassword123}@10.0.1.20:5432/mlflow
      --default-artifact-root s3://mlflow-artifacts
      --host 0.0.0.0
      --port 5000
    depends_on:
      - postgres
      - minio
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 2G

  jupyterhub:
    image: jupyterhub/jupyterhub:4.0
    container_name: jupyterhub
    hostname: jupyterhub
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.10:8000:8000"
    environment:
      DOCKER_NETWORK_NAME: hospital-network
      POSTGRES_HOST: 10.0.1.20
      POSTGRES_USER: mluser
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-mlpassword123}
      POSTGRES_DB: jupyterhub
    volumes:
      - jupyterhub-data:/srv/jupyterhub
      - ./configs/jupyterhub_config.py:/srv/jupyterhub/jupyterhub_config.py:ro
      - /var/run/docker.sock:/var/run/docker.sock
    command: jupyterhub -f /srv/jupyterhub/jupyterhub_config.py
    depends_on:
      - postgres
    deploy:
      resources:
        limits:
          memory: 4G

  vllm-server:
    image: vllm/vllm-openai:v0.3.0
    container_name: vllm-server
    hostname: vllm
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.10:8001:8000"
    environment:
      HF_HOME: /root/.cache/huggingface
    volumes:
      - vllm-models:/root/.cache/huggingface
    command: >
      --model mistralai/Mistral-7B-Instruct-v0.2
      --dtype float16
      --max-model-len 4096
      --tensor-parallel-size 1
      --gpu-memory-utilization 0.8
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
        limits:
          memory: 24G
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 5

  # ========================================
  # MONITORING LAYER (VM3: 10.0.1.30)
  # ========================================

  prometheus:
    image: prom/prometheus:v2.48.0
    container_name: prometheus
    hostname: prometheus
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.30:9090:9090"
    volumes:
      - ./configs/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus-data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--storage.tsdb.retention.time=30d'
      - '--web.enable-lifecycle'
    healthcheck:
      test: ["CMD", "wget", "-q", "--spider", "http://localhost:9090/-/healthy"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 4G

  grafana:
    image: grafana/grafana:10.2.0
    container_name: grafana
    hostname: grafana
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.30:3000:3000"
    environment:
      GF_SECURITY_ADMIN_USER: ${GRAFANA_ADMIN_USER:-admin}
      GF_SECURITY_ADMIN_PASSWORD: ${GRAFANA_ADMIN_PASSWORD:-admin123}
      GF_INSTALL_PLUGINS: grafana-piechart-panel
      GF_DATABASE_TYPE: postgres
      GF_DATABASE_HOST: 10.0.1.20:5432
      GF_DATABASE_NAME: grafana
      GF_DATABASE_USER: mluser
      GF_DATABASE_PASSWORD: ${POSTGRES_PASSWORD:-mlpassword123}
    volumes:
      - grafana-data:/var/lib/grafana
      - ./configs/grafana-datasources.yml:/etc/grafana/provisioning/datasources/datasources.yml:ro
      - ./configs/grafana-dashboards.yml:/etc/grafana/provisioning/dashboards/dashboards.yml:ro
    depends_on:
      - prometheus
      - postgres
    healthcheck:
      test: ["CMD", "wget", "-q", "--spider", "http://localhost:3000/api/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 1G

  # ========================================
  # WORKFLOW ORCHESTRATION (VM3: 10.0.1.30)
  # ========================================

  airflow-webserver:
    image: apache/airflow:2.7.3-python3.10
    container_name: airflow-webserver
    hostname: airflow-webserver
    restart: unless-stopped
    networks:
      - hospital-network
    ports:
      - "10.0.1.30:8080:8080"
    environment:
      AIRFLOW__CORE__EXECUTOR: LocalExecutor
      AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://mluser:${POSTGRES_PASSWORD:-mlpassword123}@10.0.1.20:5432/airflow
      AIRFLOW__CORE__LOAD_EXAMPLES: 'false'
      AIRFLOW__WEBSERVER__EXPOSE_CONFIG: 'true'
      AIRFLOW__CORE__FERNET_KEY: ${AIRFLOW_FERNET_KEY}
      AIRFLOW__WEBSERVER__SECRET_KEY: ${AIRFLOW_SECRET_KEY}
      _AIRFLOW_DB_UPGRADE: 'true'
      _AIRFLOW_WWW_USER_CREATE: 'true'
      _AIRFLOW_WWW_USER_USERNAME: ${AIRFLOW_ADMIN_USER:-admin}
      _AIRFLOW_WWW_USER_PASSWORD: ${AIRFLOW_ADMIN_PASSWORD:-admin123}
    volumes:
      - airflow-logs:/opt/airflow/logs
      - ./dags:/opt/airflow/dags:ro
      - ./plugins:/opt/airflow/plugins:ro
    depends_on:
      - postgres
    command: webserver
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 5
    deploy:
      resources:
        limits:
          memory: 2G

  airflow-scheduler:
    image: apache/airflow:2.7.3-python3.10
    container_name: airflow-scheduler
    hostname: airflow-scheduler
    restart: unless-stopped
    networks:
      - hospital-network
    environment:
      AIRFLOW__CORE__EXECUTOR: LocalExecutor
      AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://mluser:${POSTGRES_PASSWORD:-mlpassword123}@10.0.1.20:5432/airflow
      AIRFLOW__CORE__LOAD_EXAMPLES: 'false'
      AIRFLOW__CORE__FERNET_KEY: ${AIRFLOW_FERNET_KEY}
    volumes:
      - airflow-logs:/opt/airflow/logs
      - ./dags:/opt/airflow/dags:ro
      - ./plugins:/opt/airflow/plugins:ro
    depends_on:
      - airflow-webserver
    command: scheduler
    healthcheck:
      test: ["CMD-SHELL", "airflow jobs check --job-type SchedulerJob"]
      interval: 30s
      timeout: 10s
      retries: 5
    deploy:
      resources:
        limits:
          memory: 2G

# ========================================
# NETWORKS
# ========================================

networks:
  hospital-network:
    name: hospital-network
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16

# ========================================
# VOLUMES
# ========================================

volumes:
  postgres-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/postgres

  redis-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/redis

  minio-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/minio

  jupyterhub-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/jupyterhub

  vllm-models:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/vllm-models

  prometheus-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/prometheus

  grafana-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/grafana

  airflow-logs:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /data/airflow/logs
EOF

# Create .env file for secrets
cat > .env <<'EOF'
# Database passwords
POSTGRES_PASSWORD=mlpassword123

# MinIO credentials
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin123

# Grafana credentials
GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=admin123

# Airflow credentials
AIRFLOW_ADMIN_USER=admin
AIRFLOW_ADMIN_PASSWORD=admin123
AIRFLOW_FERNET_KEY=<generate with: python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())">
AIRFLOW_SECRET_KEY=<generate with: openssl rand -base64 32>
EOF

echo "Master docker-compose.yml created successfully!"
echo "Next steps:"
echo "1. Review and customize configs/prometheus.yml"
echo "2. Review and customize configs/jupyterhub_config.py"
echo "3. Generate Airflow keys: python -c \"from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())\""
echo "4. Deploy: docker-compose up -d"
```

---

*[Document continues with remaining phases...]*

**Note**: This document is comprehensive and exceeds typical response length. I'll now commit what we have and continue with the remaining sections in subsequent iterations.

**Status**: Phases 0-4 completed (Weeks -2 to 6). Remaining phases (5-7, WBS, Business Processes, Use Cases) to be added in next commit.
