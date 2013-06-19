package MatFel::Schema::Result::User_Accion;

use strict;
use warnings;

use base qw/DBIx::Class/;
use MatFel::Controller::Utilidades;
  
# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('user_accion');
# Set columns in table
__PACKAGE__->add_columns(qw/id user_id accion cliente desde timestamp/);
# Set the primary key for the table
__PACKAGE__->set_primary_key(qw/id/);



# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-11-22 13:45:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:E8fMb+2A5sCt2mAZ7RmZoA
#
# Set relationships:
#

# has_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table (aka, foreign key in peer table)
__PACKAGE__->belongs_to(user_id => 'MatFel::Schema::Result::User', 'id');

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
# __PACKAGE__->many_to_many(roles => 'map_user_roles', 'role');

# Have the 'password' column use a SHA-1 hash and 10-character salt
    # with hex encoding; Generate the 'check_password" method

sub geo_country {
my ($self)=@_;
  my $record =0;

if ($self->desde){
  $record= MatFel::Controller::Utilidades::get_geo_ip($self->desde,0);
}

return($record);
}

1;
