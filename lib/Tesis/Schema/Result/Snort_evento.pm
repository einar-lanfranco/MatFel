package Tesis::Schema::Result::Snort_evento;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('event');
# Set columns in table
__PACKAGE__->add_columns(qw/sid cid signature timestamp/);
# Set the primary key for the table
__PACKAGE__->set_primary_key(qw/sid cid/);
#
# Set relationships:
#
# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table
__PACKAGE__->belongs_to(sig_id => 'Tesis::Schema::Result::Snort_signature', 'signature');
__PACKAGE__->belongs_to(alerta => 'Tesis::Schema::Result::Alerta',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->belongs_to(ip_header => 'Tesis::Schema::Result::Snort_ipheader',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );

# __PACKAGE__->has_many(escaneos => 'Tesis::Schema::Result::OV_scan', 'id_servidor');
# __PACKAGE__->has_many(trafico_entrada => 'Tesis::Schema::Result::Trafico_entrada', 'id_servidor');
# __PACKAGE__->has_many(trafico_salida => 'Tesis::Schema::Result::Trafico_salida', 'id_servidor');
    
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut
    
1;
