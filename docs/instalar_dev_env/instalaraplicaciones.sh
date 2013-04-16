#!/bin/bash 




###############
## Funciones ##
###############

function instalarParaCompilar(){
 apt-get install perl build-essential libexpat1-dev libgeo-ip-perl libssl-dev
}


function instalarConCpan(){
    #Instalar lo que no esta en paquete de debian
    cpan -i Catalyst::Plugin::Unicode::Encoding
    cpan -i Chart::OFC2 
}


function crearBaseDeDatos(){
    #Crear la base de datos
    mysql -h$HOST_BASE -u $USER --password=$PASSWD < $LUGAR/sql/matfel.sql
    for i in `130 $VERSION_ACTUAL`; do
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
                mysql --default-character-set=utf8 $BASE -u$USER --password=$PASSWD < $LUGAR/sql/sql.rev$i;
          fi;
    done;
}

function desarrollo(){
    mkdir /var/log/matfel
    echo '#!/bin/sh' >/usr/bin/matfel
    echo "perl $LUGAR/script/matfel_server.pl  -d -r  > /dev/null 2>/var/log/matfel/matfel.log &" >>/usr/bin/matfel
    chmod +x /usr/bin/matfel

}


function openvas(){
    ######################
    ## Instalar OpenVas ##
    ######################
    mkdir -p $LUGAR/openvas
    pushd $LUGAR/openvas

    wget http://download.opensuse.org/repositories/security:/OpenVAS:/STABLE:/v3/Debian_6.0/$ARCH/libopenvas3_3.1.4-1_$ARCH.deb
    wget http://download.opensuse.org/repositories/security:/OpenVAS:/STABLE:/v3/Debian_6.0/$ARCH/openvas-client_3.0.3-1_$ARCH.deb
    wget http://download.opensuse.org/repositories/security:/OpenVAS:/STABLE:/v3/Debian_6.0/$ARCH/openvas-scanner_3.1.1-1_$ARCH.deb
    dpkg -i *.deb
    popd
    
    ########################
    ## Configurar OpenVas ##
    ########################
    
    #Crear certificado del servidor
    openvas-mkcert
    
    #Agregar un usuario
    openvas-adduser

    #Bajar los plugins
    openvas-nvt-sync


    #Nikto - a web server scanning and testing tool
    nikto -update
}

function wapiti(){
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

function snortbarnyard(){

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
    #Poner el script para que arranque automaticamente
    cp $LUGAR/docs/instalador/aux/barnyard2 /etc/init.d/
    cp $LUGAR/docs/instalador/aux/matfelWeb /etc/init.d/
    chmod +x /etc/init.d/matfelWeb
    chmod +x /etc/init.d/barnyard2
    chmod +x $LUGAR/script/matfel_server.pl
    update-rc.d matfelWeb defaults
    update-rc.d barnyard2 defaults

    cp $PATH_INSTALL/docs/instalador/monitoreo /etc/apache2/sites-available
    echo NameVirtualHost *:3000 >> /etc/apache2/ports.conf
    echo Listen 3000 >> /etc/apache2/ports.conf
    a2ensite monitoreo
    a2enmod fcgid
    /etc/init.d/apache2 restart


}


















###########################
## Instalar dependencias ##
###########################
function dependencias(){
    
    aptitude update
    
    if [ $TIPO = "fuente" ]
    then
		instalarParaCompilar
		cpan -i CPAN
		echo "Primero vamos a configurar cpan para proceder con la instlalación de los distintos paquetes,"
		echo "esto NO es automático, deberá interactuar"
		echo "Cuando aparezca el shell interactivo debe introducir las siguientes 3 líneas"
		echo "o conf prerequisites_policy follow"
		echo "o conf commit"
		echo "exit"
		cpan 
		cpan -i Catalyst::Plugin::Unicode::Encoding
		cpan -i Catalyst::Plugin::Session::State::Cookie
		cpan -i Catalyst::Authentication::Realm::SimpleDB
		#Esto es para los reportes del Cron pero no se cambia el modulo desde el 2007, y ahora los test falla 1, por eso hay q forzarlo
		cpan -i -f Text::Report
		cd $LUGAR
		echo "el lugar es "$LUGAR
		#Bucar el arbol de directorios del proyecto
		perl Makefile.PL
		make installdeps
    	exit 1
    fi
    if [ $TIPO = "debian" ]
        then
        
        aptitude -y install sqlite3 libdbd-sqlite3-perl libcatalyst-perl \
            libcatalyst-modules-perl libdbix-class-timestamp-perl \
            libdatetime-format-sqlite-perl libconfig-general-perl \
            libhtml-formfu-model-dbic-perl libterm-readline-perl-perl \
            libdbix-class-encodedcolumn-perl libperl6-junction-perl \
            libtest-pod-perl libgeo-ip-perl libxml-rsslite-perl libgdchart-gd2-noxpm\
            build-essential nikto nmap w3af smbclient bzip2\
            libglib2.0-0 libgpgme11 libopenvas3 libpcap0.8 mysql-server\
            libmysqlclient-dev libpcap0.8-dev libapache2-mod-perl2 apache2-mpm-prefork\
            libcatalyst-engine-apache-perl apache2 libnet-smtp-ssl-perl libnet-smtp-tls-perl\
            libapache2-mod-fcgid subversion libmail-sendmail-perl  liburi-find-perl


    
        instalarConCpan
        openvas
        wapiti
        snortbarnyard
    fi               
	aptitude clean
	
}



if [ $# -ne 7 ]
then
    echo $# $1 $2 $3 $4 $5 $6 $7
    echo "FALLO  Utiliza: $(basename $0) directorio_donde_lo_queremos_instalar usuario_de_la_base password_de_la_base"
    exit 1
else
    ###############################
    ##  Variables para el scritp ##
    ###############################
    LUGAR=$1
    USER=$2
    PASSWD=$3
    HOST_BASE=$4
    BASE=$5
    TIPO=$6
    ARCH=$7
    VERSION_ACTUAL=$(cat $LUGAR/version)
    dependencias

    #############################
    ## Agregar configuraciones ##
    #############################
    crearBaseDeDatos
    firewall
    agregarInicio
fi

    

