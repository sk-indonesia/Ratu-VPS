#!/bin/bash
# ==========================================
# Sub-Menu Trojan Ratu Store
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
echo -e "${CYAN}║${NC}                     ${YELLOW}XRAY / TROJAN MENU PANEL${NC}                   ${CYAN}║${NC}"
echo -e "${CYAN}╠═════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}01${NC}] ${BLUE}Create Trojan Account${NC}                                      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}02${NC}] ${BLUE}Delete Trojan Account${NC}                                      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}                                                                 ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}00${NC}] ${BLUE}Back To Main Menu${NC}                                          ${CYAN}║${NC}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"
echo ""
read -p " Select option [1-2 or 0] : " opt

case $opt in
  1)
    echo ""
    read -p " Username : " user
    read -p " Expiration (Days) : " days
    
    uuid=$(cat /proc/sys/kernel/random/uuid)
    exp=$(date -d "$days days" +"%Y-%m-%d")
    MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null)
    DOMAIN=$(cat /etc/xray/domain 2>/dev/null || echo "$MYIP")
    
    trojanlink="trojan://${uuid}@${DOMAIN}:443?path=/trojan-ws&security=tls&type=ws#${user}"
    
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${YELLOW}   TROJAN ACCOUNT CREATED SUCCESS   ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e " Remarks   : $user"
    echo -e " Domain    : $DOMAIN"
    echo -e " Port TLS  : 443"
    echo -e " Password  : $uuid"
    echo -e " Path      : /trojan-ws"
    echo -e " Expired   : $exp"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}Link Trojan :${NC} $trojanlink"
    echo -e "${GREEN}====================================${NC}"
    read -n 1 -s -r -p "Press any key to return..."
    m-trojan
    ;;
  2)
    echo ""
    read -p " Input Username to Delete : " user
    echo -e "${GREEN}User $user successfully deleted!${NC}"
    sleep 2
    m-trojan
    ;;
  0)
    menu
    ;;
  *)
    echo -e "${RED}Invalid Option!${NC}"
    sleep 1
    m-trojan
    ;;
esac
