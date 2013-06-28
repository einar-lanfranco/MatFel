#!/bin/bash 


###############
## Funciones ##
###############
function cron(){
	read -p "Ingrese la url de acceso a matfel incluyendo protoco y el puerto, Por ejemplo https://localhost:8000   " URL
    sed "s%URLMATFEL%$URL%g" $LUGAR/otros/actualizar_reglas.sh > /usr/bin/actualizar_reglas.sh
    echo "* * * * *   root    bash /usr/bin/actualizar_reglas.sh 2>&1" >>/etc/crontab
}


function firewall(){
    echo "Configurando FW"
    echo "Tenga en cuenta que la mayoría de las reglas está comentadas para no interferir con lo que esta en el sistema previamente. Descomentarlas es lo mas apropiado para establecer una política restricitva"
    #IPv6
    cp $LUGAR/docs/instalador/aux/ip6tables /etc/network/if-up.d/ip6tablesMatFel
    chmod +x /etc/network/if-up.d/ip6tablesMatFel
    #IPv4
    cp $LUGAR/docs/instalador/aux/iptables /etc/network/if-up.d/iptablesMatFel
    chmod +x /etc/network/if-up.d/iptablesMatFel
}

LUGAR=$1
echo "Instalaremos el Firewall recuerde que eso solo lo debe instalar en el servidor que lee las reglas de MatFel"
echo "Una vez instaldo el cron en el firewall tiene que tocar las preferencias del sistema de MatFel para permitir consultas de este equipo"
firewall
cron
