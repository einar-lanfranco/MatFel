use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'MatFel' }
BEGIN { use_ok 'MatFel::Controller::Servidores' }

ok( request('/servidores')->is_success, 'Request should succeed' );


