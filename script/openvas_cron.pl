#!/usr/bin/perl
use strict;
use warnings;
use OV;

open(LOG,">>".getPreference('log') );
*STDERR=*LOG;
*STDOUT=*LOG;

print localtime(time)." scan_run: Start\n";

my $schema=getSchema();
my $ov_scan;
    
my $sql='';
if (!$ARGV[0]){ 
# Sin argumento se busca los que estan en estado Inicial y se deben ejecutar en forma inmediata (U) 
$ov_scan = $schema->resultset('OV_scan')->search({estado => 'I',frecuencia=> 'U'}, {order_by => 'id'})
}
else {
# Se ejecutan los Diarios, Semanales o Mensuales
$ov_scan = $schema->resultset('OV_scan')->search({frecuencia=> $ARGV[0]}, {order_by => 'id'})
}

while (my $ov = $ov_scan->next) {
    $ov->estado('S');
    $ov->update;
###########################
    run_scan($ov->id);
##########################
    $ov->estado('F');
    $ov->update;
}

print localtime(time)." scan_run: Finish\n";
close LOG;

exit 0;
