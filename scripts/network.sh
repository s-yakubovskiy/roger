#! /bin/sh
home=$(pwd)
# source $home/./header.sh
CYAN=$'\e[1;36m'
RED=$'\e[1;31m'
GRN=$'\e[1;32m'
YEL=$'\e[1;33m'
BLU=$'\e[1;34m'
MAG=$'\e[1;35m'
NC=$'\e[0m' # No Color

echo "...
${CYAN} Backup your current NentworkInterfaces conf${NC} ${RED}/etc/ssh/sshd_config${NC}
..."
echo '' 
sleep 1
touch conf_files/.interfaces_backup
cat /etc/network/interfaces > conf_files/.interfaces_backup
echo "${CYAN}applying our pre-conf files${NC} (in dir /conf_files)"
echo ''
cat conf_files/network_interfaces.conf > /etc/network/interfaces
echo "${CYAN}...restarting network...${NC}"
/etc/init.d/networking stop
/etc/init.d/networking start
sleep 2
ifup enp0s3
# sleep 2
ifup enp0s8
echo "${GRN} done!${NC}"
