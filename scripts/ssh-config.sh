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


#check if installed
echo ''
dpkg -l | grep -q "openssh-server"
if [[ $? != 0 ]]; then
	apt install openssh-server
fi
echo "...
${CYAN} Backup your current sshd conf${NC} ${RED}/etc/ssh/sshd_config${NC}
..."
echo '' 
sleep 1

# touch ../conf_files/.interfaces_backup
# cat /etc/network/interfaces > ../conf_files/.interfaces_backup
touch conf_files/.sshd_config_backup
cat conf_files/sshd_config.conf > /etc/ssh/sshd_config
echo "${CYAN}applying our pre-conf files${NC} (in dir /conf_files)"
# cat ../conf_files/network_interfaces.conf > /etc/network/interfaces
def_port=$(cat /etc/ssh/sshd_config | grep "^Port" | awk '{print $2}')
echo "\n Your ${YEL}default ssh port${NC} to connect is: ${RED}$def_port${NC}"
sleep 1

service networking restart
systemctl restart sshd
service --status-all

sleep 1


#echo "${CYAN}write HOST IP of machine where to connect\n"
#read ip_host
if [ -f  ~/.ssh/*pub ]; then
	echo 'You have already had a SSH PUB KEY'
	echo 'No need to ssh-keygen'; else
	ssh-keygen
fi
# sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config.conf
#echo "${CYAN} >>> Please, input your login to connect through SSH${NC}\n"
#read login
#echo "${CYAN} >>> Please, input your password to connect through SSH${NC}\n"
#read passwd
# sshpass -p $passwd ssh -o StrictHostKeyChecking=no $login@$ip_host
echo "... please, connect to ssh $(whoami)@$(ip add show enp0s8 | grep "inet " | awk '{print $2'})..."
read answer
echo "finalizing ssh PasswordAuthentication stuff"
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "${GRN}SSH server with PUB keys are successfully installed.${NC}"

#ssh-copy-id -f $login@$ip_host
