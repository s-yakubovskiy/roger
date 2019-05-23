#! /bin/sh
home=$(pwd)

MAG=$'\e[1;35m'
NC=$'\e[0m' # No Color

md5sum -c /etc/crontab.sum | grep "FAILED"
if [ $? -eq 0 ]; then
        echo "$(date)${MAG}CRONTAB MODIFIED${NC}" > /etc/tmp/checksum.fail
        /usr/sbin/sendmail root@mail.com < /etc/tmp/checksum.fail
        rm /etc/tmp/checksum.fail
        md5sum /etc/crontab > /etc/crontab.sum
fi
