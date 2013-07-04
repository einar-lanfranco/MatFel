#!/bin/bash 


###############
## Funciones ##
###############
function agregarBarnyardAlInicio(){
    cp $LUGAR/docs/instalador/aux/barnyard2 /etc/init.d/
    chmod +x /etc/init.d/barnyard2
    insserv barnyard2
    
}
function configurarBarnyard(){
	mkdir /etc/barnyard
	#Obtengo la placa de la conf de snort
    PLACA=$(cat /etc/snort/snort.debian.conf |grep INTERFACE| sed 's%.*="%%g'|sed 's/"//g')
    sed "s%placaRED%$PLACA%g" $LUGAR/docs/instalador/aux/barnyard2.conf > /etc/barnyard/barnyard2.conf
    echo "output database: alert, mysql, user=$USER password=$PASSWD dbname=$BASE host=$HOST_BASE" >> /etc/barnyard/barnyard2.conf
    mkdir /var/log/barnyard2 
  
}

function compilarBarnyard(){
    cd /usr/src/
    wget http://www.securixlive.com/download/barnyard2/barnyard2-1.9.tar.gz
    tar xzvf barnyard2-1.9.tar.gz
    cd barnyard2-1.9/
    #Ojo aca que esta solo funcionando con 32 bits, si se cambia probablemente haya que dambiar el directorio de las librerias de nysql para compliar..
    ./configure --with-mysql-libraries=/usr/lib/i386-linux-gnu/ 
    make
    make install
}

function configurarSnortParaBarnyard(){
	echo "Intentando autoconfigurar Snort para que use unfied2 como salida y desahbilitar el resto de los metodos"
	echo "Es recomendable verificarlo a mano en /etc/snort/snort.conf sólo debería existir un output"
	sed "s%output log_tcpdump: tcpdump.log%#output log_tcpdump: tcpdump.log%g" /etc/snort/snort.conf > /tmp/snort.conf
	sed "s%# output alert_unified2: filename snort.alert, limit 128, nostam%output alert_unified2:  filename snortunifed2.log, limit 128%g" /tmp/snort.conf > /etc/snort/snort.conf
}

function instalarBarnyard(){
	compilarBarnyard
	configurarBarnyard
	configurarSnortParaBarnyard
	agregarBarnyardAlInicio
}
function instalarSnort(){
    aptitude install snort libpcap-dev build-essential libmysqlclient-dev
    echo "La configuracion de snort la van a tener que tunear especificamente al sistema"
    echo "Utilizar dpkg-reconfigure snort y mirar los archivos /etc/snort/snort.conf y /etc/snort/snort.debian.conf" 
}

echo "Instalaremos Snort y Barnyard en su sistema"
LUGAR=$1
USER=$2
PASSWD=$3
HOST_BASE=$4
BASE=$5
instalarSnort
instalarBarnyard
echo "Instalación concluida"
