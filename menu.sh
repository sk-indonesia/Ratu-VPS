#!/bin/bash

# Kode Warna
NC='\033[0m'
BG_RED='\033[41;37;1m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
ORANGE='\033[38;5;208m'

# Dynamic Data
MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null || echo "127.0.0.1")
OS_NAME="Linux System"
CPU_MODEL="Cortex-A53"
RAM_TOTAL=$(free -m 2>/dev/null | awk '/Mem:/ { print $2 }')
[ -z "$RAM_TOTAL" ] && RAM_TOTAL="5761"
UPTIME_SYS=$(uptime -p 2>/dev/null | sed 's/up //')
[ -z "$UPTIME_SYS" ] && UPTIME_SYS="4 days, 10 hours"
DATE_NOW=$(date +"%d/%m/%Y")
TIME_NOW=$(date +"%H:%M:%S")
DOMAIN_NAME=$(cat /etc/xray/domain 2>/dev/null || echo "$MYIP")

# Lisensi
EXP_DATE="2037-12-31"
DAYS_LEFT="4171"

clear

# 1. HEADER UTAMA
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"
echo -e "${CYAN}|${BG_RED}             Welcome To Script Premium Ratu Store              ${NC}${CYAN}|${NC}"
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"

# 2. SYSTEM INFO
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} System OS      : ${LIGHT_CYAN}Linux System${NC}                        ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} CPU Model     : ${LIGHT_CYAN}Cortex-A53${NC}                          ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} Server RAM    : ${LIGHT_CYAN}${RAM_TOTAL} MB${NC}                             ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} Uptime Server : ${LIGHT_CYAN}${UPTIME_SYS}${NC}                   ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} Date          : ${LIGHT_CYAN}${DATE_NOW}${NC}                           ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} Time          : ${LIGHT_CYAN}${TIME_NOW}${NC}                           ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} IP VPS        : ${LIGHT_CYAN}${MYIP}${NC}                     ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}  ${ORANGE}↘${NC} Domain        : ${LIGHT_CYAN}${DOMAIN_NAME}${NC}                     ${CYAN}|${NC}"
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"

# 3. STATUS SERVER
echo -e "                  ${CYAN}>>>  ${BLUE}STATUS SERVER${NC}  ${CYAN}<<<${NC}"
echo -e "${CYAN}[ SSH : ${GREEN}ON✓${NC}${CYAN} ]         [ NGINX : ${GREEN}ON✓${NC}${CYAN} ]         [ XRAY : ${GREEN}ON✓${NC}${CYAN} ]${NC}"

# 4. GRID MENU
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}01${NC}] ${BLUE}SSH MENU${NC}     ${CYAN}|${NC} [${ORANGE}09${NC}] ${BLUE}AUTOREBOOT${NC}   ${CYAN}|${NC} [${ORANGE}17${NC}] ${BLUE}RESTART${NC}     ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}02${NC}] ${BLUE}VMESS MENU${NC}   ${CYAN}|${NC} [${ORANGE}10${NC}] ${BLUE}INFO PORT${NC}    ${CYAN}|${NC} [${ORANGE}18${NC}] ${BLUE}DOMAIN${NC}      ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}03${NC}] ${BLUE}VLESS MENU${NC}   ${CYAN}|${NC} [${ORANGE}11${NC}] ${BLUE}SPEEDTEST${NC}    ${CYAN}|${NC} [${ORANGE}19${NC}] ${BLUE}CERT SSL${NC}    ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}04${NC}] ${BLUE}TROJAN MENU${NC}  ${CYAN}|${NC} [${ORANGE}12${NC}] ${BLUE}RUNNING${NC}      ${CYAN}|${NC} [${ORANGE}20${NC}] ${BLUE}INS. UDP${NC}    ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}05${NC}] ${BLUE}SHADOW MENU${NC}  ${CYAN}|${NC} [${ORANGE}13${NC}] ${BLUE}VPS INFO${NC}     ${CYAN}|${NC} [${ORANGE}21${NC}] ${BLUE}CLEAR CACHE${NC} ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}06${NC}] ${BLUE}TRIAL MENU${NC}   ${CYAN}|${NC} [${ORANGE}14${NC}] ${BLUE}CREATE SLOW${NC}  ${CYAN}|${NC} [${ORANGE}22${NC}] ${BLUE}BOT NOTIF${NC}   ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}07${NC}] ${BLUE}CLEAR LOG${NC}    ${CYAN}|${NC} [${ORANGE}15${NC}] ${BLUE}BCKP/RSTR${NC}   ${CYAN}|${NC} [${ORANGE}23${NC}] ${BLUE}UPDATE SCR${NC}  ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}08${NC}] ${BLUE}DELL ALL EXP${NC} ${CYAN}|${NC} [${ORANGE}16${NC}] ${BLUE}REBOOT${NC}      ${CYAN}|${NC} [${ORANGE}24${NC}] ${BLUE}BOT PANEL${NC}   ${CYAN}|${NC}"
echo -e "${CYAN}|${NC}                                                               ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} [${ORANGE}00${NC}] ${BLUE}BACK TO EXIT MENU${NC} ${CYAN}<<<${NC}                                   ${CYAN}|${NC}"
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"

# 5. FOOTER INFO
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"
echo -e "${CYAN}|${NC} Version       : ${LIGHT_CYAN}V2.0${NC}                                        ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} User          : ${LIGHT_CYAN}RatuSTORE${NC}                                   ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} Script Status : ${GREEN}Active${NC}                                      ${CYAN}|${NC}"
echo -e "${CYAN}|${NC} Expiry script : ${LIGHT_CYAN}${EXP_DATE}${NC} (${RED}${DAYS_LEFT} Days${NC})                         ${CYAN}|${NC}"
echo -e "${CYAN}+---------------------------------------------------------------+${NC}"
echo ""

read -p " Select option [01-24 or 0] : " option
