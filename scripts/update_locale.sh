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

echo ''
echo "${CYAN}>>>> apt update && apt upgrade <<<<<<${NC}"
sleep 1

apt update
apt upgrade
echo "..set locale to ${CYAN}en_US${NC}..."
sed -i 's/^# en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
locale-gen

echo "${CYAN}>>>> installing zsh and change default shell for root <<<<<<${NC}"
sleep 1
apt install zsh
chsh -s /bin/zsh root

echo "${GRN}Completed.${NC}"

