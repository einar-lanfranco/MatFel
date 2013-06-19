package MatFel::Controller::OFC;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Chart::OFC2;
use Chart::OFC2::Axis;
use Chart::OFC2::Bar;
use Chart::OFC2::Line;
use Chart::OFC2::Pie;

=head1 NAME

MatFel::Controller::OFC - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MatFel::Controller::OFC in OFC.');
}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


=head2 base
    
   Can place common logic to start chained dispatch here
    
=cut
    
sub base :Chained('/') :PathPart('ofc') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Print a message to the debug log
        $c->log->debug('*** INSIDE BASE METHOD ***');
    }


sub historico_vulnerabilidades :Chained('base') :PathPart('historico_vulnerabilidades') :Args(2) {
    my ($self, $c, $id, $rango_historico) = @_;

    $c->log->debug('OFC Historico de Escaneo id '.$id);

    my $escaneo_total =$c->model('DB::OV_scanresults')->search({id_scan => $id}, {'+columns' => ['risk.prioridad'],join => 'risk',,order_by => 'prioridad ASC'});
    
    my @linea_alta=();
    my @linea_media=();
    my @linea_baja=();

    my $fechas_vuln =$c->model('DB::OV_scanresults')->search(
        {id_scan => $id}, {select => [{DATE => 'timestamp' }],   as => ['timestamp'], group_by => [{DATE => 'timestamp' }]}
       );
    
    #Avanzamos hasta la fecha que nos interesa
    my $cantidad= $fechas_vuln->count;
    if ($cantidad > $rango_historico ){
        my $diferencia= $cantidad - $rango_historico;
       for(my $i=1;$i <= $diferencia ;$i++){my $dia = $fechas_vuln->next;}
    }

    my $total_max =0;
    my @fechas;
    while( my $dia = $fechas_vuln->next ) {
	    push(@fechas, join("/",reverse(split("-",substr($dia->timestamp,0,10)))));
	    
	    my $escaneo_dia=$escaneo_total->search({timestamp =>{-like => $dia->timestamp.'%'}});
	    my @cantidades=(0,0,0);
	    my $max =0;
	    while (my $rs = $escaneo_dia->next) {
		if ($rs->risk->prioridad <= 3){
		    $cantidades[$rs->risk->prioridad - 1]++;
		    if ($cantidades[$rs->risk->prioridad - 1] > $max ) {$max=$cantidades[$rs->risk->prioridad - 1];} #Para recuperar el máximo
		}
	    }
	    if ($max > $total_max){$total_max=$max;}
	    push(@linea_alta,$cantidades[0]);
	    push(@linea_media,$cantidades[1]);
	    push(@linea_baja,$cantidades[2]);
    }


    my $chart = Chart::OFC2->new(
        'title'  => '',
        'x_axis' => Chart::OFC2::XAxis->new(
	   'labels' => {
            'labels' => \@fechas,
	   }
        ),
        'y_axis' => {
            'max' => $total_max,
            'min' => 0,
        },
    );
    $chart->bg_colour('#FFFFFF');
    
    if ($total_max ne 0){
    
        my $line_alta = Chart::OFC2::Line->new();
	$line_alta->colour('#F64747');
	$line_alta->text('Altas');
	$line_alta->values(\@linea_alta);
	$chart->add_element($line_alta);

        my $line_media = Chart::OFC2::Line->new();
	$line_media->colour('#FF9900');
	$line_media->text('Medias');
	$line_media->values(\@linea_media);
	$chart->add_element($line_media);
	
	my $line_baja = Chart::OFC2::Line->new();
	$line_baja->colour('#F0F647');
	$line_baja->text('Bajas');
	$line_baja->values(\@linea_baja);
	$chart->add_element($line_baja);
    }
    else {#No hay nada
	my $line = Chart::OFC2::Line->new();
	$chart->add_element($line);
    }
   

    $c->response->body($chart->render_chart_data());
    }
    
sub vulnerabilidades_barras :Chained('base') :PathPart('vulnerabilidades_barras') :Args(1) {
    my ($self, $c, $id) = @_;

    $c->log->debug('OFC de Escaneo id '.$id);
    my $ov_scan = $c->model('DB::ov_scan')->find($id);
    my @label=('Vulnerabilidades');
    my $cantidades = $ov_scan->estado_actual;
    my $max =0;

    while(my ($key, $value) = each(%$cantidades)) {if($value>$max){ $max=$value;}} 

    my $chart = Chart::OFC2->new(
        'title'  => '',
        'x_axis' => Chart::OFC2::XAxis->new(
	   'labels' => {
            'labels' => \@label,
	   }
        ),
        'y_axis' => {
            'max' => $max,
            'min' => 0,
        },
    );
    $chart->bg_colour('#FFFFFF');
    
    if ($max ne 0){
	my $bar_alta = Chart::OFC2::Bar::3D->new();
	my @data_alta=($cantidades->{1});
	$bar_alta->colour('#F64747');
	$bar_alta->text('Altas');
	$bar_alta->values(\@data_alta);
	$chart->add_element($bar_alta);
	
	my @data_media=($cantidades->{2});
	my $bar_media = Chart::OFC2::Bar::3D->new();
	$bar_media->colour('#FF9900');
	$bar_media->text('Medias');
	$bar_media->values(\@data_media);
	$chart->add_element($bar_media); 
	
	my @data_baja=($cantidades->{3});
	my $bar_baja = Chart::OFC2::Bar::3D->new();
	$bar_baja->colour('#F0F647');
	$bar_baja->text('Bajas');
	$bar_baja->values(\@data_baja);
	$chart->add_element($bar_baja); 
    }
    else {#No hay nada
	my $bar = Chart::OFC2::Bar::3D->new();
	$chart->add_element($bar);
    }
   

    $c->response->body($chart->render_chart_data());
    }

sub vulnerabilidades_torta :Chained('base') :PathPart('vulnerabilidades_torta') :Args(1) {
    my ($self, $c, $id) = @_;

    my $ov_scan = $c->model('DB::ov_scan')->find($id);
    my $cantidades = $ov_scan->estado_actual;
    my $max =0;
    my $suma =0;

    while(my ($key, $value) = each(%$cantidades)) {
      if($value>$max){ $max=$value;}
      $suma+=$value;
    } 

    my $escala= int($suma);
     
    my $chart = Chart::OFC2->new(
      'title'  => '',
         'y_axis' => {
             'max' => $max,
             'min' => 0,
             'steps' => $escala ,
         },
    );
    $chart->bg_colour('#FFFFFF');
  my $pie = Chart::OFC2::Pie->new(
      'tip' => '#val# de #total#<br>#percent# de 100%',
        values       => [
            { 'value' => $cantidades->{1}, 'label' => 'Altas',      'colour' => '#F64747' },
            { 'value' => $cantidades->{2}, 'label' => 'Medias', 'colour' => '#FF9900' },
            { 'value' => $cantidades->{3}, 'label' => 'Bajas',   'colour' => '#F0F647' },
            ],
    );
    $chart->add_element($pie);
    $c->response->body($chart->render_chart_data());
}



sub alertas_por_nivel_barras :Chained('base') :PathPart('alertas_por_nivel_barras') :Args(2) {
    my ($self, $c, $id,$rango) = @_;
    my $dt = DateTime->today->subtract( days => $rango );
    my $alertas_total =$c->model('DB::Alerta')->search({'me.id_servidor' => $id,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'},select => ['sig_priority as nivel','COUNT(*) as cuenta'],group_by => 'sig_id.sig_priority'});
    my @linea_alta=();
    my @linea_media=();
    my @linea_baja=();
    my $total_max =0;
    my @niveles=(0,0,0,0);
    while (my $nivel = $alertas_total->next) {
#     foreach my $nivel (@escaneo_total){    
#        print $nivel->get_column('sig_priority as nivel');#('nivel');
        @niveles[$nivel->get_column('sig_priority as nivel')]=$nivel->get_column('COUNT(*) as cuenta');
        $total_max+=$nivel->get_column('COUNT(*) as cuenta');
    }
    my $escala= 1;
    if ($total_max ne 0){ $escala=int($total_max/10);}
    
    if ($escala == 0) {$escala=1};
    my $chart = Chart::OFC2->new(
      'title'  => '',
    #'x_axis' => Chart::OFC2::XAxis->new(
 	   #'labels' => {
            #  'labels' => ["alta","baja"],
 	  #}
    #     ),
         'y_axis' => {
             'max' => $total_max,
             'min' => 0,
             'steps' => $escala ,
         },
    );
    $chart->bg_colour('#FFFFFF');
#     $chart->title('Eventos por severidad - barras');
    
    if ($total_max ne 0){
	my $bar_alta = Chart::OFC2::Bar::3D->new();
	my @data_alta=($niveles[1]);
	$bar_alta->colour('#F64747');
	$bar_alta->text('Altas');
	$bar_alta->values(\@data_alta);
	$chart->add_element($bar_alta);
	
	my @data_media=($niveles[2]);
	my $bar_media = Chart::OFC2::Bar::3D->new();
	$bar_media->colour('#FF9900');
	$bar_media->text('Medias');
	$bar_media->values(\@data_media);
	$chart->add_element($bar_media); 
	
	my @data_baja=($niveles[3]);
	my $bar_baja = Chart::OFC2::Bar::3D->new();
	$bar_baja->colour('#F0F647');
	$bar_baja->text('Bajas');
	$bar_baja->values(\@data_baja);
	$chart->add_element($bar_baja); 
    }
    else {#No hay nada
	my $bar = Chart::OFC2::Bar::3D->new();
	$chart->add_element($bar);
    }
   

    $c->response->body($chart->render_chart_data());
}

sub alertas_por_nivel_torta :Chained('base') :PathPart('alertas_por_nivel_torta') :Args(2) {
    my ($self, $c, $id,$rango) = @_;
    my $dt = DateTime->today->subtract( days => $rango );
    my $alertas_total =$c->model('DB::Alerta')->search({'me.id_servidor' => $id,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'},select => ['sig_priority as nivel','COUNT(*) as cuenta'],group_by => 'sig_id.sig_priority'});
#     print "HOLA";
    my @linea_alta=();
    my @linea_media=();
    my @linea_baja=();
    my $total_max =0;
    my @niveles=(0,0,0,0);
    while (my $nivel = $alertas_total->next) {
        @niveles[$nivel->get_column('sig_priority as nivel')]=$nivel->get_column('COUNT(*) as cuenta');
        $total_max+=$nivel->get_column('COUNT(*) as cuenta');
    }
    my $escala= 1;
    if ($total_max ne 0){ $escala=int($total_max/10);}
    if ($escala == 0) {$escala=1};
    my $chart = Chart::OFC2->new(
      'title'  => '',
    #'x_axis' => Chart::OFC2::XAxis->new(
       #'labels' => {
            #  'labels' => ["alta","baja"],
      #}
    #     ),
         'y_axis' => {
             'max' => $total_max,
             'min' => 0,
             'steps' => $escala ,
         },
    );
    $chart->bg_colour('#FFFFFF');
#     $chart->title('Eventos por severidad - torta');
  my $pie = Chart::OFC2::Pie->new(
      'tip' => '#val# de #total#<br>#percent# de 100%',
        values       => [
            { 'value' => $niveles[1], 'label' => 'Altas',      'colour' => '#F64747' },
            { 'value' => $niveles[2], 'label' => 'Medias', 'colour' => '#FF9900' },
            { 'value' => $niveles[3], 'label' => 'Bajas',   'colour' => '#F0F647' },
            ],
    );
$chart->add_element($pie);
    $c->response->body($chart->render_chart_data());
}


sub alertas_historico_barras :Chained('base') :PathPart('alertas_historico_barras') :Args(2) {
    my ($self, $c, $id,$rango_historico) = @_;
    my $dt = DateTime->today->subtract( weeks => $rango_historico );
    my $alertas_total =$c->model('DB::Alerta')->search({'me.id_servidor' => $id,'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'}, select => ['sig_priority',{ count => '*', -as => 'cuenta'},{ week => 'evento.timestamp', -as => 'semana' }], as => [qw/
      sig_priority
      cuenta
      semana
    /],
,group_by => ['week(evento.timestamp)','sig_id.sig_priority'],order_by =>['week(evento.timestamp)']}) ;
    my $total_max =0;
    my $nro_semana=DateTime->today->week_number();
    my $semana_inicial=$nro_semana - $rango_historico + 1;
    my %data;
    my @fechas;
    for(my $i = $semana_inicial ; $i <= $nro_semana; $i++){
        $data{'1'}[$i-$semana_inicial]=0;
        $data{'2'}[$i-$semana_inicial]=0;
        $data{'3'}[$i-$semana_inicial]=0;
        push(@fechas,$i."");
    }
    
    while (my $nivel = $alertas_total->next) {
         $data{$nivel->get_column('sig_priority')}[$nivel->get_column('semana')-$semana_inicial]=$nivel->get_column('cuenta');
         $total_max+=$nivel->get_column('cuenta');
   }
    my $escala= 1;
    if ($total_max ne 0){ $escala=int($total_max/10);}
    if ($escala == 0) {$escala=1};
    my $chart = Chart::OFC2->new(
      'title'  => '',
    'x_axis' => {
 	   'labels' => \@fechas,
         },
         'y_axis' => {
             'max' => $total_max,
             'min' => 0,
             'steps' => $escala ,
         },
    );
    $chart->bg_colour('#FFFFFF');
#     $chart->title('Eventos por severidad - barras');

    

if ($total_max ne 0){
	my $bar_alta = Chart::OFC2::Bar::3D->new();
	my @data_alta=$data{'1'};
	$bar_alta->colour('#F64747');
	$bar_alta->text('Altas');
	$bar_alta->values(@data_alta);
	$chart->add_element($bar_alta);
	
	my @data_media=$data{'2'};
	my $bar_media = Chart::OFC2::Bar::3D->new();
	$bar_media->colour('#FF9900');
	$bar_media->text('Medias');
	$bar_media->values(@data_media);
	$chart->add_element($bar_media); 
	
	my @data_baja=$data{'3'};;
	my $bar_baja = Chart::OFC2::Bar::3D->new();
	$bar_baja->colour('#F0F647');
	$bar_baja->text('Bajas');
	$bar_baja->values(@data_baja);
	$chart->add_element($bar_baja); 

    }
    else {#No hay nada
	my $bar = Chart::OFC2::Bar::3D->new();
	$chart->add_element($bar);
    }
   

    $c->response->body($chart->render_chart_data());
}

1;
