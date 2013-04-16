package Tesis::Schema::Result::OV_scanresults;

use strict;
use warnings;

use base qw/DBIx::Class/;

#Para detectar las uris
use CGI qw(escapeHTML);
use URI::Find;

# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('ov_scanresults');
# Set columns in table
__PACKAGE__->add_columns(qw/id id_scan ip port OID type description timestamp false_positive risk CVE BID/);
# Set the primary key for the table
__PACKAGE__->set_primary_key('id');
#
# Set relationships:
#
# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table
#__PACKAGE__->has_many(map_user_role => 'MyAppDB::UserRole', 'user_id');
    
__PACKAGE__->belongs_to(risk => 'Tesis::Schema::Result::OV_risk_factor');
__PACKAGE__->belongs_to(id_scan => 'Tesis::Schema::Result::OV_scan');

=head1 NAME
    MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
    This is an object that represents a row in the 'Servidor' table of your application
    database.  It uses DBIx::Class (aka, DBIC) to do ORM.
    For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
    Offline utilities may wish to use this class directly.
=cut

sub puerto {
  my $self = shift;
  my $text=$self->port;
  $text =~ m/.*\((\d*)\/(\w*)\).*/;
  return $1 ;

}
 
sub protocolo {
  my $self = shift;
  my $text=$self->port;
  $text =~ m/.*\((\d*)\/(\w*)\).*/;
  return $2 ;
}

sub trafico_entrante_bloqueado {
my ($self)=@_;

return Tesis::Controller::Utilidades::esta_trafico_entrada_bloqueado( $self->result_source->schema , $self->id_scan->id_servidor->id, $self->puerto, $self->protocolo);
}

sub getDescriptionUri {
  my $self = shift;
  my $text=$self->description;

  my $finder = URI::Find->new(sub {
      my($uri, $orig_uri) = @_;
      return qq|<b><a href="$uri" onclick="this.target='_blank'">$orig_uri</a></b>|;
  });
  $finder->find(\$text, \&escapeHTML);

  return $text;
}
1;
