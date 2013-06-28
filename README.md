Bienvenido a MatFel!
=====================

¿Qué es MatFel?
----------------

MatFel es un software que integra distintos productos de seguridad en software libre incluyendo el IDS Snort,
el Firewall NetFilter/Iptables y el analizador de vulnerabilidades OpenVas.
Esta integración esta realizada de manera de poder controlarla mediante una simple interfaz web.

¿Cómo esta escrito?
-------------------

En su mayoría MatFel esta desarrollado utilizando Perl apoyandonos en Catalyst Framework para el desarrollo.
En nuestras instalaciones utilizamos MySQL como motor de base de datos y Apache o Nginx o el propio Framework Catalyst como servidor Web.

¿Cómo funciona?
---------------

MatFel tiene 4 componentes principales: 
1- MatFel es la componente web del sistema que centraliza la inteligencia 
2- Snort, MatFel lee las alertas que genera el IDS y las parsea para tomar algun comportamiento, para ello lo que hacemos es que Snort a traves del Barnyard escriba en una base de datos que leerá Matfel.
3- OpenVas, el servidor de Openvas se puede instalar en cualquier lugar Matfel actua como cliente de OpenVas y le pide que realice pruebas, a traves de las respuestas se obtiene la información del usuario.
4- Firewalls, MatFel genera las reglas que configuraran los Firewalls

'''
Los 4 componentes de MatFel pueden instalarse en forma independiente en distintos equipos o en forma centralizada.
'''

ACTUALIDAD
En este momento estamos trabajando para liberar un instalador en bash automatico que permita que el usuario 
instale todo de una manera muy simple desde bash al menos para Debian y Ubuntu. De todas maneras existe 
documentación en la carpeta docs que puede facilitarle la instalación de todos los componentes y las 
dependencias que necesita para funcionar.



Run script/tesis_server.pl to test the application.
