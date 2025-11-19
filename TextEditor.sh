#!/usr/bin/env bash
# Description: Simple text file viewer and editor
# Author: CustomShell Project
# Version: 1.0
# Usage: run TextEditor.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        Simple Text Editor${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

read -rp "Enter filename: " filename

if [ -z "$filename" ]; then
    echo -e "${RED}Error: No filename provided${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Select an option:${NC}"
echo -e "  ${GREEN}1${NC} - View file"
echo -e "  ${GREEN}2${NC} - Create/Edit file"
echo -e "  ${GREEN}3${NC} - Append to file"
echo -e "  ${GREEN}4${NC} - Show file info"
echo ""
read -rp "Enter choice [1-4]: " choice

echo ""

case "$choice" in
    1)
        if [ ! -f "$filename" ]; then
            echo -e "${RED}Error: File does not exist${NC}"
            exit 1
        fi
        echo -e "${BOLD}${CYAN}Content of $filename:${NC}"
        echo -e "${CYAN}═══════════════════════════════════════${NC}"
        cat "$filename"
        echo -e "${CYAN}═══════════════════════════════════════${NC}"
        ;;
    2)
        echo -e "${YELLOW}Enter text (type 'EOF' on a new line to finish):${NC}"
        > "$filename"
        while IFS= read -r line; do
            [ "$line" = "EOF" ] && break
            echo "$line" >> "$filename"
        done
        echo -e "${GREEN}File saved successfully!${NC}"
        ;;
    3)
        echo -e "${YELLOW}Enter text to append (type 'EOF' on a new line to finish):${NC}"
        while IFS= read -r line; do
            [ "$line" = "EOF" ] && break
            echo "$line" >> "$filename"
        done
        echo -e "${GREEN}Text appended successfully!${NC}"
        ;;
    4)
        if [ ! -f "$filename" ]; then
            echo -e "${RED}Error: File does not exist${NC}"
            exit 1
        fi
        echo -e "${BOLD}${CYAN}File Information:${NC}"
        echo -e "${YELLOW}Name:${NC} $filename"
        echo -e "${YELLOW}Size:${NC} $(wc -c < "$filename") bytes"
        echo -e "${YELLOW}Lines:${NC} $(wc -l < "$filename")"
        echo -e "${YELLOW}Words:${NC} $(wc -w < "$filename")"
        echo -e "${YELLOW}Modified:${NC} $(ls -l "$filename" | awk '{print $6, $7, $8}')"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        ;;
esac

echo ""
