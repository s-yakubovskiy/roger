17. Разрешить или запретить ICMP Ping запросы.
Чтобы запретить ping:
# iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
# iptables -A INPUT -i eth1 -p icmp --icmp-type echo-request -j DROP

Разрешить для определенных сетей / хостов:
# iptables -A INPUT -s 192.168.1.0/24 -p icmp --icmp-type echo-request -j ACCEPT

Разрешить только часть ICMP запросов:
### ** предполагается, что политики по умолчанию для входящих установлены в DROP ** ###
# iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
# iptables -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
# iptables -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
## ** разрешим отвечать на запрос ** ##
# iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

18. Открыть диапазон портов.
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7000:7010 -j ACCEPT

19. Открыть диапазон адресов.
## разрешить подключение к порту 80 (Apache) если адрес в диапазоне от 192.168.1.100 до 192.168.1.200 ##
# iptables -A INPUT -p tcp --destination-port 80 -m iprange --src-range 192.168.1.100-192.168.1.200 -j ACCEPT

## пример для nat ##
# iptables -t nat -A POSTROUTING -j SNAT --to-source 192.168.1.20-192.168.1.25

20. Закрыть или открыть стандартные порты.
Заменить ACCEPT на DROP, чтобы заблокировать порт.

## ssh tcp port 22 ##
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 22 -j ACCEPT

## cups (printing service) udp/tcp port 631 для локальной сети ##
iptables -A INPUT -s 192.168.1.0/24 -p udp -m udp --dport 631 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -p tcp -m tcp --dport 631 -j ACCEPT

## time sync via NTP для локальной сети (udp port 123) ##
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p udp --dport 123 -j ACCEPT

## tcp port 25 (smtp) ##
iptables -A INPUT -m state --state NEW -p tcp --dport 25 -j ACCEPT

# dns server ports ##
iptables -A INPUT -m state --state NEW -p udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state NEW -p tcp --dport 53 -j ACCEPT

## http/https www server port ##
iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT

## tcp port 110 (pop3) ##
iptables -A INPUT -m state --state NEW -p tcp --dport 110 -j ACCEPT

## tcp port 143 (imap) ##
iptables -A INPUT -m state --state NEW -p tcp --dport 143 -j ACCEPT

## Samba file server для локальной сети ##
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 137 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 138 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 139 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 445 -j ACCEPT

## proxy server для локальной сети ##
iptables -A INPUT -s 192.168.1.0/24 -m state --state NEW -p tcp --dport 3128 -j ACCEPT

## mysql server для локальной сети ##
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT