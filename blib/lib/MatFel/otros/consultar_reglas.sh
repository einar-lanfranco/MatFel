#!/bin/sh
#wget --post-data 'username=admin&password=admin&submit=Entrar' http://192.168.56.101:3000/cron/generar_reglas -o iptables
wget http://192.168.56.101:3000/cron/generar_reglas -O iptables
sudo sh iptables
