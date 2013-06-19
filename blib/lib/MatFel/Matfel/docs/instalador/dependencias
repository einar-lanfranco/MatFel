apt-get update

apt-get -y install sqlite3 libdbd-sqlite3-perl libcatalyst-perl \
    libcatalyst-modules-perl libdbix-class-timestamp-perl \
    libdatetime-format-sqlite-perl libconfig-general-perl \
    libhtml-formfu-model-dbic-perl libterm-readline-perl-perl \
    libdbix-class-encodedcolumn-perl libperl6-junction-perl \
    libtest-pod-perl libgeo-ip-perl libxml-rsslite-perl\
    libgdchart-gd2-noxpm libnet-smtp-ssl-perl libnet-smtp-tls-perl\
    libapache2-mod-perl2 libapache2-mod-fcgid\
    libglib2.0-0 libgpgme11 libopenvas3 libpcap0.8\
    mysql-server subversion bzip2 nmap nikto w3af smbclient


apt-get clean



####Instalar OpenVas 4 ###########
echo "deb http://download.opensuse.org/repositories/security:/OpenVAS:/STABLE:/v4/Debian_5.0/ ./" >> /etc/apt/sources.list
apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys BED1E87979EAFD54

aptitude update
aptitude -y install  openvas-scanner openvas-client

#Crear certificado del servidor
openvas-mkcert -q

#Agregar un usuario
openvas-adduser

#Bajar los plugins
openvas-nvt-sync

####FIN Instalar OpenVas 4 ###########



#Instalar Snort y Barnyard2
apt-get install snort libmysqlclient-dev build-essential libpcap0.8-dev 
