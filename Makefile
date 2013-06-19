# This Makefile is for the MatFel extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.55_02 (Revision: 65502) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Este es el instalador de MatFel]
#     AUTHOR => q[Einar Lanfranco <einar.lanfranco@gmail.com>]
#     BUILD_REQUIRES => {  }
#     DIR => []
#     DISTNAME => q[MatFel]
#     EXE_FILES => [q[script/actualizar_alertas.pl], q[script/matfel_cgi.pl], q[script/matfel_create.pl], q[script/matfel_fastcgi.pl], q[script/matfel_server.pl], q[script/matfel_test.pl], q[script/openvas_cron.pl], q[script/openvas_cron_diario.pl], q[script/openvas_cron_mensual.pl], q[script/openvas_cron_semanal.pl], q[script/prueba.pl], q[script/tesis_cgi.pl], q[script/tesis_create.pl], q[script/tesis_fastcgi.pl], q[script/tesis_server.pl], q[script/tesis_test.pl], q[script/update-nessusrc.pl]]
#     NAME => q[MatFel]
#     NO_META => q[1]
#     PL_FILES => {  }
#     PREREQ_PM => { DateTime=>q[0], Catalyst::Plugin::ConfigLoader=>q[0], Net::SMTP::TLS=>q[0], Catalyst::Plugin::Session::Store::FastMmap=>q[0], Catalyst::Plugin::Session::State::Cookie=>q[0], Text::Report=>q[0], Config::General=>q[0], Catalyst::View::TT=>q[0], DBIx::Class::EncodedColumn=>q[0], parent=>q[0], ExtUtils::MakeMaker=>q[6.42], Catalyst::Plugin::Session=>q[0], Date::Calc=>q[0], Mail::Sendmail=>q[0], XML::RSSLite=>q[0], Catalyst::Authentication::Realm::SimpleDB=>q[0], File::Copy::Recursive=>q[0], Date::Manip=>q[0], XML::RSS=>q[0], Catalyst::Controller::HTML::FormFu=>q[0], Chart::OFC2=>q[0], Catalyst::Plugin::Static::Simple=>q[0], DBIx::Class::TimeStamp=>q[0], Catalyst::Plugin::StackTrace=>q[0], Geo::IP=>q[0], Catalyst::Action::RenderView=>q[0], URI::Find=>q[0], Catalyst::Plugin::Unicode::Encoding=>q[0], Catalyst::Plugin::Authentication=>q[0], CPAN=>q[1.9], Net::SMTP::SSL=>q[0], Catalyst::Runtime=>q[5.9] }
#     VERSION => q[0.01]
#     dist => {  }
#     realclean => { FILES=>q[MYMETA.yml] }
#     test => { TESTS=>q[t/01app.t t/02pod.t t/03podcoverage.t t/controller_Escaneos.t t/controller_Login.t t/controller_Logout.t t/controller_OFC.t t/controller_Servidores.t t/controller_Tesis-Usuarios.t t/controller_Usuarios.t t/model_DB.t t/model_MyAppDB.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl/5.10/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -O2 -g -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = /lib/libc-2.11.3.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.32-5-amd64
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.10.1
SITEARCHEXP = /usr/local/lib/perl/5.10.1
SO = so
VENDORARCHEXP = /usr/lib/perl5
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = MatFel
NAME_SYM = MatFel
VERSION = 0.01
VERSION_MACRO = VERSION
VERSION_SYM = 0_01
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.01
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = /usr
PERLPREFIX = $(PREFIX)
SITEPREFIX = $(PREFIX)/local
VENDORPREFIX = $(PREFIX)
INSTALLPRIVLIB = $(PERLPREFIX)/share/perl/5.10
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.10.1
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(VENDORPREFIX)/share/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(PERLPREFIX)/lib/perl/5.10
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(SITEPREFIX)/lib/perl/5.10.1
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(VENDORPREFIX)/lib/perl5
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(PERLPREFIX)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(SITEPREFIX)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(VENDORPREFIX)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(PERLPREFIX)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(SITEPREFIX)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(VENDORPREFIX)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(PERLPREFIX)/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(SITEPREFIX)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(VENDORPREFIX)/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(PERLPREFIX)/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(SITEPREFIX)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(VENDORPREFIX)/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /usr/lib/perl/5.10
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl/5.10/CORE
PERL = /usr/bin/perl "-Iinc"
FULLPERL = /usr/bin/perl "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.10/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.55_02
MM_REVISION = 65502

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = MatFel
BASEEXT = MatFel
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = 
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/matfel_cgi.pl \
	script/matfel_create.pl \
	script/matfel_fastcgi.pl \
	script/matfel_server.pl \
	script/matfel_test.pl \
	script/tesis_cgi.pl \
	script/tesis_create.pl \
	script/tesis_fastcgi.pl \
	script/tesis_server.pl \
	script/tesis_test.pl \
	script/update-nessusrc.pl
MAN3PODS = lib/MatFel.pm \
	lib/MatFel/Controller/Alertas.pm \
	lib/MatFel/Controller/Cron.pm \
	lib/MatFel/Controller/Escaneos.pm \
	lib/MatFel/Controller/Login.pm \
	lib/MatFel/Controller/Logout.pm \
	lib/MatFel/Controller/Mail.pm \
	lib/MatFel/Controller/Monitoreo.pm \
	lib/MatFel/Controller/OFC.pm \
	lib/MatFel/Controller/Preferencias.pm \
	lib/MatFel/Controller/Root.pm \
	lib/MatFel/Controller/Servidores.pm \
	lib/MatFel/Controller/Trafico.pm \
	lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	lib/MatFel/Controller/Trafico_entrada.pm \
	lib/MatFel/Controller/Trafico_salida.pm \
	lib/MatFel/Controller/Usuarios.pm \
	lib/MatFel/Controller/Utilidades.pm \
	lib/MatFel/Model/DB.pm \
	lib/MatFel/Schema/Result/Alerta.pm \
	lib/MatFel/Schema/Result/Estado.pm \
	lib/MatFel/Schema/Result/OV_risk_factor.pm \
	lib/MatFel/Schema/Result/OV_scan.pm \
	lib/MatFel/Schema/Result/OV_scanresults.pm \
	lib/MatFel/Schema/Result/Preferencia.pm \
	lib/MatFel/Schema/Result/Protocolo.pm \
	lib/MatFel/Schema/Result/Servidor.pm \
	lib/MatFel/Schema/Result/Snort_data.pm \
	lib/MatFel/Schema/Result/Snort_evento.pm \
	lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	lib/MatFel/Schema/Result/Snort_ipheader.pm \
	lib/MatFel/Schema/Result/Snort_opt.pm \
	lib/MatFel/Schema/Result/Snort_opt_code.pm \
	lib/MatFel/Schema/Result/Snort_reference_system.pm \
	lib/MatFel/Schema/Result/Snort_referencia.pm \
	lib/MatFel/Schema/Result/Snort_sigClass.pm \
	lib/MatFel/Schema/Result/Snort_sig_reference.pm \
	lib/MatFel/Schema/Result/Snort_signature.pm \
	lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	lib/MatFel/Schema/Result/Snort_udpheader.pm \
	lib/MatFel/Schema/Result/Snort_url_reference.pm \
	lib/MatFel/Schema/Result/Trafico_entrada.pm \
	lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	lib/MatFel/Schema/Result/Trafico_salida.pm \
	lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	lib/MatFel/View/TT.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/MatFel.pm \
	lib/MatFel/Controller/Alertas.pm \
	lib/MatFel/Controller/Cron.pm \
	lib/MatFel/Controller/Escaneos.pm \
	lib/MatFel/Controller/Login.pm \
	lib/MatFel/Controller/Logout.pm \
	lib/MatFel/Controller/Mail.pm \
	lib/MatFel/Controller/Monitoreo.pm \
	lib/MatFel/Controller/OFC.pm \
	lib/MatFel/Controller/Preferencias.pm \
	lib/MatFel/Controller/Root.pm \
	lib/MatFel/Controller/Servidores.pm \
	lib/MatFel/Controller/Trafico.pm \
	lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	lib/MatFel/Controller/Trafico_entrada.pm \
	lib/MatFel/Controller/Trafico_salida.pm \
	lib/MatFel/Controller/Usuarios.pm \
	lib/MatFel/Controller/Utilidades.pm \
	lib/MatFel/Model/DB.pm \
	lib/MatFel/Schema.pm \
	lib/MatFel/Schema/Result/Alerta.pm \
	lib/MatFel/Schema/Result/Estado.pm \
	lib/MatFel/Schema/Result/OV_estado.pm \
	lib/MatFel/Schema/Result/OV_frecuencia.pm \
	lib/MatFel/Schema/Result/OV_risk_factor.pm \
	lib/MatFel/Schema/Result/OV_scan.pm \
	lib/MatFel/Schema/Result/OV_scanresults.pm \
	lib/MatFel/Schema/Result/Preferencia.pm \
	lib/MatFel/Schema/Result/Protocolo.pm \
	lib/MatFel/Schema/Result/Role.pm \
	lib/MatFel/Schema/Result/Servidor.pm \
	lib/MatFel/Schema/Result/Snort_data.pm \
	lib/MatFel/Schema/Result/Snort_evento.pm \
	lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	lib/MatFel/Schema/Result/Snort_ipheader.pm \
	lib/MatFel/Schema/Result/Snort_opt.pm \
	lib/MatFel/Schema/Result/Snort_opt_code.pm \
	lib/MatFel/Schema/Result/Snort_reference_system.pm \
	lib/MatFel/Schema/Result/Snort_referencia.pm \
	lib/MatFel/Schema/Result/Snort_sigClass.pm \
	lib/MatFel/Schema/Result/Snort_sig_reference.pm \
	lib/MatFel/Schema/Result/Snort_signature.pm \
	lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	lib/MatFel/Schema/Result/Snort_udpheader.pm \
	lib/MatFel/Schema/Result/Snort_url_reference.pm \
	lib/MatFel/Schema/Result/Trafico_entrada.pm \
	lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	lib/MatFel/Schema/Result/Trafico_salida.pm \
	lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	lib/MatFel/Schema/Result/User.pm \
	lib/MatFel/Schema/Result/UserRole.pm \
	lib/MatFel/Schema/Result/User_Accion.pm \
	lib/MatFel/View/TT.pm \
	lib/OV.pm

PM_TO_BLIB = lib/MatFel/Schema/Result/Trafico_salida.pm \
	blib/lib/MatFel/Schema/Result/Trafico_salida.pm \
	lib/MatFel/Schema/Result/OV_risk_factor.pm \
	blib/lib/MatFel/Schema/Result/OV_risk_factor.pm \
	lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	blib/lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	lib/MatFel/Controller/Login.pm \
	blib/lib/MatFel/Controller/Login.pm \
	lib/MatFel/Controller/Monitoreo.pm \
	blib/lib/MatFel/Controller/Monitoreo.pm \
	lib/MatFel/Controller/Root.pm \
	blib/lib/MatFel/Controller/Root.pm \
	lib/MatFel/Controller/Trafico.pm \
	blib/lib/MatFel/Controller/Trafico.pm \
	lib/MatFel/Controller/Trafico_entrada.pm \
	blib/lib/MatFel/Controller/Trafico_entrada.pm \
	lib/MatFel/Controller/Cron.pm \
	blib/lib/MatFel/Controller/Cron.pm \
	lib/MatFel/Schema/Result/UserRole.pm \
	blib/lib/MatFel/Schema/Result/UserRole.pm \
	lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	blib/lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	lib/MatFel/Schema/Result/Snort_referencia.pm \
	blib/lib/MatFel/Schema/Result/Snort_referencia.pm \
	lib/MatFel/Schema/Result/Protocolo.pm \
	blib/lib/MatFel/Schema/Result/Protocolo.pm \
	lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	blib/lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	lib/MatFel/Controller/Utilidades.pm \
	blib/lib/MatFel/Controller/Utilidades.pm \
	lib/MatFel/Schema/Result/Snort_ipheader.pm \
	blib/lib/MatFel/Schema/Result/Snort_ipheader.pm \
	lib/MatFel/Schema/Result/Estado.pm \
	blib/lib/MatFel/Schema/Result/Estado.pm \
	lib/MatFel/Schema.pm \
	blib/lib/MatFel/Schema.pm \
	lib/MatFel/Schema/Result/Snort_signature.pm \
	blib/lib/MatFel/Schema/Result/Snort_signature.pm \
	lib/MatFel/Controller/Escaneos.pm \
	blib/lib/MatFel/Controller/Escaneos.pm \
	lib/MatFel/Controller/Alertas.pm \
	blib/lib/MatFel/Controller/Alertas.pm \
	lib/MatFel/Controller/Logout.pm \
	blib/lib/MatFel/Controller/Logout.pm \
	lib/MatFel/Controller/Servidores.pm \
	blib/lib/MatFel/Controller/Servidores.pm \
	lib/OV.pm \
	blib/lib/OV.pm \
	lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	blib/lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	lib/MatFel/Controller/Preferencias.pm \
	blib/lib/MatFel/Controller/Preferencias.pm \
	lib/MatFel/View/TT.pm \
	blib/lib/MatFel/View/TT.pm \
	lib/MatFel/Schema/Result/Servidor.pm \
	blib/lib/MatFel/Schema/Result/Servidor.pm \
	lib/MatFel/Schema/Result/Preferencia.pm \
	blib/lib/MatFel/Schema/Result/Preferencia.pm \
	lib/MatFel/Schema/Result/Snort_evento.pm \
	blib/lib/MatFel/Schema/Result/Snort_evento.pm \
	lib/MatFel/Controller/Mail.pm \
	blib/lib/MatFel/Controller/Mail.pm \
	lib/MatFel/Model/DB.pm \
	blib/lib/MatFel/Model/DB.pm \
	lib/MatFel/Schema/Result/Snort_sig_reference.pm \
	blib/lib/MatFel/Schema/Result/Snort_sig_reference.pm \
	lib/MatFel/Schema/Result/User.pm \
	blib/lib/MatFel/Schema/Result/User.pm \
	lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	blib/lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	lib/MatFel/Schema/Result/OV_estado.pm \
	blib/lib/MatFel/Schema/Result/OV_estado.pm \
	lib/MatFel/Controller/Trafico_salida.pm \
	blib/lib/MatFel/Controller/Trafico_salida.pm \
	lib/MatFel/Schema/Result/Snort_reference_system.pm \
	blib/lib/MatFel/Schema/Result/Snort_reference_system.pm \
	lib/MatFel/Controller/Usuarios.pm \
	blib/lib/MatFel/Controller/Usuarios.pm \
	lib/MatFel/Schema/Result/OV_scanresults.pm \
	blib/lib/MatFel/Schema/Result/OV_scanresults.pm \
	lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	blib/lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	lib/MatFel.pm \
	blib/lib/MatFel.pm \
	lib/MatFel/Schema/Result/OV_scan.pm \
	blib/lib/MatFel/Schema/Result/OV_scan.pm \
	lib/MatFel/Schema/Result/Snort_opt_code.pm \
	blib/lib/MatFel/Schema/Result/Snort_opt_code.pm \
	lib/MatFel/Schema/Result/Alerta.pm \
	blib/lib/MatFel/Schema/Result/Alerta.pm \
	lib/MatFel/Schema/Result/Snort_udpheader.pm \
	blib/lib/MatFel/Schema/Result/Snort_udpheader.pm \
	lib/MatFel/Controller/OFC.pm \
	blib/lib/MatFel/Controller/OFC.pm \
	lib/MatFel/Schema/Result/Snort_sigClass.pm \
	blib/lib/MatFel/Schema/Result/Snort_sigClass.pm \
	lib/MatFel/Schema/Result/OV_frecuencia.pm \
	blib/lib/MatFel/Schema/Result/OV_frecuencia.pm \
	lib/MatFel/Schema/Result/User_Accion.pm \
	blib/lib/MatFel/Schema/Result/User_Accion.pm \
	lib/MatFel/Schema/Result/Snort_data.pm \
	blib/lib/MatFel/Schema/Result/Snort_data.pm \
	lib/MatFel/Schema/Result/Role.pm \
	blib/lib/MatFel/Schema/Result/Role.pm \
	lib/MatFel/Schema/Result/Trafico_entrada.pm \
	blib/lib/MatFel/Schema/Result/Trafico_entrada.pm \
	lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	blib/lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	lib/MatFel/Schema/Result/Snort_url_reference.pm \
	blib/lib/MatFel/Schema/Result/Snort_url_reference.pm \
	lib/MatFel/Schema/Result/Snort_opt.pm \
	blib/lib/MatFel/Schema/Result/Snort_opt.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.55_02
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = MatFel
DISTVNAME = MatFel-0.01


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	script/matfel_server.pl \
	script/matfel_cgi.pl \
	script/matfel_create.pl \
	script/tesis_create.pl \
	script/tesis_test.pl \
	script/matfel_fastcgi.pl \
	script/tesis_server.pl \
	script/tesis_cgi.pl \
	script/tesis_fastcgi.pl \
	script/matfel_test.pl \
	script/update-nessusrc.pl \
	lib/MatFel/Schema/Result/Trafico_salida.pm \
	lib/MatFel/Schema/Result/OV_risk_factor.pm \
	lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	lib/MatFel/Controller/Login.pm \
	lib/MatFel/Controller/Monitoreo.pm \
	lib/MatFel/Controller/Root.pm \
	lib/MatFel/Controller/Trafico.pm \
	lib/MatFel/Controller/Trafico_entrada.pm \
	lib/MatFel/Controller/Cron.pm \
	lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	lib/MatFel/Schema/Result/Snort_referencia.pm \
	lib/MatFel/Schema/Result/Protocolo.pm \
	lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	lib/MatFel/Controller/Utilidades.pm \
	lib/MatFel/Schema/Result/Snort_ipheader.pm \
	lib/MatFel/Schema/Result/Estado.pm \
	lib/MatFel/Schema/Result/Snort_signature.pm \
	lib/MatFel/Controller/Escaneos.pm \
	lib/MatFel/Controller/Alertas.pm \
	lib/MatFel/Controller/Logout.pm \
	lib/MatFel/Controller/Servidores.pm \
	lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	lib/MatFel/Controller/Preferencias.pm \
	lib/MatFel/View/TT.pm \
	lib/MatFel/Schema/Result/Servidor.pm \
	lib/MatFel/Schema/Result/Preferencia.pm \
	lib/MatFel/Schema/Result/Snort_evento.pm \
	lib/MatFel/Controller/Mail.pm \
	lib/MatFel/Model/DB.pm \
	lib/MatFel/Schema/Result/Snort_sig_reference.pm \
	lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	lib/MatFel/Controller/Trafico_salida.pm \
	lib/MatFel/Schema/Result/Snort_reference_system.pm \
	lib/MatFel/Controller/Usuarios.pm \
	lib/MatFel/Schema/Result/OV_scanresults.pm \
	lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	lib/MatFel.pm \
	lib/MatFel/Schema/Result/OV_scan.pm \
	lib/MatFel/Schema/Result/Snort_opt_code.pm \
	lib/MatFel/Schema/Result/Alerta.pm \
	lib/MatFel/Schema/Result/Snort_udpheader.pm \
	lib/MatFel/Controller/OFC.pm \
	lib/MatFel/Schema/Result/Snort_sigClass.pm \
	lib/MatFel/Schema/Result/Snort_data.pm \
	lib/MatFel/Schema/Result/Trafico_entrada.pm \
	lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	lib/MatFel/Schema/Result/Snort_url_reference.pm \
	lib/MatFel/Schema/Result/Snort_opt.pm
	$(NOECHO) $(POD2MAN) --section=$(MAN1EXT) --perm_rw=$(PERM_RW) \
	  script/matfel_server.pl $(INST_MAN1DIR)/matfel_server.pl.$(MAN1EXT) \
	  script/matfel_cgi.pl $(INST_MAN1DIR)/matfel_cgi.pl.$(MAN1EXT) \
	  script/matfel_create.pl $(INST_MAN1DIR)/matfel_create.pl.$(MAN1EXT) \
	  script/tesis_create.pl $(INST_MAN1DIR)/tesis_create.pl.$(MAN1EXT) \
	  script/tesis_test.pl $(INST_MAN1DIR)/tesis_test.pl.$(MAN1EXT) \
	  script/matfel_fastcgi.pl $(INST_MAN1DIR)/matfel_fastcgi.pl.$(MAN1EXT) \
	  script/tesis_server.pl $(INST_MAN1DIR)/tesis_server.pl.$(MAN1EXT) \
	  script/tesis_cgi.pl $(INST_MAN1DIR)/tesis_cgi.pl.$(MAN1EXT) \
	  script/tesis_fastcgi.pl $(INST_MAN1DIR)/tesis_fastcgi.pl.$(MAN1EXT) \
	  script/matfel_test.pl $(INST_MAN1DIR)/matfel_test.pl.$(MAN1EXT) \
	  script/update-nessusrc.pl $(INST_MAN1DIR)/update-nessusrc.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/MatFel/Schema/Result/Trafico_salida.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Trafico_salida.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/OV_risk_factor.pm $(INST_MAN3DIR)/MatFel::Schema::Result::OV_risk_factor.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Trafico_salida_bloqueado.$(MAN3EXT) \
	  lib/MatFel/Controller/Login.pm $(INST_MAN3DIR)/MatFel::Controller::Login.$(MAN3EXT) \
	  lib/MatFel/Controller/Monitoreo.pm $(INST_MAN3DIR)/MatFel::Controller::Monitoreo.$(MAN3EXT) \
	  lib/MatFel/Controller/Root.pm $(INST_MAN3DIR)/MatFel::Controller::Root.$(MAN3EXT) \
	  lib/MatFel/Controller/Trafico.pm $(INST_MAN3DIR)/MatFel::Controller::Trafico.$(MAN3EXT) \
	  lib/MatFel/Controller/Trafico_entrada.pm $(INST_MAN3DIR)/MatFel::Controller::Trafico_entrada.$(MAN3EXT) \
	  lib/MatFel/Controller/Cron.pm $(INST_MAN3DIR)/MatFel::Controller::Cron.$(MAN3EXT) \
	  lib/MatFel/Controller/Trafico_bloqueado_salida.pm $(INST_MAN3DIR)/MatFel::Controller::Trafico_bloqueado_salida.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_referencia.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_referencia.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Protocolo.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Protocolo.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Trafico_entrada_bloqueado.$(MAN3EXT) \
	  lib/MatFel/Controller/Utilidades.pm $(INST_MAN3DIR)/MatFel::Controller::Utilidades.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_ipheader.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_ipheader.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Estado.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Estado.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_signature.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_signature.$(MAN3EXT) \
	  lib/MatFel/Controller/Escaneos.pm $(INST_MAN3DIR)/MatFel::Controller::Escaneos.$(MAN3EXT) \
	  lib/MatFel/Controller/Alertas.pm $(INST_MAN3DIR)/MatFel::Controller::Alertas.$(MAN3EXT) \
	  lib/MatFel/Controller/Logout.pm $(INST_MAN3DIR)/MatFel::Controller::Logout.$(MAN3EXT) \
	  lib/MatFel/Controller/Servidores.pm $(INST_MAN3DIR)/MatFel::Controller::Servidores.$(MAN3EXT) \
	  lib/MatFel/Controller/Trafico_bloqueado_entrada.pm $(INST_MAN3DIR)/MatFel::Controller::Trafico_bloqueado_entrada.$(MAN3EXT) \
	  lib/MatFel/Controller/Preferencias.pm $(INST_MAN3DIR)/MatFel::Controller::Preferencias.$(MAN3EXT) \
	  lib/MatFel/View/TT.pm $(INST_MAN3DIR)/MatFel::View::TT.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Servidor.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Servidor.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Preferencia.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Preferencia.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_evento.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_evento.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  lib/MatFel/Controller/Mail.pm $(INST_MAN3DIR)/MatFel::Controller::Mail.$(MAN3EXT) \
	  lib/MatFel/Model/DB.pm $(INST_MAN3DIR)/MatFel::Model::DB.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_sig_reference.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_sig_reference.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_icmp_type.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_icmp_type.$(MAN3EXT) \
	  lib/MatFel/Controller/Trafico_salida.pm $(INST_MAN3DIR)/MatFel::Controller::Trafico_salida.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_reference_system.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_reference_system.$(MAN3EXT) \
	  lib/MatFel/Controller/Usuarios.pm $(INST_MAN3DIR)/MatFel::Controller::Usuarios.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/OV_scanresults.pm $(INST_MAN3DIR)/MatFel::Schema::Result::OV_scanresults.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_icmpheader.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_icmpheader.$(MAN3EXT) \
	  lib/MatFel.pm $(INST_MAN3DIR)/MatFel.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/OV_scan.pm $(INST_MAN3DIR)/MatFel::Schema::Result::OV_scan.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_opt_code.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_opt_code.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Alerta.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Alerta.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_udpheader.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_udpheader.$(MAN3EXT) \
	  lib/MatFel/Controller/OFC.pm $(INST_MAN3DIR)/MatFel::Controller::OFC.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_sigClass.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_sigClass.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_data.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_data.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Trafico_entrada.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Trafico_entrada.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_tcpheader.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_tcpheader.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_url_reference.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_url_reference.$(MAN3EXT) \
	  lib/MatFel/Schema/Result/Snort_opt.pm $(INST_MAN3DIR)/MatFel::Schema::Result::Snort_opt.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/actualizar_alertas.pl script/matfel_cgi.pl script/matfel_create.pl script/matfel_fastcgi.pl script/matfel_server.pl script/matfel_test.pl script/openvas_cron.pl script/openvas_cron_diario.pl script/openvas_cron_mensual.pl script/openvas_cron_semanal.pl script/prueba.pl script/tesis_cgi.pl script/tesis_create.pl script/tesis_fastcgi.pl script/tesis_server.pl script/tesis_test.pl script/update-nessusrc.pl

pure_all :: $(INST_SCRIPT)/matfel_server.pl $(INST_SCRIPT)/matfel_cgi.pl $(INST_SCRIPT)/openvas_cron.pl $(INST_SCRIPT)/tesis_test.pl $(INST_SCRIPT)/openvas_cron_mensual.pl $(INST_SCRIPT)/prueba.pl $(INST_SCRIPT)/openvas_cron_diario.pl $(INST_SCRIPT)/tesis_server.pl $(INST_SCRIPT)/tesis_fastcgi.pl $(INST_SCRIPT)/matfel_test.pl $(INST_SCRIPT)/update-nessusrc.pl $(INST_SCRIPT)/openvas_cron_semanal.pl $(INST_SCRIPT)/actualizar_alertas.pl $(INST_SCRIPT)/matfel_create.pl $(INST_SCRIPT)/tesis_create.pl $(INST_SCRIPT)/matfel_fastcgi.pl $(INST_SCRIPT)/tesis_cgi.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/matfel_server.pl $(INST_SCRIPT)/matfel_cgi.pl \
	  $(INST_SCRIPT)/openvas_cron.pl $(INST_SCRIPT)/tesis_test.pl \
	  $(INST_SCRIPT)/openvas_cron_mensual.pl $(INST_SCRIPT)/prueba.pl \
	  $(INST_SCRIPT)/openvas_cron_diario.pl $(INST_SCRIPT)/tesis_server.pl \
	  $(INST_SCRIPT)/tesis_fastcgi.pl $(INST_SCRIPT)/matfel_test.pl \
	  $(INST_SCRIPT)/update-nessusrc.pl $(INST_SCRIPT)/openvas_cron_semanal.pl \
	  $(INST_SCRIPT)/actualizar_alertas.pl $(INST_SCRIPT)/matfel_create.pl \
	  $(INST_SCRIPT)/tesis_create.pl $(INST_SCRIPT)/matfel_fastcgi.pl \
	  $(INST_SCRIPT)/tesis_cgi.pl 

$(INST_SCRIPT)/matfel_server.pl : script/matfel_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/matfel_server.pl
	$(CP) script/matfel_server.pl $(INST_SCRIPT)/matfel_server.pl
	$(FIXIN) $(INST_SCRIPT)/matfel_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/matfel_server.pl

$(INST_SCRIPT)/matfel_cgi.pl : script/matfel_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/matfel_cgi.pl
	$(CP) script/matfel_cgi.pl $(INST_SCRIPT)/matfel_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/matfel_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/matfel_cgi.pl

$(INST_SCRIPT)/openvas_cron.pl : script/openvas_cron.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/openvas_cron.pl
	$(CP) script/openvas_cron.pl $(INST_SCRIPT)/openvas_cron.pl
	$(FIXIN) $(INST_SCRIPT)/openvas_cron.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/openvas_cron.pl

$(INST_SCRIPT)/tesis_test.pl : script/tesis_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/tesis_test.pl
	$(CP) script/tesis_test.pl $(INST_SCRIPT)/tesis_test.pl
	$(FIXIN) $(INST_SCRIPT)/tesis_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/tesis_test.pl

$(INST_SCRIPT)/openvas_cron_mensual.pl : script/openvas_cron_mensual.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/openvas_cron_mensual.pl
	$(CP) script/openvas_cron_mensual.pl $(INST_SCRIPT)/openvas_cron_mensual.pl
	$(FIXIN) $(INST_SCRIPT)/openvas_cron_mensual.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/openvas_cron_mensual.pl

$(INST_SCRIPT)/prueba.pl : script/prueba.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/prueba.pl
	$(CP) script/prueba.pl $(INST_SCRIPT)/prueba.pl
	$(FIXIN) $(INST_SCRIPT)/prueba.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/prueba.pl

$(INST_SCRIPT)/openvas_cron_diario.pl : script/openvas_cron_diario.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/openvas_cron_diario.pl
	$(CP) script/openvas_cron_diario.pl $(INST_SCRIPT)/openvas_cron_diario.pl
	$(FIXIN) $(INST_SCRIPT)/openvas_cron_diario.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/openvas_cron_diario.pl

$(INST_SCRIPT)/tesis_server.pl : script/tesis_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/tesis_server.pl
	$(CP) script/tesis_server.pl $(INST_SCRIPT)/tesis_server.pl
	$(FIXIN) $(INST_SCRIPT)/tesis_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/tesis_server.pl

$(INST_SCRIPT)/tesis_fastcgi.pl : script/tesis_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/tesis_fastcgi.pl
	$(CP) script/tesis_fastcgi.pl $(INST_SCRIPT)/tesis_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/tesis_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/tesis_fastcgi.pl

$(INST_SCRIPT)/matfel_test.pl : script/matfel_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/matfel_test.pl
	$(CP) script/matfel_test.pl $(INST_SCRIPT)/matfel_test.pl
	$(FIXIN) $(INST_SCRIPT)/matfel_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/matfel_test.pl

$(INST_SCRIPT)/update-nessusrc.pl : script/update-nessusrc.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/update-nessusrc.pl
	$(CP) script/update-nessusrc.pl $(INST_SCRIPT)/update-nessusrc.pl
	$(FIXIN) $(INST_SCRIPT)/update-nessusrc.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/update-nessusrc.pl

$(INST_SCRIPT)/openvas_cron_semanal.pl : script/openvas_cron_semanal.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/openvas_cron_semanal.pl
	$(CP) script/openvas_cron_semanal.pl $(INST_SCRIPT)/openvas_cron_semanal.pl
	$(FIXIN) $(INST_SCRIPT)/openvas_cron_semanal.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/openvas_cron_semanal.pl

$(INST_SCRIPT)/actualizar_alertas.pl : script/actualizar_alertas.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/actualizar_alertas.pl
	$(CP) script/actualizar_alertas.pl $(INST_SCRIPT)/actualizar_alertas.pl
	$(FIXIN) $(INST_SCRIPT)/actualizar_alertas.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/actualizar_alertas.pl

$(INST_SCRIPT)/matfel_create.pl : script/matfel_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/matfel_create.pl
	$(CP) script/matfel_create.pl $(INST_SCRIPT)/matfel_create.pl
	$(FIXIN) $(INST_SCRIPT)/matfel_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/matfel_create.pl

$(INST_SCRIPT)/tesis_create.pl : script/tesis_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/tesis_create.pl
	$(CP) script/tesis_create.pl $(INST_SCRIPT)/tesis_create.pl
	$(FIXIN) $(INST_SCRIPT)/tesis_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/tesis_create.pl

$(INST_SCRIPT)/matfel_fastcgi.pl : script/matfel_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/matfel_fastcgi.pl
	$(CP) script/matfel_fastcgi.pl $(INST_SCRIPT)/matfel_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/matfel_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/matfel_fastcgi.pl

$(INST_SCRIPT)/tesis_cgi.pl : script/tesis_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/tesis_cgi.pl
	$(CP) script/tesis_cgi.pl $(INST_SCRIPT)/tesis_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/tesis_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/tesis_cgi.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  *$(LIB_EXT) core \
	  core.[0-9] $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] $(BASEEXT).bso \
	  pm_to_blib.ts core.[0-9][0-9][0-9][0-9] \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  perl$(EXE_EXT) tmon.out \
	  *$(OBJ_EXT) pm_to_blib \
	  $(INST_ARCHAUTODIR)/extralibs.ld blibdirs.ts \
	  core.[0-9][0-9][0-9][0-9][0-9] *perl.core \
	  core.*perl.*.? $(MAKE_APERL_FILE) \
	  perl $(BASEEXT).def \
	  core.[0-9][0-9][0-9] mon.out \
	  lib$(BASEEXT).def perlmain.c \
	  perl.exe so_locations \
	  $(BASEEXT).exp 
	- $(RM_RF) \
	  blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  MYMETA.yml $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{META.yml} => q{Module meta-data (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLSITEARCH)/perllocal.pod
	-$(NOECHO) umask 02; $(MKPATH) $(DESTINSTALLSITEARCH)
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLSITEARCH)/perllocal.pod

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::



# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/01app.t t/02pod.t t/03podcoverage.t t/controller_Escaneos.t t/controller_Login.t t/controller_Logout.t t/controller_OFC.t t/controller_Servidores.t t/controller_Tesis-Usuarios.t t/controller_Usuarios.t t/model_DB.t t/model_MyAppDB.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0.01">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Este es el instalador de MatFel</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Einar Lanfranco &lt;einar.lanfranco@gmail.com&gt;</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="CPAN::" VERSION="1.9" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Action::RenderView" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Authentication::Realm::SimpleDB" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Controller::HTML::FormFu" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authentication" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::ConfigLoader" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::State::Cookie" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::Store::FastMmap" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::StackTrace" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Static::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Unicode::Encoding" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Runtime" VERSION="5.9" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::View::TT" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Chart::OFC2" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::General" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBIx::Class::EncodedColumn" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBIx::Class::TimeStamp" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Date::Calc" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Date::Manip" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTime::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="ExtUtils::MakeMaker" VERSION="6.42" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="File::Copy::Recursive" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Geo::IP" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Mail::Sendmail" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Net::SMTP::SSL" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Net::SMTP::TLS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Text::Report" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="URI::Find" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="XML::RSS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="XML::RSSLite" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="parent::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="i486-linux-gnu-thread-multi-5.10" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/MatFel/Schema/Result/Trafico_salida.pm blib/lib/MatFel/Schema/Result/Trafico_salida.pm \
	  lib/MatFel/Schema/Result/OV_risk_factor.pm blib/lib/MatFel/Schema/Result/OV_risk_factor.pm \
	  lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm blib/lib/MatFel/Schema/Result/Trafico_salida_bloqueado.pm \
	  lib/MatFel/Controller/Login.pm blib/lib/MatFel/Controller/Login.pm \
	  lib/MatFel/Controller/Monitoreo.pm blib/lib/MatFel/Controller/Monitoreo.pm \
	  lib/MatFel/Controller/Root.pm blib/lib/MatFel/Controller/Root.pm \
	  lib/MatFel/Controller/Trafico.pm blib/lib/MatFel/Controller/Trafico.pm \
	  lib/MatFel/Controller/Trafico_entrada.pm blib/lib/MatFel/Controller/Trafico_entrada.pm \
	  lib/MatFel/Controller/Cron.pm blib/lib/MatFel/Controller/Cron.pm \
	  lib/MatFel/Schema/Result/UserRole.pm blib/lib/MatFel/Schema/Result/UserRole.pm \
	  lib/MatFel/Controller/Trafico_bloqueado_salida.pm blib/lib/MatFel/Controller/Trafico_bloqueado_salida.pm \
	  lib/MatFel/Schema/Result/Snort_referencia.pm blib/lib/MatFel/Schema/Result/Snort_referencia.pm \
	  lib/MatFel/Schema/Result/Protocolo.pm blib/lib/MatFel/Schema/Result/Protocolo.pm \
	  lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm blib/lib/MatFel/Schema/Result/Trafico_entrada_bloqueado.pm \
	  lib/MatFel/Controller/Utilidades.pm blib/lib/MatFel/Controller/Utilidades.pm \
	  lib/MatFel/Schema/Result/Snort_ipheader.pm blib/lib/MatFel/Schema/Result/Snort_ipheader.pm \
	  lib/MatFel/Schema/Result/Estado.pm blib/lib/MatFel/Schema/Result/Estado.pm \
	  lib/MatFel/Schema.pm blib/lib/MatFel/Schema.pm \
	  lib/MatFel/Schema/Result/Snort_signature.pm blib/lib/MatFel/Schema/Result/Snort_signature.pm \
	  lib/MatFel/Controller/Escaneos.pm blib/lib/MatFel/Controller/Escaneos.pm \
	  lib/MatFel/Controller/Alertas.pm blib/lib/MatFel/Controller/Alertas.pm \
	  lib/MatFel/Controller/Logout.pm blib/lib/MatFel/Controller/Logout.pm \
	  lib/MatFel/Controller/Servidores.pm blib/lib/MatFel/Controller/Servidores.pm \
	  lib/OV.pm blib/lib/OV.pm \
	  lib/MatFel/Controller/Trafico_bloqueado_entrada.pm blib/lib/MatFel/Controller/Trafico_bloqueado_entrada.pm \
	  lib/MatFel/Controller/Preferencias.pm blib/lib/MatFel/Controller/Preferencias.pm \
	  lib/MatFel/View/TT.pm blib/lib/MatFel/View/TT.pm \
	  lib/MatFel/Schema/Result/Servidor.pm blib/lib/MatFel/Schema/Result/Servidor.pm \
	  lib/MatFel/Schema/Result/Preferencia.pm blib/lib/MatFel/Schema/Result/Preferencia.pm \
	  lib/MatFel/Schema/Result/Snort_evento.pm blib/lib/MatFel/Schema/Result/Snort_evento.pm \
	  lib/MatFel/Controller/Mail.pm blib/lib/MatFel/Controller/Mail.pm \
	  lib/MatFel/Model/DB.pm blib/lib/MatFel/Model/DB.pm \
	  lib/MatFel/Schema/Result/Snort_sig_reference.pm blib/lib/MatFel/Schema/Result/Snort_sig_reference.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/MatFel/Schema/Result/User.pm blib/lib/MatFel/Schema/Result/User.pm \
	  lib/MatFel/Schema/Result/Snort_icmp_type.pm blib/lib/MatFel/Schema/Result/Snort_icmp_type.pm \
	  lib/MatFel/Schema/Result/OV_estado.pm blib/lib/MatFel/Schema/Result/OV_estado.pm \
	  lib/MatFel/Controller/Trafico_salida.pm blib/lib/MatFel/Controller/Trafico_salida.pm \
	  lib/MatFel/Schema/Result/Snort_reference_system.pm blib/lib/MatFel/Schema/Result/Snort_reference_system.pm \
	  lib/MatFel/Controller/Usuarios.pm blib/lib/MatFel/Controller/Usuarios.pm \
	  lib/MatFel/Schema/Result/OV_scanresults.pm blib/lib/MatFel/Schema/Result/OV_scanresults.pm \
	  lib/MatFel/Schema/Result/Snort_icmpheader.pm blib/lib/MatFel/Schema/Result/Snort_icmpheader.pm \
	  lib/MatFel.pm blib/lib/MatFel.pm \
	  lib/MatFel/Schema/Result/OV_scan.pm blib/lib/MatFel/Schema/Result/OV_scan.pm \
	  lib/MatFel/Schema/Result/Snort_opt_code.pm blib/lib/MatFel/Schema/Result/Snort_opt_code.pm \
	  lib/MatFel/Schema/Result/Alerta.pm blib/lib/MatFel/Schema/Result/Alerta.pm \
	  lib/MatFel/Schema/Result/Snort_udpheader.pm blib/lib/MatFel/Schema/Result/Snort_udpheader.pm \
	  lib/MatFel/Controller/OFC.pm blib/lib/MatFel/Controller/OFC.pm \
	  lib/MatFel/Schema/Result/Snort_sigClass.pm blib/lib/MatFel/Schema/Result/Snort_sigClass.pm \
	  lib/MatFel/Schema/Result/OV_frecuencia.pm blib/lib/MatFel/Schema/Result/OV_frecuencia.pm \
	  lib/MatFel/Schema/Result/User_Accion.pm blib/lib/MatFel/Schema/Result/User_Accion.pm \
	  lib/MatFel/Schema/Result/Snort_data.pm blib/lib/MatFel/Schema/Result/Snort_data.pm \
	  lib/MatFel/Schema/Result/Role.pm blib/lib/MatFel/Schema/Result/Role.pm \
	  lib/MatFel/Schema/Result/Trafico_entrada.pm blib/lib/MatFel/Schema/Result/Trafico_entrada.pm \
	  lib/MatFel/Schema/Result/Snort_tcpheader.pm blib/lib/MatFel/Schema/Result/Snort_tcpheader.pm \
	  lib/MatFel/Schema/Result/Snort_url_reference.pm blib/lib/MatFel/Schema/Result/Snort_url_reference.pm \
	  lib/MatFel/Schema/Result/Snort_opt.pm blib/lib/MatFel/Schema/Result/Snort_opt.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 0.91
catalyst_par :: all
	$(NOECHO) $(PERL) -Ilib -Minc::Module::Install -MModule::Install::Catalyst -e"Catalyst::Module::Install::_catalyst_par( '', 'MatFel', { CLASSES => [], CORE => 0, ENGINE => 'CGI', MULTIARCH => 0, SCRIPT => '', USAGE => q## } )"
# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(NOECHO) $(NOOP)

