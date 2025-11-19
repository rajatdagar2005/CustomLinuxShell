#!/usr/bin/env bash
# Description: Demonstrates terminal color codes and formatting options
# Author: CustomShell Project
# Version: 1.0
# Usage: run ColorDemo.sh

BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}                    Terminal Color Demo${NC}"
echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BOLD}Standard Colors:${NC}"
for i in {30..37}; do
  echo -e "\033[${i}m■ Color Code ${i} - Sample Text\033[0m"
done

echo ""
echo -e "${BOLD}Bright Colors:${NC}"
for i in {90..97}; do
  echo -e "\033[${i}m■ Color Code ${i} - Sample Text\033[0m"
done

echo ""
echo -e "${BOLD}Background Colors:${NC}"
for i in {40..47}; do
  echo -e "\033[${i}m  Color Code ${i} - Sample Text  \033[0m"
done

echo ""
echo -e "${BOLD}Text Formatting:${NC}"
echo -e "\033[1mBold Text\033[0m"
echo -e "\033[2mDim Text\033[0m"
echo -e "\033[3mItalic Text\033[0m"
echo -e "\033[4mUnderlined Text\033[0m"
echo -e "\033[7mInverted Colors\033[0m"

echo ""
echo -e "${BOLD}═══════════════════════════════════════════════════════════════${NC}"
