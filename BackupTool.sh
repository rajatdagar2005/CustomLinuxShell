#!/usr/bin/env bash
# Description: Simple backup and restore utility for files and directories
# Author: CustomShell Project
# Version: 1.0
# Usage: run BackupTool.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

BACKUP_DIR="./backups"

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        Backup Tool${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}Select an option:${NC}"
echo -e "  ${GREEN}1${NC} - Create backup"
echo -e "  ${GREEN}2${NC} - List backups"
echo -e "  ${GREEN}3${NC} - Restore backup"
echo ""
read -rp "Enter choice [1-3]: " choice

echo ""

case "$choice" in
    1)
        read -rp "Enter file/directory to backup: " target
        
        if [ ! -e "$target" ]; then
            echo -e "${RED}Error: Target does not exist${NC}"
            exit 1
        fi
        
        mkdir -p "$BACKUP_DIR"
        timestamp=$(date +%Y%m%d_%H%M%S)
        backup_name="$(basename "$target")_${timestamp}.tar.gz"
        
        echo -e "${YELLOW}Creating backup...${NC}"
        tar -czf "${BACKUP_DIR}/${backup_name}" "$target" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Backup created: ${backup_name}${NC}"
            echo -e "${YELLOW}Location:${NC} ${BACKUP_DIR}/${backup_name}"
        else
            echo -e "${RED}✗ Backup failed${NC}"
        fi
        ;;
    2)
        if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
            echo -e "${YELLOW}No backups found${NC}"
            exit 0
        fi
        
        echo -e "${BOLD}${CYAN}Available Backups:${NC}"
        echo -e "${CYAN}═══════════════════════════════════════${NC}"
        ls -lh "$BACKUP_DIR" | tail -n +2 | while read -r line; do
            size=$(echo "$line" | awk '{print $5}')
            date=$(echo "$line" | awk '{print $6, $7, $8}')
            name=$(echo "$line" | awk '{print $9}')
            printf "${GREEN}%-40s${NC} ${YELLOW}%8s${NC}  %s\n" "$name" "$size" "$date"
        done
        ;;
    3)
        if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
            echo -e "${YELLOW}No backups available${NC}"
            exit 0
        fi
        
        echo -e "${BOLD}${CYAN}Available Backups:${NC}"
        ls -1 "$BACKUP_DIR"
        echo ""
        read -rp "Enter backup filename to restore: " backup_file
        
        if [ ! -f "${BACKUP_DIR}/${backup_file}" ]; then
            echo -e "${RED}Error: Backup file not found${NC}"
            exit 1
        fi
        
        read -rp "Restore to current directory? (y/n): " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            echo -e "${YELLOW}Restoring backup...${NC}"
            tar -xzf "${BACKUP_DIR}/${backup_file}" 2>/dev/null
            
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Backup restored successfully${NC}"
            else
                echo -e "${RED}✗ Restore failed${NC}"
            fi
        else
            echo -e "${YELLOW}Restore cancelled${NC}"
        fi
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        ;;
esac

echo ""
echo -e "${CYAN}═══════════════════════════════════════${NC}"
