#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
use strict;
use warnings;
use OV;
use Fcntl qw(:flock);

unless (!flock(DATA, LOCK_EX|LOCK_NB)) {

open(LOG,">>".getPreference('log') );
*STDERR=*LOG;
*STDOUT=*LOG;

print localtime(time)." Escaneo Inmediato: Start\n";

my $schema=getSchema();
my $ov_scan;
    
my $sql='';

# Se ejecutan los Mensuales
$ov_scan = $schema->resultset('OV_scan')->search({frecuencia=> 'U', estado => {'!=' => 'S'}}, {order_by => 'id'});

  my @all_scans=$ov_scan->all;
 #Pongo todo en Scanning antes para que nos e vuelvan a ejecutar
foreach my $ov  (@all_scans) {
print $ov->id_servidor->ipv4."\n";
    $ov->estado('S');
    $ov->update;
  }
#Recorremos por 2da vez
  foreach my $ov  (@all_scans) {
    print localtime(time)."=> *** Ejecutando Escaneo Inmediato: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***\n";
###########################
    run_scan($ov->id);
##########################
    print localtime(time)."=> *** Escaneo Finalizado Inmediato: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***\n";
    $ov->estado('F');
    $ov->update;
}

print localtime(time)." Escaneo Inmediato: Finish\n";

close LOG;
exit 0;


}else{
print localtime(time)." Escaneo Inmediato: YA ESTA CORRIENDO!!!\n";
}

#ESTA PARTE ES MUY IMPORTANTE, TIENE QUE IR AL FINAL

__DATA__
This exists so flock() code above works.
DO NOT REMOVE THIS DATA SECTION.

