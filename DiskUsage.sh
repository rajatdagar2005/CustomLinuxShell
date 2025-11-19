#!/usr/bin/env bash
# Description: Displays disk usage statistics for all mounted filesystems
# Author: CustomShell Project
# Version: 1.0
# Usage: run DiskUsage.sh

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}              Disk Usage Summary${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BOLD}${YELLOW}All Filesystems:${NC}"
df -h 2>/dev/null || df

echo ""
echo -e "${BOLD}${YELLOW}Current Location:${NC}"
echo -e "Path: ${GREEN}$(pwd)${NC}"
df -h . 2>/dev/null | tail -n +2 || df . | tail -n +2

echo ""
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
