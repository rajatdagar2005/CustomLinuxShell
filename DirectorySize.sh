#!/usr/bin/env bash
# Description: Displays the size of current directory and subdirectories
# Author: CustomShell Project
# Version: 1.0
# Usage: run DirectorySize.sh

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        Directory Size Analysis${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Current Directory:${NC} $(pwd)"
echo ""

echo -e "${BOLD}Total Size:${NC}"
du -sh . 2>/dev/null || echo "Unable to calculate size"
echo ""

echo -e "${BOLD}Subdirectory Sizes:${NC}"
du -sh */ 2>/dev/null | sort -h || echo "No subdirectories found"

echo ""
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
