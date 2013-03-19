package Tesis::Controller::Servidores;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';

=head1 NAME

Tesis::Controller::Usuarios - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Tesis::Controller::Servidores en Servidores.');
}


=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

=head2 formfu_create


Use HTML::FormFu to create a new book
    
=cut
    
sub formfu_create :Chained('base') :PathPart('formfu_create') :Args(0) :FormConfig {
        my ($self, $c) = @_;
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
  
        # Check if the form has been submitted (vs. displaying the initial
        # form) and if the data passed validation.  "submitted_and_valid"
        # is shorthand for "$form->submitted && !$form->has_errors"
        if ($form->submitted_and_valid) {
            # Create a new book
            my $servidor = $c->model('DB::Servidor')->new_result({});
            # Save the form data for the book
	    $servidor->user($c->user->get('id'));
            $form->model->update($servidor);

            #Marcamos el cambio
            &Tesis::Controller::Utilidades::marcar_cambio($c); 

            # Set a status message for the servidor
            $c->flash->{status_msg} = 'Servidor creado';
            # Return to the books list
            $c->response->redirect($c->uri_for($self->action_for('lista'))); 
            $c->detach;
        } else {
            # Get the authors from the DB
            my @servidor_objs = $c->model("DB::Servidor")->all();
            # Create an array of arrayrefs where each arrayref is an author
            my @servidores;
           # foreach (sort {$a->last_name cmp $b->last_name} @user_objs) {
            #    push(@users, [$_->id, $_->last_name]);
            #}
            # Get the select added by the config file
           # my $select = $form->get_element({type => 'Select'});
            # Add the authors to it
             #$select->options(\@users);
        }
        
        # Set the template
        $c->stash->{template} = 'servidores/formfu_create.tt2';
    }

=head2 base
    
   Can place common logic to start chained dispatch here
    
=cut
    
sub base :Chained('/') :PathPart('servidores') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Store the ResultSet in stash so it's available for other methods
        $c->stash->{resultset} = $c->model('DB::Servidor');
    
        # Print a message to the debug log
        $c->log->debug('*** INSIDE BASE METHOD ***');
    }
    
=head2 formfu_edit
    
    Use HTML::FormFu to update an existing User
    
=cut
    
sub formfu_edit :Chained('object') :PathPart('formfu_edit') :Args(0) 
            :FormConfig('servidores/formfu_create.conf') {
        my ($self, $c) = @_;
       #FIXME hay q arreglar los permisos
        # Get the specified book already saved by the 'object' method
        my $servidor = $c->stash->{object};
    
        # Make sure we were able to get a book
        unless ($servidor) {
            $c->flash->{error_msg} = "Usuario Inválido -- No se puede editar";
            $c->response->redirect($c->uri_for($self->action_for('list')));
            $c->detach;
        }
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
    
        # Check if the form has been submitted (vs. displaying the initial
        # form) and if the data passed validation.  "submitted_and_valid"
        # is shorthand for "$form->submitted && !$form->has_errors"
        if ($form->submitted_and_valid) {
            # Save the form data for the book
            $form->model->update($servidor);

            #Marcamos el cambio
            &Tesis::Controller::Utilidades::marcar_cambio($c); 

            # Set a status message for the user
            $c->flash->{status_msg} = 'Servidor Actualizado';
            # Return to the books list
            $c->response->redirect($c->uri_for($self->action_for('lista')));
            $c->detach;
        } else {
            $form->model->default_values($servidor);
        }
    
        # Set the template
        $c->stash->{template} = 'servidores/formfu_create.tt2';
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
    
=head2 lista
    
    Fetch all servidor objects and pass to books/list.tt2 in stash to be displayed
    
=cut
    
sub lista : Local {
        # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
        # 'Context' that's used to 'glue together' the various components
        # that make up the application
        my ($self, $c,$rows,$page) = @_;
	if ($rows== ''){ $rows=10;}
	if ($page== ''){ $page=1;}
#        print $rows;
#        print $page;
#       exit;
        # Retrieve all of the book records as book model objects and store in the
        # stash where they can be accessed by the TT template
        # $c->stash->{books} = [$c->model('DB::Book')->all];
        # But, for now, use this code until we create the model later
	    my $id_user=$c->user->get('id');
        #FIXME hay q arreglar los permisos ahora solo se ven los servidores del usuario pero no se manejan los roles
	    $c->stash->{servidores} = [$c->model('DB::Servidor')->search({user => $id_user},{rows=>$rows, page=>$page})];
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$c->user->id ***");
        # Set the TT template to use.  You will almost always want to do this
        # in your action methods (action methods respond to servidor input in
        # your controllers).
        $c->stash->{rows}=$rows;
        $c->stash->{pages}=$page;
        
        $c->stash->{template} = 'servidores/lista.tt2';
}


    
=head2 buscar
    
    Busca entre los servidores
    
=cut
    
sub buscar : Local :Args(1) {

        my ($self, $c, $busqueda) = @_;
    
	my $id_user=$c->user->get('id');
	$c->stash->{servidores} = [$c->model('DB::Servidor')->search({user => $id_user, nombre => {'like' , '%'.$busqueda.'%'}})];
	$c->stash->{busqueda} = $busqueda;
        $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$c->user->id ***");
        $c->stash->{template} = 'servidores/lista.tt2';
}

=head2 borrar
    
    Borrar un usuario
    
=cut
    
sub borrar :Chained('object') :PathPart('borrar') :Args(0) {
        my ($self, $c) = @_;
        #FIXME hay q arreglar los permisos
	if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        my $nombre=$c->stash->{object}->nombre_dir;
        $c->stash->{object}->delete;
    
        #Marcamos el cambio
        &Tesis::Controller::Utilidades::marcar_cambio($c); 

        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Servidor $nombre borrado.";}
	else
	{
	$c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder Borrarlo.";
	}
        # Forward to the list action/method in this controller
        $c->forward('lista');
    }

=head2 habilitar
    
    habilitar/deshabilitar el servidor
    
=cut
    
sub habilitar :Chained('object') :PathPart('habilitar') :Args(1) {
        my ($self, $c, $habilitado) = @_;
        #FIXME hay q arreglar los permisos
    if ($c->user->get('id') eq $c->stash->{object}->user()) {
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
       my $nombre=$c->stash->{object}->nombre_dir;
        $c->stash->{object}->update({ habilitado => $habilitado,});

        #Marcamos el cambio
        &Tesis::Controller::Utilidades::marcar_cambio($c); 

        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Servidor ".$nombre;
      if ($habilitado) {$c->stash->{status_msg} .=" habilitado.";} 
          else {$c->stash->{status_msg} .=" deshabilitado.";} 
    }
    else
    {
    $c->stash->{status_msg} = "Usted no tiene permisos sobre ese Servidor para poder modificar su habilitación o no.";
    }
        # Forward to the list action/method in this controller
        $c->forward('lista');
    }

1;
