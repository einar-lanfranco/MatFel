package MatFel::Schema::Result::OV_frecuencia;

use strict;
use warnings;

use base qw/DBIx::Class/;
    
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('ov_frecuencia');
# Set columns in table
__PACKAGE__->add_columns(qw/id descripcion/);
# Set the primary key for the table
__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(escaneos => 'MatFel::Schema::Result::OV_scan', 'frecuencia');
1;
