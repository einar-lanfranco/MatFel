package MatFel::Schema::Result::Servidor;

use strict;
use warnings;
use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('servidor');

# Set columns in table
__PACKAGE__->add_columns(qw/id   nombre   alta   user   examinado   habilitado   reporte   descripcion   ipv6   ipv4   mascarav4/);
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

__PACKAGE__->has_many(escaneos => 'MatFel::Schema::Result::OV_scan', 'id_servidor');
__PACKAGE__->has_many(alertas => 'MatFel::Schema::Result::Alerta', 'id_servidor');
__PACKAGE__->has_many(trafico_entrada => 'MatFel::Schema::Result::Trafico_entrada', 'id_servidor');
__PACKAGE__->has_many(trafico_salida => 'MatFel::Schema::Result::Trafico_salida', 'id_servidor');
__PACKAGE__->belongs_to(buscar_user => 'MatFel::Schema::Result::User','user');    
__PACKAGE__->has_many(trafico_entrada_bloqueado => 'MatFel::Schema::Result::Trafico_entrada_bloqueado', 'id_servidor');
__PACKAGE__->has_many(trafico_salida_bloqueado => 'MatFel::Schema::Result::Trafico_salida_bloqueado', 'id_servidor');

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
  my $nombre_final = $self->nombre." (".$self->ipv4;
  if ($self->mascarav4 ne '255.255.255.255'){ 
	$nombre_final.="/".$self->mascarav4;
  }
 $nombre_final.=")";

 return $nombre_final;
}

sub dir_ip {
  my $self = shift;
  my $ip = $self->ipv4;
  if ($self->mascarav4 ne '255.255.255.255'){
        $ip.="/".$self->mascarav4;
  }
 return $ip;
}


sub nombre_ip {
  my $self = shift;
    my $nombre_ip = $self->nombre;
    if($self->ipv4){$nombre_ip.=" (".$self->ipv4.")";}
  return $nombre_ip;

}

sub dia_ultimo_escaneo {
  my $self = shift;

  my $ultimo_escaneo_con_resultados=$self->escaneos;
    if ($ultimo_escaneo_con_resultados){
        while (my $rs = $ultimo_escaneo_con_resultados->next) {
             if ($rs->hay_resultados){
		return substr($rs->ultimo_timestamp,0,10);
             }
        }
    }

return 0;
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

sub estado_mensual_escaneos {
  my $self = shift;
  my $escaneos=$self->escaneos;
    if ($escaneos){
        while (my $rs = $escaneos->next) {
            if ($rs->hay_resultados){
                my $estado=$rs->estado_promedio_mensual;
                $estado->{'id_ov_scan'}=$rs->id;
                return $estado;
            }
        }
    }
  return 0;
}

sub reporte_vulnerabilidades_diaria{
    my $self = shift;
    my %reporte;

    $reporte{'actual'} = $self->escaneo_con_resultados;
    $reporte{'mensual'} = $self->estado_mensual_escaneos;

        my %estado=(
            1 => "=",
            2 => "=",
            3 => "=",
        );

    if($reporte{'actual'}) {
        foreach my $key (%estado){
            if($reporte{'actual'}->{$key} > $reporte{'mensual'}->{$key}){
                    $estado{$key}="+";
            }elsif($reporte{'actual'}->{$key} < $reporte{'mensual'}->{$key}){
                    $estado{$key}="-";
            }
        }
    }

    $reporte{'estado'} = \%estado;
    return %reporte;

}

sub estado_alertas_rango {
    my $self = shift;
    my ( $rango ) = @_;

    my $dt = DateTime->today->subtract( days => $rango );
    my %alertas=(
        1 => 0,
        2 => 0,
        3 => 0,
    );
    my $id_serv=$self->id;

    #Para las estadisticas por severidad
    my $alertas_total =$self->alertas->search({'evento.timestamp' => {'>=', $dt->iso8601()}}, {join => {'evento' =>'sig_id'},select => ['sig_priority as nivel','COUNT(*) as cuenta'],group_by => 'sig_id.sig_priority'});

    while (my $nivel = $alertas_total->next) {
        $alertas{$nivel->get_column('sig_priority as nivel')}=$nivel->get_column('COUNT(*) as cuenta');
    }
    
    return \%alertas;
}


sub reporte_alertas_diaria{
    my $self = shift;
    my %reporte;

    $reporte{'actual'} = $self->estado_alertas_rango(1);
    $reporte{'mensual'} = $self->estado_alertas_rango(30);
    #Promediar la mensual
    foreach my $key ($reporte{'mensual'}){
                $reporte{'mensual'}->{$key}= $reporte{'mensual'}->{$key} / 30;
    }

    if($reporte{'actual'}) {
        my %estado=(
            1 => "=",
            2 => "=",
            3 => "=",
        );

        foreach my $key (%estado){
            if($reporte{'actual'}->{$key} > $reporte{'mensual'}->{$key}){
                    $estado{$key}="+";
            }elsif($reporte{'actual'}->{$key} < $reporte{'mensual'}->{$key}){
                    $estado{$key}="-";
            }
        }
    $reporte{'estado'} = \%estado;
    }

    return %reporte;

}

1;
