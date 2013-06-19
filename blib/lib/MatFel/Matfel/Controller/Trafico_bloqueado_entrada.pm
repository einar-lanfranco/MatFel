package MatFel::Controller::Trafico_bloqueado_entrada;

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

    $c->response->body('Matched MatFel::Controller::Trafico_bloqueado_entrada.');
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
        $c->stash->{resultset} = $c->model('DB::Trafico_entrada_bloqueado');
    
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
        die "El servidor con $id no se encuentra!" if !$c->stash->{object};
    
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


=head2 borrar
    
    Borrar un trafico
    
=cut
    
sub borrar :Chained('object') :PathPart('borrar_entrante_bloqueado') :Args(0) {
        my ($self, $c) = @_;
    
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        $c->stash->{object}->delete;

        #Marcamos el cambio
        &MatFel::Controller::Utilidades::marcar_cambio($c); 

        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Trafico de Entrada Bloqueado Borrado.";
        $c->log->debug('*** EINAR ***'. $c->uri_for($self->action_for('listar_trafico')));
        # Forward to the list action/method in this controller
        $c->response->redirect($c->uri_for($c->controller('trafico')->action_for('listar_trafico'),[$c->stash->{object}->id_servidor->id()])); 
    }

1;

