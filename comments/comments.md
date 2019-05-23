#trouble with mounting
mount /dev/sr0 /media/cdrom

apt update
apt upgrade #To install Linux headers
apt install gcc
apt install make
cd /media/"username"/VBOX*
./VBoxLinuxAdditions.run
reboot

-------------------------------------------------------------------
#troubleshoot with mask config
#nano /etc/network/interfaces
 This file describes the network interfaces available on your system
and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

//# The loopback network interface
auto lo
iface lo inet loopback

//# The primary network interface
//# allow-hotplug enp0s3
//# iface enp0s3 inet dhcp
auto enp0s3
iface enp0s3 inet static
address 192.168.10.10
netmask 255.255.255.252
gateway 10.0.2.2

//#The Something
auto enp0s8
iface enp0s8 inet static
address 192.168.99.2
netmask 255.255.255.252
__________________________________________________________________

#SSH without passwd and using pubkeys
ssh-keygen

ssh u@ip -p {}
ssh-copy-id  u@ip -p {}

//config nano /etc/ssh/sshd_config
#Port 2288
#PermitRootLogin no
#PubkeyAuthentication yes

____________________________________________________________________
#IPATBLE config >> iptable.md

#fail2ban
https://vps.ua/wiki/install-linux-vps/security/configuring-fail2ban/


#IP TABLES KNOWLEDGEBASE

Whitelist/Blacklist Traffic by AddressPermalink
You can use iptables to block all traffic and then only allow traffic from certain IP addresses. These firewall rules limit access to specific resources at the network layer. Below is an example sequence of commands:

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -m comment --comment "Allow loopback connections" -j ACCEPT
iptables -A INPUT -p icmp -m comment --comment "Allow Ping to work as expected" -j ACCEPT

iptables -A INPUT -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -s 198.51.100.0 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
In the first command, the -s 192.168.1.0/24 statement specifies that all source IPs (-s) in the address space of 192.168.1 are allowed. You may specify an IP address range using CIDR (Classless Inter-Domain Routing) notation, or individual IP addresses, as in the second command. 
The third command allows all incoming and outgoing packets that are associated with existing connections. 
The final two commands set the default policy for all INPUT and FORWARD chains to drop all packets.
https://www.linode.com/docs/security/firewalls/control-network-traffic-with-iptables/
