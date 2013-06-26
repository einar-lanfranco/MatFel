#!/bin/bash 
###########
#Funciones#
###########
function instalar_MatFel(){
	bash instalarMatFel.sh $LUGAR $USER $PASSWD $HOST_BASE $BASE $USUARIOPASS $USUARIOBASE $VERSION_ACTUAL						 
}
function instalar_OpenVAS(){
	bash instalarOpenvas.sh $LUGAR
}
function instalar_Snort(){
	bash instalarSnort.sh $LUGAR $USER $PASSWD $HOST_BASE $BASE

}
function instalar_Firewall(){
	bash instalarOpenvas.sh $LUGAR
}

						
						
if [ $# -ne 8 ]
then
    echo $# $1 $2 $3 $4 $5 $6 $7 $8
    echo "FALLO  Utiliza: $(basename $0) directorio_donde_lo_queremos_instalar usuario_de_la_base password_de_la_base"
    exit 1
else
    #########################################
    ##  Seteo las Variables para el scritp ##
    #########################################
    LUGAR=$1
    USER=$2
    PASSWD=$3
    HOST_BASE=$4
    BASE=$5
    USUARIOPASS=$6
    USUARIOBASE=$7
    VERSION_ACTUAL=$(cat $LUGAR/version)
    echo "Para cumplimentar su funcionamiento MatFel utiliza OpenVAS y Snort, estas que pueden instalarse locales o remotas."
    echo "Adicionalmente esta la instalación de los fws clientes de MatFel"
    echo "Este script es genérico y lo asistirá en la instalacion de cualquiera o de todas las partes."
    LOOPEAR=1
    while [ $LOOPEAR -eq 1 ]; do
		select sn in "TODO" "MatFel" "OpenVAS" "Snort" "Firewall" "Salir"; do
				case $sn in
					TODO)
						echo "Instalaremos todo"
						instalar_MatFel
						instalar_OpenVAS
						instalar_Snort
						instalar_Firewall
						break;;
					MatFel)
						instalar_MatFel
						break;;
					OpenVAS)
						instalar_OpenVAS
						break;;
					Snort)
						instalar_Snort
						break;;
					Firewall)
						instalar_Firewall
						break;;
					Salir)
						LOOPEAR=0
						break;;
				esac
        done
    done
      
fi

###KNOWN BUGS
## No diferencia entre que falle la conexion a la base porque no esta la base de que no sirvan las credenciales al momento de la creacion
## En el sql.264 esta mal que se apunta a un lugar fijo para obetener un par de variables, hay una que es geoip-db que no tiene mas sentido
