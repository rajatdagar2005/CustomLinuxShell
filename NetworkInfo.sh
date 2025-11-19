#!/usr/bin/env bash
# Description: Display network configuration and connectivity information
# Author: CustomShell Project
# Version: 1.0
# Usage: run NetworkInfo.sh

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}           Network Information${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BOLD}${YELLOW}Network Interfaces:${NC}"
if command -v ip &> /dev/null; then
    ip addr show | grep -E "^[0-9]+:|inet " | sed 's/^/  /'
elif command -v ifconfig &> /dev/null; then
    ifconfig | grep -E "^[a-z]|inet " | sed 's/^/  /'
else
    echo -e "${RED}  Network tools not available${NC}"
fi

echo ""
echo -e "${BOLD}${YELLOW}Hostname:${NC} $(hostname)"

if command -v hostname &> /dev/null; then
    local_ip=$(hostname -I 2>/dev/null | awk '{print $1}')
    [ -n "$local_ip" ] && echo -e "${BOLD}${YELLOW}Local IP:${NC} $local_ip"
fi

echo ""
echo -e "${BOLD}${YELLOW}DNS Resolution Test:${NC}"
if ping -c 1 google.com &> /dev/null; then
    echo -e "  ${GREEN}✓ Internet connectivity: OK${NC}"
else
    echo -e "  ${RED}✗ Internet connectivity: Failed${NC}"
fi

echo ""
echo -e "${BOLD}${YELLOW}Active Network Connections:${NC}"
if command -v netstat &> /dev/null; then
    netstat -tn 2>/dev/null | grep ESTABLISHED | wc -l | xargs echo "  Established connections:"
elif command -v ss &> /dev/null; then
    ss -tn 2>/dev/null | grep ESTAB | wc -l | xargs echo "  Established connections:"
else
    echo -e "  ${YELLOW}Network statistics not available${NC}"
fi

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
