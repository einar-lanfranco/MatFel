#!/usr/bin/perl
use strict;
use warnings;
use Tesis::Schema;
use Tesis::Model::DB;
use Fcntl qw(:flock);


sub getSchema
{
    my $db = Tesis::Model::DB->new();
    my $schema = Tesis::Schema->connect($db->connect_info->{'dsn'},$db->connect_info->{'user'},$db->connect_info->{'password'});
    return $schema;
}

sub getPreference
{
    my ($name)=@_;
    my $schema=getSchema();
    my $pref = $schema->resultset('Preferencia')->search({nombre => $name})->single;
    return $pref->valor;

}


open(LOG,">>".getPreference('log') );
*STDERR=*LOG;
*STDOUT=*LOG;


unless (!flock(DATA, LOCK_EX|LOCK_NB)) {

print localtime(time)." actualizar_alertas: Start\n";

	my $schema=getSchema();
    my $ultima_actualizacion=$schema->resultset('Preferencia')->find({nombre =>"ultima_actualizacion" });
    my @eventos= $schema->resultset('Snort_evento')->search({ timestamp => {'>=', $ultima_actualizacion->valor }});
    foreach my $evento (@eventos){
        my $ip_hdr= $schema->resultset('Snort_ipheader')->find({sid=>$evento->sid, cid=>$evento->cid});
        if($ip_hdr){
			#ip_src ip_dst
			my $servidor=$schema->resultset('Servidor')->find({ipv4=>$ip_hdr->get_ip_dst()});
			if (!$servidor) {
					   #quiere decir que no hay ningun ataque a ese servidor, me fijo si ese servidor genero
					   $servidor=$schema->resultset('Servidor')->find({ipv4=>$ip_hdr->get_ip_src()});
					}
			if ($servidor) {
			#tengo q agregar el alerta a la tabla de alertas
				 my $alerta = $schema->resultset('Alerta')->create({id_servidor=>$servidor->id, sid=> $evento->sid, cid=> $evento->cid});
				
			}
		}
    }
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $now= ($year+1900).'-'.($mon+1).'-'.$mday.' '.$hour.':'.$min.':'.$sec;
    my $preferencias = $schema->resultset('Preferencia');
    $preferencias->find_or_create({
        nombre => "ultima_actualizacion"
        })->update({
            valor => $now
    });

print localtime(time)." actualizar_alertas: End\n";


}else{
print localtime(time)." actualizar_alertas: YA ESTA CORRIENDO!!!\n";
}

close LOG;
exit 0;

#ESTA PARTE ES MUY IMPORTANTE, TIENE QUE IR AL FINAL

__DATA__
This exists so flock() code above works.
DO NOT REMOVE THIS DATA SECTION.

