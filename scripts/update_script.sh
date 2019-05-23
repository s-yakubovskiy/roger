#! /bin/sh
echo $(date) >> /var/log/update__script.log
apt update 1>> /var/log/update__script.log 2> /dev/null
apt upgrade 1>> /var/log/update__script.log 2> /dev/null
echo '' >> /var/log/update__script.log