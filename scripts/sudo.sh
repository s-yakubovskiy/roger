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

echo "${CYAN}>>>> installing sudo && adding user to sudoers <<<<<<${NC}"
sleep 1

apt install sudo
echo "\nInput your user name (to add it to sudoers): "
read name
usermod -a -G sudo $name
echo "hello, ${CYAN}$name${NC}"
echo "$name	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cat /etc/sudoers
id
echo "${GRN}Completed.${NC}"
sleep 1


