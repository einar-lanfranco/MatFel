package MatFel::Controller::Trafico_entrada;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';
use MatFel::Controller::Utilidades;
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

    $c->response->body('Matched MatFel::Controller::Trafico_entrada.');
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
    
sub base :Chained('/') :PathPart('trafico') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Store the ResultSet in stash so it's available for other methods
        $c->stash->{resultset} = $c->model('DB::Trafico_entrada');
    
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
        die "El trafico con $id no se encuentra!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }




=head2 server
    
    Busca el servidor para el que se quiere agregar trafico
    
=cut
    
sub server :Chained('/') :PathPart('id') :CaptureArgs(1) {
        # $id = primary key of book to delete
        my ($self, $c, $id) = @_;
        $c->stash->{resultset} = $c->model('DB::Servidor');    
        # Find the book object and store it in the stash
        $c->stash(object => $c->stash->{resultset}->find($id));
    
        # Make sure the lookup was successful.  You would probably
        # want to do something like this in a real app:
        #   $c->detach('/error_404') if !$c->stash->{object};
        die "El trafico con $id no se encuentra!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }
    
=head2 create

Usar create para agregar nuevo trafico entrante al servidor
    
=cut
    
sub create :Chained('server') :PathPart('create') :Args(0) :FormConfig('trafico/entrante_create.conf') {
        my ($self, $c) = @_;
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
        if ($c->user->get('id') eq  $c->stash->{object}->user()) {
        if ($form->submitted_and_valid) {
            # Create a new trafico_entrante
            my $trafico_entrante = $c->model('DB::Trafico_entrada')->new_result({});
            # Save the form data for the book
            $trafico_entrante->id_servidor($c->stash->{object}->id());
            $form->model->update($trafico_entrante);
            # Set a status message for the servidor
            &MatFel::Controller::Utilidades::marcar_cambio($c);
            $c->flash->{status_msg} = 'Trafico Entrante agregado con exito';
            # Return to the books list
            $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id()]));
            $c->detach;
        } else {
            #FIXME, FIXME no me gusta como queda esto me parece una cagada, deberia haber un metodo que retorne directamente los elementos del arreglo como valores y no como objetos
            my @auxprotocolo= $c->model("DB::Protocolo")->search({ 'firewall' => 1});#search(undef, {columns => [qw/id nombre/], })];
            my @protocolo;
            foreach (@auxprotocolo) {
                 push(@protocolo, [$_->id, $_->nombre]);
            }
            my @auxestado = $c->model("DB::Estado")->all();#search(undef, {columns => [qw/id estado/], })];
            my @estado;
            foreach (@auxestado) {
                 push(@estado, [$_->id, $_->estado]);
            }
            my $selectEstado = $form->get_element({name => 'estado'});
            $selectEstado->options(\@estado);
            my $selectProtocolo = $form->get_element({name => 'protocolo'});
            $selectProtocolo->options(\@protocolo);
            $c->stash->{id_servidor}=$c->stash->{object}->id();
        }
        
        # Set the template
    }else
  {
        $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
  }
       $c->stash->{template} = 'trafico/entrante_create.tt2';
   
}


sub edit :Chained('object') :PathPart('edit_entrante') :CapturArgs(0) 
            :FormConfig('trafico/entrante_create.conf') {
        my ($self, $c) = @_;
        my $trafico = $c->stash->{object};
    
        # Make sure we were able to get a book
        unless ($trafico) {
            $c->flash->{error_msg} = "Usuario Inválido -- No se puede editar";
            $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id_servidor->id()])); 
            $c->detach;
        }
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
    
        # Check if the form has been submitted (vs. displaying the initial
        # form) and if the data passed validation.  "submitted_and_valid"
        # is shorthand for "$form->submitted && !$form->has_errors"
	if ($c->user->get('id') eq $c->stash->{object}->id_servidor->user()) {
        if ($form->submitted_and_valid) {
            
            # Save the form data for the book
            $form->model->update($trafico);
            # Set a status message for the user
            $c->flash->{status_msg} = 'Trafico Actualizado';
            # Return to the books list
            &MatFel::Controller::Utilidades::marcar_cambio($c);
            $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id_servidor->id()])); 
            $c->detach;
        } else {
            my @auxprotocolo= $c->model("DB::Protocolo")->all();
            my @protocolo;
            foreach (@auxprotocolo) {
                 push(@protocolo, [$_->id, $_->nombre]);
            }
            my @auxestado = $c->model("DB::Estado")->all();
            my @estado;
            foreach (@auxestado) {
                 push(@estado, [$_->id, $_->estado]);
            }
            my $selectEstado = $form->get_element({name => 'estado'});
            $selectEstado->options(\@estado);
            my $selectProtocolo = $form->get_element({name => 'protocolo'});
            $selectProtocolo->options(\@protocolo);
            $form->model->default_values($trafico);
        }
    
    }
	else
  {
        $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
  }
        # Set the template
        $c->stash->{template} = 'trafico/entrante_create.tt2';
    }    
    

=head2 borrar
    
    Borrar un trafico
    
=cut
    
sub borrar :Chained('object') :PathPart('borrar') :Args(0) {
        my ($self, $c) = @_;
    
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        $c->stash->{object}->delete;

        #Marcamos el cambio
        &MatFel::Controller::Utilidades::marcar_cambio($c);

        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Trafico de Entrada Eliminado Borrado.";
    
        # Forward to the list action/method in this controller
        $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id_servidor->id()])); 
    }

=head2 habilitar
    
    habilitar/deshabilitar el trafico entrante
    
=cut
    
sub habilitar_entrada :Chained('object') :PathPart('habilitar_entrada') :Args(1) {
        my ($self, $c, $habilitado) = @_;

    if ($c->user->get('id') eq $c->stash->{object}->id_servidor->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
       my $nombre=$c->stash->{object}->puerto."/".$c->stash->{object}->protocolo->nombre;
        $c->stash->{object}->update({ habilitado => $habilitado,});

        #Marcamos el cambio
        &MatFel::Controller::Utilidades::marcar_cambio($c); 

        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Tráfico entrante a ".$nombre;
      if ($habilitado) {$c->stash->{status_msg} .=" habilitado.";} 
          else {$c->stash->{status_msg} .=" deshabilitado.";} 
    }
    else
    {
    $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder modificar su habilitación o no de tráfico entrante.";
    }
        # Forward to the list action/method in this controller
        $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id_servidor->id()])); 
    }
    
1;
