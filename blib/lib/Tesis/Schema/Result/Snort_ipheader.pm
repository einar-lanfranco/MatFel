package Tesis::Schema::Result::Snort_ipheader;

use strict;
use warnings;

use base qw/DBIx::Class/;
use Socket;
use Tesis::Controller::Utilidades;

# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('iphdr');
# Set columns in table
__PACKAGE__->add_columns(qw/sid cid ip_src ip_dst ip_ver ip_hlen ip_tos ip_len ip_id ip_flags ip_off ip_ttl ip_proto ip_csum/);
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
__PACKAGE__->belongs_to(evento => 'Tesis::Schema::Result::Snort_evento',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->might_have(tcp_header => 'Tesis::Schema::Result::Snort_tcpheader',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->might_have(udp_header => 'Tesis::Schema::Result::Snort_udpheader',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->might_have(icmp_header => 'Tesis::Schema::Result::Snort_icmpheader',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->might_have(data => 'Tesis::Schema::Result::Snort_data',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid'} );
__PACKAGE__->belongs_to(ip_proto => 'Tesis::Schema::Result::Protocolo' );
__PACKAGE__->might_have(opt_proto => 'Tesis::Schema::Result::Snort_opt',{ 'foreign.sid' => 'self.sid','foreign.cid' => 'self.cid','foreign.opt_proto' => "0"});

# __PACKAGE__->belongs_to(id_servidor => 'Tesis::Schema::Result::Servidor');
# __PACKAGE__->belongs_to(protocolo => 'Tesis::Schema::Result::Protocolo');
# __PACKAGE__->belongs_to(estado => 'Tesis::Schema::Result::Estado');    
    
=head1 NAME
	MyAppDB::Servidor - A model object representing a person with access to the system.
=head1 DESCRIPTION
	This is an object that represents a row in the 'Servidor' table of your application
	database.  It uses DBIx::Class (aka, DBIC) to do ORM.
	For Catalyst, this is designed to be used through MyApp::Model::MyAppDB.
	Offline utilities may wish to use this class directly.
=cut

=head2 dec2dot
    
   Esta funcion es interna es para transformar las ips en la forma q las manejan snort-barnyard2 (numero decimal) a el formato tradicional de ipv4
    
=cut


sub dec2dot {
	my ($address) = @_;
	my $d = $address % 256; 
        $address -= $d; 
        $address /= 256;
	my $c = $address % 256; 
        $address -= $c; 
        $address /= 256;
	my $b = $address % 256; 
        $address -= $b; 
        $address /= 256;
	my $a = $address;
	my $dotted="$a.$b.$c.$d";
	return $dotted;
}

sub get_ip_src {
my ($self)=@_;
return(dec2dot($self->ip_src()));
}

sub get_ip_dst {
my ($self)=@_;
return(dec2dot($self->ip_dst()));
}

sub get_port_dst {
my ($self)=@_;

if ($self->ip_proto eq 'ICMP'){ return("ICMP") }
   elsif ($self->ip_proto->nombre eq 'TCP'){return($self->tcp_header->tcp_dport)} 
        elsif ($self->ip_proto->nombre eq 'UDP'){return($self->udp_header->udp_dport)}
            else { return("RESERVED")}
}

sub get_port_src {
my ($self)=@_;

if ($self->ip_proto eq 'ICMP'){ return("ICMP") }
   elsif ($self->ip_proto->nombre eq 'TCP'){return($self->tcp_header->tcp_sport)} 
        elsif ($self->ip_proto->nombre eq 'UDP'){return($self->udp_header->udp_sport)}
            else { return("RESERVED")}
}



sub get_geo_ip_src {
my ($self)=@_;
  return(Tesis::Controller::Utilidades::get_geo_ip($self->get_ip_src,0));
}


sub get_geo_ip_dst {
  my ($self)=@_;
  return(Tesis::Controller::Utilidades::get_geo_ip($self->get_ip_dst,0));
}


sub get_protocolo{
my ($self)=@_;

if ($self->ip_proto eq 'ICMP'){ return($self->icmp_header) }
   elsif ($self->ip_proto->nombre eq 'TCP'){return($self->tcp_header)} 
        elsif ($self->ip_proto->nombre eq 'UDP'){return($self->udp_header)}
            else { return("RESERVED")}
#1 para ICMP, 2 para IGMP, 6 para TCP y 17 para UDP
}

sub get_nombre_src {
my ($self)=@_;
my $iaddr = inet_aton($self->get_ip_src()); # or whatever address
return ((gethostbyaddr($iaddr, AF_INET))[0]);
}

sub get_nombre_dst {
my ($self)=@_;
my $iaddr = inet_aton($self->get_ip_dst()); # or whatever address
return ((gethostbyaddr($iaddr, AF_INET))[0]);
}


=head2 obtener_pdu_superior
    
   Esta funcion esta pensada para devolver los datos de capa superior que esta envolviendo el encabezado ip, como lo que contiene puede ser de distinta naturaleza y snort-barnyard manejan tablas distintas de la ba para cada cosa eso puede ser un problema 
    
=cut
sub obtener_pdu_superior{
my ($self)=@_;
#Lo que esta aca es medio feo, pero es la unica manera que se me ocurrio por ahora, solo manejamos 4 tipos de payloads-alertas: TCP, UDP, ICMP y RAW IP, intente darle la vuelta por medio de las relaciones pero no hubo caso o esta relacionado con uno o con otro,habria q repensarlo

if ($self->ip_proto->id eq 1){ #es icmp
#         return ($c->model('DB::Snort_icmpheader')->find({'sid' => $self->sid, 'cid' => $self->cid }));
        return $self->icmp_header;
         } 
    elsif ($self->ip_proto->id eq 6){#es TCP
# return ($c->model('DB::Snort_tcpheader')->find({'sid' => $self->sid, 'cid' => $self->cid }));
#         return ([$c->model('DB::Servidor')->search({user => $id_user})](0));return $self->tcp_header;           
        return $self->tcp_header;}
    elsif ($self->ip_proto->id eq 17){#es UDP
        return $self->udp_header;}
    elsif ($self->ip_proto->id eq 255){#es RAW IP
        }

}



1;
