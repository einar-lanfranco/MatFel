#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'Tesis';
all_from 'lib/Tesis.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;
requires (
		'CPAN' => '1.9',
		'Catalyst::Plugin::Authentication' => '0',
		'Catalyst::Plugin::Session' => '0',
		'Catalyst::Plugin::Session::Store::FastMmap' => '0',
		'Catalyst::Plugin::Session::State::Cookie' => '0',
		'Catalyst::Plugin::StackTrace' => '0',
		'Catalyst::Plugin::Unicode::Encoding'=> '0',
		'Catalyst::Authentication::Realm::SimpleDB'=> '0',
		'Chart::OFC2'=> '0',
		'Catalyst::View::TT',
		'DateTime',
		'XML::RSS',
		'Date::Calc',
		'Geo::IP',
		'Mail::Sendmail',
		'Net::SMTP::SSL',
		'Net::SMTP::TLS',
		'Text::Report',
		'DBIx::Class::TimeStamp',
		'DBIx::Class::EncodedColumn',
		'URI::Find',
		'Date::Manip',
		'XML::RSSLite',
		'Catalyst::Controller::HTML::FormFu',
		'Catalyst::Plugin::Unicode::Encoding',
		'Catalyst::Plugin::Session::State::Cookie',
		'Catalyst::Authentication::Realm::SimpleDB',
		'Text::Report',
		 );
install_script glob('script/*.pl');
auto_install;
WriteAll;
