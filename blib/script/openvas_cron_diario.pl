#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
use strict;
use warnings;
use OV;
use Fcntl qw(:flock);

open(LOG,">>".getPreference('log') );
*STDERR=*LOG;
*STDOUT=*LOG;

unless (!flock(DATA, LOCK_EX|LOCK_NB)) {

print localtime(time)." Escaneo Diario: Start\n";

my $schema=getSchema();
my $ov_scan;
    
my $sql='';

# Se ejecutan los Diarios
$ov_scan = $schema->resultset('OV_scan')->search({frecuencia=> 'D', estado => {'!=' => 'S'}}, {order_by => 'id'});

  my @all_scans=$ov_scan->all;
 #Pongo todo en Scanning antes para que nos e vuelvan a ejecutar
foreach my $ov  (@all_scans) {
print $ov->id_servidor->ipv4."\n";
    $ov->estado('S');
    $ov->update;
  }
#Recorremos por 2da vez
  foreach my $ov  (@all_scans) {
    print localtime(time)."=> *** Ejecutando Escaneo Diario: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***\n";
###########################
    run_scan($ov->id);
##########################
    print localtime(time)."=> *** Escaneo Finalizado Diario: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***\n";
    $ov->estado('F');
    $ov->update;
}

print localtime(time)." Escaneo Diario: Finish\n";

}else{
print localtime(time)." Escaneo Diario: YA ESTA CORRIENDO!!!\n";
}

close LOG;
exit 0;

#ESTA PARTE ES MUY IMPORTANTE, TIENE QUE IR AL FINAL

__DATA__
This exists so flock() code above works.
DO NOT REMOVE THIS DATA SECTION.

