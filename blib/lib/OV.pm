package OV;

#Este modulo provee funcionalidades varias para OpenVAS
#Escrito el 20/07/2007 por matiasp@linti.unlp.edu.ar
#
#Copyright (C) 2003-2007  Linti, Facultad de Informática, UNLP
#This file is part of Nessus-UNLP
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

use strict;
require Exporter;
use MatFel::Schema;
use MatFel::Model::DB;
use Date::Manip;
use DateTime;

use DBI;
use vars qw(@EXPORT @ISA);
@ISA=qw(Exporter);
@EXPORT=qw(&configuration
	   &getPreference
	   &insert_scan
	   &parse_nbe
	   &uploadReport 
	   &getDBI
	   &getSchema
	   &run_scan 
	   &sendReport
	   );

sub getSchema
{
    my $db = MatFel::Model::DB->new();
    my $schema = MatFel::Schema->connect($db->connect_info->{'dsn'},$db->connect_info->{'user'},$db->connect_info->{'password'});
    return $schema;
}

sub getPreference
{
    my ($name)=@_;
    my $schema=getSchema();
    my $pref = $schema->resultset('Preferencia')->search({nombre => $name})->single;
    return $pref->valor;

}


##Busca el Risk Factor##
sub getRisk
{
my ($risk)=@_;

if ($risk ne '') {
    
    my $schema=getSchema();
    my $rf = $schema->resultset('OV_risk_factor')->search({descripcion => $risk})->single;
    if ($rf){
		my $id=$rf->id;
		if($id){
			return $id;
		} else {
			return 0;
		}
	}
}

}


##Ejecuta el OPENVAS para ese Scan  teniendo la conexion de catalyst $c##
sub run_scan_catalyzed {
	my ( $c, $ov_scan)=@_;
	my ($cmd)="";

	my $target=$ov_scan->id_servidor->ipv4."/".$ov_scan->id_servidor->mascarav4;

	my $host =  $c->model('DB::Preferencia')->find({nombre => "openvas-server"})->valor;
	my $port =  $c->model('DB::Preferencia')->find({nombre => "openvas-port"})->valor;
	my $user =  $c->model('DB::Preferencia')->find({nombre => "openvas-user"})->valor;
	my $pass =  $c->model('DB::Preferencia')->find({nombre => "openvas-pass"})->valor;
	my $path =  $c->model('DB::Preferencia')->find({nombre => "openvas-client"})->valor;
	my $output_dir = $c->model('DB::Preferencia')->find({nombre => "report-dir"})->valor;
	my $target_file=$output_dir.'target'.$ov_scan->id;
	my $result_file=$output_dir.'result'.$ov_scan->id.'.nbe';

	open (T, '>'.$target_file);  #se escribe el archivo
	printf T $target;
	close T;

	open (T, '>'.$result_file);  #se escribe el archivo
	close T;


	$c->log->debug( localtime(time)." scan_run: Scanning :: $target ::");
	$cmd = qq{ $path   --batch-mode $host $port $user $pass $target_file $result_file -T nbe -x };
	$c->log->debug( localtime(time)." comando  :: $cmd ::");
	
	system ($cmd);
	
	if ( $? == -1 )
	{
	    $c->log->debug(localtime(time)."Falló la ejecución de OPENVAS: $!");
	}
	else
	{
	    $c->log->debug( localtime(time)." scan_run: Finish Scanning :: $target ::");

	    $c->log->debug( localtime(time)." scan_run: Insert Results :: $target ::");

	    my $resultado_escaneo= &parse_nbe($result_file,$ov_scan->id);

	    if ($resultado_escaneo){

	      eval {
		$c->model('DB')->schema->populate('OV_scanresults', [[qw/id_scan IP Port OID Type Description risk CVE BID/],@$resultado_escaneo]);
	      };
	      if($@){ $c->log->debug( localtime(time)." scan_run: ERROR EN EL POPULATE :: ".$@." ::");}
	      #Se actualiza el servidor con la fecha actual en examinado
	      $ov_scan->id_servidor->update({ examinado => \'NOW()' });
	    }

	    $c->log->debug( localtime(time)." scan_run: END Insert Results :: $target ::");

	    if ( $c->model('DB::Preferencia')->find({nombre => "send_report"})->valor) {
		$c->log->debug( localtime(time)." scan_run: Send Report :: $target ::");
		#sendReport($id);
		$c->log->debug( localtime(time)." scan_run: END Send Report :: $target ::");
	    }
	}
}

##Ejecuta el OPENVAS para ese Scan ID ##
sub run_scan {
	my ($id)=@_;
	my ($cmd)="";

	my $schema=getSchema();
	my $servidor = ($schema->resultset('OV_scan')->search({id => $id}))->single;
	my $target=$servidor->id_servidor->ipv4."/".$servidor->id_servidor->mascarav4;

	my $host = getPreference('openvas-server');
	my $port = getPreference('openvas-port');
	my $user = getPreference('openvas-user');
	my $pass = getPreference('openvas-pass');
	my $path = getPreference('openvas-client');
	my $output_dir = getPreference('report-dir');
	my $target_file=$output_dir.'target'.$id;
	my $result_file=$output_dir.'result'.$id.'.nbe';

	open (T, '>'.$target_file);  #se escribe el archivo
	printf T $target;
	close T;

	open (T, '>'.$result_file);  #se escribe el archivo
	close T;


	print localtime(time)." scan_run: Scanning :: $target ::\n";
	$cmd = qq{ $path   --batch-mode $host $port $user $pass $target_file $result_file -T nbe -x };
	print localtime(time)." comando  :: $cmd ::\n";
	
	system ($cmd);
	
	if ( $? == -1 )
	{
	    print localtime(time)."Falló la ejecución de OPENVAS: $!\n";
	}
	else
	{
	    print localtime(time)." scan_run: Finish Scanning :: $target ::\n";

	    print localtime(time)." scan_run: Insert Results :: $target ::\n";
	    my $resultado_escaneo= &parse_nbe($result_file,$id);

	    if ($resultado_escaneo){
	      my $schema=getSchema();
	      $schema->populate('OV_scanresults', [[qw/id_scan IP Port OID Type Description risk CVE BID/],@$resultado_escaneo]);
              #Se actualiza el servidor con la fecha actual en examinado
              $servidor->id_servidor->update({ examinado => \'NOW()' });

	    }

	    print localtime(time)." scan_run: END Insert Results :: $target ::\n";

	    if (getPreference('send_report')) {
		print localtime(time)." scan_run: Send Report :: $target ::\n";
		#sendReport($id);
		print localtime(time)." scan_run: END Send Report :: $target ::\n";
	    }
	}
}

##Procesa el resultado de un Scan, recibe el archivo y el id del Scan ##
sub parse_nbe
{
my ($filename, $id)=@_;

my @resultado_escaneo=();
open(NBE, "$filename") || die "File not found\nYou need to provide this program with a valid filename to parse.\n";
while (<NBE>)
{
my @values = split(/\|/, $_);


if  (($values[0] ne "timestamps")  and ($values[0] eq "results")and($values[6] ne ''))
{


#FORMATEO LA DESCRIPCION
$values[6] =~  s/\n//g;
$values[6] =~  s/\r//g;
$values[6] =~  s/\\n\\n/\\n/g;
$values[6] =~  s/\\n//;
$values[6] =~  s/\\n/\n/g;

###Buscar el riesgo en la descripcion####

my $risk = '-';
my $cvss = undef;

my $idRisk=0;

my $order=7;#Orden alto -> Riesgo Nulo

my $aux=$values[6];
#$aux =~  s/\n//g;
my $i=index($aux,'Risk factor');

if ($i ne -1 ){
	#Quito Risk factor :
   	$aux=substr($aux,$i+11);
	my $lin=0;
	while ((substr($aux,$lin,1) eq "\n") or (substr($aux,$lin,1) eq "\r") or (substr($aux,$lin,1) eq " ") or (substr($aux,$lin,1) eq ":")){$lin++;}	
	$aux=substr($aux,$lin);

	my $rin=0;
	while ((substr($aux,$rin,1) ne "\n") and (substr($aux,$rin,1) ne "\r") and (substr($aux,$lin,1) ne " ")){$rin++;}	
	$risk=substr($aux,0,$rin);
	$idRisk=getRisk($risk);
	}
###Buscar el riesgo en la descripcion####

###Buscar el/los identificado/es CVE####
my $descripcion=$values[6];
my @parrafos = split(/\n/, $descripcion);
my @cves=undef;
my $cve=undef;
foreach my $p (@parrafos){
	my $ip=index($p,'CVE : ');
 	
	if ($ip ne -1 ){
 	#Encontre el parrafo!!!
	$p=substr($p,$ip+6);
	@cves = split(/, /, $p);
 	$cve=join("|",@cves);
	}
}

###Buscar el/los identificado/es BID####
my $descripcion=$values[6];
my @parrafos = split(/\n/, $descripcion);
my @bids=undef;
my $bid=undef;
foreach my $p (@parrafos){
    my $ip=index($p,'BID : ');
    
    if ($ip ne -1 ){
    #Encontre el parrafo!!!
    $p=substr($p,$ip+6);
    @bids = split(/, /, $p);
    $bid=join("|",@bids);
    }
}

push (@resultado_escaneo,[$id,$values[2],$values[3],$values[4],$values[5],$values[6],$idRisk,$cve,$bid])

}#if

}
close(NBE);

return (\@resultado_escaneo);

}

#
# 
# sub uploadReport {
# 
# my ($filepath)=@_;
# 
#   my $output_dir = getPreference('output-dir');
#  
#   my $dbh = getDBI();
#   my $SQL = "Select max(id) from ov_scan;";
#   my $sth = $dbh->prepare($SQL);
#   $sth->execute() or die "Cannot execute statement: $DBI::errstr\n";
#   my $maxid=$sth->fetchrow;
#   $sth->finish();
#   my $id=$maxid+1;
# 
#   $SQL = "INSERT INTO ov_scan SET id=? , id_servidor=? , timestamp=Now();";
#   $sth = $dbh->prepare($SQL);
#   $sth->execute($id,'UP');
#   $sth->finish();
# 
# my $result_file=$output_dir.'result'.$id.'.nbe';
# 
# print "RES ".$result_file;
# print "\n PATH".$filepath;
# my $msg='';
# my $bytes_read;
# my $size= 0;
# my $buff=''; 
# 
# if (!$result_file) {
# #Hace el upload de un archivo
#   
#                 if (!open(WFD,">$result_file")) {
#                         $msg="Hay un error y el archivo no puede escribirse en el servidor.";
#                 }
# 
#                 while ($bytes_read=read($filepath,$buff,2096)) {
#                         $size += $bytes_read;
#                         binmode WFD;
#                         print WFD $buff;
#                 }
#                 close(WFD);
#         }
# print " MES ". $msg;
# return($msg);
# 
# }


###Envia el reporte de un escaneo##
# sub sendReport
# {
# my ($id)=@_;
# use Mail::Sendmail;
# 
# if (getPreference('send_report')) {
# 
# my $resultado=getSummaryReport($id);
# 
# my $mailSubject="Vulnerabilidades de ".$resultado->{'objetivo'}." al dia ".$resultado->{'fecha'}." ( Altas: ".$resultado->{'alto'}." - Medias: ".$resultado->{'medio'}." - Bajas: ".$resultado->{'bajo'}." )";
# my $mailMessage=$resultado->{'resumen'};
# 
# my %mail = ( To => getPreference('mail_dir'),
#              From => getPreference('mail_dir'),
#              Subject => $mailSubject,
#              Message => $mailMessage);
# 
#     if (getPreference('mail_dir') ){
# #           sendmail(%mail) or die $resultado='error';
#        if(sendmail(%mail)) {
#                         print  localtime(time)." sendReport=> SE ENVIO MAIL A: ".getPreference('mail_dir')."\n" ;
#                 }
#                 else {
#                         print  localtime(time)." sendReport=> FALLO EL SENDMAIL !!"."\n";
#                 }
# 
# 
# 	}
# }
# 
# }
