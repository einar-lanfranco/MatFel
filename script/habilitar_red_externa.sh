En la maquina real
iptables -I FORWARD -i vboxnet0 -j ACCEPT
iptables -I FORWARD -o vboxnet0 -j ACCEPT 
iptables -t nat -I POSTROUTING -o wlan0 -j MASQUERADE 
echo 1 > /proc/sys/net/ipv4/ip_forward

En la virtual
route add default gw 192.168.56.1
