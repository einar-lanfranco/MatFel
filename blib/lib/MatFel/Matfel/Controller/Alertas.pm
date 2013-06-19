package MatFel::Controller::Alertas;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';
use DateTime;
=head1 NAME

MatFel::Controller::Usuarios - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MatFel::Controller::Servidores en Servidores.');
}


=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


=head2 base
    
   Can place common logic to start chained dispatch here
    
=cut
    
sub base :Chained('/') :PathPart('alerta') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Store the ResultSet in stash so it's available for other methods
        $c->stash->{resultset} = $c->model('DB::Servidor');
    
        # Print a message to the debug log
        $c->log->debug('*** INSIDE BASE METHOD ***');
    }
    

=head2 object
    
    Fetch the specified object based on the servidor ID and store
    it in the stash
    
=cut
    
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of book to delete
        my ($self, $c, $id) = @_;
    
        # Find the book object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
    
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "El usuario con $id no se encuentra!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
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

    
=head2 lista
    
    la idea es listar las alertas para determinado servidor
    
=cut
    
sub resumen_alertas :Chained('object') :PathPart('resumen_alertas') :Args(2) {
  my ($self, $c, $rango,$rango_historico) = @_;
#     print "ID".$c->user->get('id');
#          print "R".$rango;
# #        print "RH".$rango_historico;
#     print "user".($c->stash->{object}->user());
	if ($c->user->get('id') eq $c->stash->{object}->user()) {
#         print "entre";
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        
        $c->stash->{servidor}=$c->stash->{object};
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
        $c->stash->{rango_historico}=$rango_historico;
         


        #Para las estadisticas por severidad
        my $alertas_total =$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'},select => ['sig_priority as nivel','COUNT(*) as cuenta'],group_by => 'sig_id.sig_priority'});
        my $total_max =0;
        my @niveles=(0,0,0,0);
        while (my $nivel = $alertas_total->next) {
            @niveles[$nivel->get_column('sig_priority as nivel')]=$nivel->get_column('COUNT(*) as cuenta');
            $total_max+=$nivel->get_column('COUNT(*) as cuenta');
        }
        $c->stash->{altas}=$niveles[1];
        $c->stash->{medias}=$niveles[2];
        $c->stash->{bajas}=$niveles[3];
        
        #Para las estadisticas por evento
         my $alertas_total2 =$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento'},select => ['COUNT(distinct(signature)) as cuenta']});
        $c->stash->{eventos_unicos}=$alertas_total2->next->get_column('COUNT(distinct(signature)) as cuenta');
        #Para saber la cantidad de ips de las que vieneron los ataques
        my $alertas_total3 =$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()},'ip_src' =>{'<>',&dot2dec($c->stash->{object}->ipv4) }}, {join => {'evento'=>'ip_header'},select => ['COUNT(distinct(ip_src)) as einar']});
        $c->stash->{ip_distintas_llegaron}=$alertas_total3->next->get_column('COUNT(distinct(ip_src)) as einar');
        #Para saber la cantidad de ips distintas las que ataque
        my $alertas_total4 =$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()},'ip_dst' =>{'<>',&dot2dec($c->stash->{object}->ipv4)}}, {join => {'evento'=>'ip_header'},select => ['COUNT(distinct(ip_dst)) as einar']});
        $c->stash->{ip_distintas_fue}=$alertas_total4->next->get_column('COUNT(distinct(ip_dst)) as einar');
        #Esto es para la lista agrupadas por signature
       $c->stash->{resumen_por_tipo} =[$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'},select => ['sig_id','sig_priority','sig_name','COUNT(*) as cuenta'],group_by => 'evento.signature',  order_by => { -desc =>'cuenta'}})];
        #Este es para los eventos que genero mi server agrupados por ip destino
        $c->stash->{alertas_desde_mi}=[$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()},'ip_src' => {'=',&dot2dec($c->stash->{object}->ipv4)}}, {join => {'evento' =>'ip_header'}, select => [{ count => '*', -as => 'cuenta'},'ip_dst','evento.sid','evento.cid'], as => [qw/
      cuenta
      destino
      sid
      cid
    /],
,group_by => ['ip_header.ip_dst'],  order_by => { -desc =>'cuenta'}}) ];
        #Este es para los eventos que se detectaron hacia mi server agrupados por ip origen!
        $c->stash->{alertas_hacia_mi} =[$c->model('DB::Alerta')->search({'me.id_servidor' => $id_serv,'evento.timestamp' => {'>=', $dt->iso8601()},'ip_src' => {'<>',&dot2dec($c->stash->{object}->ipv4)}}, {join => {'evento' =>'ip_header'}, select => [{ count => '*', -as => 'cuenta'},'ip_src','evento.sid','evento.cid'], as => [qw/
      cuenta
      origen
      sid
      cid
    /],
,group_by => ['ip_header.ip_dst'], order_by => { -desc =>'cuenta'}}) ];

        
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
	
	
	
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/resumen_alertas.tt2';
}

=head2 lista
    
    la idea es listar las alertas para determinado servidor
    
=cut
    
sub listar_severidad :Chained('object') :PathPart('listar_severidad') :Args(4) {
        my ($self, $c, $rango, $nivel,$rows,$page) = @_;
        if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{alertas} = [$c->model('DB::Alerta')->search({ 'me.id_servidor' => $id_serv,
                                                                 'evento.timestamp' => {'>=', $dt->iso8601()},
                                                                 'sig_id.sig_priority'=> $nivel },
                                                                 {join => {'evento' =>[{'ip_header'},{'sig_id'=>['map_class_id']}]}, rows=>$rows, page=>$page})];
#                                                                 {join => {'evento' =>'sig_id'}})];
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{quinto}=$nivel;

        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
	
	
	
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/listar_alerta.tt2';
}


sub listar_todos :Chained('object') :PathPart('listar_todos') :Args(4) {
        my ($self, $c, $rango,$papa,$rows,$page) = @_;
        if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{alertas} = [$c->model('DB::Alerta')->search({ 'me.id_servidor' => $id_serv,
                                                                 'evento.timestamp' => {'>=', $dt->iso8601()}},
                                                                  {join => {'evento' =>[{'ip_header'},{'sig_id'=>['map_class_id']}]}, rows=>$rows, page=>$page})];
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{quinto}=$papa;
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}		
  #Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/listar_alerta.tt2';
}

=head2 lista
    
    la idea es listar las alertas para determinado servidor
    
=cut
    
sub listar_por_signature :Chained('object') :PathPart('listar_por_signature') :Args(4) {
        my ($self, $c, $rango, $signature,$rows,$page) = @_;
        if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{alertas} = [$c->model('DB::Alerta')->search({ 'me.id_servidor' => $id_serv,
                                                                 'evento.timestamp' => {'>=', $dt->iso8601()},
                                                                 'evento.signature'=> $signature },
                                                                {join => {'evento' =>[{'ip_header'},{'sig_id'=>['map_class_id']}]}, rows=>$rows, page=>$page,order_by => { -desc =>'evento.timestamp'}})];
#                                                                 {join => {'evento' =>'sig_id'},order_by => { -desc =>'evento.timestamp'}})];
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{quinto}=$signature;
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
	
	
	
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/listar_alerta.tt2';
}

=head2 listar_por_ip_destino
    
    la idea es listar las alertas pero solo las que fueron hacia alguna ip en particular
    
=cut
    
sub listar_por_ip_destino :Chained('object') :PathPart('listar_por_ip_destino') :Args(4) {
        my ($self, $c, $rango, $destino,$rows,$page) = @_;
        if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{alertas} = [$c->model('DB::Alerta')->search({ 'me.id_servidor' => $id_serv,
                                                                 'evento.timestamp' => {'>=', $dt->iso8601()},
                                                                 'ip_dst' =>$destino } ,
                                                               {join => {'evento' =>[{'ip_header'},{'sig_id'=>['map_class_id']}]}, rows=>$rows, page=>$page})];
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
#         $c->stash->{destino}=$destino;
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{quinto}=$destino;
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
		
	
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/listar_alerta.tt2';
}

=head2 listar_por_ip_destino
    
    la idea es listar las alertas pero solo las que fueron hacia alguna ip en particular
    
=cut
    
sub listar_por_ip_origen :Chained('object') :PathPart('listar_por_ip_origen') :Args(4) {
        my ($self, $c, $rango, $origen,$rows,$page) = @_;
        if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $dt = DateTime->today->subtract( days => $rango );
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{alertas} = [$c->model('DB::Alerta')->search({ 'me.id_servidor' => $id_serv,
                                                                 'evento.timestamp' => {'>=', $dt->iso8601()},
                                                                 'ip_src' =>$origen } ,
                                                                {join => {'evento' =>[{'ip_header'},{'sig_id'=>['map_class_id']}]}, rows=>$rows, page=>$page})];
        $c->stash->{id_servidor}=$id_serv;
        $c->stash->{rango}=$rango;
#         $c->stash->{origen}=$origen;
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{quinto}=$origen;
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
		
	
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'alertas/listar_alerta.tt2';
}


sub listar_ultimas_alertas :Chained('base') :PathPart('listar_ultimas_alertas') :Args(1) {
        my ($self, $c, $dias) = @_;
            
            if(!$dias){$dias=1;}
            my ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime(time - (86400 * $dias));
            $yearOffset += 1900;
            $month ++;
            my $timestamp_past="$yearOffset-$month-$dayOfMonth 00:00:00";

            my @alertas_entre_logins=$c->model('DB::Alerta')->search({'buscar_user.id' => $c->user->id,'evento.timestamp' => {'>=', $timestamp_past }}, {join => ['evento', {'id_servidor'=>'buscar_user'}], select => [{ count => '*', -as => 'cuenta'},'id_servidor.nombre','id_servidor.id'], as => [qw/ cuenta server_nombre id_servidor /], group_by => 'id_servidor.id', order_by => {-desc => 'cuenta'}});
            $c->stash->{alertas_entre_logins}=\@alertas_entre_logins;

            my @top_ip_atacantes=$c->model('DB::Alerta')->search({'buscar_user.id' => $c->user->id,'evento.timestamp' => {'>=', $timestamp_past }}, {join => [{'evento'=>'ip_header'}, {'id_servidor'=>'buscar_user'}], select => [{ count => '*', -as => 'cuenta'},'ip_header.ip_src'], as => [qw/ cuenta ip_src  /], group_by => 'ip_header.ip_src', order_by => {-desc => 'cuenta'}, rows=> 10 });
            $c->stash->{top_ip_atacantes}=\@top_ip_atacantes;

            my @top_ip_atacadas=$c->model('DB::Alerta')->search({'buscar_user.id' => $c->user->id,'evento.timestamp' => {'>=', $timestamp_past }}, {join => [{'evento'=>'ip_header'}, {'id_servidor'=>'buscar_user'}], select => [{ count => '*', -as => 'cuenta'},'ip_header.ip_dst'], as => [qw/ cuenta ip_dst /], group_by => 'ip_header.ip_dst', order_by => {-desc => 'cuenta'}, rows=> 10 });
            $c->stash->{top_ip_atacadas}=\@top_ip_atacadas;

            $c->stash->{rango}=$dias;
            $c->stash->{template} = 'alertas/listar_ultimas_alertas.tt2';
}


1;
