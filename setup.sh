#!/bin/bash
# ==========================================
# Script Name : Ratu script auto-installer tunneling
# Author      : Ratu Store
# Repository  : Ratu-VPS
# ==========================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear

# 1. CEK ROOT
if [ "${EUID}" -ne 0 ]; then
  echo -e "${RED}[ERROR] Script ini harus dijalankan sebagai ROOT!${NC}"
  exit 1
fi

# 2. CEK LISENSI IP
echo -e "${BLUE}[*] Checking IP Authorization Ratu Store...${NC}"
MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null || curl -s ipv4.icanhazip.com)
URL_AUTHO="https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/ip.txt"
CHECK_IP=$(curl -s $URL_AUTHO | grep -w "$MYIP")

if [ -n "$CHECK_IP" ]; then
    EXP_DATE=$(echo "$CHECK_IP" | cut -d'|' -f3)
    TODAY=$(date +%Y-%m-%d)
    if [[ "$TODAY" < "$EXP_DATE" ]] || [[ "$TODAY" == "$EXP_DATE" ]]; then
        echo -e "${GREEN}[OK] IP Authorized! Welcome Ratu Store Client.${NC}"
        sleep 1
    else
        echo -e "${RED}[ERROR] Masa berlaku lisensi IP Anda telah habis (${EXP_DATE}).${NC}"
        exit 1
    fi
else
    echo -e "${RED}[ERROR] IP VPS (${MYIP}) belum terdaftar di Ratu Store!${NC}"
    exit 1
fi

# 3. PROSES INSTALLASI CORE ENGINE
clear
echo -e "${YELLOW}====================================================${NC}"
echo -e "${GREEN}     START INSTALLING RATU TUNNELING ENGINE          ${NC}"
echo -e "${YELLOW}====================================================${NC}"
echo ""

# A. Update & Dependensi
echo -e "${BLUE}[1/4] Updating system & dependencies...${NC}"
apt update -y && apt upgrade -y
apt install -y curl wget jq net-tools cron lsb-release tar zip unzip nginx haproxy socat certbot

# B. Install Xray-Core Utama
echo -e "${BLUE}[2/4] Installing Xray-Core Engine...${NC}"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# C. Setup Direktori Konfigurasi Ratu Store
echo -e "${BLUE}[3/4] Configuring Xray & Nginx Directories...${NC}"
mkdir -p /etc/xray
mkdir -p /var/log/xray

# D. Install Menu & Perintah Terminal
echo -e "${BLUE}[4/4] Installing Ratu Store Command Interface...${NC}"
wget -O /usr/bin/menu "https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/menu.sh"
chmod +x /usr/bin/menu

# Set Auto-Start Service
systemctl enable xray
systemctl restart xray
systemctl enable nginx
systemctl restart nginx

clear
echo -e "${GREEN}====================================================${NC}"
echo -e "${GREEN}   INSTALLATION ENGINE COMPLETED SUCCESSFULLY!      ${NC}"
echo -e "${GREEN}   Ketik '${YELLOW}menu${GREEN}' untuk membuka panel Ratu Store.     ${NC}"
echo -e "${GREEN}====================================================${NC}"
