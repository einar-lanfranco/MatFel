package Tesis::Controller::Cron;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use OV;

=head1 NAME

Tesis::Controller::Cron - Catalyst Controller

=head1 DESCRIPTION

La idea es que a partir de Cron podamos ejecutar todo lo que va a tener que ir en el cron

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Tesis::Controller::Cron.');
}

sub generar_regla {
    
    my($ip_o,$prot,$puerto_o,$ip_d,$puerto_d,$state,$policy)= @_;
    if (($puerto_o eq 'any')&&($puerto_d eq 'any')){
        return ("iptables -A TESIS -s $ip_o -p $prot -m state --state $state -j $policy\n");
                }
    elsif($puerto_o eq 'any'){
        return ("iptables -A TESIS -s $ip_o -d $ip_d -p $prot --dport $puerto_d -m state --state $state -j $policy\n");}
    elsif($puerto_d eq 'any'){
        return ("iptables -A TESIS -s $ip_o -d $ip_d -p $prot --sport $puerto_o -m state --state $state -j $policy\n");
    }
    
    
    }
sub generar_regla_limpiar_firewall {
      
    my $limpiar_fw = "# REGLAS PARA LIMPIAR EL FIREWALL\n";
       $limpiar_fw.= "iptables -F TESIS;\n";
    return ($limpiar_fw);

    }
    

sub generar_reglas : Local {
    my ( $self, $c ) = @_;

    $c->log->debug("*** Generar Reglas ***");

    my @reload_firewall = $c->model('DB::Preferencia')->search({nombre =>"reload_firewall" });
    my @ip_firewall=$c->model('DB::Preferencia')->search({nombre =>"ip_firewall" });
    #FIXME para permitir multiples firewalls
    $c->res->content_type('text/plain');
    $c->res->header('Content-Disposition' =>"attachment; filename=reglas.txt");
    my $reglas='';

      $c->log->debug("Reload FW: ".$reload_firewall[0]->valor());
      $c->log->debug("Dir IP: ".$ip_firewall[0]->valor." = ".$c->req->address());

    if (($reload_firewall[0]->valor())  && ($ip_firewall[0]->valor eq $c->req->address())) {


    $c->log->debug("*** SE REGENERAN LAS REGLAS ***");

        $reglas=generar_regla_limpiar_firewall();
	#obtener toda la lista de servidores
        my @servidores=$c->model('DB::Servidor')->search({habilitado=>'1'});
        #por servidor obetener trafico salida asociado
        foreach my $servidor (@servidores) {

              $c->log->debug("PROCESANDO EL SERVIDOR: ".$servidor->nombre_dir);

            my $trafico_entrada_habilitado=$servidor->trafico_entrada_habilitado();
            my $trafico_salida_habilitado=$servidor->trafico_salida_habilitado();
            my $trafico_entrada_bloqueado=$servidor->trafico_entrada_bloqueado();
            my $trafico_salida_bloqueado=$servidor->trafico_salida_bloqueado();


            if($trafico_entrada_habilitado->count || $trafico_salida_habilitado->count||$trafico_entrada_bloqueado->count || $trafico_salida_bloqueado->count){

              $c->log->debug("REGLAS DEL SERVIDOR: ".$servidor->nombre_dir);
              $reglas.= "\n#### REGLAS DEL SERVIDOR: ".$servidor->nombre_dir." ####\n";
              
              if($trafico_entrada_bloqueado->count){
                $reglas.= "# TRAFICO BLOQUEADO ENTRANTE \n";
                while ( my $trafico_entrante = $trafico_entrada_bloqueado->next ) {
                    $reglas=$reglas.generar_regla($trafico_entrante->ip_origen(), $trafico_entrante->protocolo->nombre(),"any",$servidor->ipv4(), $trafico_entrante->puerto(), $trafico_entrante->estado->estado(),'DROP');
                }
              }

              if($trafico_salida_bloqueado->count){
                $reglas.= "# TRAFICO BLOQUEADO SALIENTE \n";
                #por servidor obtener el trafico de salida que se va a asociar
                while ( my $trafico_saliente = $trafico_salida_bloqueado->next ) {
                    $reglas=$reglas.generar_regla($servidor->ipv4(), $trafico_saliente->protocolo->nombre(),"any",$trafico_saliente->ip_destino(), $trafico_saliente->puerto(), $trafico_saliente->estado->estado(),'DROP');
                }
              }

              if($trafico_entrada_habilitado->count){
                $reglas.= "# TRAFICO ENTRANTE \n";
                while ( my $trafico_entrante = $trafico_entrada_habilitado->next ) {
                    $reglas=$reglas.generar_regla($trafico_entrante->ip_origen(), $trafico_entrante->protocolo->nombre(),"any",$servidor->ipv4(), $trafico_entrante->puerto(), $trafico_entrante->estado->estado(),'ACCEPT');
                }
              }

              if($trafico_salida_habilitado->count){
                $reglas.= "# TRAFICO SALIENTE \n";
                #por servidor obtener el trafico de salida que se va a asociar
                while ( my $trafico_saliente = $trafico_salida_habilitado->next ) {
                    $reglas=$reglas.generar_regla($servidor->ipv4(), $trafico_saliente->protocolo->nombre(),"any",$trafico_saliente->ip_destino(), $trafico_saliente->puerto(), $trafico_saliente->estado->estado(),'ACCEPT');
                }
              }
              
            } else {
              $c->log->debug("NO HAY REGLAS PARA EL SERVIDOR: ".$servidor->nombre_dir);
              $reglas.= "\n#### NO HAY REGLAS PARA EL SERVIDOR: ".$servidor->nombre_dir." ####\n";
            }
         }
    }
    my $preferencias = $c->model('DB::Preferencia');
    $preferencias->find_or_create({
        nombre => "reload_firewall"
        })->update({
            valor => "0"
    });

    $c->res->output($reglas);
}

sub actualizar_alertas : Local {
    my ( $self, $c ) = @_;
    my $ultima_actualizacion=$c->model('DB::Preferencia')->find({nombre =>"ultima_actualizacion" });
    my @eventos=$c->model('DB::Snort_evento')->search({ timestamp => {'>=', $ultima_actualizacion->valor }});
    foreach my $evento (@eventos){
        my $ip_hdr=$c->model('DB::Snort_IPheader')->find({sid=>$evento->sid, cid=>$evento->cid});
        #ip_src ip_dst
        my $servidor=$c->model('DB::Servidor')->find({ipv4=>$ip_hdr->get_ip_dst()});
        if (!$servidor) {
                   #quiere decir que no hay ningun ataque a ese servidor, me fijo si ese servidor genero
                   $servidor=$c->model('DB::Servidor')->find({ipv4=>$ip_hdr->get_ip_src()});
                }
        if ($servidor) {
        #tengo q agregar el alerta a la tabla de alertas
             my $alerta = $c->model('DB::Alerta')->create({id_servidor=>$servidor->id, sid=> $evento->sid, cid=> $evento->cid});
            
        }
    }
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $now= ($year+1900).'-'.($mon+1).'-'.$mday.' '.$hour.':'.$min.':'.$sec;
    my $preferencias = $c->model('DB::Preferencia');
    $preferencias->find_or_create({
        nombre => "ultima_actualizacion"
        })->update({
            valor => $now
    });

        # Set the template
        $c->stash->{template} = 'cron/mensaje.tt2';
	$c->stash->{status_msg} = "Alertas actualizadas ($now).";

}

sub procesar_openvas : Local {
    my ( $self, $c, $frecuencia ) = @_;
    $c->log->debug("*** PROCESAR OPENVAS ***");
    my $ov_scans;
    if (!$frecuencia){ 
      # Sin argumento se busca los que estan en estado Inicial y se deben ejecutar en forma inmediata (U) 
      $ov_scans = $c->model('DB::OV_scan')->search({estado => 'I',frecuencia=> 'U'}, {order_by => 'id'});
      $c->log->debug("*** Escaneos inmediatos ***");
    }
    else {
      # Se ejecutan los Diarios, Semanales o Mensuales
      $ov_scans = $c->model('DB::OV_scan')->search({frecuencia=> $frecuencia, estado => {'!=' => 'S'}}, {order_by => 'id'});
      $c->log->debug("*** Escaneos con frecuencia: ".$frecuencia." ***");
    }
  my @all_scans=$ov_scans->all;

 #Pongo todo en Scanning antes para que nos e vuelvan a ejecutar
  foreach my $ov  (@all_scans) {
    $ov->estado('S');
    $ov->update;
  }
#Recorremos por 2da vez
  foreach my $ov  (@all_scans) {

    $c->log->debug(localtime(time)."=> *** Ejecutando Escaneo: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***");
  ###########################
    OV::run_scan_catalyzed( $c, $ov);
  ##########################
    $c->log->debug(localtime(time)."=> *** Escaneo Finalizado: ".$ov->id." (".$ov->id_servidor->ipv4."/".$ov->id_servidor->mascarav4.") ***");
    $ov->estado('F');
    $ov->update;
  }

  # Set the template
  $c->stash->{template} = 'cron/mensaje.tt2';
  $c->stash->{status_msg} = "Escaneos OpenVAS procesados (".localtime(time).")";
  if ($frecuencia){ $c->stash->{status_msg} .= " con frecuencia $frecuencia";}
}

1
