package MatFel::Controller::Cron;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use MatFel::Controller::Mail;
use Text::Report;
use OV;

=head1 NAME

MatFel::Controller::Cron - Catalyst Controller

=head1 DESCRIPTION

La idea es que a partir de Cron podamos ejecutar todo lo que va a tener que ir en el cron

=head1 METHODS

=cut

=head2 index

=cut


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MatFel::Controller::Cron.');
}

sub generar_regla {
    
    my($ip_o,$mask_o,$prot,$puerto_o,$ip_d,$mask_d,$puerto_d,$state,$policy)= @_;
    if (($puerto_o eq 'any')&&($puerto_d eq 'any')){
        return ("iptables -A TESIS -s $ip_o/$mask_o -p $prot -m state --state $state -j $policy\n");
                }
    elsif($puerto_o eq 'any'){
        return ("iptables -A TESIS -s $ip_o/$mask_o -d $ip_d/$mask_d -p $prot --dport $puerto_d -m state --state $state -j $policy\n");}
    elsif($puerto_d eq 'any'){
        return ("iptables -A TESIS -s $ip_o/$mask_o  -d $ip_d/$mask_d -p $prot --sport $puerto_o -m state --state $state -j $policy\n");
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
                    $reglas=$reglas.generar_regla($trafico_entrante->ip_origen(), $trafico_entrante->mascara_origen,$trafico_entrante->protocolo->nombre(),"any",$servidor->ipv4(), $servidor->mascarav4,$trafico_entrante->puerto(), $trafico_entrante->estado->estado(),'DROP');
                }
              }

              if($trafico_salida_bloqueado->count){
                $reglas.= "# TRAFICO BLOQUEADO SALIENTE \n";
                #por servidor obtener el trafico de salida que se va a asociar
                while ( my $trafico_saliente = $trafico_salida_bloqueado->next ) {
                    $reglas=$reglas.generar_regla($servidor->ipv4(), $servidor->mascarav4,$trafico_saliente->protocolo->nombre(),"any",$trafico_saliente->ip_destino(), $trafico_saliente->mascara_destino,$trafico_saliente->puerto(), $trafico_saliente->estado->estado(),'DROP');
                }
              }

              if($trafico_entrada_habilitado->count){
                $reglas.= "# TRAFICO ENTRANTE \n";
                while ( my $trafico_entrante = $trafico_entrada_habilitado->next ) {
                    $reglas=$reglas.generar_regla($trafico_entrante->ip_origen(), $trafico_entrante->mascara_origen,$trafico_entrante->protocolo->nombre(),"any",$servidor->ipv4(), $servidor->mascarav4, $trafico_entrante->puerto(), $trafico_entrante->estado->estado(),'ACCEPT');
                }
              }

              if($trafico_salida_habilitado->count){
                $reglas.= "# TRAFICO SALIENTE \n";
                #por servidor obtener el trafico de salida que se va a asociar
                while ( my $trafico_saliente = $trafico_salida_habilitado->next ) {
                    $reglas=$reglas.generar_regla($servidor->ipv4(), $servidor->mascarav4, $trafico_saliente->protocolo->nombre(),"any",$trafico_saliente->ip_destino(), $trafico_saliente->mascara_destino,$trafico_saliente->puerto(), $trafico_saliente->estado->estado(),'ACCEPT');
                }
              }
              
            } else {
              $c->log->debug("NO HAY REGLAS PARA EL SERVIDOR: ".$servidor->nombre_dir);
              $reglas.= "\n#### NO HAY REGLAS PARA EL SERVIDOR: ".$servidor->nombre_dir." ####\n";
            }
         }
    $reglas.= "iptables -A TESIS -j RETURN;\n";
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
  eval{
    OV::run_scan_catalyzed( $c, $ov);
  };

  if ($@){
      $c->log->debug(localtime(time)."=> *** ERROR EN ESCANEO: ".$@." ***");
  }
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

=item sub enviar_resumen
    La idea de esta rutina es enviar por mail todo lo que se configure debe mandarse, para eso en cada servidor sera configurable:
    - enviar_alertas de la ultima semana 
    - enviar_resumen de vulnerabilidades
    Cada usuario debera tener una dir de mail
    En las preferencias tendremos 'mail_from','smtp_server', 'smtp_metodo', 'port_mail', 'username_mail', 'password_mail', 'smtp_server_sendmail'
=cut
sub enviar_resumen : Local {
    my ( $self, $c ) = @_;
    my $resultado="Error de ip, estas queriendo acceder desde ".$c->req->address();

    my $send_report=$c->model('DB::Preferencia')->find({nombre =>"send_report" });
    my $info_smtp_hash_ref;
    if ((($c->req->address() eq "127.0.0.1")||($c->req->address() eq "163.10.10.70"))&&($send_report->valor())) {
        $resultado="ok";
        my @preferencias = ('mail_from','smtp_server', 'smtp_metodo', 'port_mail', 'username_mail', 'password_mail');
        foreach (@preferencias){
                $info_smtp_hash_ref->{"$_"}=(($c->model('DB::Preferencia')->search({nombre =>"$_" }))[0])->valor();
            }
        #Obtener todos los usuarios:
        my @todos_los_usuarios=$c->model('DB::User')->all();
        my @usuarios_de_rol_superior;
        my $mail='';
        foreach (@todos_los_usuarios){
           @usuarios_de_rol_superior = $c->model('DB::User')->search({'role.id' => {'>', $_->map_user_roles->first->role->id}}, {join => {'map_user_roles' =>'role'}});
           my @servers_para_reporte=();
           foreach my $servidor ($_->servidores){
                if ($servidor->reporte){
                    push (@servers_para_reporte,$servidor);
                }
            }
            $mail=generar_reporte(@servers_para_reporte);
	    #$resultado=$mail;
              $resultado.=send_mail($info_smtp_hash_ref, $mail, $_->email_address,$c);
               foreach my $superior (@usuarios_de_rol_superior){
                          $resultado.= send_mail($info_smtp_hash_ref, $mail, $superior->email_address);
               }


             }
        
        }
    $c->res->output($resultado);
}


=item sub limpiar_escaneos
    Limpia escaneos colgados poniendolos en estado Filanizado = 'F' si pasan varias horas sin resultados
=cut
sub limpiar_escaneos : Local {
    my ( $self, $c ) = @_;
    my $resultado="Error de ip, estas queriendo acceder desde ".$c->req->address();

    if ($c->req->address() eq "127.0.0.1") {
        $resultado="ok";
	my @escaneos=$c->model('DB::OV_scan')->find({estado => 'S'});
        foreach my $ov (@escaneos){
	    $ov->estado('F');
	    $ov->update;
        }
    }

    $c->res->output($resultado);
}

sub generar_reporte: Local {
    my ( @servers_para_reporte ) = @_;
    my @reporte_total;
    my $resumen='';
    my $detalle;
    foreach my $servidor (@servers_para_reporte){
        my %reporte;
        $reporte{'servidor'}=$servidor;
        $reporte{'vulnerabilidades'}="";
        $reporte{'alertas'}="";

        my %reporte_vulnerabilidades = $servidor->reporte_vulnerabilidades_diaria;
            $reporte{'vulnerabilidades'}=\%reporte_vulnerabilidades;

        my %reporte_alertas = $servidor->reporte_alertas_diaria;
            $reporte{'alertas'}=\%reporte_alertas;

        push(@reporte_total,\%reporte);
    }

    my $reporte_txt = armar_reporte_diario(@reporte_total);

    return ($reporte_txt);
}

sub armar_reporte_diario: Local {
    my ( @reporte_total ) = @_;


    my $rpt = Text::Report->new(debug => 'error', debugv => 1);

    $rpt->defblock(name => 'titulo_general');
    $rpt->fill_block('titulo_general', ['Reporte Diario'],[scalar(localtime(int(time)))]);
    $rpt->insert('dbl_line');

    $rpt->defblock(name => 'vulnerabilidades',
          title => 'Vulnerabilidades',
          useColHeaders => 1,
          sortby => 2,
          sorttype => 'numeric',
          orderby => 'descending',
          columnWidth => 14,
          columnAlign => 'right',
          pad => {top => 2, bottom => 2},

         column =>
         {
            1 => {width => 50, align => 'left', head => 'Servidor'},
            2 => {width => 5, align => 'center', head => 'A'},
            3 => {width => 5, align => 'center', head => 'AM'},
            4 => {width => 1, align => 'center', head => 'EA'},
            5 => {width => 5, align => 'center', head => 'M'},
            6 => {width => 5, align => 'center', head => 'MM'},
            7 => {width => 1, align => 'center', head => 'EM'},
            8 => {width => 5, align => 'center', head => 'B'},
            9 => {width => 5, align => 'center', head => 'BM'},
            10 => {width => 1, align => 'center', head => 'EB'},
            11 => {width => 20, align => 'center', head => 'Fecha Escaneo'},
         },

            );

    #Armo los datos
    my @data_vulnerabilidades=();

    foreach my $reporte (@reporte_total){
        my @line=($reporte->{'servidor'}->nombre_ip);
        for (my $i=1;$i<=3;$i++){
            push(@line,$reporte->{'vulnerabilidades'}->{'actual'}?$reporte->{'vulnerabilidades'}->{'actual'}->{$i}:'0');
            push(@line,$reporte->{'vulnerabilidades'}->{'mensual'}?$reporte->{'vulnerabilidades'}->{'mensual'}->{$i}:'0');
            push(@line,$reporte->{'vulnerabilidades'}->{'estado'}?$reporte->{'vulnerabilidades'}->{'estado'}->{$i}:'0');
        }
   	push(@line,$reporte->{'servidor'}->dia_ultimo_escaneo?$reporte->{'servidor'}->dia_ultimo_escaneo:'-');
        push(@data_vulnerabilidades,[@line]);
    }

    $rpt->fill_block('vulnerabilidades', @data_vulnerabilidades);

    # Create a separator:
    $rpt->insert('dotted_line');

    $rpt->defblock(name => 'alertas',
          title => 'Alertas',
          useColHeaders => 1,
          sortby => 2,
          sorttype => 'numeric',
          orderby => 'descending',
          columnWidth => 14,
          columnAlign => 'right',
          pad => {top => 2, bottom => 2},

         column =>
         {
            1 => {width => 50, align => 'left', head => 'Servidor'},
            2 => {width => 5, align => 'center', head => 'A'},
            3 => {width => 5, align => 'center', head => 'AM'},
            4 => {width => 1, align => 'center', head => 'EA'},
            5 => {width => 5, align => 'center', head => 'M'},
            6 => {width => 5, align => 'center', head => 'MM'},
            7 => {width => 1, align => 'center', head => 'EM'},
            8 => {width => 5, align => 'center', head => 'B'},
            9 => {width => 5, align => 'center', head => 'BM'},
            10 => {width => 1, align => 'center', head => 'EB'},
         },

            );

    #Armo los datos
    my @data_alertas=();


    foreach my $reporte (@reporte_total){

        my @line=($reporte->{'servidor'}->nombre_ip);
        for (my $i=1;$i<=3;$i++){
            push(@line,$reporte->{'alertas'}->{'actual'}?$reporte->{'alertas'}->{'actual'}->{$i}:'0');
            push(@line,$reporte->{'alertas'}->{'mensual'}?$reporte->{'alertas'}->{'mensual'}->{$i}:'0');
            push(@line,$reporte->{'alertas'}->{'estado'}?$reporte->{'alertas'}->{'estado'}->{$i}:'0');
        }
        
        push(@data_alertas,[@line]);
    }

    $rpt->fill_block('alertas', @data_alertas);

    # Create a separator:
    $rpt->insert('dotted_line');


    # Create a footer block:
    $rpt->defblock(name => 'referencias');
    $rpt->fill_block('referencias', ['Referencias'], ["A=Altas AM=Altas Mensual EA=Estado Altas"],["M=Medias MM=Medias Mensual EM=Estado Medias"],["B=Bajas BM=Bajas Mensual EB=Estado Bajas"]);
    # Create a separator:
    $rpt->insert('dotted_line');
    
    # Create a footer block:
    $rpt->defblock(name => 'footer');
    $rpt->fill_block('footer', ['MatFel'], ['GNU General Public License version 3.0 (GPLv3)']);

   my @report = $rpt->report('get');
   my $resultado='';
   for(@report){$resultado.="$_\n";}

   return ($resultado);
}
1
