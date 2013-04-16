package Tesis::Controller::Utilidades;

use strict;
use warnings;

use Geo::IP;
use Geo::IP::Record;


=item

    sub marcar_cambio
        Esta funcion se invoca cuando se realiza un cambio que indica que se han modificado las reglas del firewall, por lo que es necesario que se regeneren y se vuelvan a aplicar
    
=cut
sub marcar_cambio {
 my ($c)=@_;
 my $preferencias = $c->model('DB::Preferencia');
 $preferencias->find_or_create({
    nombre => "reload_firewall"
})->update({
    valor => "1"
});
return 1;

}
=item

    sub marcar_actualizacion
        Esta funcion se invoca cuando se realiza una actualizacion de las alertas, se setea la variable ultima_actualizacion con el timestamp del ùltimo evento procesado
    
=cut
sub marcar_actualizacion {
 my ($c,$timestamp)=@_;
 my $preferencias = $c->model('DB::Preferencia');
 $preferencias->find_or_create({
    nombre => "ultima_actualizacion"
})->update({
    valor => $timestamp
});
return 1;

}

=item

    sub buscar registro Geo::IP
        Esta funcion busca la localización geográfica a partir de una IP
    
=cut

my $geoip_db=0;

sub get_geo_db {
 my ($c)=@_;

  if (!$geoip_db){
      my $pref;
      if($c){
         $pref= $c->model('DB::Preferencia');
      }
      else{
           my $model = Tesis::Model::DB->new();
         $pref= $model->resultset('Preferencia');
      }
    $geoip_db = $pref->find({nombre => "geoip-db"})->valor;
  }
return $geoip_db;
}

sub get_geo_ip {
 my ($ip,$c)=@_;

  my $record =0;
  if ($ip){
    my $db= get_geo_db($c);
    if($db){
      my $gi = Geo::IP->open($db, GEOIP_STANDARD);   
      $record = $gi->record_by_addr($ip);
    }
  }
  return($record);
}



=head2 esta_trafico_entrada_bloqueado
    
    esta_trafico_entrada_bloqueado chequea si esta el trafico a un puerto bloqueado de un servidor 
    
=cut
    
sub esta_trafico_entrada_bloqueado {
  my ($schema,$id_servidor, $port, $proto) = @_;
  
        my $protocolo=$schema->resultset('Protocolo')->find({nombre => $proto , firewall => 1});
        my $teb = $schema->resultset('Trafico_entrada_bloqueado')->find({
                    id_servidor   => $id_servidor,
                    protocolo => $protocolo->id(),
                    puerto  => $port,
                    ip_origen   => '0.0.0.0',
                    mascara_origen   => '0.0.0.0',
                });
      if ($teb) {return $teb->id;}
      else {return 0;}
}

=head2 esta_trafico_entrada_a_ip_bloqueado
    
    esta_trafico_entrada_a_ip_bloqueado chequea si esta el trafico entrante de un puerto a una ip bloqueado de un servidor 
    
=cut
    
sub esta_trafico_entrada_a_ip_bloqueado {
  my ($schema,$id_servidor, $ip , $port, $proto) = @_;

      my $protocolo=$schema->resultset('Protocolo')->find({nombre => $proto , firewall => 1});
      my $teb = $schema->resultset('Trafico_entrada_bloqueado')->find({
                    id_servidor   => $id_servidor,
                    protocolo => $protocolo->id(),
                    puerto  => $port,
                    ip_origen   => Tesis::Controller::Utilidades::dec2dot($ip),
                    mascara_origen   => '255.255.255.255',
                }) ;
      if ($teb) {return $teb->id;}
      else {return 0;}
}

=head2 esta_trafico_salida_a_ip_bloqueado
    
    esta_trafico_salida_a_ip_bloqueado chequea si esta el trafico saliente de un puerto a una ip bloqueado de un servidor 
    
=cut
    
sub esta_trafico_salida_a_ip_bloqueado {
  my ($schema,$id_servidor, $ip , $port, $proto) = @_;

      my $protocolo=$schema->resultset('Protocolo')->find({nombre => $proto , firewall => 1});
      my $tsb = $schema->resultset('Trafico_salida_bloqueado')->find({
                    id_servidor   => $id_servidor,
                    protocolo => $protocolo->id(),
                    puerto  => $port,
                    ip_destino   => Tesis::Controller::Utilidades::dec2dot($ip),
                    mascara_destino   => '255.255.255.255',
                });

      if ($tsb) {return $tsb->id;}
      else {return 0;}
}


=head2 dot2dec
    
    Rutina auxiliar que transforma ip desde formato . a formato decimal
    
=cut
sub dot2dec {
         my $address = $_[0];
         my ($a, $b, $c, $d) = split '\.', $address;
         my $decimal = $d + ($c * 256) + ($b * 256**2) + ($a * 256**3);
         return $decimal;
          }

=head2 dot2dec
    
    Rutina auxiliar que transforma ip desde formato decimal a formato .
    
=cut

sub dec2dot {
    my ($address) = @_;
    my $d = $address % 256; 
        $address -= $d; 
        $address /= 256;
    my $c = $address % 256; 
        $address -= $c; 
        $address /= 256;
    my $b = $address % 256; 
        $address -= $b; 
        $address /= 256;
    my $a = $address;
    my $dotted="$a.$b.$c.$d";
    return $dotted;
}
1;
