#!/bin/bash 


###############
## Funciones ##
###############

function instalarOpenVAS(){
    echo "Tener en cuenta que este paso puede tener inconventientes ya que el openvas va cambiando al igual q las versiones disponibles para Debian"    
    read "AVISO!!! Se instalaran las dependencias de Openvas desde repos de ellos y el nikto que esta en la sección non-free de los repos de debian" ESPERA
    #########################
    ##Montar el repositorio##
    #########################
    echo "deb http://download.opensuse.org/repositories/security:/OpenVAS:/UNSTABLE:/v5/Debian_6.0/ ./" > /etc/apt/sources.list.d/openvas5.list
    ######################
    ## Instalar OpenVas ##
    ######################
	aptitude update
	aptitude install openvas-scanner openvas-cli libopenvas5 nikto
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
    #instalarWapiti
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


$LUGAR=$1
instalarOpenVAS

##Bugs conocidos, revisar si openvas-cli es necesario en una arquitectura distribuida
