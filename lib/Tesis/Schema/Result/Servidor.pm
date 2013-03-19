package Tesis::Schema::Result::Servidor;

use strict;
use warnings;
use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('servidor');

# Set columns in table
__PACKAGE__->add_columns(qw/id   nombre   alta   user   examinado   habilitado   activo   descripcion   ipv6   ipv4   mascarav4/);
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
__PACKAGE__->has_many(escaneos => 'Tesis::Schema::Result::OV_scan', 'id_servidor');
__PACKAGE__->has_many(trafico_entrada => 'Tesis::Schema::Result::Trafico_entrada', 'id_servidor');
__PACKAGE__->has_many(trafico_salida => 'Tesis::Schema::Result::Trafico_salida', 'id_servidor');
__PACKAGE__->belongs_to(buscar_user => 'Tesis::Schema::Result::User','user');    
__PACKAGE__->has_many(trafico_entrada_bloqueado => 'Tesis::Schema::Result::Trafico_entrada_bloqueado', 'id_servidor');
__PACKAGE__->has_many(trafico_salida_bloqueado => 'Tesis::Schema::Result::Trafico_salida_bloqueado', 'id_servidor');
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut

sub nombre_dir {
  my $self = shift;
  return $self->nombre." (".$self->ipv4."/".$self->mascarav4.")";

}


sub trafico_entrada_habilitado {
  my $self = shift;
  my $trafico_habilitado = $self->trafico_entrada->search({habilitado=>'0'});
  return $trafico_habilitado;
}


sub trafico_salida_habilitado {
  my $self = shift;
  my $trafico_habilitado = $self->trafico_salida->search({habilitado=>'0'});
  return $trafico_habilitado;
}

sub trafico_entrada_bloqueado {
  my $self = shift;
  my $trafico_bloqueado = $self->trafico_entrada_bloqueado->search({habilitado=>'0'});
  return $trafico_bloqueado;
}


sub trafico_salida_bloqueado {
  my $self = shift;
  my $trafico_bloqueado = $self->trafico_salida_bloqueado->search({habilitado=>'0'});
  return $trafico_bloqueado;
}

sub escaneo_con_resultados {
  my $self = shift;
    my $ultimo_escaneo_con_resultados=$self->escaneos;
    if ($ultimo_escaneo_con_resultados){
        while (my $rs = $ultimo_escaneo_con_resultados->next) {
            if ($rs->hay_resultados){
                my $estado=$rs->estado_actual;
                $estado->{'id_ov_scan'}=$rs->id;
                return $estado;
            }
        }
    }
  return 0;
}
1;
