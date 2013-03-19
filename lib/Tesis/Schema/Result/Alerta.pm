package Tesis::Schema::Result::Alerta;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('alerta');
# Set columns in table
__PACKAGE__->add_columns(qw/id timestamp id_servidor sid cid/);
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
__PACKAGE__->belongs_to(id_servidor => 'Tesis::Schema::Result::Servidor');
__PACKAGE__->belongs_to(evento=> 'Tesis::Schema::Result::Snort_evento',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );

# __PACKAGE__->belongs_to([cid => 'Tesis::Schema::Result::Servidor', 'cid', sid => 'Tesis::Schema::Result::Servidor', 'sid']);

    
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut
  

sub alerta_entrante_bloqueada {
my ($self)=@_;

return Tesis::Controller::Utilidades::esta_trafico_entrada_a_ip_bloqueado( $self->result_source->schema , $self->id_servidor->id, $self->evento->ip_header->ip_src , $self->evento->ip_header->get_port_dst,  $self->evento->ip_header->ip_proto->nombre);

}

sub alerta_saliente_bloqueada {
my ($self)=@_;

return Tesis::Controller::Utilidades::esta_trafico_salida_a_ip_bloqueado( $self->result_source->schema , $self->id_servidor->id, $self->evento->ip_header->ip_dst , $self->evento->ip_header->get_port_src,  $self->evento->ip_header->ip_proto->nombre);

}

1;
