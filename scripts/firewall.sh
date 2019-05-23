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




# : ' comments in bash way



echo ''
echo "${CYAN}Working on your IPTABLES. 
${NC}Add ${RED}<iptables.conf>${CYAN} to ${RED}/etc/iptables/iptables.conf ... \

${NC}Make rules permanent with pre-up script hooked on loopback interfaces. ${NC}"
sleep 1
if [ ! -f /etc/iptables/iptables.conf ]; then
	sudo mkdir /etc/iptables
	sudo touch /etc/iptables/iptables.conf

	sudo chmod +x $home/conf_files/iptables-rdy.conf
	sudo $home/conf_files/./iptables-rdy.conf
	# sudo iptables-restore <	$home/conf_files/iptables-rdy.conf

	sudo iptables-save > /etc/iptables/iptables.conf
	sudo touch /etc/iptables/iptables-restore.sh
	echo "iptables-restore < /etc/iptables/iptables.conf" > /etc/iptables/iptables-restore.sh
	sudo chmod +x /etc/iptables/iptables-restore.sh
	echo "iptables rdy"; else
	echo ''
	echo "You already have a iptables.conf file. ${RED}Nothing to do"
	sleep 1
fi

# '


echo "Checking whether ${RED}APACHE2${NC} installed..."
sleep 1
if [ ! -f /etc/apache2/apache2.conf ]; then
	apt install apache2 -y
fi
echo "installing ${RED}fail2ban${NC} and pre-conf it to ban anyone \
who tried to connect to our ssh with wrong password"
echo ''
sleep 1
apt install fail2ban
touch /etc/fail2ban/jail.d/jail-debian.local
cat $home/conf_files/fail2ban.conf > /etc/fail2ban/jail.d/jail-debian.local
service fail2ban restart
service fail2ban status
echo "${GRN}Completed.${NC}"
sleep 1

