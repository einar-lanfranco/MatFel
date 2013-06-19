package MatFel::Controller::Root;

use strict;
use warnings;

use parent 'Catalyst::Controller';
use LWP::Simple;
use DateTime;
use XML::RSS;
use Date::Calc qw(Delta_Days);
use MatFel::Controller::Utilidades;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

MatFel::Controller::Root - Root Controller for MatFel

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my @results;
    my $preferencias = $c->model('DB::Preferencia');
    my @files=split(',',($preferencias->find({nombre => "rss_server"})->valor));
    foreach my $url ( @files )
 	{
         my $rss = XML::RSS->new(encoding=>'UTF-8');#encode_output=>'latin1');#encoding=>'iso-8859-1');
 	my $data = get( $url);
 	eval{$rss->parse( $data );
	push(@results,$rss);
         }
     }

    $c->stash->{rsss}=\@results;
    my $cuantos=($preferencias->find({nombre => "dias_resumen_de_alertas"})->valor);

    my $ultimos;
    my @today = (localtime)[5,4,3];
    $today[0] += 1900;
    $today[1]++;
    my ($date, $time) = split(' ', $c->user->last_login->timestamp);
    my @fecha = split('-', $date);
    my $days = Delta_Days(@fecha, @today);
    if ($days <= $cuantos){
	    $ultimos=$c->user->last_login->timestamp;
	    $c->stash->{entre_logins}=1;
    } 
    else{
	    $ultimos=DateTime->now(time_zone => 'local')->subtract(days => $cuantos)->set(hour => 0, minute => 0, second => 0);
	    $c->stash->{entre_logins}=0;

    }	
    my @alertas_entre_logins=$c->model('DB::Alerta')->search({'buscar_user.id' => $c->user->id,'evento.timestamp' => {'>=', $ultimos}}, {join => ['evento', {'id_servidor'=>'buscar_user'}], select => [{ count => '*', -as => 'cuenta'},'id_servidor.nombre','id_servidor.id'], as => [qw/ cuenta server_nombre id_servidor /], group_by => 'id_servidor.id', order_by => {-desc => 'cuenta'}});
    $c->stash->{alertas_entre_logins}=\@alertas_entre_logins;


    ($date, $time) = split(' ', $c->user->last_login->timestamp);
    $days = Delta_Days(@fecha, @today);
    if ($days==0){ $days=1;}
#$c->stash->{rango}=$days;
    $c->stash->{rango}=$cuantos;

if ($c->request->address){
   $c->stash->{geo_login} = MatFel::Controller::Utilidades::get_geo_ip($c->request->address,$c);
}


# my $dt=DateTime->today( time_zone => 'local' );
#      my ($date, $time) = split(' ', $c->user->last_login->timestamp);
#      my ($year, $month, $day) = split('-', $date);
#      my ($hour, $minute, $second) = split(':', $time);
#     my $dt2 = DateTime->new(hour=>$hour, minute=>$minute, second=>$second, month=>$month, day=>$day, year=>$year); 
#      $c->stash->{rango}=$dt->subtract_datetime($dt2);#->in_units('years','months','weeks','days'); 
#      $c->stash->{rango2}=$dt.'-'.$dt2.'=years:'.($c->stash->{rango})->in_units('years').'months'.($c->stash->{rango})->in_units('months').'weeks'.($c->stash->{rango})->in_units('weeks').'days'.($c->stash->{rango})->in_units('days');
#      $c->stash->{rango}=$dt2->add(days=>((($c->stash->{rango})->in_units('years')*5)+(($c->stash->{rango})->in_units('months')*30)+($c->stash->{rango})->in_units('days')));
# $c->stash->{rango}=Date::Manip::ParseDateDelta(Date::Manip::ParseDate("today"));
# $c->stash->{rango2}=Date::Manip::ParseDateDelta(Date::Manip::ParseDate($c->user->last_login->timestamp));
# # $c->stash->{rango3}=Date::Manip::DateCmp("today",$c->user->last_login->timestamp);

# $c->stash->{rango4}=$c->stash->{rango3}->Date::Manip::Delta::printf('Day: %+05dv');
#$c->stash->{rango}=((($c->stash->{rango})->in_units('months')*30)+($c->stash->{rango})->in_units('days'));
#      $c->stash->{rango}= $dt->subtract_datetime( "2002-08-09 00:00:00");#$c->user->last_login->timestamp );
#         $c->stash->{ip_distintas_llegaron}=$alertas_total3->next->get_column('COUNT(distinct(ip_src)) as einar');

     }



sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
sub contacto :Local {
    my ( $self, $c, @args ) = @_;
#    $c->response->body('It works');
}
=head2 auto
    
  Check if there is a user and, if not, forward to login page
    
=cut
# Note that 'auto' runs after 'begin' but before your actions and that
# 'auto's "chain" (all from application path to most specific class are run)
# See the 'Actions' section of 'Catalyst::Manual::Intro' for more info.
sub auto : Private {
    my ($self, $c) = @_;
    # Allow unauthenticated users to reach the login page.  This
    # allows unauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the 'index' action we
    # added above.
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    if (($c->controller('contacto'))&&($c->controller eq $c->controller('contacto'))){
        return 1;
    }
    if (($c->controller('cron'))&&($c->controller eq $c->controller('cron'))){
        return 1;
    }

    # If a user doesn't exist, force login
    if (! $c->user_exists) {
        # Dump a log message to the development server debug output
        #$c->log->debug('***Root::auto User not found, forwarding to /login');
        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }
    
    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}

=head2 usuarios
    
  La idea es acceder al manejo de Usuarios
    
=cut


sub usuarios :Local {
    my ( $self, $c, @args ) = @_;
#    $c->response->body('It works');
}

=head2 usuarios
    
  La idea es acceder al manejo de los datos del Usuario logueado
    
=cut


sub misDatos :Local {
    my ( $self, $c, @args ) = @_;
#    $c->response->body('It works');
}

sub ayuda :Local {
    my ( $self, $c, @args ) = @_;
#    $c->response->body('It works');
}

1;
