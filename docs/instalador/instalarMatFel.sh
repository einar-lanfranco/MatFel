#!/bin/bash 


###############
## Funciones ##
###############

function configurarInicioApache(){
	#########################################
	#####"Hay que revisarlo"#################
	#########################################
	echo "Configurando el sistema para que meran se ejecute automaticamente como un servicio del sistema"
	##ESTO HAT QUE REVISARLO
	aptitude -y install libapache2-mod-perl2 apache2-mpm-prefork libcatalyst-engine-apache-perl apache2 libapache2-mod-fcgid
	#cp $LUGAR/docs/instalador/aux/matfelWeb /etc/init.d/
    	#chmod +x /etc/init.d/matfelWeb
    	#chmod +x $LUGAR/script/matfel_server.pl
    	#update-rc.d matfelWeb defaults
	cp $PATH_INSTALL/docs/instalador/monitoreo /etc/apache2/sites-available
	echo NameVirtualHost *:3000 >> /etc/apache2/ports.conf
	echo Listen 3000 >> /etc/apache2/ports.conf
	a2ensite monitoreo
	a2enmod fcgid
	/etc/init.d/apache2 restart
}


function instalarConCpan(){
    #Instalar lo que no esta en paquete de debian
    cpan -i Chart::OFC2 
}


function desarrollo(){
    mkdir /var/log/matfel
    echo '#!/bin/sh' >/usr/bin/matfel
    echo "perl $LUGAR/script/matfel_server.pl  -d -r  > /dev/null 2>/var/log/matfel/matfel.log &" >>/usr/bin/matfel
    chmod +x /usr/bin/matfel
    echo "El sistema nunca se ejecutará automáticamete, usted tendrá que invocarlo en una consola como /usr/bin/matfel y los logs los podrá visualizar en  /var/log/matfel/matfel.log"
    echo "Apunte con un browser al puerto 3000 de este equipo y ya podra utilizar MatFel"
}


function configurarInicioNginx(){
	echo "Configurando el sistema para que meran se ejecute automaticamente como un servicio del sistema mediante nginx"
	aptitude -y install nginx libfcgi-procmanager-perl
	sed "s%LUGAR%$LUGAR%g" $LUGAR/docs/instalador/aux/matfelfcgi > /etc/init.d/matfelfcgi
	chmod +x /etc/init.d/matfelfcgi
	insserv matfelfcgi
    cp $LUGAR/docs/instalador/aux/nginx /etc/nginx/sites-available/matfel
	ln -s /etc/nginx/sites-available/matfel /etc/nginx/sites-enabled/matfel 
   	cp -a $LUGAR/docs/instalador/aux/ssl /etc/nginx/
   	/etc/init.d/matfelfcgi start
	/etc/init.d/nginx restart
}



function instalarParaCompilar(){
 aptitude install perl build-essential libexpat1-dev libgeo-ip-perl libssl-dev
}

function configurarInicio(){
echo "Eligiremos el servidor web a utilizar"
select sn in "Nginx" "Nada"; do
            case $sn in
                Nginx ) echo "Configurando Nginx";
                        configurarInicioNginx
                        break;;
                Nada ) ITIPO="des";
                        echo "No hay nada implementado aun"
                        break;;
            esac
        done

}
function configurarBDDMatfel()
{
	CONFIGURACION="$LUGAR/lib/MatFel/Model/DB.pm"
	sed "s%dbi:mysql:tesis%dbi:mysql:$BASE%g" $CONFIGURACION > /tmp/DB.pm
	sed "s%tesis%$USUARIOBASE%g" /tmp/DB.pm > /tmp/DB1.pm
	sed "s%test%$USUARIOPASS%g" /tmp/DB1.pm > $CONFIGURACION
}

function crearBaseDeDatos(){
    echo "Creamos  la base de datos $BASE en el $HOST_BASE"
    mysql -h$HOST_BASE -u $USER --password=$PASSWD -e "set names utf8; create database $BASE; GRANT ALL ON $BASE.* to $USUARIOBASE@localhost identified by '$USUARIOPASS';"
    mysql $BASE --default-character-set=utf8 -h$HOST_BASE -u $USER --password=$PASSWD < $LUGAR/sql/matfel.sql
    echo "la version actual es ".$VERSION_ACTUAL
    for i in $(seq 130 $VERSION_ACTUAL); do
          if [ -e $LUGAR/sql/sql.rev$i ]; then
                echo "Aplicando sql.rev$i";
                mysql -h$HOST_BASE --default-character-set=utf8 $BASE -u$USER --password=$PASSWD < $LUGAR/sql/sql.rev$i;
          fi;
    done;
    configurarBDDMatfel
}

function actualizarbasededatos(){
    #Actualizar la base de datos
    VERSION_INSTALADA=$(mysql $BASE -h$HOST_BASE -u$USER --password=$PASSWD -e "select valor from preferencia where nombre = 'version'")
    for i in `$VERSION_INSTALADA $VERSION_ACTUAL`; do
                echo "Aplicando sql.rev$i";
          if [ -e $LUGAR/sql/sql.rev$i ]; then
                mysql -h$HOST --default-character-set=utf8 $BASE -u$USER --password=$PASSWD < $LUGAR/sql/sql.rev$i;
          fi;
    done;
    mysql $BASE -h$HOST_BASE -u$USER --password=$PASSWD -e "update preferencia set valor="$VERSION_ACTUAL" where nombre = 'version'"
    
}

########################################################
#Estas dependencias hay que forzarlas para que instalen#
########################################################

function instalarDependenciasConProblemas(){
	#Esto es para los reportes del Cron pero no se cambia el modulo desde el 2007, y ahora los test falla 1, por eso hay q forzarlo
	aptitude install make
	cpan -i -f Text::Report
	
	}


###########################
## Instalar dependencias ##
###########################
function dependenciasPerl(){
		echo "Instalaremos las dependencias desde $TIPO"
		aptitude update
		cpan -i CPAN
		if [ $TIPO = "fuente" ]
			then
				instalarParaCompilar
				echo "Primero vamos a configurar cpan para proceder con la instlalación de los distintos paquetes,"
				echo "esto NO es automático, deberá interactuar"
				echo "Cuando aparezca el shell interactivo debe introducir las siguientes 3 líneas"
				echo "o conf prerequisites_policy follow"
				echo "o conf commit"
				echo "exit"
				cd $LUGAR
				echo "el lugar es "$LUGAR
				#Bucar el arbol de directorios del proyecto
				perl Makefile.PL
				make installdeps
				exit 1
		fi
		if [ $TIPO = "debian" ]
		then
				aptitude -y install libcatalyst-perl \
				libcatalyst-modules-perl libcatalyst-engine-apache-perl libcatalyst-plugin-unicode-encoding-perl \
				libdatetime-perl libxml-rss-perl libdate-calc-perl libtest-pod-perl libgeo-ip-perl \
				libmail-sendmail-perl libnet-smtp-ssl-perl libnet-smtp-tls-perl liburi-find-perl \
				libdbix-class-encodedcolumn-perl libdbix-class-timestamp-perl libdate-manip-perl \
				libxml-rsslite-perl libtest-differences-perl libmoosex-strictconstructor-perl libhtml-formfu-model-dbic-perl
       			instalarConCpan
			        #Esto que esta comentado no se si es necesario inicialmente
				#~ libcatalyst-engine-apache-perl   sqlite3 libdbd-sqlite3-perl\
				#~ libdatetime-format-sqlite-perl libconfig-general-perl \
            			#~ libhtml-formfu-model-dbic-perl libterm-readline-perl-perl \
				#~ libperl6-junction-perl \
				#~ libgdchart-gd2-noxpm\
				# build-essential nikto nmap w3af smbclient bzip2\
				#~ libglib2.0-0 libgpgme11 libopenvas3 libpcap0.8 mysql-server\
				#~ libmysqlclient-dev libpcap0.8-dev libapache2-mod-perl2 apache2-mpm-prefork\
				#~ apache2 libapache2-mod-fcgid subversion   
	    	fi     
		aptitude clean
		instalarDependenciasConProblemas
		
}



if [ $# -ne 8 ]
then
    echo $# $1 $2 $3 $4 $5 $6 $7 $8 
    echo "FALLO  Utiliza: $(basename $0) directorio_donde_lo_queremos_instalar usuario_de_la_base password_de_la_base HOST_BASE USUARIO_privilegiado_BASE  PASS_privilegiado_BASE VERSION_actual"
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
    VERSION_ACTUAL=$8
    echo "Quiere compilar todos los módulos de perl para este sistema o utilizará los empaquetados de Debian/Ubuntu?"
    select sn in "Fuente" "Debian"; do
            case $sn in
                Debian ) echo "Instaladando desde los paquetes de Debian";
                        TIPO="debian";
                        break;;
                Fuente ) TIPO="fuente";
                        echo "Instalando desde las Fuentes, vamos a compilar todo";
                        break;;
            esac
     done
    ####################################
    ##Instalo las dependencias de Perl##
    ####################################
    dependenciasPerl
    #############################
    ## Creo la base de datos   ##
    #############################
    crearBaseDeDatos
    #################################
    ## Instalamos Msource de Matfel##
    #################################
    echo "¿Usted quiere instalar MatFel como un sistema en producción o lo va a utilizar para desarrollar sobre el?"
    select sn in "Producción" "Desarrollo"; do
            case $sn in
                Producción ) echo "Ambiente de Producción - Debian";
                        configurarInicio
                        break;;
                Desarrollo ) ITIPO="des";
                        desarrollo
                        break;;
            esac
    done
     
fi

###KNOWN BUGS
## No considera que no exista Mysql-client, entonces ni bien arranca falla el script    
## No diferencia entre que falle la conexion a la base porque no esta la base de que no sirvan las credenciales al momento de la creacion
## En el sql.264 esta mal que se apunta a un lugar fijo para obetener un par de variables, hay una que es geoip-db que no tiene mas sentido
