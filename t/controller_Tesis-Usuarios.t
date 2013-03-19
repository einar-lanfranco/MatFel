use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tesis' }
BEGIN { use_ok 'Tesis::Controller::Tesis::Usuarios' }

ok( request('/tesis/usuarios')->is_success, 'Request should succeed' );


