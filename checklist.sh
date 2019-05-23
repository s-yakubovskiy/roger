#! /bin/sh
home=$(pwd)
CYAN=$'\e[1;36m'
RED=$'\e[1;31m'
GRN=$'\e[1;32m'
YEL=$'\e[1;33m'
BLU=$'\e[1;34m'
MAG=$'\e[1;35m'
NC=$'\e[0m' # No Color

# source $home/scripts/./header.sh
DIALOG=${DIALOG=dialog}
tempfile=$(tempfile 2>/dev/null) || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Roger Skyline #1 {21school DevOps project}" \
		--title "Choose your options" --clear \
		--checklist "Hi, you can select what to do with script  " 20 75 11 \
		"Basic"		"Update/Upgrade Debian. Generate LOCALE" ON \
		"Sudo"		"Install SUDO. Add user. Add user to sudoers." off \
		"Network"	"Network part. Predefined conf with \30 mask \DHCP off" off \
		"SSH-conf"	"Pre-conf SSH with PUB key access and custom port" off \
		"Firewall"	"Messing with your IP tables." off \
		"Crontab"	"Messing with your crontab" off \
		"WebPart"	"Installing & Updating Apache2" off \
		"SSL"		"Generating SSL cert & Updating Apache2" off \
		"Services"	"Mail Utils and Site Template" off \
		"Flush_IP"	"flush iptables" off \
		"Addlater"	"to be continued" off  2> $tempfile

retval=$?

choice=`cat $tempfile`
case $retval in
	0)
	# echo "'$choice' are scheduled to be done"
	echo "$choice" > $home/choices.tmp
	clear
	a=$home/choices.tmp
for i in $(cat ${a} | tr ' ' '\n') ; do
	str=${str},${i}
	echo ""
	echo Doing ... ${YEL}${i}${NC}
	sleep 3
	if [ "${i}" = "Basic" ]; then
		$home/scripts/./update_locale.sh
	elif [ "${i}" = "Sudo" ]; then
		$home/scripts/./sudo.sh
	elif [ "${i}" = "Network" ]; then
		$home/scripts/./network.sh
	elif [ "${i}" = "SSH-conf" ]; then
		$home/scripts/./ssh-config.sh
	elif [ "${i}" = "Firewall" ]; then
		$home/scripts/./firewall.sh
	elif [ "${i}" = "WebPart" ]; then
		$home/scripts/./webpart.sh
	elif [ "${i}" = "SSL" ]; then
		$home/scripts/./ssl.sh
	elif [ "${i}" = "Crontab" ]; then
		$home/scripts/./crontab.sh
	elif [ "${i}" = "Services" ]; then
		$home/scripts/./mail.sh
	elif [ "${i}" = "Flush_IP" ]; then
		$home/scripts/./ip_flush.sh
	fi
	rm -rf $home/choices.tmp
done


	;;
	1)
	clear
	echo "Cancel pressed.";;

	255)
	clear
	echo "ESC pressed.";;
esac
