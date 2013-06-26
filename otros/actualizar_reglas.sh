#!/bin/bash

wget -q -O /tmp/iptables URLMATFEL/cron/generar_reglas 2>&1

if test ! -s /tmp/iptables
then
  echo No se generaron reglas nuevas
else
   mv /tmp/iptables /etc/network/if-up/matfelRecibidas
   chmod +x /etc/network/if-up/matfelRecibidas
   bash /etc/network/if-up/matfelRecibidas
fi
