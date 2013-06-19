package MatFel::Schema::Result::User;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("user");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "username",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "password",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "email_address",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "first_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "last_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "active",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


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
__PACKAGE__->has_many(map_user_roles => 'MatFel::Schema::Result::UserRole', 'user_id');
__PACKAGE__->has_many(servidores => 'MatFel::Schema::Result::Servidor', 'user');
__PACKAGE__->has_many(acciones => 'MatFel::Schema::Result::User_Accion', 'user_id');
# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(roles => 'map_user_roles', 'role');

# Have the 'password' column use a SHA-1 hash and 10-character salt
    # with hex encoding; Generate the 'check_password" method
__PACKAGE__->add_columns(
        'password' => {
            data_type           => "TEXT",
            size                => undef,
            encode_column       => 1,
            encode_class        => 'Digest',
            encode_args         => {algorithm => 'SHA-1', 
                                    format => 'hex'
                                    },
            encode_check_method => 'check_password',
        },
    );

sub last_login{
my ($self)=@_;
return  (($self->acciones->search({ accion => 'login' }, {order_by => { -desc => [qw/timestamp/]}, offset=>1, limit => 1}))[0]);
}

sub last_logout{
my ($self)=@_;
return  (($self->acciones->search({ accion => 'logout' }, {order_by => { -desc => [qw/timestamp/]}}))[0]);
}

sub last_bad_logins{
my ($self)=@_;
my $last_login= last_login($self);
if ($last_login){
return  ($self->acciones->search({ accion => 'errorlogin', timestamp => {'>=', $last_login->timestamp }}, {order_by => { -desc => [qw/timestamp/]}}));}
else{return "";}

}
1;
