use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tesis' }
BEGIN { use_ok 'Tesis::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );


