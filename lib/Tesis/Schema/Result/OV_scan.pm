package Tesis::Schema::Result::OV_scan;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('ov_scan');
# Set columns in table
__PACKAGE__->add_columns(qw/id id_servidor timestamp estado frecuencia/);
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
__PACKAGE__->belongs_to(estado => 'Tesis::Schema::Result::OV_estado');
__PACKAGE__->belongs_to(frecuencia => 'Tesis::Schema::Result::OV_frecuencia');
__PACKAGE__->has_many(resultados => 'Tesis::Schema::Result::OV_scanresults',  { 'foreign.id_scan' => 'self.id' } );

=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut
   
sub escaneo_total {
  my $self = shift;
  my $escaneo_total = $self->resultados->search({id_scan => $self->id}, {'+columns' => ['risk.prioridad'],join => 'risk',,order_by => 'prioridad ASC'});
  return $escaneo_total;
}

sub ultimo_escaneo {
  my $self = shift;
  if ($self->hay_resultados){
      	return $self->escaneo_total->search({timestamp =>$self->ultimo_timestamp});
  }
  return 0;
}

sub ultimo_timestamp {
  my $self = shift;
  return $self->resultados->get_column('timestamp')->max();
}

sub estado_actual {
  my $self = shift;
  
    my $ultimo_escaneo=$self->ultimo_escaneo;
    my %cantidades=(
        1 => 0,
        2 => 0,
        3 => 0,
    );
    if ($ultimo_escaneo){
	    while (my $rs = $ultimo_escaneo->next) {
		if ($rs->risk->prioridad <= 3){
		  $cantidades{$rs->risk->prioridad}++;
		}
	    }
      }
  return \%cantidades;
}

sub hay_resultados {
  my $self = shift;
  return !($self->resultados->count == 0);
}

1;
