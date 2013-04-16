package Tesis::Controller::Usuarios;

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

    $c->response->body('Matched Tesis::Controller::Usuarios in Usuarios.');
}


=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

=head2 formfu_create


Use HTML::FormFu to create a new user
    
=cut
    
sub formfu_create :Chained('base') :PathPart('formfu_create') :Args(0) :FormConfig {
        my ($self, $c) = @_;
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
  
#         FIXME aca habria que chequear que el usuario logueado sea ADMIN
        if (($form->submitted_and_valid)&&($c->user->map_user_roles->first->role->id lt $form->param_value('perfiles'))){
            # Create a new book
            my $user = $c->model('DB::User')->new_result({});
            # Save the form data for the book
            $form->model->update($user);
            my $user_rol = $c->model('DB::UserRole')->new_result({user_id=>$user->id,role_id=>$form->param_value('perfiles')});
            $form->model->update($user_rol);
            # Set a status message for the user
            $c->flash->{status_msg} = 'Usuario creado';
            # Return to the books list
            $c->response->redirect($c->uri_for($self->action_for('lista'))); 
            $c->detach;
        } else {
            # Get the authors from the DB
#             print $c->user->map_user_roles->first->role->id;
             my @user_objs = $c->model("DB::Role")->search({'id' => {'>', $c->user->map_user_roles->first->role->id}},{order_by => { -asc =>'id'}});
#             my @user_objs = $c->model("DB::Role")->all();
            # Create an array of arrayrefs where each arrayref is an author
            my @roles;
            foreach (sort {$a->role cmp $b->role} @user_objs) {
                push(@roles, [$_->id, $_->role]);
            }
            # Get the select added by the config file
            my $select = $form->get_element({type => 'Select'});
            # Add the authors to it
            $select->options(\@roles);
        }
        
        # Set the template
        $c->stash->{template} = 'usuarios/formfu_create.tt2';
    }

=head2 base
    
   Can place common logic to start chained dispatch here
    
=cut
    
sub base :Chained('/') :PathPart('usuarios') :CaptureArgs(0) {
        my ($self, $c) = @_;
    
        # Store the ResultSet in stash so it's available for other methods
        $c->stash->{resultset} = $c->model('DB::user');
    
        # Print a message to the debug log
        $c->log->debug('*** INSIDE BASE METHOD ***');
    }
    
=head2 formfu_edit
    
    Use HTML::FormFu to update an existing User
    
=cut
    
sub formfu_edit :Chained('object') :PathPart('formfu_edit') :Args(0) 
            :FormConfig('usuarios/formfu_create.conf') {
        my ($self, $c) = @_;
    
        # Get the specified book already saved by the 'object' method
        my $user = $c->stash->{object};
    
        # Make sure we were able to get a book
        unless ($user) {
            $c->flash->{error_msg} = "Usuario Inválido -- No se puede editar";
            $c->response->redirect($c->uri_for($self->action_for('list')));
            $c->detach;
        }
    
        # Get the form that the :FormConfig attribute saved in the stash
        my $form = $c->stash->{form};
    
        # Check if the form has been submitted (vs. displaying the initial
        # form) and if the data passed validation.  "submitted_and_valid"
        # is shorthand for "$form->submitted && !$form->has_errors"
        if (($form->submitted_and_valid)&&(($c->user->map_user_roles->first->role->id lt $form->param_value('perfiles'))||(($c->user->map_user_roles->first->role->id eq $form->param_value('perfiles'))&& ($c->user->id eq $user->id)))){
            # Save the form data for the book
            $form->model->update($user);
            # Set a status message for the user
#             print $user->id;
            my $user_rol = $c->model('DB::UserRole')->search({'user_id'=>$user->id})->first;
            $user_rol->role_id($form->param_value('perfiles'));
            $user_rol->update();
            
            $c->flash->{status_msg} = 'Usuario Actualizado';
            # Return to the books list
            $c->response->redirect($c->uri_for($self->action_for('lista')));
            $c->detach;
        } else {
            $form->model->default_values($user);
             # Obetener los roles de la base de datos, pero todos aquellos a los que estoyt autorizado a asignar
             my @user_objs;
             if ($user->id eq $c->user->id){ @user_objs= $c->model("DB::Role")->search({'id' => {'>=', $c->user->map_user_roles->first->role->id}},{order_by => { -asc =>'id'}})}
             else{ @user_objs= $c->model("DB::Role")->search({'id' => {'>', $c->user->map_user_roles->first->role->id}},{order_by => { -asc =>'id'}});}
            
            # Create an array of arrayrefs where each arrayref is an author
            my @roles;
            foreach (sort {$a->role cmp $b->role} @user_objs) {
                push(@roles, [$_->id, $_->role]);
            }
            # Get the select added by the config file
            my $select = $form->get_element({type => 'Select'});
            # Add the authors to it
            $select->options(\@roles);
            my $role_obj = $c->model("DB::UserRole")->single({user_id => $user->id});
            $select->default($role_obj->role_id);
        }

# Set the template
        $c->stash->{template} = 'usuarios/formfu_create.tt2';
            }    

=head2 object

    Fetch the specified object based on the user ID and store
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
    
    Fetch all user objects and pass to books/list.tt2 in stash to be displayed
    
=cut
    
sub lista : Local {
        # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
        # 'Context' that's used to 'glue together' the various components
        # that make up the application
        my ($self, $c) = @_;
    
        # Retrieve all of the book records as book model objects and store in the
        # stash where they can be accessed by the TT template
        # $c->stash->{books} = [$c->model('DB::Book')->all];
        # But, for now, use this code until we create the model later
        $c->stash->{usuarios} = [$c->model('DB::User')->search({'role.id' => {'>', $c->user->map_user_roles->first->role->id}}, {join => {'map_user_roles' =>'role'}})];
    
        # Set the TT template to use.  You will almost always want to do this
        # in your action methods (action methods respond to user input in
        # your controllers).
        $c->stash->{template} = 'usuarios/lista.tt2';
}

=head2 borrar
    
    Borrar un usuario
    
=cut
    
sub borrar :Chained('object') :PathPart('borrar') :Args(0) {
        my ($self, $c) = @_;
    
        # Use the book object saved by 'object' and delete it along
        # with related 'book_author' entries
        if ($c->user->map_user_roles->first->role->id lt $c->stash->{object}->map_user_roles->first->role->id){
        $c->stash->{object}->delete;
    
        # Set a status message to be displayed at the top of the view
        $c->stash->{status_msg} = "Usuario Borrado.";
    } else{
        $c->stash->{status_msg} = "No podes borrar el Usuario.";}
    
        # Forward to the list action/method in this controller
        $c->forward('lista');
    }
    
1;
