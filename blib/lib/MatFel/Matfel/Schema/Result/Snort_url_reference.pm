package MatFel::Schema::Result::Snort_url_reference;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('url_reference');
# Set columns in table
__PACKAGE__->add_columns(qw/ref_system_name url/);
# Set the primary key for the tabl
__PACKAGE__->set_primary_key(qw/ref_system_name/);
#
# Set relationships:
#
# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table
# __PACKAGE__->has_many(map_sig_id => 'MatFel::Schema::Result::Snort_evento', 'signature');
# __PACKAGE__->belongs_to(map_class_id => 'MatFel::Schema::Result::Snort_sigClass', 'sig_class_id');
# __PACKAGE__->has_many(map_sig_referencia => 'MatFel::Schema::Result::Snort_sig_reference', 'sig_id');
# __PACKAGE__->belongs_to(id_servidor => 'MatFel::Schema::Result::Servidor');
# __PACKAGE__->belongs_to(protocolo => 'MatFel::Schema::Result::Protocolo');
# __PACKAGE__->belongs_to(estado => 'MatFel::Schema::Result::Estado');    
# __PACKAGE__->belongs_to(sig_class_id => 'MatFel::Schema::Result::Snort_signature', 'sig_id');
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut
    
1;
