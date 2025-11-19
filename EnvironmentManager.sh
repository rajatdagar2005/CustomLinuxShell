#!/usr/bin/env bash
# Description: View and manage environment variables
# Author: CustomShell Project
# Version: 1.0
# Usage: run EnvironmentManager.sh

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}         Environment Variable Manager${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Select an option:${NC}"
echo -e "  ${GREEN}1${NC} - Show all environment variables"
echo -e "  ${GREEN}2${NC} - Show common variables (PATH, HOME, USER, etc.)"
echo -e "  ${GREEN}3${NC} - Search for a variable"
echo -e "  ${GREEN}4${NC} - Show PATH directories"
echo ""
read -rp "Enter choice [1-4]: " choice

echo ""

case "$choice" in
    1)
        echo -e "${BOLD}${CYAN}All Environment Variables:${NC}"
        echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
        env | sort | while IFS='=' read -r var value; do
            printf "${GREEN}%-30s${NC} %s\n" "$var" "$value"
        done
        ;;
    2)
        echo -e "${BOLD}${CYAN}Common Environment Variables:${NC}"
        echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
        for var in USER HOME SHELL PATH LANG TERM PWD OLDPWD; do
            value="${!var}"
            [ -n "$value" ] && printf "${GREEN}%-15s${NC} %s\n" "$var:" "$value"
        done
        ;;
    3)
        read -rp "Enter variable name to search: " search_term
        echo ""
        echo -e "${BOLD}${CYAN}Search Results for '$search_term':${NC}"
        env | grep -i "$search_term" | while IFS='=' read -r var value; do
            printf "${GREEN}%-30s${NC} %s\n" "$var" "$value"
        done
        ;;
    4)
        echo -e "${BOLD}${CYAN}PATH Directories:${NC}"
        echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
        echo "$PATH" | tr ':' '\n' | nl -w3 -s'. ' | while read line; do
            echo -e "${GREEN}$line${NC}"
        done
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        ;;
esac

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
