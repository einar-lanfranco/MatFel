use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'MatFel' }
BEGIN { use_ok 'MatFel::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );


