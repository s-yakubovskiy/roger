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

echo "...Add ${RED}crontab jobs${NC}..."
sleep 1

crontab $home/scripts/cron.jobs
echo ""
echo "Checking ${RED}crontab checksum file${NC}. If doesn't exist -> create checksum..."
if [ ! -f /etc/crontab.sum ]; then
	md5sum /etc/crontab > /etc/crontab.sum
fi
