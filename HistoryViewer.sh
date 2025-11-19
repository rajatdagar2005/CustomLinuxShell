#!/usr/bin/env bash
# Description: View and search command history
# Author: CustomShell Project
# Version: 1.0
# Usage: run HistoryViewer.sh

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD='\033[1m'

HISTORY_FILE=".customsh_history"

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}Command History Viewer${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

if [ ! -f "$HISTORY_FILE" ]; then
    echo -e "${YELLOW}No history file found${NC}"
    exit 0
fi

echo -e "${YELLOW}Select an option:${NC}"
echo -e "  ${GREEN}1${NC} - Show all history"
echo -e "  ${GREEN}2${NC} - Show last 20 commands"
echo -e "  ${GREEN}3${NC} - Search history"
echo ""
read -rp "Enter choice [1-3]: " choice

case "$choice" in
    1)
        echo ""
        echo -e "${BOLD}${CYAN}Full Command History:${NC}"
        local count=1
        while IFS= read -r line; do
            printf "${CYAN}%4d${NC}  %s\n" "$count" "$line"
            ((count++))
        done < "$HISTORY_FILE"
        ;;
    2)
        echo ""
        echo -e "${BOLD}${CYAN}Last 20 Commands:${NC}"
        local count=1
        tail -n 20 "$HISTORY_FILE" | while IFS= read -r line; do
            printf "${CYAN}%4d${NC}  %s\n" "$count" "$line"
            ((count++))
        done
        ;;
    3)
        read -rp "Enter search term: " term
        echo ""
        echo -e "${BOLD}${CYAN}Search Results for '$term':${NC}"
        grep -n "$term" "$HISTORY_FILE" | while IFS=: read -r num line; do
            printf "${CYAN}%4s${NC}  %s\n" "$num" "$line"
        done
        ;;
    *)
        echo -e "${YELLOW}Invalid choice${NC}"
        ;;
esac

echo ""
echo -e "${CYAN}═══════════════════════════════════════${NC}"
