#!/bin/bash

# ==================================================
# SCRIPT NAME : Auto-Installer Tunneling Premium
# BRAND       : Ratu STORE
# REPOSITORY  : Ratu-VPS
# ==================================================

# Sistem Cek Autentikasi IP & Lisensi
BURIQ () {
curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register > /root/tmp
data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
d1=(`date -d "$exp" +%s`)
d2=(`date -d "$biji" +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo $user > /etc/.$user.ini
else
rm -f /etc/.$user.ini > /dev/null 2>&1
fi
done
rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
if [ "$CekOne" = "$CekTwo" ]; then
res="Expired"
fi
else
clear
fi
}

PERMISSION () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register | awk '{print $4}' | grep $MYIP)
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
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/register | grep $MYIP | awk '{print $3}')
fi

# Pengambilan Jumlah Akun Active
vlx=$(grep -c -E "#& " "/etc/xray/config.json" 2>/dev/null || echo "0")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json" 2>/dev/null || echo "0")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#! " "/etc/xray/config.json" 2>/dev/null || echo "0")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json" 2>/dev/null || echo "0")
let ssa=$ssx/2

# Kode Warna Terminal
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

# Pengambilan Status System & Bandwidth
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}' 2>/dev/null || echo "0 B")"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}' 2>/dev/null || echo "0 B")"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}' 2>/dev/null || echo "0 B")"
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}' 2>/dev/null || echo "0 B")"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}' 2>/dev/null || echo "0 B")"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}' 2>/dev/null || echo "0 B")"
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}' 2>/dev/null || echo "0 B")"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}' 2>/dev/null || echo "0 B")"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}' 2>/dev/null || echo "0 B")"

tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
total_ram=`grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

clear

# Pengecekan Service System
cek=$(service ssh status 2>/dev/null | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then stat=-f5; else stat=-f7; fi

ssh=$(service ssh status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then ressh="${green}ON${NC}"; else ressh="${red}OFF${NC}"; fi

sshstunel=$(service stunnel4 status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then resst="${green}ON${NC}"; else resst="${red}OFF${NC}"; fi

sshws=$(service WebSocket status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then ressshws="${green}ON${NC}"; else ressshws="${red}OFF${NC}"; fi

ngx=$(service nginx status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then resngx="${green}ON${NC}"; else resngx="${red}OFF${NC}"; fi

dbr=$(service dropbear status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then resdbr="${green}ON${NC}"; else resdbr="${red}OFF${NC}"; fi

v2r=$(service xray status 2>/dev/null | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then resv2r="${green}ON${NC}"; else resv2r="${red}OFF${NC}"; fi

# Sub-Fungsi
function addhost(){
clear
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"
echo "Dont forget to renew cert"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}

function genssl(){
clear
systemctl stop nginx
domain=$(cat /var/lib/scrz-prem/ipvps.conf 2>/dev/null | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek "
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek "
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... "
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... "
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek "
sleep 2
echo $domain > /etc/xray/domain
systemctl restart xray
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... "
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

export sem=$(curl -s https://raw.githubusercontent.com/sk-indonesia/Ratu-VPS/main/versions 2>/dev/null || echo "V2.0")
export pak=$(cat /home/.ver 2>/dev/null || echo "V2.0")
IPVPS=$(curl -s ipinfo.io/ip || echo "$MYIP")

# Header Tampilan
clear
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │                 ${BIWhite}${UWhite}RATU SCRIPT PREMIUM${NC}"
echo -e "${BICyan} │"
echo -e "${BICyan} │  ${BICyan}OS         :  ${BIYellow}$( cat /etc/os-release 2>/dev/null | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) )${NC}"
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
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  ${BIYellow}SSH         VMESS           VLESS          TROJAN $NC"
echo -e "${BICyan} │  ${Blue} $ssh1            $vma               $vla               $tra $NC"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"
echo -e "     ${BICyan} SSH ${NC}: $ressh"" ${BICyan} NGINX ${NC}: $resngx"" ${BICyan}  XRAY ${NC}: $resv2r"" ${BICyan} TROJAN ${NC}: $resv2r"
echo -e "   ${BICyan}     STUNNEL ${NC}: $resst" "${BICyan} DROPBEAR ${NC}: $resdbr" "${BICyan} SSH-WS ${NC}: $ressshws"
echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}01${BICyan}] SSH     ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}08${BICyan}] ADD-HOST        ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}02${BICyan}] VMESS   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}09${BICyan}] RUNNING         ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}03${BICyan}] VLESS   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}10${BICyan}] WS PORT ${BIPurple}($(cat /etc/ws/status 2>/dev/null || echo "80"))${NC}  ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}04${BICyan}] TROJAN  ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}11${BICyan}] INSTALL BOT     ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}05${BICyan}] SETTING ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}12${BICyan}] BANDWITH        ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}06${BICyan}] TRIAL   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}13${BICyan}] MENU THEME      ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} │  ${BICyan}[${BIWhite}07${BICyan}] BACKUP  ${BICyan}[${BIYellow}Menu${BICyan}]${NC}"  "${BICyan}  [${BIWhite}14${BICyan}] UPDATE SCRIPT   ${BICyan}[${BIYellow}Menu${BICyan}]${NC}" "${BICyan} │${NC}"
echo -e "${BICyan} └─────────────────────────────────────────────────────┘${NC}"

# Masa Lisensi / Expiry Script
DATE=$(date +'%d %B %Y')
datediff() {
d1=$(date -d "$1" +%s)
d2=$(date -d "$2" +%s)
echo -e "        ${BICyan}│$NC Expiry In     : $(( (d1 - d2) / 86400 )) Days $NC"
}
echo -e "        ${BICyan}┌─────────────────────────────────────┐${NC}"
echo -e "        ${BICyan}│$NC Version       : $(cat /opt/.ver 2>/dev/null || echo "V2.0") Last Update ${NC}"
echo -e "        ${BICyan}│$NC ${GREEN}User          :\033[1;36m $Name \e[0m"
datediff "$Exp" "$DATE"
echo -e "        ${BICyan}└─────────────────────────────────────┘${NC}"
echo

# Pemilihan Menu Navigasi
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-set ;;
6) clear ; menu-trial ;;
7) clear ; menu-backup ;;
8) clear ; addhost ;;
9) clear ; running ;;
10) clear ; wsport ;;
11) clear ; xolpanel ;;
12) clear ; bw ;;
13) clear ; menu-theme ;;
14) clear ; update-script ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
