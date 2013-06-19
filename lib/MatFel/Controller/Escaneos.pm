package MatFel::Controller::Escaneos;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';

=head1 NAME

MatFel::Controller::Escaneos - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MatFel::Controller::Escaneos in Escaneos.');
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
    
sub base :Chained('/') :PathPart('escaneos') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Store the ResultSet in stash so it's available for other methods
        $c->stash->{resultset} = $c->model('DB::ov_scan');
    
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
        die "El escaneo con $id no se encuentra!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }



=head2 lista
    
    Fetch all user objects and pass to escaneos/list.tt2 in stash to be displayed
    
=cut
    
sub lista : Local {
        my ($self, $c,$rows,$page) = @_;

        if ($rows== ''){ $rows=10;}
        if ($page== ''){ $page=1;}

	my $id_user=$c->user->get('id');
        $c->stash->{escaneos} = [$c->model('DB::OV_scan')->search({user => $id_user}, { join => 'id_servidor',rows=>$rows, page=>$page})];
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$c->user->id ***");
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        $c->stash->{template} = 'escaneos/lista.tt2';
}


=head2 lista de un servidor
    
    Fetch all user objects and pass to escaneos/list.tt2 in stash to be displayed
    
=cut
    
sub lista_servidor :Chained('base') :PathPart('lista_servidor') :Args(1) {
        my ($self, $c, $id_serv) = @_;

	my $ov_scan=$c->stash->{object};
	my $id_user=$c->user->get('id');
        $c->stash->{escaneos} = [$c->model('DB::OV_scan')->search({user => $id_user , id_servidor => $id_serv}, { join => 'id_servidor'})];
        $c->stash->{servidor} =  $c->model('DB::Servidor')->find($id_serv);
        $c->log->debug("*** INSIDE lista_servidor METHOD for obj id=$c->user->id ***");
        $c->stash->{template} = 'escaneos/lista.tt2';
}

=head2 editar
    
    Use HTML::FormFu to update an existing User
    
=cut
    
sub editar :Chained('object') :PathPart('editar') :Args(0) 
            :FormConfig('escaneos/formfu_edit.conf') {
        my ($self, $c) = @_;
    
        # Get the specified book already saved by the 'object' method
        my $ov_scan = $c->stash->{object};
    
        # Make sure we were able to get a book
        unless ($ov_scan) {
            $c->flash->{error_msg} = "Escaneo Inválido -- No se puede editar";
            $c->response->redirect($c->uri_for($self->action_for('list')));
            $c->detach;
        }
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};

        if ($form->submitted_and_valid) {
            $form->model->update($ov_scan);
            # Set a status message for the user
            $c->flash->{status_msg} = 'Escaneo Actualizado';
            # Return to the books list
            $c->response->redirect($c->uri_for($self->action_for('lista')));
            $c->detach;
        } else {
            $form->model->default_values($ov_scan);
       	    $c->stash->{escaneo}=$ov_scan;

            my @freq_objs = $c->model("DB::OV_frecuencia")->all();
            my @frecuencia;
            foreach (@freq_objs) {
                push(@frecuencia, [$_->id, $_->descripcion]);
            }
            my $selectFrecuencia = $form->get_element({type => 'Select'});
            $selectFrecuencia->options(\@frecuencia);

  	    $form->model->default_values($ov_scan);
        }

# Set the template
        $c->stash->{template} = 'escaneos/formfu_edit.tt2';
            }

sub formfu_create :Chained('base') :PathPart('formfu_create') :Args(1) :FormConfig {
        my ($self, $c, $id_serv) = @_;
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
  
        # Check if the form has been submitted (vs. displaying the initial
        # form) and if the data passed validation.  "submitted_and_valid"
        # is shorthand for "$form->submitted && !$form->has_errors"
        if ($form->submitted_and_valid) {
            # Create a new book
            my $ov_scan = $c->model('DB::OV_scan')->new_result({id_servidor=>$form->param_value('servidor'),frecuencia=>$form->param_value('frecuencia'),estado=>'I' });
            $form->model->update($ov_scan);
            $c->flash->{status_msg} = 'Escaneo creado';
            $c->response->redirect($c->uri_for($self->action_for('lista'))); 
            $c->detach;
        } else {
            my @srv_objs;
            if($id_serv){
              @srv_objs = $c->model("DB::Servidor")->search({user => $c->user->get('id'), id => $id_serv});
            }
            else{
              @srv_objs = $c->model("DB::Servidor")->search({user => $c->user->get('id')});
            }

            my @servidores;
            foreach (@srv_objs) {
                push(@servidores, [$_->id, $_->nombre.": ".$_->descripcion." (".$_->ipv4."/".$_->mascarav4.")"]);
            }

            my $selectServidores = $form->get_element({type => 'Select',name => 'servidor'});
            $selectServidores->options(\@servidores);

            my @freq_objs = $c->model("DB::OV_frecuencia")->all();
            my @frecuencias;
            foreach (@freq_objs) {
                push(@frecuencias, [$_->id, $_->descripcion]);
            }
            my $selectFrecuencia = $form->get_element({type => 'Select',name => 'frecuencia'});
            $selectFrecuencia->options(\@frecuencias);

        }
        
        # Set the template
        $c->stash->{template} = 'escaneos/formfu_create.tt2';
    }

=head2 borrar
    
    Borrar un escaneo
    
=cut
    
sub borrar :Chained('object') :PathPart('borrar') :Args(0) {
        my ($self, $c) = @_;
	if ($c->user->get('id') eq $c->stash->{object}->id_servidor->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        $c->stash->{object}->delete;
    
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Escaneo Borrado.";
	}
	else
	{
		$c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder borrar el escaneo.";
	}
        # Forward to the list action/method in this controller
        $c->forward('lista');
    }


sub ultimo_escaneo :Chained('object') :PathPart('ultimo_escaneo') :Args(0)  {
        my ($self, $c) = @_;

	my $ov_scan=$c->stash->{object};
	my $ultimo_timestamp=$ov_scan->ultimo_timestamp;
	my $ultimo_dia= substr($ultimo_timestamp,0,10);
	$c->stash->{ultimo_escaneo} = [$ov_scan->ultimo_escaneo];
	$c->stash->{ultimo_dia}=join("/",reverse(split("-",$ultimo_dia)));
	$c->stash->{oid_url}=$c->model('DB::Preferencia')->find({nombre => "OIDs-url"})->valor;
	$c->stash->{cve_url}=$c->model('DB::Preferencia')->find({nombre => "CVEs-url"})->valor;
    $c->stash->{bid_url}=$c->model('DB::Preferencia')->find({nombre => "BIDs-url"})->valor;
	$c->stash->{escaneo}=$ov_scan;
        $c->stash->{template} = 'escaneos/resultado_escaneo.tt2';
}

sub escaneos_historicos :Chained('object') :PathPart('escaneos_historicos') :Args(1)  {
        my ($self, $c, $rango_historico) = @_;

	my $ov_scan=$c->stash->{object};
	my $fechas_vuln =$c->model('DB::OV_scanresults')->search(
        {id_scan => $ov_scan->id}, {select => [{DATE => 'timestamp' }],   as => ['timestamp'], group_by => [{DATE => 'timestamp' }]}
       );

 	my @fechas;
	while( my $dia = $fechas_vuln->next ) {
	    push(@fechas, join("/",reverse(split("-",substr($dia->timestamp,0,10)))));
	}

    $c->stash->{rango_historico}=$rango_historico || 10;
	$c->stash->{escaneo}=$ov_scan;
	$c->stash->{dias_escaneos} = \@fechas;
	$c->stash->{cantidad_dias} = scalar(@fechas);
	$c->stash->{primer_dia} = $fechas[0];
	$c->stash->{ultimo_dia} = $fechas[scalar(@fechas)-1];
    $c->stash->{template} = 'escaneos/escaneos_historicos.tt2';
}

sub escaneo_dia :Chained('object') :PathPart('escaneo_dia') :Args(1) {
        my ($self, $c, $dia) = @_;

	my $ov_scan=$c->stash->{object};

	my $escaneo_total =$ov_scan->escaneo_total;
	
	$c->stash->{escaneo} = [$escaneo_total->search({timestamp =>{-like => $dia.'%'}})];
	$c->stash->{dia}=join("/",reverse(split("-",$dia)));
	$c->stash->{oid_url}=$c->model('DB::Preferencia')->find({nombre => "OIDs-url"})->valor;
	$c->stash->{cve_url}=$c->model('DB::Preferencia')->find({nombre => "CVEs-url"})->valor;
    $c->stash->{bid_url}=$c->model('DB::Preferencia')->find({nombre => "BIDs-url"})->valor;
	
        $c->stash->{no_wrapper}=1;
}
1;
