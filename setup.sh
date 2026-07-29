#!/bin/bash
# ==========================================
# Script Name : Ratu script auto-installer tunneling
# Author      : Ratu Store
# Repository  : Ratu-VPS
# ==========================================

# Kode Warna
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

# 2. SISTEM PENGECEKAN LISENSI IP
echo -e "${BLUE}[*] Checking IP Authorization Ratu Store...${NC}"
MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null || curl -s ipv4.icanhazip.com)

# URL RAW DATABASE IP KAMU
URL_AUTHO="https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/ip.txt"

# Cek IP di Database
CHECK_IP=$(curl -s $URL_AUTHO | grep -w "$MYIP")

if [ -n "$CHECK_IP" ]; then
    EXP_DATE=$(echo "$CHECK_IP" | cut -d'|' -f3)
    TODAY=$(date +%Y-%m-%d)
    
    if [[ "$TODAY" < "$EXP_DATE" ]] || [[ "$TODAY" == "$EXP_DATE" ]]; then
        echo -e "${GREEN}[OK] IP Authorized! Welcome Ratu Store Client.${NC}"
        sleep 2
    else
        echo -e "${RED}[ERROR] Masa berlaku lisensi IP Anda telah habis pada ($EXP_DATE).${NC}"
        echo -e "${YELLOW}Silakan hubungi Admin Ratu Store untuk memperpanjang!${NC}"
        exit 1
    fi
else
    echo -e "${RED}[ERROR] IP VPS ($MYIP) belum terdaftar!${NC}"
    echo -e "${YELLOW}Silakan beli lisensi resmi di Ratu Store terlebih dahulu.${NC}"
    exit 1
fi

# 3. PERSIAPAN SISTEM & INSTALLASI
clear
echo -e "${YELLOW}====================================================${NC}"
echo -e "${GREEN}     START INSTALLING RATU TUNNELING SCRIPT          ${NC}"
echo -e "${YELLOW}====================================================${NC}"
echo ""

# Update Repository & Paket Dasar
echo -e "${BLUE}[1/3] Updating system packages...${NC}"
apt update -y && apt upgrade -y
apt install -y curl wget jq net-tools cron lsb-release tar zip unzip

# Set Timezone WIB
timedatectl set-timezone Asia/Jakarta

echo -e "${BLUE}[2/3] Installing Menu System...${NC}"
# Unduh File Menu Interaktif
wget -O /usr/bin/menu "https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/menu.sh"
chmod +x /usr/bin/menu

echo -e "${BLUE}[3/3] Completing setup...${NC}"
sleep 1

clear
echo -e "${GREEN}====================================================${NC}"
echo -e "${GREEN}   INSTALLATION COMPLETED SUCCESSFULLY!             ${NC}"
echo -e "${GREEN}   Ketik '${YELLOW}menu${GREEN}' untuk membuka panel Ratu Store.     ${NC}"
echo -e "${GREEN}====================================================${NC}"
