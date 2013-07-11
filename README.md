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

1. MatFel es la componente web del sistema que centraliza la inteligencia 
2. Snort, MatFel lee las alertas que genera el IDS y las parsea para tomar algun comportamiento, para ello lo que hacemos es que Snort a traves del Barnyard escriba en una base de datos que leerá Matfel.
3. OpenVas, el servidor de Openvas se puede instalar en cualquier lugar Matfel actua como cliente de OpenVas y le pide que realice pruebas, a traves de las respuestas se obtiene la información del usuario.
4. Firewalls, MatFel genera las reglas que configuraran los Firewalls


**Nota:** Hay que tener en cuenta que los 4 componentes de MatFel pueden instalarse en forma independiente en distintos equipos o en forma centralizada en uno solo, esto dependerá de las necesidades de cada usuario.


¿Cómo instalarlo?
-----------------

**INSTALADOR EN ETAPA DESARROLLO y TESTING**

El instalador actual esta siendo desarrollado para plataformas Debian, para otra distribución solo hay que cambiar la forma en que se invocan las dependencias en los scripts.

El aplicativo de instalación tiene 2 dependencias obligatorias que debe instalar el usuario: el cliente MySQL y git, y una opcional que no necesariamente es obligatoria si se usa una base en otro lugar, es el servidor de MySQL

Lo único que debe bajar el usuario es docs/instalador/instalar.exe (** Aclaración: el .exe no tiene nada que ver con los ejecutables de MS no se asusten** )

Solo debe descargarlo de github, ejecutarlo y el proceso lo llevará paso a paso:

Bajarlo:
```bash
wget https://github.com/einar-lanfranco/MatFel/blob/master/docs/instalador/instalar.exe
```
Ejecutarlo:
```bash
bash instalar.exe

```


¿Como usarlo?
-------------

Apuntar con un browser a **https://Nombre_o_IP_del_servidor** y allí utilizar usuario: **admin**  y password: **adminMatFel**
