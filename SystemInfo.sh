#!/usr/bin/env bash
# Description: Display comprehensive system information
# Author: CustomShell Project
# Version: 1.0
# Usage: run SystemInfo.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}System Information${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${YELLOW}OS:${NC}          $(uname -s)"
echo -e "${YELLOW}Kernel:${NC}      $(uname -r)"
echo -e "${YELLOW}Architecture:${NC} $(uname -m)"
echo -e "${YELLOW}Hostname:${NC}    $(hostname)"
echo -e "${YELLOW}User:${NC}        $(whoami)"
echo -e "${YELLOW}Shell:${NC}       $SHELL"
echo -e "${YELLOW}Directory:${NC}   $(pwd)"
echo -e "${YELLOW}Home:${NC}        $HOME"
echo ""
echo -e "${BOLD}${YELLOW}System Resources:${NC}"
echo -e "${YELLOW}Uptime:${NC}      $(uptime -p 2>/dev/null || uptime)"
echo -e "${YELLOW}Date/Time:${NC}   $(date)"
echo -e "${CYAN}═══════════════════════════════════════${NC}"
