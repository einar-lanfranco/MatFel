package MatFel::Schema::Result::Snort_udpheader;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('udphdr');
# Set columns in table
__PACKAGE__->add_columns(qw/sid cid udp_sport udp_dport udp_len udp_csum/);
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
#__PACKAGE__->has_many(map_user_role => 'MyAppDB::UserRole', 'user_id');
# __PACKAGE__->belongs_to(id_servidor => 'MatFel::Schema::Result::Servidor');
# __PACKAGE__->belongs_to(protocolo => 'MatFel::Schema::Result::Protocolo');
# __PACKAGE__->belongs_to(estado => 'MatFel::Schema::Result::Estado');    
__PACKAGE__->belongs_to(ipheader => 'MatFel::Schema::Result::Snort_ipheader',{ 'foreign.sid' => 'self.sid'},{'foreign.cid' => 'self.cid'} );    
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut
sub retornar_hash_de_valores{
my ($self)=@_;
my %valores;
$valores{"udp_sport"}=$self->udp_sport; 
$valores{"udp_dport"}=$self->udp_dport; 
$valores{"udp_len"}=$self->udp_len;
$valores{"udp_csum"}=$self->udp_csum;
return \%valores;
}
1;
