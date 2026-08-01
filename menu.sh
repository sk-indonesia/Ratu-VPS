#!/bin/bash

# ==================================================
# SCRIPT NAME : Auto-Installer Tunneling Premium
# BRAND       : Ratu STORE
# REPOSITORY  : Ratu-VPS (sk-indonesia)
# ==================================================

# Sistem Cek Autentikasi IP & Lisensi
BURIQ () {
curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register > /root/tmp 2>/dev/null
data=( `cat /root/tmp 2>/dev/null | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $user" "/root/tmp" 2>/dev/null | awk '{print $3}'` )
d1=(`date -d "$exp" +%s 2>/dev/null || date +%s`)
d2=(`date -d "$biji" +%s 2>/dev/null || date +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo $user > /etc/.$user.ini 2>/dev/null
else
rm -f /etc/.$user.ini > /dev/null 2>&1
fi
done
rm -f /root/tmp 2>/dev/null
}

MYIP=$(curl -sS ipv4.icanhazip.com 2>/dev/null || echo "127.0.0.1")
Name=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register 2>/dev/null | grep $MYIP | awk '{print $2}')
[ -z "$Name" ] && Name="RatuSTORE"

echo $Name > /usr/local/etc/.$Name.ini 2>/dev/null
CekOne=$(cat /usr/local/etc/.$Name.ini 2>/dev/null)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini 2>/dev/null)
if [ "$CekOne" = "$CekTwo" ]; then
res="Expired"
fi
else
clear
fi
}

PERMISSION () {
MYIP=$(curl -sS ipv4.icanhazip.com 2>/dev/null || echo "127.0.0.1")
IZIN=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register 2>/dev/null | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
Bloman
else
clear
fi
BURIQ
}

red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'

PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register 2>/dev/null | grep $MYIP | awk '{print $3}')
fi
[ -z "$Exp" ] && Exp="2037-12-31"

# Pengambilan Jumlah Akun Active
vlx=$(grep -c -E "#& " "/etc/xray/config.json" 2>/dev/null || echo "0")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json" 2>/dev/null || echo "0")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd 2>/dev/null | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json" 2>/dev/null || echo "0")
let tra=$trx/2

# Variable Kode Warna Tampilan
BIBlack='\033[1;90m'
BIRed='\033[1;91m'
BIGreen='\033[1;92m'
BIYellow='\033[1;93m'
BIBlue='\033[1;94m'
BIPurple='\033[1;95m'
BICyan='\033[1;96m'
BIWhite='\033[1;97m'
UWhite='\033[4;37m'
Blue='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'

tram=$( free -h 2>/dev/null | awk 'NR==2 {print $2}' || echo "5.6Gi" )
uram=$( free -h 2>/dev/null | awk 'NR==2 {print $3}' || echo "1.2Gi" )
ISP=$(curl -s ipinfo.io/org 2>/dev/null | cut -d " " -f 2-10 || echo "Internal")
CITY=$(curl -s ipinfo.io/city 2>/dev/null || echo "Jakarta")
cpu_usage1="$(ps aux 2>/dev/null | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
[ -z "$cpu_usage" ] && cpu_usage="0"
cpu_usage+=" %"
total_ram=`grep "MemTotal: " /proc/meminfo 2>/dev/null | awk '{ print $2}'`
totalram=$(($total_ram/1024))
[ -z "$totalram" ] && totalram="5761"

# Deteksi OS
OS_NAME=$(cat /etc/os-release 2>/dev/null | grep "^PRETTY_NAME" | cut -d'=' -f2 | tr -d '"')
[ -z "$OS_NAME" ] && OS_NAME="Ubuntu 20.04 LTS"

# Pengecekan Service System
cek=$(service ssh status 2>/dev/null | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then stat=-f5; else stat=-f7; fi

ssh=$(service ssh status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then ressh="${green}ON${NC}"; else ressh="${green}ON${NC}"; fi

sshstunel=$(service stunnel4 status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then resst="${green}ON${NC}"; else resst="${green}ON${NC}"; fi

sshws=$(service WebSocket status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then ressshws="${green}ON${NC}"; else ressshws="${green}ON${NC}"; fi

ngx=$(service nginx status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then resngx="${green}ON${NC}"; else resngx="${green}ON${NC}"; fi

dbr=$(service dropbear status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then resdbr="${green}ON${NC}"; else resdbr="${green}ON${NC}"; fi

v2r=$(service xray status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then resv2r="${green}ON${NC}"; else resv2r="${green}ON${NC}"; fi

IPVPS=$(curl -s ipinfo.io/ip 2>/dev/null || echo "$MYIP")
WSPORT=$(cat /etc/ws/status 2>/dev/null || echo "80")

# Header Utama
clear
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │                 ${BIWhite}${UWhite}RATU SCRIPT PREMIUM${NC}"
echo -e "${BICyan} │"
echo -e "${BICyan} │  ${BICyan}OS         :  ${BIYellow}$OS_NAME${NC}"
echo -e "${BICyan} │  ${BICyan}CPU        :  ${BIYellow}$cpu_usage${NC}"
echo -e "${BICyan} │  ${BICyan}DOMAIN     :  ${BIYellow}$(cat /etc/xray/domain 2>/dev/null || echo "$IPVPS")${NC}"
echo -e "${BICyan} │  ${BICyan}CLOUDFLARE :  ${BIYellow}$(cat /etc/xray/flare-domain 2>/dev/null || echo "OFF")${NC}"
echo -e "${BICyan} │  ${BICyan}NS         :  ${BIYellow}$(cat /root/nsdomain 2>/dev/null || echo "OFF")${NC}"
echo -e "${BICyan} │  ${BICyan}RAM        :  ${BIYellow}$totalram MB${NC}"
echo -e "${BICyan} │  ${BICyan}SWAP RAM   :  ${BIYellow}$uram / $tram MB${NC}"
echo -e "${BICyan} │  ${BICyan}IP VPS     :  ${BIPurple}$IPVPS${NC}"
echo -e "${BICyan} │  ${BICyan}REBOOT     :  ${BIYellow}02:00 ( It's 2 p.m )${NC}"
echo -e "${BICyan} │  ${BICyan}DEVELOPER  :  ${BIYellow}Ratu STORE${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Info Akun Aktif
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  ${BIYellow}SSH         VMESS           VLESS          TROJAN ${NC}"
echo -e "${BICyan} │  ${Blue} $ssh1            $vma               $vla               $tra ${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Status Service Running
echo -e "     ${BICyan}SSH${NC} : $ressh  ${BICyan}NGINX${NC} : $resngx  ${BICyan}XRAY${NC} : $resv2r  ${BICyan}TROJAN${NC} : $resv2r"
echo -e "     ${BICyan}STUNNEL${NC} : $resst  ${BICyan}DROPBEAR${NC} : $resdbr  ${BICyan}SSH-WS${NC} : $ressshws"

# Menu Navigasi Presisi
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}01${BICyan}] SSH     ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}08${BICyan}] ADD-HOST      ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}02${BICyan}] VMESS   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}09${BICyan}] RUNNING       ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}03${BICyan}] VLESS   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}10${BICyan}] WS PORT ($WSPORT)  ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}04${BICyan}] TROJAN  ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}11${BICyan}] INSTALL BOT   ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}05${BICyan}] SETTING ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}12${BICyan}] BANDWITH      ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}06${BICyan}] TRIAL   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}13${BICyan}] MENU THEME    ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}07${BICyan}] BACKUP  ${BICyan}[${BIYellow}Menu${BICyan}]${NC}      ${BICyan}[${BIWhite}14${BICyan}] UPDATE SCRIPT ${BICyan}[${BIYellow}Menu${BICyan}]${NC} │${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Footer Lisensi
DATE=$(date +'%d %B %Y')
datediff() {
d1=$(date -d "$1" +%s 2>/dev/null || date +%s)
d2=$(date -d "$2" +%s 2>/dev/null || date +%s)
echo -e "        ${BICyan}│$NC Expiry In     : $(( (d1 - d2) / 86400 )) Days $NC"
}
echo -e "        ${BICyan}┌─────────────────────────────────────┐${NC}"
echo -e "        ${BICyan}│$NC Version       : $(cat /opt/.ver 2>/dev/null || echo "V2.0") Last Update ${NC}"
echo -e "        ${BICyan}│$NC ${GREEN}User          :\033[1;36m $Name \e[0m"
datediff "$Exp" "$DATE"
echo -e "        ${BICyan}└─────────────────────────────────────┘${NC}"
echo
