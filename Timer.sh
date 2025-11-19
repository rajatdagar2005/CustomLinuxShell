#!/usr/bin/env bash
# Description: Countdown timer with visual display
# Author: CustomShell Project
# Version: 1.0
# Usage: run Timer.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}        Countdown Timer${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
echo ""

read -rp "Enter seconds: " sec

# Validate input
if ! [[ "$sec" =~ ^[0-9]+$ ]] || [ "$sec" -le 0 ]; then
  echo -e "${RED}Error: Please enter a positive number${NC}"
  exit 1
fi

echo ""
echo -e "${YELLOW}Starting countdown from $sec seconds...${NC}"
sleep 1

while [ $sec -gt 0 ]; do
  # Color based on remaining time
  if [ $sec -le 5 ]; then
    color=$RED
  elif [ $sec -le 10 ]; then
    color=$YELLOW
  else
    color=$GREEN
  fi
  
  printf "\r${BOLD}${color}Time remaining: %02d seconds${NC}  " "$sec"
  sleep 1
  sec=$((sec - 1))
done

echo ""
echo -e "${BOLD}${RED}⏰ Time's up!${NC}"
echo ""
