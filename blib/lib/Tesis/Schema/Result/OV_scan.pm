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

sub escaneos_mensual {
  my $self = shift;
  if ($self->hay_resultados){
        my $dt = DateTime->today->subtract( days => 30 );
         return $self->escaneo_total->search({timestamp =>{'>=', $dt->iso8601()}});
  }
  return 0;
}


sub cant_escaneos_mensual {
  my $self = shift;
  if ($self->hay_resultados){
        my $dt = DateTime->today->subtract( days => 30 );
         return $self->escaneos_mensual->search({},{columns => [ qw/DATE(timestamp)/ ],group_by => 'DATE(timestamp)'})->count;
  }
  return 0;
}

sub ultimo_escaneo {
  my $self = shift;
  if ($self->hay_resultados){
	my $ultimo_dia= substr($self->ultimo_timestamp,0,10);
      	return $self->escaneo_total->search({timestamp =>{-like => $ultimo_dia.'%'}});
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

sub estado_promedio_mensual {
  my $self = shift;
  
    my $escaneos_mensual=$self->escaneos_mensual;
    my %cantidades=(
        1 => 0,
        2 => 0,
        3 => 0,
    );
    if ($escaneos_mensual){
        while (my $rs = $escaneos_mensual->next) {
        if ($rs->risk->prioridad <= 3){
          $cantidades{$rs->risk->prioridad}++;
        }
        }
        
        #Calculo el promedio del mes
        foreach my $key (%cantidades){
            if($self->cant_escaneos_mensual > 0){
                $cantidades{$key}= $cantidades{$key} / $self->cant_escaneos_mensual;
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
