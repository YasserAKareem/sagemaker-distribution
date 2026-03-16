# Request for Proposal (RFP)
## Enterprise AI/ML Platform for Hospital Deployment

**Document Type**: Request for Proposal (RFP)
**RFP Number**: HOSP-AIML-2026-001
**Issue Date**: 2026-03-16
**Proposal Due Date**: 2026-04-30
**Expected Award Date**: 2026-05-15
**Project Start Date**: 2026-06-01

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Organization Background](#2-organization-background)
3. [Project Overview](#3-project-overview)
4. [Technical Requirements](#4-technical-requirements)
5. [Functional Requirements](#5-functional-requirements)
6. [Non-Functional Requirements](#6-non-functional-requirements)
7. [Compliance & Security Requirements](#7-compliance--security-requirements)
8. [Implementation Requirements](#8-implementation-requirements)
9. [Support & Maintenance Requirements](#9-support--maintenance-requirements)
10. [Evaluation Criteria](#10-evaluation-criteria)
11. [Proposal Submission Requirements](#11-proposal-submission-requirements)
12. [Terms and Conditions](#12-terms-and-conditions)
13. [Appendices](#13-appendices)

---

## 1. Executive Summary

### 1.1 Purpose

[Hospital Name] is seeking proposals from qualified vendors to design, implement, and support a comprehensive **enterprise-grade AI/ML platform** capable of supporting 1,000+ concurrent users across multiple organizational personas. The platform must be production-ready, HIPAA-compliant, and optimized for healthcare workflows including medical imaging analysis, clinical decision support, and healthcare operations.

### 1.2 Background

Our hospital currently operates with limited AI/ML capabilities and seeks to establish a modern, scalable platform that will:

- Enable data scientists and researchers to develop and deploy machine learning models
- Provide clinical staff with AI-assisted diagnostic tools and decision support systems
- Support healthcare operations with predictive analytics and automation
- Ensure compliance with healthcare regulations (HIPAA, HITECH, state laws)
- Deliver measurable improvements in patient outcomes and operational efficiency

### 1.3 Scope

The selected vendor will be responsible for:

1. **Solution Design**: Architecture design, technology selection, capacity planning
2. **Infrastructure Deployment**: Hardware procurement assistance, software installation, configuration
3. **Integration**: Connection with existing hospital systems (EHR, PACS, LIS, HIS)
4. **Training**: Comprehensive training for 6 distinct user personas
5. **Support**: Ongoing technical support, maintenance, and optimization

### 1.4 Budget

- **Total Budget**: $500,000 - $750,000 (Year 1 including hardware)
- **Ongoing Annual Budget**: $350,000 - $450,000 (Years 2-5 for operations)
- **Funding Source**: Hospital capital budget + federal AI innovation grants

### 1.5 Timeline

| Phase | Duration | Completion Date |
|-------|----------|-----------------|
| Proposal Evaluation | 2 weeks | 2026-05-15 |
| Contract Negotiation | 2 weeks | 2026-05-31 |
| Phase 1: Infrastructure | 8 weeks | 2026-07-26 |
| Phase 2: Core Services | 6 weeks | 2026-09-06 |
| Phase 3: Healthcare Integration | 4 weeks | 2026-10-04 |
| Phase 4: User Onboarding | 3 weeks | 2026-10-25 |
| **Total Project Duration** | **23 weeks** | **2026-10-25** |

---

## 2. Organization Background

### 2.1 Hospital Profile

- **Organization Type**: [Academic Medical Center / Community Hospital / Hospital System]
- **Bed Count**: [300-500 beds]
- **Annual Patient Volume**: [~50,000 inpatients, ~200,000 outpatients]
- **Employees**: [~2,000 total staff]
- **IT Department**: [20 FTE including 5 infrastructure, 8 applications, 4 security, 3 help desk]

### 2.2 Current IT Environment

| System | Vendor/Product | Status |
|--------|---------------|--------|
| **EHR** | [Epic / Cerner / Meditech] | Production |
| **PACS** | [GE / Philips / Agfa] | Production |
| **LIS** | [Sunquest / Cerner / Soft] | Production |
| **Data Warehouse** | [On-premise / Cloud] | Production |
| **Virtualization** | VMware vSphere 8.0 | Production |
| **Storage** | [NetApp / Dell EMC / Pure] | Production |
| **Network** | Cisco (10GbE core, 1GbE edge) | Production |
| **Identity Mgmt** | Active Directory 2019 | Production |

### 2.3 Current AI/ML Capabilities

- **Existing Tools**: Limited (Excel, SPSS, ad-hoc Python scripts)
- **Data Science Team**: 3 FTE (1 lead, 2 analysts)
- **Current Projects**: Readmission prediction (pilot), sepsis early warning (planned)
- **Pain Points**: No centralized platform, difficult collaboration, no model deployment capability

### 2.4 Strategic Goals

1. **Clinical Excellence**: Improve diagnostic accuracy, reduce medical errors, personalize treatment
2. **Operational Efficiency**: Optimize staffing, reduce wait times, improve resource utilization
3. **Research Innovation**: Enable clinical research, attract grants, publish peer-reviewed studies
4. **Financial Sustainability**: Reduce costs through AI-driven optimization ($5M annual savings target)
5. **Workforce Development**: Train 100+ staff in AI/ML literacy, recruit top data science talent

---

## 3. Project Overview

### 3.1 Objectives

#### Primary Objectives

1. **Deploy production-ready AI/ML platform** supporting 1,000+ concurrent users within 6 months
2. **Achieve 99.9% uptime** (max 8.76 hours downtime/year) for critical clinical applications
3. **Ensure HIPAA compliance** with full audit trail and encryption for all PHI
4. **Deliver measurable ROI** within 18 months (target: $3M annual cost savings)

#### Secondary Objectives

5. **Multi-persona support** for 6 distinct user types (developers, management, operations, clinicians, lab staff, researchers)
6. **Healthcare integration** with EHR (HL7/FHIR), PACS (DICOM), and other hospital systems
7. **Self-service model deployment** enabling data scientists to deploy models without IT intervention
8. **Responsible AI** with bias detection, model explainability, and fairness metrics

### 3.2 Key Use Cases

The platform must support the following initial use cases:

#### Use Case 1: Radiology AI Assistance
- **Description**: AI-assisted chest X-ray interpretation for pneumonia detection
- **Users**: 25 radiologists, 10 residents
- **Volume**: ~500 images/day
- **Requirements**: DICOM integration, <5s inference latency, 95%+ sensitivity/specificity
- **Impact**: 30% reduction in reading time, improved diagnostic accuracy

#### Use Case 2: Clinical Decision Support
- **Description**: Sepsis early warning system analyzing vitals, labs, and clinical notes
- **Users**: 200 nurses, 50 physicians (ICU, ED)
- **Volume**: Real-time monitoring of 100 concurrent patients
- **Requirements**: HL7 integration, <1-minute alert latency, low false positive rate (<5%)
- **Impact**: 20% reduction in sepsis mortality, $2M annual savings

#### Use Case 3: Readmission Risk Prediction
- **Description**: ML model predicting 30-day readmission risk at discharge
- **Users**: 50 physicians, 30 case managers, 20 discharge planners
- **Volume**: ~150 discharges/day
- **Requirements**: EHR integration (FHIR), explainable predictions (SHAP), risk score + interventions
- **Impact**: 15% reduction in readmissions, $1M annual savings

#### Use Case 4: Operational Forecasting
- **Description**: ED volume forecasting for staffing optimization
- **Users**: 10 operations managers, 5 nurse supervisors
- **Volume**: Daily forecasts (7-day horizon), updated hourly
- **Requirements**: Historical data integration, hourly granularity, 85%+ accuracy (MAPE)
- **Impact**: 10% reduction in staffing costs, improved patient satisfaction

#### Use Case 5: Research Data Science
- **Description**: De-identified data analysis for clinical research
- **Users**: 100 researchers, 20 biostatisticians
- **Volume**: Ad-hoc queries on 10-year patient database (~5M patients)
- **Requirements**: De-identification pipeline (Presidio), IRB approval workflow, Jupyter notebooks
- **Impact**: 5+ peer-reviewed publications/year, $500K in grant funding

### 3.3 User Personas

The platform must support distinct workflows for 6 user personas:

| Persona | Count | Primary Activities | Access Level | Key Tools |
|---------|-------|-------------------|--------------|-----------|
| **Developers** | 50 (5%) | Model development, training, deployment | Full dev access + GPU allocation | JupyterHub, MLflow, Git, VS Code |
| **Management** | 20 (2%) | Executive dashboards, ROI tracking | Read-only dashboards | Grafana, Metabase BI |
| **Operations** | 30 (3%) | Platform monitoring, user management, troubleshooting | Full system access (admin) | Prometheus, Grafana, Keycloak Admin |
| **Doctors** | 600 (60%) | Clinical decision support, AI-assisted diagnosis | Patient data + inference API | Clinical UI, DICOM Viewer, AI alerts |
| **Lab Staff** | 200 (20%) | Lab result analysis, quality control | Lab data + batch inference | Lab Dashboard, Image Analysis |
| **Researchers** | 100 (10%) | Clinical research, data analysis | De-identified data only | JupyterHub, RStudio, Data Warehouse |

### 3.4 Success Criteria

The project will be considered successful if the following criteria are met:

#### Technical Success Criteria

- ✅ **Uptime**: 99.9% availability (measured monthly)
- ✅ **Performance**: <100ms API latency (95th percentile), <50ms LLM TTFT
- ✅ **Scalability**: Support 1,000+ concurrent users with <10% degradation
- ✅ **Security**: Zero PHI breaches, 100% audit log coverage
- ✅ **Compliance**: Pass HIPAA audit within 6 months of deployment

#### Business Success Criteria

- ✅ **User Adoption**: 80% of target users active within 6 months
- ✅ **ROI**: $3M annual cost savings or revenue generation within 18 months
- ✅ **Time-to-Insight**: 50% reduction in analytics project cycle time
- ✅ **Research Output**: 5+ peer-reviewed publications leveraging platform
- ✅ **Clinical Impact**: Measurable improvement in at least 2 quality metrics (mortality, readmissions, etc.)

---

## 4. Technical Requirements

### 4.1 Infrastructure Requirements

#### 4.1.1 Compute Infrastructure

| Component | Requirement | Justification |
|-----------|-------------|---------------|
| **GPU Nodes** | 4× servers with 2× NVIDIA A100 40GB or better | High-performance LLM inference (vLLM) + model training |
| **CPU Cores** | 128+ cores per GPU node | Parallel data preprocessing, Triton Inference Server |
| **Memory (GPU)** | 128GB RAM per node minimum | Large batch sizes, multi-model serving |
| **Database Nodes** | 3× servers with 64GB RAM, 2TB SSD (RAID 10) | PostgreSQL cluster (primary + 2 read replicas) |
| **Storage Nodes** | 4× servers with 128GB RAM, 32TB raw capacity | MinIO distributed object storage (S3-compatible) |
| **Application Nodes** | 6× servers with 64GB RAM, 512GB SSD | Web services (JupyterHub, MLflow, Grafana, etc.) |
| **Management Nodes** | 2× servers with 32GB RAM, 512GB SSD | Monitoring (Prometheus, Loki), orchestration |

**Total**: 19 servers minimum

#### 4.1.2 Networking Requirements

- **Core Network**: 10 Gigabit Ethernet (10GbE) minimum
- **Storage Network**: Dedicated 10GbE network for MinIO (optional: 25GbE for better performance)
- **Management Network**: Separate 1GbE network for IPMI/BMC access
- **Internet Connection**: 1Gbps for software updates (can be one-way/firewalled)
- **Internal Bandwidth**: 40Gbps aggregate recommended for GPU-to-storage traffic

#### 4.1.3 Storage Requirements

| Storage Type | Capacity | IOPS | Use Case |
|--------------|----------|------|----------|
| **Fast SSD** | 20TB | 100K+ | Database storage, model artifacts, logs |
| **Object Storage** | 100TB+ | 10K+ | Training datasets, DICOM images, backups |
| **Archive** | 200TB+ (optional) | 1K+ | Long-term retention (7-year audit trail) |

**Growth Projection**: 20% annual growth for 5 years

### 4.2 Software Requirements

#### 4.2.1 Core Platform Components

The solution **must include** the following open-source components or commercial equivalents with feature parity:

| Component | Requirement | Minimum Version | Purpose |
|-----------|-------------|-----------------|---------|
| **Container Orchestration** | Kubernetes or Docker Swarm | K8s 1.29+ / Swarm 24.0+ | Workload orchestration, scaling |
| **Notebook Server** | JupyterHub (multi-user) | 4.0+ | Interactive development environment |
| **ML Platform** | MLflow (experiment tracking, registry) | 2.10+ | Model lifecycle management |
| **Workflow Orchestration** | Apache Airflow | 2.8+ | ETL pipelines, batch jobs |
| **LLM Inference** | vLLM or equivalent (not Ollama) | 0.4+ | Production LLM serving (must support 500+ req/s) |
| **Model Serving** | NVIDIA Triton Inference Server | 2.40+ | High-performance model deployment |
| **Object Storage** | MinIO or S3-compatible | Latest | S3-compatible storage for datasets/artifacts |
| **Database** | PostgreSQL with clustering | 15+ | Metadata storage, feature store |
| **Caching** | Redis with high availability | 7.0+ | Session storage, feature cache |
| **Feature Store** | Feast or equivalent | 0.35+ | Online/offline feature serving |
| **Monitoring** | Prometheus + Grafana | Prometheus 2.45+, Grafana 10+ | Platform and model monitoring |
| **Logging** | Loki or equivalent | 2.9+ | Centralized log aggregation |
| **Authentication** | Keycloak or enterprise SSO | 23+ | Identity management, SSO, RBAC |

**Rationale for vLLM requirement**: Ollama is **not acceptable** due to inability to handle 1,000 concurrent users (throughput <5 req/s, no continuous batching). vLLM provides 40× better throughput (500+ req/s) and is mandatory for production use.

#### 4.2.2 Healthcare-Specific Components

| Component | Requirement | Standard | Purpose |
|-----------|-------------|----------|---------|
| **FHIR Server** | HAPI FHIR or equivalent | FHIR R4+ | EHR integration, patient data API |
| **DICOM Server** | Orthanc or commercial PACS | DICOM 3.0 | Medical imaging storage and retrieval |
| **HL7 Interface** | Mirth Connect or equivalent | HL7 v2.x | Bidirectional HL7 messaging (ADT, ORM, ORU) |
| **De-identification** | Presidio or equivalent | HIPAA Safe Harbor | PHI removal for research datasets |
| **Audit Logger** | Custom or commercial | HIPAA compliant | Immutable audit trail (7-year retention) |

#### 4.2.3 AI/ML Frameworks and Libraries

The platform **must support** the following frameworks (pre-installed):

**Deep Learning**:
- PyTorch 2.0+ (primary framework)
- TensorFlow 2.12+ (legacy support)
- JAX 0.4+ (research use)
- ONNX Runtime 1.15+ (cross-platform inference)

**Medical AI Libraries**:
- MONAI 1.3+ (medical imaging)
- MedicalNet (pre-trained 3D models)
- TorchXRayVision (chest X-ray models)

**General ML**:
- scikit-learn 1.3+
- XGBoost 2.0+
- LightGBM 4.0+
- CatBoost 1.2+

**NLP & LLMs**:
- Hugging Face Transformers 4.35+
- LangChain 0.1+
- LangGraph 0.0.50+
- spaCy 3.7+ (with scispaCy medical models)

**Computer Vision**:
- OpenCV 4.8+
- Albumentations 1.3+
- Detectron2 (latest)
- MMDetection 3.2+

**Data Processing**:
- Pandas 2.1+
- Polars 0.19+
- Dask 2023.10+
- Apache Spark 3.5+ (optional)

### 4.3 Integration Requirements

#### 4.3.1 EHR Integration

- **Standard**: HL7 v2.x (ADT, ORM, ORU) and/or FHIR R4 REST API
- **Direction**: Bidirectional (read patient data, write back AI predictions)
- **Data Elements**: Demographics, vitals, lab results, medications, diagnoses (ICD-10), procedures (CPT)
- **Latency**: <5 seconds for real-time queries
- **Authentication**: OAuth 2.0 or SAML 2.0 (compatible with EHR vendor SSO)
- **Volume**: 10,000+ queries/day

#### 4.3.2 PACS Integration

- **Standard**: DICOM 3.0 (C-STORE, C-FIND, C-MOVE, C-GET)
- **Modalities**: CR, DX, CT, MR, US, NM, PT (all DICOM modalities)
- **Direction**: Bidirectional (retrieve images for AI, store AI annotations)
- **Data Elements**: Images (DICOM files), metadata (patient, study, series)
- **Volume**: 500+ studies/day (~50GB/day)
- **Viewer**: Web-based DICOM viewer (e.g., OHIF) for clinicians

#### 4.3.3 Laboratory Information System (LIS)

- **Standard**: HL7 v2.x (ORU messages for lab results)
- **Direction**: Inbound (read lab results)
- **Data Elements**: Lab test results, reference ranges, abnormal flags
- **Latency**: <1 minute from result availability
- **Volume**: 5,000+ results/day

#### 4.3.4 Active Directory / LDAP

- **Standard**: LDAP v3 or Active Directory (Kerberos, NTLM)
- **Purpose**: User authentication, group membership, SSO
- **Sync**: Real-time or 5-minute incremental sync
- **Attributes**: Username, email, department, job title, manager

### 4.4 Deployment Architecture

#### 4.4.1 Orchestration Options

Vendor must propose **one** of the following (with rationale):

**Option 1: Kubernetes Cluster (Recommended for >1K users)**
- 5 master nodes (HA control plane)
- 15+ worker nodes (autoscaling)
- Persistent storage (CSI driver for MinIO/PostgreSQL)
- Ingress controller (Traefik or NGINX)
- Cert-manager for TLS automation

**Option 2: Docker Swarm**
- 3 manager nodes (HA)
- 12+ worker nodes
- Overlay networking
- Simpler than Kubernetes, suitable for 1K users

**Option 3: Bare Metal / VMs**
- Direct deployment on 19 servers
- Manual scaling and orchestration
- Simplest but least flexible

**Vendor must justify selection** based on hospital IT expertise, budget, and growth plans.

#### 4.4.2 High Availability Requirements

| Component | HA Requirement | Implementation |
|-----------|----------------|----------------|
| **Database** | 99.9% uptime | PostgreSQL primary + 2 replicas (Patroni/Stolon), automatic failover |
| **Cache** | 99.9% uptime | Redis Sentinel (3 nodes), automatic failover |
| **Object Storage** | 99.99% uptime | MinIO distributed (4 nodes, EC:2), self-healing |
| **LLM Inference** | 99.9% uptime | vLLM replicas (2-4 instances), load balancing |
| **Model Serving** | 99.9% uptime | Triton replicas (2+ per model), health checks |
| **Web Services** | 99.5% uptime | Multiple replicas (2-3), load balancing |

**RTO (Recovery Time Objective)**: <1 hour
**RPO (Recovery Point Objective)**: <15 minutes (daily backups acceptable for non-critical data)

#### 4.4.3 Backup and Disaster Recovery

- **Database Backups**: Full daily + incremental hourly (pg_basebackup, WAL archiving)
- **Object Storage Backups**: S3 replication to offsite MinIO or public cloud (daily sync)
- **Configuration Backups**: Git repository for Infrastructure-as-Code (Kubernetes manifests, Ansible playbooks)
- **Retention**: 30 days (operational), 7 years (audit logs, HIPAA requirement)
- **Testing**: Quarterly disaster recovery drills (documented restore procedures)

---

## 5. Functional Requirements

### 5.1 User Management

#### 5.1.1 Authentication

- **SSO Integration**: Must integrate with hospital Active Directory via LDAP/SAML/OAuth2
- **Multi-Factor Authentication (MFA)**: Enforce MFA for all users (TOTP, WebAuthn, or SMS)
- **Session Management**: Automatic timeout after 15 minutes of inactivity (HIPAA requirement)
- **Password Policy**: Minimum 12 characters, complexity requirements (enforced by AD)

#### 5.1.2 Authorization (RBAC)

The platform must support role-based access control with the following roles:

| Role | Description | Permissions |
|------|-------------|-------------|
| **Admin** | Platform administrators | Full system access (all actions) |
| **Developer** | Data scientists, ML engineers | Create notebooks, train models, deploy to dev/staging, read all data |
| **Researcher** | Clinical researchers | Create notebooks, read de-identified data only, no model deployment |
| **Clinician** | Doctors, nurses | Access clinical UI, view AI predictions, no data science tools |
| **Lab Staff** | Lab technicians | Access lab dashboard, upload images, view batch inference results |
| **Manager** | Department heads, executives | Read-only dashboards (Grafana, Metabase), no direct data access |
| **Operator** | IT operations staff | Monitor platform, manage users, view logs, restart services |

#### 5.1.3 Audit Logging

- **PHI Access Logging**: Log every access to PHI (patient ID, user, timestamp, action)
- **Model Predictions**: Log all AI predictions (input, output, model version, timestamp)
- **User Actions**: Log login/logout, role changes, data exports, model deployments
- **Retention**: 7 years (HIPAA requirement)
- **Immutability**: Write-once storage (prevent tampering)
- **Export**: CSV/JSON export for compliance audits

### 5.2 Data Management

#### 5.2.1 Data Ingestion

- **Batch Ingestion**: CSV, Parquet, JSON upload (via web UI or API)
- **Streaming Ingestion**: Apache Kafka or equivalent (for real-time vitals, alerts)
- **DICOM Import**: Automated DICOM C-STORE listener (24/7 availability)
- **HL7 Import**: HL7 v2.x message processor (ADT, ORM, ORU)
- **FHIR Import**: FHIR R4 REST API (bulk data import via FHIR Bulk Data Access)

#### 5.2.2 Data Versioning

- **Dataset Versioning**: DVC (Data Version Control) or equivalent
- **Model Versioning**: MLflow Model Registry with stage transitions (dev → staging → production)
- **Code Versioning**: Git (GitLab or GitHub Enterprise)
- **Lineage Tracking**: Track data → model → prediction lineage (for compliance)

#### 5.2.3 Data Catalog

- **Metadata Management**: Searchable catalog of datasets, models, notebooks
- **Schema Registry**: Track column names, data types, descriptions
- **Usage Tracking**: Track which datasets are used by which models/users
- **Data Quality Metrics**: Completeness, accuracy, timeliness dashboards

#### 5.2.4 De-identification

- **Automated PHI Removal**: Presidio or equivalent (regex + NLP-based detection)
- **Safe Harbor Method**: Implement HIPAA Safe Harbor de-identification (18 identifiers)
- **Expert Determination**: Support for manual review workflow
- **Re-identification Risk**: Quantify risk scores for de-identified datasets
- **Research Workspace**: Separate environment with only de-identified data (for Researcher persona)

### 5.3 Model Development

#### 5.3.1 Notebook Environment

- **JupyterHub**: Multi-user notebook server with GPU allocation
- **Kernels**: Python 3.10+, R 4.3+, Julia 1.9+ (optional)
- **Extensions**: JupyterLab extensions (Git, Table of Contents, Variable Inspector)
- **Collaboration**: Shared notebooks, real-time co-editing (Google Docs-like)
- **Persistent Storage**: User home directories (10GB default, 100GB max)

#### 5.3.2 Experiment Tracking

- **MLflow Tracking**: Log experiments (parameters, metrics, artifacts)
- **Comparison**: Compare multiple experiments (side-by-side metrics, plots)
- **Visualization**: Built-in plots (loss curves, confusion matrices, ROC curves)
- **Search**: Filter experiments by tags, parameters, metrics
- **Integration**: Automatic logging from PyTorch, TensorFlow, scikit-learn

#### 5.3.3 Distributed Training

- **PyTorch DDP**: Data-parallel training across multiple GPUs/nodes
- **Horovod**: Framework-agnostic distributed training (PyTorch, TensorFlow, MXNet)
- **Ray Train**: Scalable distributed training with hyperparameter tuning
- **Efficiency**: >90% GPU utilization during multi-GPU training

#### 5.3.4 Hyperparameter Optimization

- **Optuna**: Bayesian optimization (TPE, CMA-ES)
- **Ray Tune**: Scalable hyperparameter tuning with early stopping
- **Integration**: Seamless integration with MLflow (automatic logging)
- **Parallelism**: Run multiple trials concurrently (based on available GPUs)

#### 5.3.5 AutoML

- **AutoGluon**: Automated model selection and ensembling (tabular, image, text)
- **FLAML**: Fast AutoML with resource constraints (budget-aware)
- **H2O AutoML**: Alternative AutoML framework (optional)

### 5.4 Model Deployment

#### 5.4.1 Model Serving

- **Triton Inference Server**: Deploy TensorFlow, PyTorch, ONNX models
- **vLLM**: Deploy large language models (Llama, Mistral, medical LLMs)
- **BentoML**: Python-based model serving framework (alternative to Triton)
- **REST API**: OpenAPI-compliant REST endpoints for model inference
- **gRPC**: High-performance gRPC endpoints (optional)

#### 5.4.2 Model Registry

- **MLflow Model Registry**: Centralized model repository
- **Stage Transitions**: dev → staging → production (with approval workflow)
- **Versioning**: Track model versions, rollback capability
- **Metadata**: Store model card (description, training data, performance, fairness metrics)

#### 5.4.3 A/B Testing and Canary Deployments

- **Traffic Splitting**: Route 10% of traffic to new model, 90% to old model
- **Metrics Comparison**: Compare latency, accuracy, error rate between model versions
- **Automatic Rollback**: Revert to old model if error rate spikes
- **BentoML or Seldon Core**: Frameworks supporting A/B testing and canary deployments

#### 5.4.4 Batch Inference

- **Apache Airflow**: Schedule batch inference jobs (nightly, weekly)
- **Spark Integration**: Scalable batch inference on large datasets (optional)
- **Output Storage**: Write predictions to database, S3, or FHIR server

### 5.5 Monitoring and Observability

#### 5.5.1 Platform Monitoring

- **Prometheus Metrics**: CPU, memory, GPU utilization, disk I/O, network traffic
- **Grafana Dashboards**: Pre-built dashboards for platform overview, GPU monitoring, service health
- **Alerting**: PagerDuty, Slack, email alerts for critical issues (disk full, service down, GPU failure)
- **Uptime Monitoring**: Track 99.9% SLA compliance (monthly reports)

#### 5.5.2 Model Monitoring

- **Prediction Logging**: Log all predictions (input, output, latency, model version)
- **Performance Metrics**: Track accuracy, precision, recall, F1 over time
- **Data Drift Detection**: Evidently AI or equivalent (detect distribution shifts)
- **Concept Drift Detection**: Alert when model performance degrades (retraining trigger)
- **Fairness Metrics**: Track disparate impact, demographic parity across subgroups (age, gender, ethnicity)

#### 5.5.3 Logging

- **Loki**: Centralized log aggregation (all containers, services)
- **Elasticsearch**: Full-text search on logs (optional, for advanced queries)
- **Retention**: 30 days for operational logs, 7 years for audit logs
- **Integration**: Grafana Loki query UI, kubectl logs integration

### 5.6 Workflow Orchestration

#### 5.6.1 Apache Airflow

- **DAG Management**: Create, edit, schedule, monitor DAGs via web UI
- **Operators**: Pre-built operators for PostgreSQL, S3, Kubernetes, MLflow, FHIR
- **Sensors**: Wait for data availability (S3 file sensor, database sensor)
- **Task Dependencies**: Complex task graphs (branching, conditional execution)
- **Monitoring**: Gantt charts, task duration, success/failure rates

#### 5.6.2 Pre-built Pipelines

Vendor must provide **at least 3 pre-built pipelines** for common use cases:

1. **ETL Pipeline**: Extract data from EHR (FHIR), transform, load to data warehouse
2. **Training Pipeline**: Ingest training data, train model, log to MLflow, deploy if accuracy > threshold
3. **Batch Inference Pipeline**: Load model from registry, run inference on new data, write predictions to FHIR

### 5.7 Collaboration and Governance

#### 5.7.1 Git Integration

- **Git Server**: GitLab Community Edition or GitHub Enterprise (on-premise)
- **JupyterHub Integration**: Clone, commit, push from JupyterLab
- **Code Review**: Pull request workflow, code review before merging
- **CI/CD**: Automated testing, linting, model validation on commit

#### 5.7.2 Model Approval Workflow

- **Staging Environment**: Test models in staging before production deployment
- **Approval Process**: Manager approval required for production deployment (Keycloak roles)
- **Documentation**: Require model card (data sources, performance, limitations) before approval
- **Audit Trail**: Track who approved model, when, and why

#### 5.7.3 Documentation

- **Knowledge Base**: Wiki or Confluence-like documentation site
- **API Docs**: Auto-generated API documentation (Swagger/OpenAPI)
- **User Guides**: Step-by-step tutorials for each persona (Jupyter notebooks as tutorials)
- **Runbooks**: Operational runbooks for common tasks (restart service, scale cluster, restore backup)

---

## 6. Non-Functional Requirements

### 6.1 Performance Requirements

| Metric | Requirement | Measurement Method |
|--------|-------------|-------------------|
| **API Latency (95th percentile)** | <100ms | Prometheus metrics (histogram) |
| **LLM Latency (TTFT)** | <50ms | vLLM built-in metrics |
| **LLM Throughput** | >500 req/s | Load testing with Locust or k6 |
| **Notebook Startup** | <60 seconds | JupyterHub spawner metrics |
| **Training Job Startup** | <60 seconds | MLflow run start time |
| **Inference Throughput** | >1000 predictions/second (per model) | Triton Inference Server metrics |
| **Data Query Latency** | <5 seconds (95th percentile) | PostgreSQL query time |
| **Dashboard Load Time** | <3 seconds | Grafana page load time |

### 6.2 Scalability Requirements

| Dimension | Current (Year 1) | Year 3 | Year 5 | Scaling Method |
|-----------|------------------|--------|--------|----------------|
| **Concurrent Users** | 1,000 | 1,500 | 2,000 | Horizontal (add app nodes) |
| **Models in Production** | 10 | 50 | 100 | Horizontal (add inference nodes) |
| **Training Jobs/Day** | 50 | 200 | 500 | Horizontal (add GPU nodes) |
| **Data Volume** | 100TB | 300TB | 500TB | Horizontal (add storage nodes) |
| **API Requests/Day** | 10M | 50M | 100M | Horizontal (load balancing) |

### 6.3 Reliability Requirements

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **Uptime (Platform)** | 99.9% (8.76 hours downtime/year max) | Prometheus uptime metrics |
| **Uptime (Inference)** | 99.9% (critical models), 99.5% (non-critical) | Model-specific uptime tracking |
| **MTTR (Mean Time to Repair)** | <1 hour | Incident response time tracking |
| **Data Durability** | 99.999999999% (11 nines) | MinIO erasure coding (EC:2) |
| **Backup Success Rate** | >99.5% | Backup job success rate |
| **RTO (Recovery Time Objective)** | <1 hour | Disaster recovery drill results |
| **RPO (Recovery Point Objective)** | <15 minutes | WAL archiving, incremental backups |

### 6.4 Usability Requirements

- **Onboarding Time**: New users productive within 1 week (training + documentation)
- **Self-Service**: 90% of tasks achievable without IT support
- **Mobile Access**: Responsive web UI (dashboards viewable on tablets)
- **Accessibility**: WCAG 2.1 Level AA compliance (for dashboards)
- **Internationalization**: Support for English (primary), Spanish (secondary)

### 6.5 Maintainability Requirements

- **Infrastructure as Code**: All configuration managed in Git (Ansible, Terraform, Kubernetes manifests)
- **Monitoring Coverage**: >95% of services instrumented with Prometheus metrics
- **Documentation Coverage**: 100% of APIs documented, runbooks for all common operations
- **Upgrade Path**: Quarterly platform upgrades (Kubernetes, MLflow, vLLM) with <4 hours downtime
- **Reproducibility**: All deployments reproducible from Git repository

---

## 7. Compliance & Security Requirements

### 7.1 HIPAA Compliance

#### 7.1.1 Administrative Safeguards

- **Security Management Process**: Document risk analysis, risk management, sanction policy
- **Security Personnel**: Designate security official, security awareness training (annual)
- **Information Access Management**: Implement RBAC (7 roles), principle of least privilege
- **Workforce Training**: Annual HIPAA training for all users with PHI access
- **Contingency Plan**: Document disaster recovery plan, test quarterly

#### 7.1.2 Physical Safeguards

- **Facility Access Controls**: Badge-access server room, surveillance cameras
- **Workstation Security**: Automatic screen lock after 5 minutes, encryption
- **Device and Media Controls**: Encrypted backups, secure media disposal (shredding)

#### 7.1.3 Technical Safeguards

| Requirement | Implementation | Verification |
|-------------|----------------|--------------|
| **Access Controls** | Keycloak RBAC + MFA | Quarterly access reviews |
| **Audit Controls** | Audit logger (7-year retention) | Monthly audit log reviews |
| **Integrity Controls** | Checksums for data, digital signatures for models | Automated integrity checks |
| **Transmission Security** | TLS 1.3 for all services, VPN for remote access | Quarterly security scans |

#### 7.1.4 Encryption

| Data State | Requirement | Implementation |
|------------|-------------|----------------|
| **At Rest** | AES-256 | PostgreSQL TDE, MinIO SSE-C, LUKS disk encryption |
| **In Transit** | TLS 1.3 | All HTTP → HTTPS (cert-manager), gRPC with mTLS |
| **Backups** | AES-256 | Encrypted backups to offsite storage |

#### 7.1.5 Business Associate Agreement (BAA)

- Vendor must sign BAA (HIPAA-compliant contract)
- For cloud components (if any), vendor must obtain BAAs from subcontractors

### 7.2 Security Requirements

#### 7.2.1 Authentication and Authorization

- **MFA Enforcement**: Mandatory for all users (TOTP, WebAuthn)
- **Password Policy**: Minimum 12 characters, complexity requirements, 90-day rotation
- **Session Management**: 15-minute idle timeout, secure session tokens
- **API Authentication**: OAuth 2.0 bearer tokens (JWT), API key rotation

#### 7.2.2 Network Security

- **Firewall**: Restrict inbound traffic to necessary ports (443, 22 for SSH)
- **Network Segmentation**: Separate VLANs for management, application, storage
- **VPN**: Remote access via VPN only (no direct internet exposure)
- **IDS/IPS**: Intrusion detection/prevention system (Suricata or Snort)

#### 7.2.3 Application Security

- **Vulnerability Scanning**: Quarterly scans with Nessus, OpenVAS, or equivalent
- **Penetration Testing**: Annual third-party penetration test
- **Dependency Scanning**: Automated scanning for vulnerable dependencies (Trivy, Snyk)
- **Container Security**: Run containers as non-root, read-only filesystems where possible
- **Secrets Management**: Vault or Kubernetes Secrets (encrypted at rest)

#### 7.2.4 Incident Response

- **Incident Response Plan**: Document breach notification procedures (72-hour HIPAA deadline)
- **Logging**: Centralized logging for security events (failed login, privilege escalation)
- **Alerting**: Real-time alerts for suspicious activity (PagerDuty, Slack)
- **Forensics**: Preserve logs for forensic analysis (7-year retention)

### 7.3 Regulatory Requirements

#### 7.3.1 FDA (if applicable)

For AI/ML models classified as **Software as a Medical Device (SaMD)**:

- **Quality System Regulation (QSR)**: Document design controls, risk management (ISO 14971)
- **Premarket Approval**: 510(k) or De Novo submission (if diagnostic AI)
- **Post-Market Surveillance**: Monitor model performance, report adverse events

**Note**: Vendor must identify which use cases may require FDA clearance (radiology AI, sepsis prediction, etc.)

#### 7.3.2 State Laws

- **California CCPA**: If applicable, support data deletion requests (right to be forgotten)
- **GDPR (if international)**: Support data portability, consent management

#### 7.3.3 Accreditation

- **Joint Commission**: Ensure platform supports Joint Commission quality metrics
- **CMS**: Support CMS quality reporting (MIPS, MACRA)

---

## 8. Implementation Requirements

### 8.1 Project Phases

#### Phase 1: Infrastructure Deployment (8 weeks)

**Week 1-2: Hardware Setup**
- Procure and rack 19 servers
- Configure networking (10GbE switches, VLANs)
- Install operating system (Ubuntu 22.04 LTS or RHEL 9)
- Configure IPMI/BMC for remote management

**Week 3-4: Core Services**
- Deploy Kubernetes/Docker Swarm cluster
- Deploy PostgreSQL cluster (primary + replicas, Patroni)
- Deploy Redis Sentinel (3 nodes)
- Deploy MinIO distributed (4 nodes)

**Week 5-6: ML Platform**
- Deploy JupyterHub (multi-user, GPU allocation)
- Deploy MLflow (experiment tracking, model registry)
- Deploy Apache Airflow (workflow orchestration)
- Configure object storage integration (MLflow artifacts → MinIO)

**Week 7-8: Inference Services**
- Deploy vLLM (2-4 replicas, load balancing)
- Deploy Triton Inference Server
- Deploy Keycloak (SSO, RBAC)
- Integrate Keycloak with Active Directory (LDAP)

**Deliverables**:
- ✅ Functional ML platform accessible via HTTPS
- ✅ 50 test users successfully authenticated via SSO
- ✅ Load test report (1,000 concurrent users, 95% success rate)

#### Phase 2: Healthcare Integration (6 weeks)

**Week 9-10: EHR Integration**
- Deploy HAPI FHIR server (R4)
- Configure HL7 v2.x adapter (Mirth Connect)
- Test bidirectional data flow (read patients, write observations)
- Performance test (10,000 FHIR queries/day)

**Week 11-12: PACS Integration**
- Deploy Orthanc DICOM server
- Configure DICOM networking (C-STORE, C-FIND, C-MOVE)
- Deploy OHIF web viewer
- Test image retrieval (500 studies/day)

**Week 13-14: Data Warehouse**
- ETL pipeline: EHR → PostgreSQL data warehouse
- De-identification pipeline (Presidio)
- Data quality checks (completeness, accuracy)

**Deliverables**:
- ✅ FHIR server integrated with EHR (bi-directional)
- ✅ DICOM server integrated with PACS (retrieve and store)
- ✅ Data warehouse with 1 year of de-identified patient data
- ✅ HL7 integration test report (100% message delivery)

#### Phase 3: Use Case Implementation (4 weeks)

**Week 15-16: Radiology AI**
- Deploy pre-trained chest X-ray model (TorchXRayVision)
- Integrate with DICOM server (automatic inference on new images)
- Clinical UI for radiologists (view predictions, accept/reject)
- Validation: 95%+ sensitivity/specificity on test set

**Week 17-18: Sepsis Prediction**
- Train sepsis early warning model (XGBoost on vitals + labs)
- Deploy to Triton Inference Server
- Real-time inference pipeline (Airflow DAG polling EHR every 5 minutes)
- Alert system (FHIR flag resource, email to clinicians)

**Deliverables**:
- ✅ Radiology AI model in production (500 images/day)
- ✅ Sepsis prediction model in production (100 patients monitored)
- ✅ Clinical validation report (signed by medical director)

#### Phase 4: Monitoring and Training (3 weeks)

**Week 19: Monitoring Setup**
- Deploy Prometheus + Grafana dashboards
- Deploy Loki for log aggregation
- Configure alerting (PagerDuty, Slack)
- Create 6 persona-specific dashboards

**Week 20-21: User Training**
- **Developers** (2 days): JupyterHub, MLflow, model deployment
- **Clinicians** (1 day): Clinical UI, AI-assisted diagnosis
- **Researchers** (1 day): De-identified data access, notebooks
- **Managers** (0.5 day): Grafana dashboards, ROI tracking
- **Operations** (2 days): Platform monitoring, user management, troubleshooting

**Deliverables**:
- ✅ Monitoring dashboards (platform, models, personas)
- ✅ User training completion (80% attendance)
- ✅ User satisfaction survey (>4.0/5.0 average)

### 8.2 Training Requirements

#### 8.2.1 Administrator Training (2 days)

**Target Audience**: Hospital IT staff (operations persona)

**Topics**:
- Day 1: Infrastructure overview, Kubernetes/Swarm basics, service architecture
- Day 2: Monitoring (Prometheus, Grafana), troubleshooting, backup/restore, user management

**Format**: Hands-on lab exercises, runbooks provided

#### 8.2.2 Developer Training (2 days)

**Target Audience**: Data scientists, ML engineers (developer persona)

**Topics**:
- Day 1: JupyterHub, MLflow experiment tracking, model training, hyperparameter tuning
- Day 2: Model deployment (Triton, vLLM), CI/CD, monitoring, responsible AI (fairness, explainability)

**Format**: Jupyter notebook tutorials, sample projects (radiology AI, sepsis prediction)

#### 8.2.3 Clinician Training (1 day)

**Target Audience**: Doctors, nurses (clinician persona)

**Topics**:
- Morning: AI/ML basics (non-technical), use cases, how to interpret AI predictions
- Afternoon: Hands-on with clinical UI (radiology viewer, sepsis alerts), accept/reject predictions, feedback loop

**Format**: Interactive demo, Q&A session

#### 8.2.4 Researcher Training (1 day)

**Target Audience**: Clinical researchers (researcher persona)

**Topics**:
- Morning: De-identified data access, data catalog, JupyterHub notebooks
- Afternoon: Statistical analysis, basic ML (scikit-learn), IRB approval workflow

**Format**: Jupyter notebook tutorials, sample research project

#### 8.2.5 Manager Training (0.5 day)

**Target Audience**: Department heads, executives (manager persona)

**Topics**:
- Grafana dashboards overview, ROI tracking, user adoption metrics, clinical impact metrics

**Format**: Dashboard walkthrough, executive summary presentation

### 8.3 Documentation Deliverables

Vendor must provide the following documentation:

| Document | Description | Audience | Format |
|----------|-------------|----------|--------|
| **Architecture Document** | System architecture, component diagrams, data flows | IT staff, developers | PDF, 50+ pages |
| **Deployment Guide** | Step-by-step installation and configuration | IT staff | Markdown, Git repo |
| **User Guides** | Persona-specific user guides (6 guides) | All personas | PDF, Jupyter notebooks |
| **API Documentation** | REST API reference (OpenAPI spec) | Developers | Swagger UI |
| **Runbooks** | Operational procedures (restart service, scale, backup) | IT staff | Markdown, Git repo |
| **Security Guide** | HIPAA compliance, security hardening, audit procedures | Security team | PDF, 30+ pages |
| **Training Materials** | Slide decks, Jupyter notebook tutorials | All personas | PowerPoint, Jupyter |
| **Troubleshooting Guide** | Common issues and resolutions | IT staff | Markdown, searchable |

---

## 9. Support & Maintenance Requirements

### 9.1 Support Tiers

#### 9.1.1 Tier 1: Business Hours Support

- **Availability**: Monday-Friday, 8 AM - 5 PM (local time)
- **Response Time**: 4 hours for critical issues, 24 hours for non-critical
- **Channels**: Email, phone, ticketing system
- **Scope**: General questions, non-critical bugs, training follow-up

#### 9.1.2 Tier 2: 24/7 Critical Support

- **Availability**: 24/7/365 for critical issues (P1)
- **Response Time**: 1 hour for P1 (platform down, data loss), 4 hours for P2
- **Channels**: Phone, pager (PagerDuty integration)
- **Scope**: Platform downtime, security incidents, data loss, critical model failures

#### 9.1.3 Dedicated Support Engineer (Optional)

- **Availability**: On-site or remote, 20 hours/week
- **Cost**: Additional $100K/year
- **Scope**: Proactive monitoring, optimization, custom development, quarterly reviews

### 9.2 Maintenance Windows

- **Scheduled Maintenance**: Monthly, 4-hour window (Saturday 2-6 AM)
- **Emergency Maintenance**: As needed (with 24-hour notice if possible)
- **Upgrade Cadence**: Quarterly platform upgrades (Kubernetes, MLflow, vLLM)

### 9.3 Service Level Agreement (SLA)

| Metric | Target | Penalty (if not met) |
|--------|--------|----------------------|
| **Platform Uptime** | 99.9% (monthly) | 10% monthly fee credit |
| **Critical Response Time** | 1 hour | 5% monthly fee credit |
| **Backup Success Rate** | 99.5% | 5% monthly fee credit |
| **Security Patch Deployment** | Within 30 days of CVE | 10% monthly fee credit |

### 9.4 Ongoing Services

#### 9.4.1 Software Updates

- **OS Patches**: Monthly security patches (Ubuntu, RHEL)
- **Container Images**: Quarterly updates for all services (Kubernetes, MLflow, vLLM, etc.)
- **Model Updates**: Quarterly updates for pre-trained models (TorchXRayVision, etc.)
- **Dependency Updates**: Monthly updates for Python packages (security vulnerabilities)

#### 9.4.2 Performance Optimization

- **GPU Utilization**: Quarterly review and optimization (target >70%)
- **Cost Optimization**: Quarterly review of resource usage, recommendations for right-sizing
- **Model Optimization**: Annual review of model performance, retraining recommendations

#### 9.4.3 Compliance Audits

- **HIPAA Audit**: Annual third-party HIPAA audit (vendor provides documentation support)
- **Security Audit**: Quarterly vulnerability scans, annual penetration test
- **Compliance Reporting**: Quarterly reports on uptime, security incidents, audit log reviews

---

## 10. Evaluation Criteria

### 10.1 Evaluation Process

**Step 1: Initial Screening (Pass/Fail)**
- ✅ Proposal submitted by deadline (2026-04-30)
- ✅ All required sections completed
- ✅ Vendor meets minimum qualifications (see 10.2)

**Step 2: Technical Evaluation (70% weight)**
- Scored 0-10 on each criterion (see 10.3)
- Minimum passing score: 7.0/10 average

**Step 3: Cost Evaluation (20% weight)**
- Lowest compliant bidder receives 10 points
- Other bidders scored proportionally: (Lowest Bid / Bidder's Bid) × 10

**Step 4: References and Interviews (10% weight)**
- Reference checks (3 references required)
- Finalist interviews with hospital leadership

**Step 5: Final Selection**
- Top 3 finalists present solution (2-hour presentation + Q&A)
- Hospital selection committee votes (majority wins)

### 10.2 Minimum Qualifications

Vendor **must meet all** of the following to be considered:

- ✅ 5+ years experience deploying enterprise AI/ML platforms
- ✅ 3+ healthcare deployments (HIPAA-compliant)
- ✅ 1+ deployment supporting 1,000+ concurrent users
- ✅ Proven experience with Kubernetes or Docker Swarm in production
- ✅ Certified expertise in at least 2 of the following: PyTorch, TensorFlow, MLflow, Kubeflow
- ✅ Willingness to sign Business Associate Agreement (BAA)
- ✅ US-based company or US subsidiary (for ITAR compliance if applicable)
- ✅ Financial stability (Dun & Bradstreet rating of 3A2 or better)

### 10.3 Technical Evaluation Criteria (70% weight)

| Criterion | Weight | Scoring Rubric (0-10) |
|-----------|--------|----------------------|
| **Architecture Design** | 15% | 10: Exceeds requirements (HA, DR, 99.99% uptime). 7: Meets requirements. 0: Below requirements |
| **Technology Stack** | 15% | 10: 100% open-source, vLLM included, state-of-the-art. 7: Mostly open, meets requirements. 0: Proprietary or Ollama |
| **Scalability** | 10% | 10: Proven 2,000+ users, auto-scaling. 7: 1,000 users, manual scaling. 0: <500 users |
| **Healthcare Integration** | 10% | 10: FHIR + DICOM + HL7, pre-built connectors. 7: FHIR only, custom dev needed. 0: No healthcare integration |
| **Security & Compliance** | 15% | 10: HIPAA + FDA experience, SOC 2 certified. 7: HIPAA only. 0: No healthcare compliance experience |
| **Performance** | 10% | 10: <50ms LLM TTFT, >500 req/s throughput. 7: <100ms, >100 req/s. 0: Worse than baseline |
| **Implementation Plan** | 10% | 10: Detailed plan, realistic timeline, proven methodology. 7: High-level plan, generic timeline. 0: Vague plan |
| **Support & Maintenance** | 5% | 10: 24/7 support, 1-hour response, 99.9% SLA. 7: Business hours, 4-hour response. 0: Best effort |

**Total Technical Score**: Sum of (Criterion Score × Weight) = Max 70 points

### 10.4 Cost Evaluation (20% weight)

**Cost Components** (vendor must provide detailed breakdown):

| Cost Component | Description |
|----------------|-------------|
| **Year 1 (Implementation)** | Professional services, software licenses (if any), hardware (if vendor-provided) |
| **Year 2-5 (Ongoing)** | Annual support, maintenance, software updates |
| **Training** | On-site or remote training (included or additional cost) |
| **Travel** | If on-site work required (T&E budget) |

**Scoring**:
- Lowest compliant bidder = 20 points
- Other bidders = (Lowest Bid / Bidder's Bid) × 20 points

**Example**:
- Vendor A: $1,500,000 (5-year TCO) → (1,500,000 / 1,500,000) × 20 = 20 points
- Vendor B: $2,000,000 (5-year TCO) → (1,500,000 / 2,000,000) × 20 = 15 points
- Vendor C: $2,500,000 (5-year TCO) → (1,500,000 / 2,500,000) × 20 = 12 points

### 10.5 References and Interviews (10% weight)

#### 10.5.1 References (5 points)

Vendor must provide **3 references** from healthcare organizations:

**Reference Questionnaire** (hospital will contact references):
1. Project scope and size (users, data volume)
2. On-time delivery (met timeline?)
3. Budget adherence (within budget?)
4. Quality of deliverables (documentation, training, code quality)
5. Support responsiveness (response times, issue resolution)
6. Overall satisfaction (1-10 scale)
7. Would you hire them again? (Yes/No)

**Scoring**:
- Average satisfaction score ≥9.0: 5 points
- Average satisfaction score 8.0-8.9: 4 points
- Average satisfaction score 7.0-7.9: 3 points
- Average satisfaction score <7.0: 0 points

#### 10.5.2 Finalist Interviews (5 points)

Top 3 finalists will present solution (2-hour session):

**Evaluation Criteria**:
- **Presentation Quality** (1-10): Clarity, organization, professionalism
- **Technical Depth** (1-10): Deep understanding of technology stack, architecture
- **Team Expertise** (1-10): Qualifications of proposed team members
- **Q&A Responses** (1-10): Ability to answer technical and business questions
- **Cultural Fit** (1-10): Alignment with hospital values, collaborative approach

**Scoring**: Average of 5 criteria = Interview Score (max 5 points)

### 10.6 Final Scoring

| Vendor | Technical (70%) | Cost (20%) | References (5%) | Interview (5%) | **Total (100%)** |
|--------|-----------------|------------|-----------------|----------------|------------------|
| Vendor A | 65 | 20 | 5 | 4 | **94** |
| Vendor B | 60 | 15 | 4 | 5 | **84** |
| Vendor C | 55 | 12 | 5 | 4 | **76** |

**Winner**: Vendor A (highest total score)

---

## 11. Proposal Submission Requirements

### 11.1 Proposal Format

- **Page Limit**: 100 pages maximum (excluding appendices)
- **Format**: PDF, 11-point font minimum, 1-inch margins
- **Naming**: `HOSP-AIML-2026-001_VendorName.pdf`
- **Submission**: Email to [procurement@hospital.org] by 2026-04-30 5:00 PM local time

### 11.2 Required Sections

Proposal must include the following sections (in order):

#### Section 1: Executive Summary (2 pages)
- Company overview, relevant experience
- High-level solution summary
- Key differentiators (why choose you?)
- Total cost (5-year TCO)

#### Section 2: Company Qualifications (5 pages)
- Company history, size, financial stability
- Relevant certifications (ISO 9001, SOC 2, etc.)
- Healthcare experience (number of projects, total users supported)
- Team qualifications (resumes of key personnel)

#### Section 3: Technical Approach (40 pages)
- Architecture design (diagrams, component descriptions)
- Technology stack (with rationale for each component)
- Scalability plan (how to grow from 1K to 2K users)
- Integration approach (EHR, PACS, Active Directory)
- Security and compliance (HIPAA safeguards, encryption)
- Performance benchmarks (latency, throughput, uptime)

#### Section 4: Implementation Plan (15 pages)
- Project phases (timeline, milestones, deliverables)
- Roles and responsibilities (RACI matrix)
- Risk management (top 5 risks + mitigation strategies)
- Quality assurance (testing, validation, acceptance criteria)
- Training plan (curricula, schedules, materials)

#### Section 5: Support and Maintenance (10 pages)
- Support tiers (availability, response times, channels)
- SLA (uptime, response time, penalties)
- Ongoing services (updates, optimization, audits)
- Escalation procedures (for critical issues)

#### Section 6: Cost Proposal (5 pages)
- Detailed cost breakdown (Year 1, Years 2-5)
- Assumptions (e.g., hospital provides hardware)
- Payment schedule (milestones)
- Cost avoidance or savings (vs AWS or current state)

#### Section 7: References (3 pages)
- 3 healthcare references (contact name, title, phone, email)
- Brief description of each project (scope, timeline, outcome)

#### Section 8: Appendices (no page limit)
- Appendix A: Detailed architecture diagrams
- Appendix B: Sample dashboards and UIs
- Appendix C: Compliance certifications (SOC 2, ISO 27001, etc.)
- Appendix D: Case studies (similar healthcare deployments)
- Appendix E: Resumes of proposed team members

### 11.3 Submission Checklist

Before submitting, ensure proposal includes:

- ✅ Executive summary (2 pages)
- ✅ Company qualifications (5 pages)
- ✅ Technical approach (40 pages)
- ✅ Implementation plan (15 pages)
- ✅ Support and maintenance (10 pages)
- ✅ Cost proposal (5 pages)
- ✅ 3 healthcare references
- ✅ Architecture diagrams (appendix)
- ✅ Compliance certifications (appendix)
- ✅ Team resumes (appendix)
- ✅ Signed Business Associate Agreement (BAA) template
- ✅ Signed RFP acknowledgment form
- ✅ Submitted by deadline (2026-04-30 5:00 PM)

### 11.4 Questions and Clarifications

- **Questions Deadline**: 2026-04-15 5:00 PM
- **Submit Questions To**: [procurement@hospital.org]
- **Answers Published**: 2026-04-22 (on hospital procurement portal)
- **Pre-Bid Conference**: Optional, 2026-04-08 10:00 AM (virtual, Zoom link in RFP notice)

---

## 12. Terms and Conditions

### 12.1 Contract Terms

- **Contract Type**: Firm Fixed Price (Year 1), Time & Materials (Years 2-5 support)
- **Contract Duration**: 1 year (with 4× 1-year renewal options)
- **Payment Terms**: Net 30 days from invoice
- **Retainage**: 10% withheld until final acceptance (Phase 4 completion)

### 12.2 Acceptance Criteria

Final acceptance requires:

- ✅ All Phase 4 deliverables completed
- ✅ Platform passes load test (1,000 concurrent users, 95% success rate)
- ✅ Platform passes security scan (no critical vulnerabilities)
- ✅ Platform passes HIPAA compliance audit (no major findings)
- ✅ 2 use cases in production (radiology AI, sepsis prediction)
- ✅ User training completed (80% attendance)
- ✅ Documentation delivered (all 8 documents)
- ✅ 30-day warranty period (no critical issues)

### 12.3 Warranties

- **Platform Warranty**: 1 year from acceptance (vendor will fix bugs at no cost)
- **Uptime Warranty**: 99.9% uptime (monthly SLA, see penalties in Section 9.3)
- **Security Warranty**: Vendor will remediate security vulnerabilities within 30 days

### 12.4 Intellectual Property

- **Ownership**: Hospital owns all code, data, models, documentation developed under contract
- **Open Source**: All open-source components remain under their original licenses (Apache 2.0, MIT, etc.)
- **Confidentiality**: Vendor agrees to 5-year NDA (protect patient data, hospital IP)

### 12.5 Termination

- **Termination for Convenience**: Hospital may terminate with 60-day notice (pay for work completed)
- **Termination for Cause**: Hospital may terminate immediately if vendor breaches contract (no payment for incomplete work)
- **Transition Assistance**: Vendor must provide 30 days transition assistance if terminated

### 12.6 Indemnification

- **Vendor Indemnifies Hospital**: For third-party IP infringement claims, negligence, breaches
- **Hospital Indemnifies Vendor**: For claims arising from hospital's use of platform (beyond vendor's control)

### 12.7 Insurance Requirements

Vendor must maintain:

- **General Liability**: $2M per occurrence, $4M aggregate
- **Professional Liability (E&O)**: $2M per claim, $4M aggregate
- **Cyber Liability**: $5M per claim (covers data breaches)
- **Workers' Compensation**: As required by state law

### 12.8 Compliance

- **HIPAA Compliance**: Vendor must comply with HIPAA Privacy and Security Rules
- **Business Associate Agreement (BAA)**: Required (template provided with RFP)
- **State Laws**: Comply with applicable state laws (data breach notification, etc.)

---

## 13. Appendices

### Appendix A: Glossary

| Term | Definition |
|------|------------|
| **ADT** | Admission, Discharge, Transfer (HL7 message type) |
| **BAA** | Business Associate Agreement (HIPAA contract) |
| **DICOM** | Digital Imaging and Communications in Medicine (medical imaging standard) |
| **FHIR** | Fast Healthcare Interoperability Resources (healthcare data exchange standard) |
| **HL7** | Health Level 7 (healthcare messaging standard) |
| **HIPAA** | Health Insurance Portability and Accountability Act |
| **LLM** | Large Language Model (e.g., GPT, Llama, Mistral) |
| **MLOps** | Machine Learning Operations (DevOps for ML) |
| **PACS** | Picture Archiving and Communication System (medical imaging storage) |
| **PHI** | Protected Health Information |
| **RBAC** | Role-Based Access Control |
| **SLA** | Service Level Agreement |
| **SSO** | Single Sign-On |
| **TTFT** | Time to First Token (LLM latency metric) |
| **vLLM** | High-performance LLM inference server |

### Appendix B: Sample BAA (Business Associate Agreement)

[Standard HIPAA Business Associate Agreement template - not included here for brevity]

### Appendix C: RFP Acknowledgment Form

```
HOSP-AIML-2026-001 RFP Acknowledgment

Company Name: _______________________________
Contact Person: _______________________________
Title: _______________________________
Email: _______________________________
Phone: _______________________________

I acknowledge that I have reviewed the RFP in its entirety and agree to the terms and conditions.

Signature: _______________________________ Date: _______________________________
```

### Appendix D: Cost Proposal Template

| Cost Component | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 | 5-Year Total |
|----------------|--------|--------|--------|--------|--------|--------------|
| **Professional Services** | $ | $ | $ | $ | $ | $ |
| **Hardware (if provided)** | $ | - | - | - | - | $ |
| **Software Licenses** | $ | $ | $ | $ | $ | $ |
| **Support & Maintenance** | $ | $ | $ | $ | $ | $ |
| **Training** | $ | - | - | - | - | $ |
| **Travel & Expenses** | $ | $ | $ | $ | $ | $ |
| **Total** | $ | $ | $ | $ | $ | $ |

**Assumptions**:
1. Hospital provides 19 servers (or vendor provides hardware at cost above)
2. Hospital provides networking infrastructure
3. Hospital provides Active Directory for SSO
4. Hospital IT staff available for integration support (10 hours/week)

### Appendix E: Reference Questionnaire

[Hospital will use this to contact vendor references]

**Reference Contact Information**:
- Organization: _______________________________
- Contact Name: _______________________________
- Title: _______________________________
- Email: _______________________________
- Phone: _______________________________

**Questions** (1-10 scale):
1. Project scope and size (users, data volume): _______________________________
2. On-time delivery (met timeline?): Yes / No (if no, explain: _______________________________)
3. Budget adherence (within budget?): Yes / No (if no, explain: _______________________________)
4. Quality of deliverables (1-10): _______
5. Support responsiveness (1-10): _______
6. Overall satisfaction (1-10): _______
7. Would you hire them again?: Yes / No
8. Additional comments: _______________________________

---

## Document Control

**Document Version**: 1.0
**Issue Date**: 2026-03-16
**Proposal Due Date**: 2026-04-30
**Expected Award Date**: 2026-05-15
**Project Start Date**: 2026-06-01

**Issuing Authority**:
[Hospital Name]
[Address]
[City, State, ZIP]
[Contact: Procurement Department]
[Email: procurement@hospital.org]
[Phone: (XXX) XXX-XXXX]

**RFP Coordinator**:
[Name], [Title]
[Email]
[Phone]

---

**END OF REQUEST FOR PROPOSAL**
