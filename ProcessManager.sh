#!/usr/bin/env bash
# Description: View and manage system processes
# Author: CustomShell Project
# Version: 1.0
# Usage: run ProcessManager.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}             Process Manager${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Select an option:${NC}"
echo -e "  ${GREEN}1${NC} - Show top processes by CPU"
echo -e "  ${GREEN}2${NC} - Show top processes by Memory"
echo -e "  ${GREEN}3${NC} - List all user processes"
echo -e "  ${GREEN}4${NC} - Search for a process"
echo -e "  ${GREEN}5${NC} - Show process tree"
echo ""
read -rp "Enter choice [1-5]: " choice

echo ""

case "$choice" in
    1)
        echo -e "${BOLD}${CYAN}Top Processes by CPU Usage:${NC}"
        ps aux --sort=-%cpu 2>/dev/null | head -n 11 || ps aux | head -n 11
        ;;
    2)
        echo -e "${BOLD}${CYAN}Top Processes by Memory Usage:${NC}"
        ps aux --sort=-%mem 2>/dev/null | head -n 11 || ps aux | head -n 11
        ;;
    3)
        echo -e "${BOLD}${CYAN}All User Processes:${NC}"
        ps -u $(whoami) 2>/dev/null || ps -u $USER
        ;;
    4)
        read -rp "Enter process name to search: " pname
        echo ""
        echo -e "${BOLD}${CYAN}Search Results for '$pname':${NC}"
        ps aux | grep -i "$pname" | grep -v grep || echo -e "${YELLOW}No processes found${NC}"
        ;;
    5)
        echo -e "${BOLD}${CYAN}Process Tree:${NC}"
        pstree 2>/dev/null || ps -ejH || echo -e "${YELLOW}Process tree not available${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        ;;
esac

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
