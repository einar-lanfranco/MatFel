#!/bin/bash 


###############
## Funciones ##
###############


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
}


function instalarSnort(){

    cd /usr/src/
    wget http://www.securixlive.com/download/barnyard2/barnyard2-1.9.tar.gz
    tar xzvf barnyard2-1.9.tar.gz
    cd barnyard2-1.9/
    ./configure --with-mysql-libraries=/usr/lib/
    make
    make install
    #Luego configurar y ejecutar barnyard2:
    cp $LUGAR/docs/instalador/aux/snort.conf /etc/snort/
    cp $LUGAR/docs/instalador/aux/barnyard2.conf /etc/
    mkdir /var/log/barnyard2
    #echo '#!/bin/sh' > /usr/bin/barnyard2
    #echo "barnyard2 -c /etc/barnyard2.conf -d /var/log/snort -f snortunifed2.log -w /var/log/snort/snort.waldo > /dev/null 2>/var/log/matfel/matfel.log &">> /usr/bin/barnyard2
    #chmod +x /usr/bin/barnyard2

}

function firewall(){
    #Configurar FW
    #IPv6
    cp $LUGAR/docs/instalador/aux/ip6tables /etc/network/if-up.d/
    chmod +x /etc/network/if-up.d/ip6tables
    #IPv4
    cp $LUGAR/docs/instalador/aux/iptables /etc/network/if-up.d/
    chmod +x /etc/network/if-up.d/iptables
}

function agregarInicio(){
    update-rc.d barnyard2 defaults
	cp $LUGAR/docs/instalador/aux/barnyard2 /etc/init.d/
    chmod +x /etc/init.d/barnyard2
}



###LO QUE ESTA ABAJO DE ESTA LINEA ESTA LISTO

function instalarOpenVAS(){
    echo "Tener en cuenta que este paso puede tener inconventientes ya que el openvas va cambiando al igual q las versiones disponibles para Debian"    
    #########################
    ##Montar el repositorio##
    #########################
    echo "deb http://download.opensuse.org/repositories/security:/OpenVAS:/UNSTABLE:/v5/Debian_6.0/ ./" > /etc/apt/sources.list.d/openvas5.list
    ######################
    ## Instalar OpenVas ##
    ######################
	apt-get update
    apt-get install openvas-scanner openvas-cli libopenvas5 nikto
    ########################
    ## Configurar OpenVas ##
    ########################
    
    #Crear certificado del servidor
    openvas-mkcert
    
    #Agregar un usuario
    openvas-adduser

    #Bajar los plugins
    read "AVISO!!! Se actualizarán los plugins de openvas, esto puede demorar un buen rato (Presione Enter para continuar)" ESPERA
    openvas-nvt-sync
    

    #Nikto - a web server scanning and testing tool
    nikto -update
    instalarWapiti
}


function configurarInicio(){
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

function instalarParaCompilar(){
 aptitude install perl build-essential libexpat1-dev libgeo-ip-perl libssl-dev
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
}

function actualizarbasededatos(){
    #Actualizar la base de datos
    VERSION_INSTALADA=$(mysql $BASE -h$HOST_BASE -u$USER --password=$PASSWD -e "select valor from preferencia where nombre = 'version'")
    for i in `$VERSION_INSTALADA $VERSION_ACTUAL`; do
          if [ -e $LUGAR/sql/sql.rev$i ]; then
                echo "Aplicando sql.rev$i";
                mysql -h$HOST --default-character-set=utf8 $BASE -u$USER --password=$PASSWD < $LUGAR/sql/sql.rev$i;
          fi;
    done;
    mysql $BASE -h$HOST_BASE -u$USER --password=$PASSWD -e "update preferencia set valor="$VERSION_ACTUAL" where nombre = 'version'"
    
}


function instalarWapiti(){
    #Wapiti - Web application vulnerability scanner / security auditor --> 2
    echo "Procesando Wapiti"
    cd $LUGAR/script
    wget http://ufpr.dl.sourceforge.net/project/wapiti/wapiti/wapiti-2.2.1/wapiti-2.2.1.tar.bz2
    tar xjvf wapiti-2.2.1.tar.bz2
    
    #Crear un script /usr/bin/wapiti
    echo '#!/bin/sh' > /usr/bin/wapiti
    echo "cd $LUGAR/script/wapiti-2.2.1/src/" >> /usr/bin/wapiti
    echo 'python wapiti.py $*' >> /usr/bin/wapiti
    chmod +x /usr/bin/wapiti
}


########################################################
#Estas dependencias hay que forzarlas para que instalen#
########################################################

funcion dependenciasConProblemas(){
	#Esto es para los reportes del Cron pero no se cambia el modulo desde el 2007, y ahora los test falla 1, por eso hay q forzarlo
	aptitude install make
	cpan -i -f Text::Report
	
	}


###########################
## Instalar dependencias ##
###########################
function dependenciasPerl(){
	echo "Instalaremos las dependencias desde $TIPO"
    #EINAR Comentado porque tarda mucho
    #aptitude update
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
            libxml-rsslite-perl libtest-differences-perl libmoosex-strictconstructor-perl
            
            #Esto que esta comentado no se si es necesario inicialmente
            #~ libcatalyst-engine-apache-perl   sqlite3 libdbd-sqlite3-perl\
            #~ libdatetime-format-sqlite-perl libconfig-general-perl \
            #~ libhtml-formfu-model-dbic-perl libterm-readline-perl-perl \
             #~ libperl6-junction-perl \
              #~ libgdchart-gd2-noxpm\
            #~ build-essential nikto nmap w3af smbclient bzip2\
            #~ libglib2.0-0 libgpgme11 libopenvas3 libpcap0.8 mysql-server\
            #~ libmysqlclient-dev libpcap0.8-dev libapache2-mod-perl2 apache2-mpm-prefork\
             #~ apache2 
            #~ libapache2-mod-fcgid subversion   
       instalarConCpan
    fi     
   ###############################
   #Listo las dependencias de Perl
   ###############################           
	aptitude clean
	instalarDependenciasConProblemas
}



if [ $# -ne 9 ]
then
    echo $# $1 $2 $3 $4 $5 $6 $7 $8 $9
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
    TIPO=$6
    ARCH=$7
    USUARIOPASS=$8
    USUARIOBASE=$9
    VERSION_ACTUAL=$(cat $LUGAR/version)
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
    echo "Para cumplimentar su funcionamiento MatFel utiliza OpenVAS y Snort, estas que pueden instalarse locales o remotas."
    echo "Si las instala remotamente tendrá que modificar la configuración, este script da las armas para hacerlo local"
    exit
    select sn in "Instalar Snort" "Sin Snort"; do
            case $sn in
                Instalar\ Snort ) echo "Con Snort";
                        instalarSnort
                        break;;
                Sin\ Snort ) 
                        echo "No instalaremos Snort ";
                        break;;
            esac
        done
     
	select sn in "Instalar OpenVAS" "Sin OpenVAS"; do
            case $sn in
                Instalar\ OpenVAS ) echo "Instalaermos OpenVAS";
                        instalarOpenVAS
                        break;;
                Sin\ OpenVAS ) 
                        echo "No instalaremos OpenVAS";
                        break;;
            esac
        done
    
    
fi

###KNOWN BUGS
## No considera que no exista Mysql-client, entonces ni bien arranca falla el script    

