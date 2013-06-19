package MatFel::Controller::Logout;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

MatFel::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
        my ($self, $c) = @_;
    
        # Clear the user's state
        
        my $logout = $c->model('DB::User_Accion')->create({user_id=>$c->user->get('id'), accion=> 'logout', desde=> $c->request->address, cliente=>$c->request->user_agent});
        $c->logout;
        # Send the user to the starting point
        $c->response->redirect($c->uri_for('/'));

}


=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
