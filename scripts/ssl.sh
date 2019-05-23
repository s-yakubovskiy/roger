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

echo "Creating ${RED}SSL certs${NC}..."
sleep 1
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
echo "Generating strong ${RED}Diffie-Hellman group${NC}..."
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

echo "..create a configuration snippet to specify strong default SSL settings.."
sleep 1
cp $home/conf_files/ssl-params.conf /etc/apache2/conf-available/ssl-params.conf

echo "\
..backup apache2 ssl conf file.."
sleep 1
cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak
echo "\
..applying ${BLU}new ssl conf file${NC}.."

cat $home/conf_files/default-ssl.conf > /etc/apache2/sites-available/default-ssl.conf

echo "\
..enable ${BLU}mod_ssl${NC}, the Apache SSL module, and ${BLU}mod_headers${NC}.."
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite default-ssl
sudo a2enconf ssl-params
echo "\
..${BLU}TESTING MODE${NC}, testing syntax and conf.."
sleep 1
sudo apache2ctl configtest
echo "\
..Do you want to ${MAG}REDIRECT HTTP > HTTPS${NC} permanently, testing syntax and conf..\
yes / no"

read name
if [ "$name" = "yes" ]; then
	sed  -i '/DocumentRoot/a \\tRedirect permanent "/" "https://192.168.99.2/"' /etc/apache2/sites-available/000-default.conf
fi
sudo systemctl restart apache2