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

echo "Checking whether ${CYAN}APACHE2${NC} installed..."
sleep 1

if [ ! -f /etc/apache2/apache2.conf ]; then
	apt install apache2 -y
fi

