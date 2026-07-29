#!/bin/bash
# ==========================================
# Sub-Menu SSH & Dropbear Ratu Store
# ==========================================

NC='\033[0m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
ORANGE='\033[38;5;208m'

clear
echo -e "${CYAN}╔═════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}                   ${YELLOW}SSH & DROPBEAR MENU PANEL${NC}                    ${CYAN}║${NC}"
echo -e "${CYAN}╠═════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}01${NC}] ${BLUE}Create SSH & OpenVPN Account${NC}                               ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}02${NC}] ${BLUE}Trial SSH & OpenVPN Account${NC}                                ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}03${NC}] ${BLUE}Renew SSH & OpenVPN Account${NC}                                ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}04${NC}] ${BLUE}Delete SSH & OpenVPN Account${NC}                               ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}05${NC}] ${BLUE}Check User Login SSH${NC}                                       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}06${NC}] ${BLUE}List Member SSH${NC}                                            ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}                                                                 ${CYAN}║${NC}"
echo -e "${CYAN}║${NC} [${ORANGE}00${NC}] ${BLUE}Back To Main Menu${NC}                                          ${CYAN}║${NC}"
echo -e "${CYAN}╚═════════════════════════════════════════════════════════════════╝${NC}"
echo ""
read -p " Select option [1-6 or 0] : " opt

case $opt in
  1)
    echo ""
    read -p " Username : " user
    read -p " Password : " pass
    read -p " Expiration (Days) : " days
    
    # Proses Tambah User Linux/SSH
    useradd -e $(date -d "$days days" +"%Y-%m-%d") -s /bin/false -M $user
    echo "$user:$pass" | chpasswd
    
    EXPIRED_DATE=$(date -d "$days days" +"%d %b %Y")
    MYIP=$(wget -qO- ipv4.icanhazip.com 2>/dev/null)
    DOMAIN=$(cat /etc/xray/domain 2>/dev/null || echo "$MYIP")
    
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${YELLOW}    SSH ACCOUNT SUCCESSFULLY CREATED ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e " Host/IP    : $DOMAIN"
    echo -e " Username   : $user"
    echo -e " Password   : $pass"
    echo -e " Port OpenSSH: 22"
    echo -e " Port Dropbear: 109, 143"
    echo -e " Port WS-ePro: 80, 8080"
    echo -e " Expired On : $EXPIRED_DATE"
    echo -e "${GREEN}====================================${NC}"
    read -n 1 -s -r -p "Press any key to return to menu..."
    m-ssh
    ;;
  2)
    echo -e "${YELLOW}Feature Trial SSH coming soon...${NC}"
    sleep 2
    m-ssh
    ;;
  3)
    echo -e "${YELLOW}Feature Renew SSH coming soon...${NC}"
    sleep 2
    m-ssh
    ;;
  4)
    echo ""
    read -p " Input Username to Delete : " user
    userdel -f $user 2>/dev/null
    echo -e "${GREEN}User $user successfully deleted!${NC}"
    sleep 2
    m-ssh
    ;;
  5)
    echo ""
    echo -e "${BLUE}--- Active Login User SSH ---${NC}"
    who | grep -E "pts"
    echo ""
    read -n 1 -s -r -p "Press any key to return..."
    m-ssh
    ;;
  6)
    echo ""
    echo -e "${BLUE}--- List All SSH Members ---${NC}"
    cat /etc/passwd | grep -E "/bin/false" | cut -d: -f1
    echo ""
    read -n 1 -s -r -p "Press any key to return..."
    m-ssh
    ;;
  0)
    menu
    ;;
  *)
    echo -e "${RED}Invalid Option!${NC}"
    sleep 1
    m-ssh
    ;;
esac
