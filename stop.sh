#!/bin/bash
###############################################################################
# Stop Script for Open Source ML Platform
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
echo "║  Stopping Open Source ML Platform                               ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Ask if user wants to remove volumes
echo -e "${YELLOW}Do you want to remove all data volumes?${NC}"
echo -e "${RED}WARNING: This will delete all your data, notebooks, models, etc.${NC}"
read -p "Remove volumes? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Stopping services and removing volumes...${NC}"
    docker compose down -v
    echo -e "${GREEN}✓ Services stopped and volumes removed${NC}"
else
    echo -e "${YELLOW}Stopping services (keeping data)...${NC}"
    docker compose down
    echo -e "${GREEN}✓ Services stopped (data preserved)${NC}"
fi

echo ""
echo -e "${BLUE}To start again, run: ${GREEN}./start.sh${NC}"
