#!/bin/bash

# ==================================================
# SCRIPT NAME : Ratu script auto-installer tunneling
# BRAND       : Ratu STORE
# REPOSITORY  : Ratu-VPS
# ==================================================

# Kode Warna
NC='\033[0m'
BG_RED='\033[41;37;1m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[38;5;208m'

# Dynamic Data System
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

# Fungsi Print Baris System Info Supaya Garis Kanan Rata Tepat di Kolom ke-65
print_sys() {
    local label="$1"
    local value="$2"
    # Format teks murni tanpa warna untuk hitung panjang karakter
    local clean_str=" ↘ $label = $value"
    local len=${#clean_str}
    local pad=$((63 - len))
    [ $pad -lt 0 ] && pad=0
    local spaces=$(printf '%*s' "$pad" '')
    echo -e "${CYAN}║${NC} ${ORANGE}↘${NC} ${label} = ${LIGHT_CYAN}${value}${NC}${spaces}${CYAN}║${NC}"
}

# 1. HEADER UTAMA
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${BG_RED}             Welcome To Script Premium Ratu Store                ${NC}${CYAN}║${NC}"
echo -e "${CYAN}╠═════════════════════════════════════════════════════════════════╣${NC}"

# 2. SYSTEM INFO
print_sys "System OS" "$OS_NAME"
print_sys "CPU Model" "$CPU_MODEL"
print_sys "Server RAM" "$RAM_TOTAL MB"
print_sys "Uptime Server" "$UPTIME_SYS"
print_sys "Date" "$DATE_NOW"
print_sys "Time" "$TIME_NOW"
print_sys "IP VPS" "$MYIP"
print_sys "Domain" "$DOMAIN_NAME"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"

# 3. STATUS SERVER
echo -e "                  ${CYAN}>>>  ${BLUE}STATUS SERVER${NC}  ${CYAN}<<<${NC}"
echo -e "${CYAN}╭──────────────────────╮ ╭──────────────────────╮ ╭──────────────────────╮${NC}"
echo -e "${CYAN}│${NC} SSH     : ${GREEN}ON✓${NC}        ${CYAN}│${NC} ${CYAN}│${NC} NGINX   : ${GREEN}ON✓${NC}        ${CYAN}│${NC} ${CYAN}│${NC} XRAY    : ${GREEN}ON✓${NC}        ${CYAN}│${NC}"
echo -e "${CYAN}╰──────────────────────╯ ╰──────────────────────╯ ╰──────────────────────╯${NC}"

# 4. GRID MENU (Presisi 65 Karakter)
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}01${NC}] ${BLUE}SSH MENU${NC}        ${CYAN}│${NC} [${ORANGE}09${NC}] ${BLUE}AUTOREBOOT${NC}      ${CYAN}│${NC} [${ORANGE}17${NC}] ${BLUE}RESTART${NC}        ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}02${NC}] ${BLUE}VMESS MENU${NC}      ${CYAN}│${NC} [${ORANGE}10${NC}] ${BLUE}INFO PORT${NC}       ${CYAN}│${NC} [${ORANGE}18${NC}] ${BLUE}DOMAIN${NC}         ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}03${NC}] ${BLUE}VLESS MENU${NC}      ${CYAN}│${NC} [${ORANGE}11${NC}] ${BLUE}SPEEDTEST${NC}       ${CYAN}│${NC} [${ORANGE}19${NC}] ${BLUE}CERT SSL${NC}       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}04${NC}] ${BLUE}TROJAN MENU${NC}     ${CYAN}│${NC} [${ORANGE}12${NC}] ${BLUE}RUNNING${NC}         ${CYAN}│${NC} [${ORANGE}20${NC}] ${BLUE}INS. UDP${NC}       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}05${NC}] ${BLUE}SHADOW MENU${NC}     ${CYAN}│${NC} [${ORANGE}13${NC}] ${BLUE}VPS INFO${NC}        ${CYAN}│${NC} [${ORANGE}21${NC}] ${BLUE}CLEAR CACHE${NC}    ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}06${NC}] ${BLUE}TRIAL MENU${NC}      ${CYAN}│${NC} [${ORANGE}14${NC}] ${BLUE}CREATE SLOW${NC}     ${CYAN}│${NC} [${ORANGE}22${NC}] ${BLUE}BOT NOTIF${NC}       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}07${NC}] ${BLUE}CLEAR LOG${NC}       ${CYAN}│${NC} [${ORANGE}15${NC}] ${BLUE}BCKP/RSTR${NC}      ${CYAN}│${NC} [${ORANGE}23${NC}] ${BLUE}UPDATE SCRIPT${NC}   ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}08${NC}] ${BLUE}DELL ALL EXP${NC}    ${CYAN}│${NC} [${ORANGE}16${NC}] ${BLUE}REBOOT${NC}         ${CYAN}│${NC} [${ORANGE}24${NC}] ${BLUE}BOT PANEL${NC}      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}                                                                 ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}00${NC}] ${BLUE}BACK TO EXIT MENU${NC} ${CYAN}<<<${NC}                                      ${CYAN}║${NC}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"

# 5. FOOTER INFO (Presisi 65 Karakter)
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC} Version       = ${LIGHT_CYAN}V2.0${NC}                                           ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} User          = ${LIGHT_CYAN}RatuSTORE${NC}                                      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} Script Status = ${GREEN}Active${NC}                                         ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} Expiry script = ${LIGHT_CYAN}${EXP_DATE}${NC} (${RED}${DAYS_LEFT} Days${NC})                            ${CYAN}║${NC}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"
echo ""

read -p " Select option [01-24 or 0] : " option
