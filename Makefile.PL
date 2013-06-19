#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
# Documentacion de como modificarlo podemos encontrarla en http://search.cpan.org/~adamk/Module-Install-1.06/lib/Module/AutoInstall.pm

use inc::Module::Install;
name        'MatFel';
abstract    'Este es el instalador de MatFel';
author      'Einar Lanfranco <einar.lanfranco@gmail.com>';
all_from    'lib/MatFel.pm';
#~ requires 	'parent';
#~ requires 'Catalyst::Runtime' => '5.90003';
#~ requires 'Catalyst::Plugin::ConfigLoader';
#~ requires 'Catalyst::Plugin::Static::Simple';
#~ requires 'Catalyst::Action::RenderView';
#~ requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires (
		'File::Copy::Recursive'=>'0',
		'parent'=>'0',
		'CPAN' => '1.9',
		'Config::General' => '0',
		'Text::Report' => '0',
		'Catalyst::Runtime' => '5.9',
		'Catalyst::Plugin::Authentication' => '0',
		'Catalyst::Plugin::Session' => '0',
		'Catalyst::Plugin::ConfigLoader' => '0',
		'Catalyst::Plugin::Session::Store::FastMmap' => '0',
		'Catalyst::Plugin::Session::State::Cookie' => '0',
		'Catalyst::Plugin::StackTrace' => '0',
		'Catalyst::Plugin::Unicode::Encoding'=> '0',
		'Catalyst::Authentication::Realm::SimpleDB'=> '0',
		'Catalyst::Controller::HTML::FormFu'=> '0',
		'Catalyst::Plugin::Static::Simple' =>'0',
		'Catalyst::Action::RenderView' => '0',
		'Catalyst::View::TT'=> '0',
		'Chart::OFC2'=> '0',
		'DateTime'=> '0',
		'XML::RSS'=> '0',
		'Date::Calc'=> '0',
		'Geo::IP'=> '0',
		'Mail::Sendmail'=> '0',
		'Net::SMTP::SSL'=> '0',
		'Net::SMTP::TLS'=> '0',
		'Text::Report'=> '0',
		'DBIx::Class::TimeStamp'=> '0',
		'DBIx::Class::EncodedColumn'=> '0',
		'URI::Find'=> '0',
		'Date::Manip'=> '0',
		'XML::RSSLite'=> '0',
		 );
catalyst;
install_script glob('script/*.pl');
auto_install;
WriteAll;
