#!/usr/bin/env bash
# Description: Simple integer calculator with support for basic arithmetic operations
# Author: CustomShell Project
# Version: 1.0
# Usage: run Calculator.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        Simple Calculator${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${YELLOW}Supports: +  -  *  /  ()${NC}"
echo -e "${YELLOW}Note: Integer arithmetic only${NC}"
echo -e "${YELLOW}Type 'quit' to exit${NC}"
echo -e "${CYAN}═══════════════════════════════════════${NC}"
echo ""

while true; do
  read -rp "calc> " expr

  # Quit
  if [ "$expr" = "quit" ] || [ "$expr" = "exit" ]; then
    echo -e "${GREEN}Exiting calculator...${NC}"
    break
  fi

  # Skip empty input
  [ -z "$expr" ] && continue

  # Validate characters
  case "$expr" in
    *[!0-9\ \+\-\*\/\(\)]*)
      echo -e "${RED}Error: Invalid characters! Use digits and + - * / () only.${NC}"
      continue
      ;;
  esac

  # Evaluate using Bash arithmetic
  result=$(( expr )) 2>/dev/null

  if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Invalid expression! Try again.${NC}"
  else
    echo -e "${GREEN}Result: ${BOLD}$result${NC}"
  fi
done
