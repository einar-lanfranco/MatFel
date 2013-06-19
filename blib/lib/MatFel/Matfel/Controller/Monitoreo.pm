package MatFel::Controller::Monitoreo;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';

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

    $c->response->body('Matched MatFel::Controller::Trafico.');
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
        die "El servidor con $id no se encuentra!" if !$c->stash->{object};
    
        # Print a message to the debug log
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
    }
    
    
=head2 trafico
    
    la idea es ver el trafico habilitado para un servidor en particular
    
=cut
    
sub listar_trafico :Chained('object') :PathPart('listar_trafico') :Args(0) {
  my ($self, $c) = @_;
	if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $id_serv=$c->stash->{object}->id();
        $c->stash->{trafico_entrada} = [$c->model('DB::Trafico_entrada')->search({id_servidor => $id_serv})];
        $c->stash->{trafico_salida} = [$c->model('DB::Trafico_salida')->search({id_servidor => $id_serv})];
        $c->stash->{trafico_entrada_bloqueado} = [$c->model('DB::Trafico_entrada_bloqueado')->search({id_servidor => $id_serv})];
        $c->stash->{trafico_salida_bloqueado} = [$c->model('DB::Trafico_salida_bloqueado')->search({id_servidor => $id_serv})];
        $c->stash->{id_servidor}=$id_serv;
        }
  else
	{
	      $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder ver mas informacion.";
	}
        # Forward to the list action/method in this controller
  $c->stash->{template} = 'servidores/listar_trafico.tt2';
}

1;
