#!/bin/bash
###############################################################################
# Quick Start Script for Open Source ML Platform
# Alternative to AWS SageMaker Distribution
###############################################################################

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  Open Source AI/ML Platform - Local Deployment                  ║"
echo "║  100% AWS-Free Alternative to SageMaker Distribution            ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker found: $(docker --version)${NC}"

# Check Docker Compose
if ! docker compose version &> /dev/null; then
    echo -e "${RED}❌ Docker Compose V2 is not installed.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker Compose found: $(docker compose version)${NC}"

# Check Docker daemon
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker daemon is not running. Please start Docker.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker daemon is running${NC}"

# Check available disk space (minimum 50GB)
AVAILABLE_SPACE=$(df -BG . | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "$AVAILABLE_SPACE" -lt 50 ]; then
    echo -e "${YELLOW}⚠️  Warning: Less than 50GB disk space available (${AVAILABLE_SPACE}GB)${NC}"
    echo -e "${YELLOW}   This may not be sufficient for all services and models.${NC}"
else
    echo -e "${GREEN}✓ Sufficient disk space available (${AVAILABLE_SPACE}GB)${NC}"
fi

echo ""

# Create necessary directories
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p notebooks models dags logs plugins feast/feature_repo
echo -e "${GREEN}✓ Directories created${NC}"

# Copy .env.example to .env if it doesn't exist
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file from template...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓ .env file created (you can customize it later)${NC}"
else
    echo -e "${GREEN}✓ .env file already exists${NC}"
fi

echo ""

# Ask user if they want to pull images first
echo -e "${YELLOW}Would you like to pull Docker images first? (recommended)${NC}"
echo -e "This will download ~15GB of images. It may take 10-30 minutes."
read -p "Pull images now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Pulling Docker images...${NC}"
    docker compose pull
    echo -e "${GREEN}✓ Images pulled successfully${NC}"
fi

echo ""

# Start services
echo -e "${YELLOW}Starting all services...${NC}"
echo -e "This may take a few minutes on first run..."
echo ""

docker compose up -d

echo ""
echo -e "${GREEN}✓ Services started successfully!${NC}"
echo ""

# Wait for services to be healthy
echo -e "${YELLOW}Waiting for services to become healthy...${NC}"
sleep 10

# Check service status
echo ""
echo -e "${BLUE}Service Status:${NC}"
docker compose ps

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════╗"
echo -e "║  🎉 Deployment Complete! Access Your Platform Below:            ║"
echo -e "╚══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Development Environments:${NC}"
echo -e "  • JupyterLab:        ${GREEN}http://localhost:8888${NC}  (no password)"
echo -e "  • VS Code Server:    ${GREEN}http://localhost:8443${NC}  (admin/admin)"
echo ""
echo -e "${BLUE}ML Platform Services:${NC}"
echo -e "  • MLflow:            ${GREEN}http://localhost:5000${NC}  (experiment tracking)"
echo -e "  • Apache Airflow:    ${GREEN}http://localhost:8080${NC}  (admin/admin)"
echo -e "  • BentoML:           ${GREEN}http://localhost:3000${NC}  (model serving)"
echo -e "  • Feast:             ${GREEN}http://localhost:6566${NC}  (feature store)"
echo ""
echo -e "${BLUE}Data Services:${NC}"
echo -e "  • MinIO Console:     ${GREEN}http://localhost:9001${NC}  (minioadmin/minioadmin)"
echo -e "  • PostgreSQL:        ${GREEN}localhost:5432${NC}        (mluser/mlpassword)"
echo -e "  • Redis:             ${GREEN}localhost:6379${NC}"
echo ""
echo -e "${BLUE}Monitoring:${NC}"
echo -e "  • Grafana:           ${GREEN}http://localhost:3001${NC}  (admin/admin)"
echo -e "  • Prometheus:        ${GREEN}http://localhost:9090${NC}"
echo ""
echo -e "${BLUE}AI/LLM Services:${NC}"
echo -e "  • Ollama API:        ${GREEN}http://localhost:11434${NC} (local LLM)"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  1. Open JupyterLab: ${GREEN}http://localhost:8888${NC}"
echo -e "  2. Try the welcome notebook: ${GREEN}notebooks/welcome.ipynb${NC}"
echo -e "  3. Check the documentation: ${GREEN}docs/DEPLOYMENT_GUIDE.md${NC}"
echo ""
echo -e "${YELLOW}Useful Commands:${NC}"
echo -e "  • View logs:         ${GREEN}docker compose logs -f [service]${NC}"
echo -e "  • Stop services:     ${GREEN}docker compose down${NC}"
echo -e "  • Restart service:   ${GREEN}docker compose restart [service]${NC}"
echo -e "  • Check status:      ${GREEN}docker compose ps${NC}"
echo ""
echo -e "${BLUE}📚 Documentation: docs/DEPLOYMENT_GUIDE.md${NC}"
echo -e "${BLUE}🐛 Issues: https://github.com/YasserAKareem/sagemaker-distribution/issues${NC}"
echo ""
echo -e "${GREEN}Happy ML Development! 🚀${NC}"
