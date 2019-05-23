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

echo "..installing ${BLU} MAILUTILS${NC}.."
sleep 1
apt install mailutils -y

echo "..posting up ${BLU} SITE TEMPLATE${NC}.."
sleep 2
rm -rf /var/www/html
cp -r /root/tmp/conf_files/html /var/www
echo "..${GRN}DONE${NC}.."
