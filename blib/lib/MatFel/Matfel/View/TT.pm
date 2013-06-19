package MatFel::View::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    INCLUDE_PATH => [
        MatFel->path_to( 'root', 'src' ),
        MatFel->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0,
    TEMPLATE_EXTENSION => '.tt2',
    ENCODING => 'utf-8',
    render_die => 0,
    render_view => 1,
});

=head1 NAME

MatFel::View::TT - Catalyst TTSite View

=head1 SYNOPSIS

See L<MatFel>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

soporte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

