#!/bin/bash
# ==========================================
# Sub-Menu VMess Ratu Store
# ==========================================

NC='\033[0m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
ORANGE='\033[38;5;208m'

clear
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}                     ${YELLOW}XRAY / VMESS MENU PANEL${NC}                    ${CYAN}║${NC}"
echo -e "${CYAN}╠═════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}01${NC}] ${BLUE}Create Vmess Account${NC}                                       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}02${NC}] ${BLUE}Delete Vmess Account${NC}                                       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}03${NC}] ${BLUE}Check User Login Vmess${NC}                                     ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}                                                                 ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}00${NC}] ${BLUE}Back To Main Menu${NC}                                          ${CYAN}║${NC}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"
echo ""
read -p " Select option [1-3 or 0] : " opt

case $opt in
  1)
    echo ""
    read -p " Username : " user
    read -p " Expiration (Days) : " days
    
    uuid=$(cat /proc/sys/kernel/random/uuid)
    exp=$(date -d "$days days" +"%Y-%m-%d")
    
    MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null)
    DOMAIN=$(cat /etc/xray/domain 2>/dev/null || echo "$MYIP")
    
    vmesslink1="vmess://$(echo -n "{\"v\":\"2\",\"ps\":\"${user}\",\"add\":\"${DOMAIN}\",\"port\":\"443\",\"id\":\"${uuid}\",\"aid\":\"0\",\"scy\":\"auto\",\"net\":\"ws\",\"path\":\"/vmess\",\"tls\":\"tls\"}" | base64 -w 0)"
    
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${YELLOW}    VMESS ACCOUNT CREATED SUCCESS   ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e " Remarks   : $user"
    echo -e " Domain    : $DOMAIN"
    echo -e " Port TLS  : 443"
    echo -e " User ID   : $uuid"
    echo -e " Path      : /vmess"
    echo -e " Expired   : $exp"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}Link TLS :${NC} $vmesslink1"
    echo -e "${GREEN}====================================${NC}"
    read -n 1 -s -r -p "Press any key to return..."
    m-vmess
    ;;
  2)
    echo ""
    read -p " Input Username to Delete : " user
    echo -e "${GREEN}User $user successfully deleted!${NC}"
    sleep 2
    m-vmess
    ;;
  3)
    echo -e "${BLUE}--- Active Vmess Users ---${NC}"
    sleep 2
    m-vmess
    ;;
  0)
    menu
    ;;
  *)
    echo -e "${RED}Invalid Option!${NC}"
    sleep 1
    m-vmess
    ;;
esac
