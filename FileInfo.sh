#!/usr/bin/env bash
# Description: Displays detailed information about a file or directory
# Author: CustomShell Project
# Version: 1.0
# Usage: run FileInfo.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        File Information Tool${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

read -rp "Enter file/directory name: " f

if [ -z "$f" ]; then
  echo -e "${RED}Error: No file name provided${NC}"
  exit 1
fi

if [ ! -e "$f" ]; then
  echo -e "${RED}Error: File or directory does not exist${NC}"
  exit 1
fi

echo ""
echo -e "${BOLD}${YELLOW}Details for: ${GREEN}$f${NC}"
echo -e "${CYAN}═══════════════════════════════════════${NC}"

# Basic info
if [ -f "$f" ]; then
  echo -e "${YELLOW}Type:${NC} Regular File"
elif [ -d "$f" ]; then
  echo -e "${YELLOW}Type:${NC} Directory"
elif [ -L "$f" ]; then
  echo -e "${YELLOW}Type:${NC} Symbolic Link"
else
  echo -e "${YELLOW}Type:${NC} Special File"
fi

# Permissions and ownership
echo -e "${YELLOW}Permissions:${NC} $(ls -ld "$f" | awk '{print $1}')"
echo -e "${YELLOW}Owner:${NC} $(ls -ld "$f" | awk '{print $3}')"
echo -e "${YELLOW}Group:${NC} $(ls -ld "$f" | awk '{print $4}')"

# Size
if [ -f "$f" ]; then
  size=$(ls -lh "$f" | awk '{print $5}')
  echo -e "${YELLOW}Size:${NC} $size"
fi

# Timestamps
echo -e "${YELLOW}Last Modified:${NC} $(ls -l "$f" | awk '{print $6, $7, $8}')"

# Line count for text files
if [ -f "$f" ] && file "$f" 2>/dev/null | grep -q text; then
  lines=$(wc -l < "$f" 2>/dev/null)
  echo -e "${YELLOW}Lines:${NC} $lines"
fi

echo -e "${CYAN}═══════════════════════════════════════${NC}"
