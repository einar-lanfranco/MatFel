package Tesis::Controller::Login;

use strict;
use warnings;
use LWP::Simple;
use XML::RSSLite;
# <p>print “=== Channel ===\n”,<br />
#     “Title: $results{‘title’}\n”,<br />
#     “Desc:  $results{‘description’}\n”,<br />
#     “Link:  $results{‘link’}\n”;</p>
# <p>for my $item (@{$results{‘items’}}) {<br />
#   print ”  — Item —\n”,<br />
#         ”  Title: $item->{‘title’}\n”,<br />
#         ”  Desc:  $item->{‘description’}\n”,<br />
#         ”  Link:  $item->{‘link’}\n\n”;<br />
# }<br />

use parent 'Catalyst::Controller';

=head1 NAME

Tesis::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    # Get the username and password from form
    my $username = $c->request->params->{username} || "";
    my $password = $c->request->params->{password} || "";
    # If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        if ($c->authenticate({ username => $username, password => $password  } )) {
            # If successful, then let them use the application
            my $login = $c->model('DB::User_Accion')->create({user_id=>$c->user->get('id'), accion=> 'login', desde=> $c->request->address, cliente=>$c->request->user_agent});
            $c->response->redirect($c->uri_for("/"));
            return;
        } else {
# Set an error message
            my $log_erroneo =$c->model('DB::User')->find({username => $username});
            if ($log_erroneo){ 
                $c->model('DB::User_Accion')->create({user_id=>$log_erroneo->id, accion=> 'errorlogin', desde=> $c->request->address, cliente=>$c->request->user_agent});}
            $c->stash->{error_msg} = "Error en el usuario o la password.";
        }
    }

# If either of above don't work out, send to the login page
    $c->stash->{template} = 'login.tt2';


}


=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
