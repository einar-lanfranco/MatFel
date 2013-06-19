#!/bin/sh

wget -q -O /tmp/iptables http://127.0.0.1:3000/cron/generar_reglas 2>&1

if test ! -s /tmp/iptables
then
  echo No se generaron reglas nuevas
else
   cp /tmp/iptables /etc/iptables
   sh /etc/iptables
fi
