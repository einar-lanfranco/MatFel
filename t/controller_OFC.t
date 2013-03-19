use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Tesis' }
BEGIN { use_ok 'Tesis::Controller::OFC' }

ok( request('/ofc')->is_success, 'Request should succeed' );


