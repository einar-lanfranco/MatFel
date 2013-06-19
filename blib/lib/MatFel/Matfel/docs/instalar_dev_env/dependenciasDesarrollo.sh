apt-get update
apt-get install perl build-essential libexpat1-dev libgeo-ip-perl libssl-dev
apt-get clean


cpan -i CPAN
cpan
cpan> o conf prerequisites_policy follow
cpan> o conf commit
cpan -i Catalyst::Plugin::Unicode::Encoding
cpan -i Catalyst::Plugin::Session::State::Cookie
cpan -i Catalyst::Authentication::Realm::SimpleDB
#Esto es para los reportes del Cron pero no se cambia el modulo desde el 2007, y ahora los test falla 1, por eso hay q forzarlo
cpan -i -f Text::Report


#Bucar el arbol de directorios del proyecto
perl MakeFile.PL
make installdeps



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
