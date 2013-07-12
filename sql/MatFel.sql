-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: MatFel
-- ------------------------------------------------------
-- Server version	5.5.31-0+wheezy1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_servidor` int(11) NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `sid` (`sid`,`cid`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `data_payload` text,
  PRIMARY KEY (`sid`,`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail` (
  `detail_type` tinyint(3) unsigned NOT NULL,
  `detail_text` text NOT NULL,
  PRIMARY KEY (`detail_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (0,'fast'),(1,'full');
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encoding`
--

DROP TABLE IF EXISTS `encoding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encoding` (
  `encoding_type` tinyint(3) unsigned NOT NULL,
  `encoding_text` text NOT NULL,
  PRIMARY KEY (`encoding_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encoding`
--

LOCK TABLES `encoding` WRITE;
/*!40000 ALTER TABLE `encoding` DISABLE KEYS */;
INSERT INTO `encoding` VALUES (0,'hex'),(1,'base64'),(2,'ascii');
/*!40000 ALTER TABLE `encoding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'RELATED',''),(2,'ESTABLISHED',''),(3,'NEW',''),(4,'ESTABLISHED,RELATED',''),(6,'NEW,ESTABLISHED,RELATED','');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `signature` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `sig` (`signature`),
  KEY `time` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icmp_code`
--

DROP TABLE IF EXISTS `icmp_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icmp_code` (
  `tipo` tinyint(3) unsigned NOT NULL,
  `subtipo` tinyint(3) unsigned NOT NULL,
  `string` varchar(255) NOT NULL,
  PRIMARY KEY (`tipo`,`subtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icmp_code`
--

LOCK TABLES `icmp_code` WRITE;
/*!40000 ALTER TABLE `icmp_code` DISABLE KEYS */;
INSERT INTO `icmp_code` VALUES (3,0,'Network Unreachable'),(3,1,'Host Unreachable'),(3,2,'Protocol Unreachable'),(3,3,'Port Unreachable'),(3,4,'Fragmentation Needed/DF set'),(3,5,'Source Route failed'),(3,6,'Network Unknown'),(3,7,'Host Unknown'),(3,8,'Host Isolated'),(3,9,'Network ANO'),(3,10,'Host ANO'),(3,11,'Network Unreach TOS'),(3,12,'Host Unreach TOS'),(3,13,'Packet Filtered'),(3,14,'Precedence violation'),(3,15,'Precedence cut off'),(5,0,'Redirect datagram for network/subnet'),(5,1,'Redirect datagram for host'),(5,2,'Redirect datagram for ToS and network'),(5,3,'Redirect datagram for Tos and host'),(9,0,'Normal router advertisement'),(9,16,'Does not route common traffic'),(11,0,'TTL exceeded in transit'),(11,1,'Fragment reassembly time exceeded'),(12,0,'Pointer indicates error'),(12,1,'Missing a required option'),(12,2,'Bad length'),(40,0,'Bad SPI'),(40,1,'Authentication failed'),(40,2,'Decompression failed'),(40,3,'Decryption failed'),(40,4,'Need authentication'),(40,5,'Need authorization');
/*!40000 ALTER TABLE `icmp_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icmp_type`
--

DROP TABLE IF EXISTS `icmp_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icmp_type` (
  `id` tinyint(3) unsigned NOT NULL,
  `string` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icmp_type`
--

LOCK TABLES `icmp_type` WRITE;
/*!40000 ALTER TABLE `icmp_type` DISABLE KEYS */;
INSERT INTO `icmp_type` VALUES (0,'Echo Reply'),(3,'Destination Unreachable'),(4,'Source Quench'),(5,'Redirect'),(8,'Echo Request'),(9,'Router Advertisement'),(10,'Router Solicitation'),(11,'Time Exceeded'),(12,'Parameter Problem'),(13,'Timestamp Request'),(14,'Timestamp Reply'),(15,'Information Request'),(16,'Information Reply'),(17,'Address Mask Request'),(18,'Address Mask Reply'),(19,'Reserved (security)'),(20,'Reserved (robustness)'),(21,'Reserved (robustness)'),(22,'Reserved (robustness)'),(23,'Reserved (robustness)'),(24,'Reserved (robustness)'),(25,'Reserved (robustness)'),(26,'Reserved (robustness)'),(27,'Reserved (robustness)'),(28,'Reserved (robustness)'),(29,'Reserved (robustness)'),(30,'Traceroute'),(31,'Datagram Conversion Error'),(32,'Mobile Host Redirect'),(33,'IPv6 Where-Are-You'),(34,'IPv6 I-Am-Here'),(35,'Mobile Registration Request'),(36,'Mobile Registration Reply'),(37,'Domain Name Request'),(38,'Domain Name Reply'),(39,'SKIP'),(40,'Photuris');
/*!40000 ALTER TABLE `icmp_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icmphdr`
--

DROP TABLE IF EXISTS `icmphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icmphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `icmp_type` tinyint(3) unsigned NOT NULL,
  `icmp_code` tinyint(3) unsigned NOT NULL,
  `icmp_csum` smallint(5) unsigned DEFAULT NULL,
  `icmp_id` smallint(5) unsigned DEFAULT NULL,
  `icmp_seq` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `icmp_type` (`icmp_type`),
  KEY `icmp_code` (`icmp_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icmphdr`
--

LOCK TABLES `icmphdr` WRITE;
/*!40000 ALTER TABLE `icmphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `icmphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_proto`
--

DROP TABLE IF EXISTS `ip_proto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_proto` (
  `id` int(3) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `firewall` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_proto`
--

LOCK TABLES `ip_proto` WRITE;
/*!40000 ALTER TABLE `ip_proto` DISABLE KEYS */;
INSERT INTO `ip_proto` VALUES (0,'IP',0),(1,'ICMP',1),(2,'IGMP',0),(4,'IPIP tunnels',0),(6,'TCP',1),(8,'EGP',0),(12,'PUP',0),(17,'UDP',1),(22,'XNS UDP',0),(29,'SO TP Class 4',0),(41,'IPv6 header',0),(43,'IPv6 routing header',0),(44,'IPv6 fragmentation header',0),(46,'RSVP',0),(47,'GRE',1),(50,'IPSec ESP',0),(51,'IPSec AH',0),(58,'ICMPv6',0),(59,'IPv6 no next header',0),(60,'IPv6 destination options',0),(92,'MTP',0),(98,'Encapsulation header',0),(103,'PIM',0),(108,'COMP',0),(255,'Raw IP',0);
/*!40000 ALTER TABLE `ip_proto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iphdr`
--

DROP TABLE IF EXISTS `iphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `ip_src` int(10) unsigned NOT NULL,
  `ip_dst` int(10) unsigned NOT NULL,
  `ip_ver` tinyint(3) unsigned DEFAULT NULL,
  `ip_hlen` tinyint(3) unsigned DEFAULT NULL,
  `ip_tos` tinyint(3) unsigned DEFAULT NULL,
  `ip_len` smallint(5) unsigned DEFAULT NULL,
  `ip_id` smallint(5) unsigned DEFAULT NULL,
  `ip_flags` tinyint(3) unsigned DEFAULT NULL,
  `ip_off` smallint(5) unsigned DEFAULT NULL,
  `ip_ttl` tinyint(3) unsigned DEFAULT NULL,
  `ip_proto` int(3) NOT NULL,
  `ip_csum` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `ip_src` (`ip_src`),
  KEY `ip_dst` (`ip_dst`),
  KEY `ip_proto` (`ip_proto`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iphdr`
--

LOCK TABLES `iphdr` WRITE;
/*!40000 ALTER TABLE `iphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `iphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipt_code`
--

DROP TABLE IF EXISTS `ipt_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipt_code` (
  `id` varchar(255) NOT NULL,
  `string` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipt_code`
--

LOCK TABLES `ipt_code` WRITE;
/*!40000 ALTER TABLE `ipt_code` DISABLE KEYS */;
INSERT INTO `ipt_code` VALUES ('0','EOL'),('0x44','TS'),('0x82','SEC'),('0x83','LSRR'),('0x84','LSRR_E'),('0x88','SID'),('0x89','SSRR'),('1','NOP'),('7','RR');
/*!40000 ALTER TABLE `ipt_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opt`
--

DROP TABLE IF EXISTS `opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opt` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `optid` int(10) unsigned NOT NULL,
  `opt_proto` tinyint(3) unsigned NOT NULL,
  `opt_code` tinyint(3) unsigned NOT NULL,
  `opt_len` smallint(6) DEFAULT NULL,
  `opt_data` text,
  PRIMARY KEY (`sid`,`cid`,`optid`),
  KEY `opt_code` (`opt_code`),
  KEY `sid` (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opt`
--

LOCK TABLES `opt` WRITE;
/*!40000 ALTER TABLE `opt` DISABLE KEYS */;
/*!40000 ALTER TABLE `opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opt_code`
--

DROP TABLE IF EXISTS `opt_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opt_code` (
  `id` tinyint(3) unsigned NOT NULL,
  `string` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opt_code`
--

LOCK TABLES `opt_code` WRITE;
/*!40000 ALTER TABLE `opt_code` DISABLE KEYS */;
INSERT INTO `opt_code` VALUES (0,'(0) EOL'),(1,'(1) NOP'),(2,'(2) MSS'),(3,'(3) WS'),(4,'(4) SACKOK'),(5,'(5) SACK'),(6,'(6) Echo'),(7,'(7) Echo Reply'),(8,'(8) TS'),(9,'(9) Partial Order Connection Permitted'),(10,'(10) Partial Order Service Profile'),(11,'(11) CC'),(12,'(12) CCNEW'),(13,'(13) CCECHO'),(14,'(14) TCP Alternate Checksum Request'),(15,'(15) TCP Alternate Checksum Data'),(16,'(16) Skeeter'),(17,'(17) Bubba'),(18,'(18) Trailer Checksum Option'),(19,'(19) MD5 Signature'),(20,'(20) SCPS Capabilities'),(21,'(21) Selective Negative Acknowledgements'),(22,'(22) Record Boundaries'),(23,'(23) Corruption Experienced'),(24,'(24) SNAP'),(25,'(25) Unassigned'),(26,'(26) TCP Compression Filter');
/*!40000 ALTER TABLE `opt_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_estado`
--

DROP TABLE IF EXISTS `ov_estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ov_estado` (
  `id` char(1) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ov_estado`
--

LOCK TABLES `ov_estado` WRITE;
/*!40000 ALTER TABLE `ov_estado` DISABLE KEYS */;
INSERT INTO `ov_estado` VALUES ('F','Fin'),('I','Inicial'),('S','Escaneando');
/*!40000 ALTER TABLE `ov_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_frecuencia`
--

DROP TABLE IF EXISTS `ov_frecuencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ov_frecuencia` (
  `id` varchar(1) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ov_frecuencia`
--

LOCK TABLES `ov_frecuencia` WRITE;
/*!40000 ALTER TABLE `ov_frecuencia` DISABLE KEYS */;
INSERT INTO `ov_frecuencia` VALUES ('D','Diario'),('M','Mensual'),('S','Semanal'),('U','Una Vez');
/*!40000 ALTER TABLE `ov_frecuencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_risk_factor`
--

DROP TABLE IF EXISTS `ov_risk_factor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ov_risk_factor` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(250) NOT NULL,
  `prioridad` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ov_risk_factor`
--

LOCK TABLES `ov_risk_factor` WRITE;
/*!40000 ALTER TABLE `ov_risk_factor` DISABLE KEYS */;
INSERT INTO `ov_risk_factor` VALUES (0,'-',10),(1,'Critical',1),(2,'From None to High',2),(3,'High',1),(4,'High (If UseLogin is enabled, and locally)',1),(5,'High (Local) / None (remote with no account)',1),(6,'High (local) / None (remote)',1),(7,'High (locally)',1),(8,'High if your configuration file is not well setup',1),(9,'Low',3),(10,'Low (Windows NT, Windows 2000) / High (Windows 2003)',2),(11,'Low (if you are not using Kerberos) or High (if kerberos is',2),(12,'Low (remotely) / High (locally)',2),(13,'Low to High',2),(14,'Low to High, depending on the function of the web site',2),(15,'Low/Medium',2),(16,'Low/None',3),(17,'Medium',2),(18,'Medium / High (depending on the sensitivity of your web',1),(19,'Medium [remote] / High [local].',2),(20,'Medium if not running snmp - because someone could enable ',2),(21,'Medium/High',1),(22,'Medium/Low',2),(23,'Medium/Serious',1),(24,'Moderate',2),(25,'None',7),(26,'None / High',3),(27,'None / Medium',3),(28,'Serious',1),(29,'Serious / Low',1),(30,'Very low / none',3),(31,'n/a',7),(33,'Low / CVSS',3);
/*!40000 ALTER TABLE `ov_risk_factor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_scan`
--

DROP TABLE IF EXISTS `ov_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ov_scan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(1) NOT NULL,
  `frecuencia` varchar(1) NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `estado` (`estado`),
  KEY `frecuencia` (`frecuencia`),
  CONSTRAINT `ov_scan_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `ov_estado` (`id`),
  CONSTRAINT `ov_scan_ibfk_3` FOREIGN KEY (`frecuencia`) REFERENCES `ov_frecuencia` (`id`),
  CONSTRAINT `ov_scan_ibfk_4` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ov_scan_ibfk_5` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ov_scan`
--

LOCK TABLES `ov_scan` WRITE;
/*!40000 ALTER TABLE `ov_scan` DISABLE KEYS */;
/*!40000 ALTER TABLE `ov_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_scanresults`
--

DROP TABLE IF EXISTS `ov_scanresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ov_scanresults` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_scan` int(11) NOT NULL,
  `ip` text NOT NULL,
  `port` text NOT NULL,
  `OID` varchar(50) NOT NULL,
  `type` text NOT NULL,
  `description` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `false_positive` tinyint(1) NOT NULL DEFAULT '0',
  `risk` tinyint(4) NOT NULL,
  `CVE` varchar(512) DEFAULT NULL,
  `BID` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_scan` (`id_scan`),
  KEY `risk` (`risk`),
  CONSTRAINT `ov_scanresults_ibfk_1` FOREIGN KEY (`id_scan`) REFERENCES `ov_scan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ov_scanresults`
--

LOCK TABLES `ov_scanresults` WRITE;
/*!40000 ALTER TABLE `ov_scanresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `ov_scanresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preferencia`
--

DROP TABLE IF EXISTS `preferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `valor` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferencia`
--

LOCK TABLES `preferencia` WRITE;
/*!40000 ALTER TABLE `preferencia` DISABLE KEYS */;
INSERT INTO `preferencia` VALUES (1,'reload_firewall','0','Variable booleana que indica si hay que hacer reload del firewall- Uso interno'),(2,'openvas-server','127.0.0.1','IP del servidor de openvas'),(3,'openvas-port','9391','Puerto del servidor de openvas'),(4,'openvas-user','matiasp','Usuario para conectarnos al servidor de openvas'),(5,'openvas-pass','passdelopenvas','Password para conectarnos al servidor de openvas'),(6,'openvas-client','/usr/bin/openvas-client','Ejecutable del cliente de openvas'),(7,'report-dir','/var/www/MatFel/root/static/reportes/','Directorio donde van los reportes de Openvas'),(8,'log','/var/log/tesis/openvas.log','Directorio donde van los logs de Openvas'),(9,'OIDs-url','http://www.openvas.org/?oid=','url para los plugins de openvas'),(10,'CVEs-url','http://cve.mitre.org/cgi-bin/cvename.cgi?name=','url a la descripciÃ³n de los CVEs'),(11,'send_report','1','enviar reportes?'),(12,'mail_dir','einar.lanfranco@gmail.com','mail de contacto?'),(13,'ip_firewall','10.0.0.1','IP desde donde dejaremos bajar las reglas para el firewall'),(14,'ultima_actualizacion','2013-7-4 23:35:2','La ultima vez que se procesaron las alertas del Snort'),(15,'geoip-db','/var/www/MatFel/root/static/GeoIP/GeoLiteCity.dat','Ubicación de la base de Geolocalización'),(16,'rss_server','http://sl.linti.unlp.edu.ar/feed/rss/','Los servidores de RSS, para poner varios separar por coma (,)'),(17,'BIDs-url','http://www.securityfocus.com/bid/','url a la descripciÃ³n de los BIDs'),(18,'smtp_server','ejempl.mail.smtp.com',''),(19,'smtp_metodo','PLANO','Las opciones son:\r\nPLANO\r\nTLS\r\nSSL\r\nSENDMAIL'),(20,'port_mail','25',''),(21,'username_mail','matfel',''),(22,'password_mail','XXXXXXXX',''),(24,'mail_from','einar.lanfranco@gmail.com','mail from'),(25,'dias_resumen_de_alertas','14','La cantidad de días en que se muestran alertas'),(26,'version','400','la proxima version que se espera instalar de MatFel');
/*!40000 ALTER TABLE `preferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference` (
  `ref_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_system_id` int(10) unsigned NOT NULL,
  `ref_tag` text NOT NULL,
  PRIMARY KEY (`ref_id`),
  KEY `ref_system_id` (`ref_system_id`)
) ENGINE=MyISAM AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference`
--

LOCK TABLES `reference` WRITE;
/*!40000 ALTER TABLE `reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_system`
--

DROP TABLE IF EXISTS `reference_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_system` (
  `ref_system_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_system_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ref_system_id`),
  KEY `ref_system_name` (`ref_system_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_system`
--

LOCK TABLES `reference_system` WRITE;
/*!40000 ALTER TABLE `reference_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Usuario'),(2,'Administrador'),(3,'Usuario');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema`
--

DROP TABLE IF EXISTS `schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema` (
  `vseq` int(10) unsigned NOT NULL,
  `ctime` datetime NOT NULL,
  PRIMARY KEY (`vseq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema`
--

LOCK TABLES `schema` WRITE;
/*!40000 ALTER TABLE `schema` DISABLE KEYS */;
INSERT INTO `schema` VALUES (107,'2010-05-26 07:49:08');
/*!40000 ALTER TABLE `schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostname` text,
  `interface` text,
  `filter` text,
  `detail` tinyint(3) unsigned DEFAULT NULL,
  `encoding` tinyint(3) unsigned DEFAULT NULL,
  `last_cid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `detail` (`detail`),
  KEY `encoding` (`encoding`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor`
--

LOCK TABLES `sensor` WRITE;
/*!40000 ALTER TABLE `sensor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servidor`
--

DROP TABLE IF EXISTS `servidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servidor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `examinado` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `habilitado` tinyint(1) NOT NULL,
  `reporte` tinyint(1) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `ipv6` varchar(255) NOT NULL,
  `ipv4` varchar(15) NOT NULL,
  `mascarav4` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  CONSTRAINT `servidor_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servidor`
--

LOCK TABLES `servidor` WRITE;
/*!40000 ALTER TABLE `servidor` DISABLE KEYS */;
/*!40000 ALTER TABLE `servidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sig_class`
--

DROP TABLE IF EXISTS `sig_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sig_class` (
  `sig_class_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sig_class_name` varchar(60) NOT NULL,
  PRIMARY KEY (`sig_class_id`),
  KEY `sig_class_id` (`sig_class_id`),
  KEY `sig_class_name` (`sig_class_name`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sig_class`
--

LOCK TABLES `sig_class` WRITE;
/*!40000 ALTER TABLE `sig_class` DISABLE KEYS */;
INSERT INTO `sig_class` VALUES (0,'SIN CLASIFICAR'),(1,'attempted-recon'),(2,'attempted-dos'),(3,'web-application-activity'),(4,'non-standard-protocol'),(5,'web-application-attack'),(6,'attempted-admin'),(7,'misc-activity'),(8,'bad-unknown'),(9,'attempted-user'),(10,'successful-recon-limited'),(11,'protocol-command-decode'),(12,'shellcode-detect'),(13,'system-call-detect'),(14,'network-scan'),(15,'policy-violation'),(16,'rpc-portmap-decode'),(17,'suspicious-filename-detect');
/*!40000 ALTER TABLE `sig_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sig_reference`
--

DROP TABLE IF EXISTS `sig_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sig_reference` (
  `sig_id` int(10) unsigned NOT NULL,
  `ref_seq` int(10) unsigned NOT NULL,
  `ref_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sig_id`,`ref_seq`),
  KEY `ref_id` (`ref_id`),
  KEY `sig_id` (`sig_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sig_reference`
--

LOCK TABLES `sig_reference` WRITE;
/*!40000 ALTER TABLE `sig_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `sig_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signature`
--

DROP TABLE IF EXISTS `signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signature` (
  `sig_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sig_name` varchar(255) NOT NULL,
  `sig_class_id` int(10) unsigned NOT NULL,
  `sig_priority` int(10) unsigned DEFAULT NULL,
  `sig_rev` int(10) unsigned DEFAULT NULL,
  `sig_sid` int(10) unsigned DEFAULT NULL,
  `sig_gid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sig_id`),
  KEY `sign_idx` (`sig_name`(20)),
  KEY `sig_class_id_idx` (`sig_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signature`
--

LOCK TABLES `signature` WRITE;
/*!40000 ALTER TABLE `signature` DISABLE KEYS */;
INSERT INTO `signature` VALUES (1,'(portscan) TCP Portscan',0,3,NULL,1,122),(2,'SNMP request tcp',1,2,11,1418,1),(3,'portscan: TCP Portscan',0,3,NULL,1,122),(4,'Snort Alert [1:100000160:0]',2,2,2,100000160,1),(5,'SNMP AgentX/tcp request ',1,2,11,1421,1),(6,'SNMP trap tcp ',1,2,11,1420,1),(7,'WEB-MISC robots.txt access ',3,2,3,1852,1),(8,'SNMP request udp ',1,2,9,1417,1),(9,'Snort Alert [1:100000159:0]',2,2,2,100000159,1),(10,'Snort Alert [1:100000162:0]',2,2,2,100000162,1),(11,'WEB-MISC Invalid HTTP Version String ',4,2,7,2570,1),(12,'http_inspect: DOUBLE DECODING ATTACK',0,3,1,2,119),(13,'WEB-PHP PHPBB viewforum.php access ',3,2,4,2566,1),(14,'WEB-CGI upload.pl access',1,2,5,891,1),(15,'WEB-PHP viewtopic.php access ',5,1,4,2229,1),(16,'portscan: TCP Portsweep',0,3,NULL,3,122),(17,'http_inspect: IIS UNICODE CODEPOINT ENCODING',0,3,1,7,119),(18,'WEB-MISC PCT Client_Hello overflow attempt ',6,1,13,2515,1),(19,'WEB-CGI calendar access',1,2,5,882,1),(20,'ICMP Destination Unreachable Communication Administratively Prohibited',7,3,4,485,1),(21,'WEB-MISC SSLv3 invalid Client_Hello attempt ',2,2,10,2522,1),(22,'SMTP TLS PCT Client_Hello overflow attempt ',6,1,13,2528,1),(23,'http_inspect: WEBROOT DIRECTORY TRAVERSAL',0,3,1,18,119),(24,'ssh: Protocol mismatch',0,3,1,4,128),(25,'snort_decoder: Bad Traffic Same Src/Dst IP!',4,3,1,151,116),(26,'BAD-TRAFFIC same SRC/DST ',8,2,8,527,1),(27,'DNS zone transfer TCP ',1,2,13,255,1),(28,'ICMP Destination Unreachable Communication with Destination Host is Administratively Prohibited',7,3,4,486,1),(29,'ATTACK-RESPONSES 403 Forbidden',1,2,7,1201,1),(30,'portscan: ICMP Sweep',0,3,NULL,25,122),(31,'ICMP Source Quench',8,2,2,477,1),(32,'Snort Alert [1:100000161:0]',2,2,2,100000161,1),(33,'smtp: Attempted header name buffer overflow',0,3,1,7,124),(34,'WEB-PHP admin.php access ',1,2,11,1301,1),(35,'Snort Alert [1:100000537:0]',5,1,1,100000537,1),(36,'DNS named version attempt ',1,2,9,257,1),(37,'snort_decoder: TCP Window Scale Option Scale Invalid (> 14)',4,3,1,59,116),(38,'SCAN nmap XMAS ',1,2,7,1228,1),(39,'WEB-PHP Mambo upload.php access ',3,2,2,2077,1),(40,'Snort Alert [1:100000187:0]',5,1,2,100000187,1),(41,'WEB-MISC backup access',1,2,5,1213,1),(42,'SMTP TLS SSLv3 invalid data version attempt ',2,2,7,2541,1),(43,'Snort Alert [1:100000928:0]',6,1,1,100000928,1),(44,'WEB-MISC SSLv3 invalid data version attempt ',2,2,9,2505,1),(45,'WEB-FRONTPAGE /_vti_bin/ access ',3,2,8,1288,1),(46,'WEB-MISC http directory traversal ',1,2,5,1113,1),(47,'WEB-MISC /etc/passwd',1,2,5,1122,1),(48,'snort_decoder: WARNING: ICMP Original IP Payload < 64 bits!',4,3,1,253,116),(49,'EXPLOIT SSLv2 Client_Hello with pad Challenge Length overflow attempt',6,1,8,2657,1),(50,'MS-SQL probe response overflow attempt ',9,1,6,2329,1),(51,'WEB-PHP Setup.php access ',3,2,2,2281,1),(52,'WEB-PHP remote include path',5,1,5,2002,1),(53,'Snort Alert [1:100000220:0]',5,1,2,100000220,1),(54,'Snort Alert [1:100000372:0]',5,1,2,100000372,1),(55,'snort_decoder: Experimental TCP options',4,3,1,58,116),(56,'WEB-CGI redirect access ',1,2,7,895,1),(57,'ICMP PING NMAP ',1,2,3,469,1),(58,'http_inspect: BARE BYTE UNICODE ENCODING',0,3,1,4,119),(59,'IMAP PCT Client_Hello overflow attempt ',6,1,13,2517,1),(60,'Snort Alert [1:100000763:0]',3,2,1,100000763,1),(61,'ICMP redirect host ',8,2,4,472,1),(62,'WEB-PHP modules.php access ',3,2,1,2565,1),(63,'Snort Alert [1:100000121:0]',3,2,1,100000121,1),(64,'WEB-MISC login.htm access ',3,2,6,1564,1),(65,'Snort Alert [1:100000186:0]',10,2,2,100000186,1),(66,'WEB-ATTACKS id command attempt',5,1,6,1333,1),(67,'Snort Alert [1:100000380:0]',5,1,2,100000380,1),(68,'Snort Alert [1:100000122:0]',5,1,1,100000122,1),(69,'WEB-CGI /cgi-bin/ access',5,1,6,1668,1),(70,'MISC MS Terminal server request ',11,3,12,1448,1),(71,'MISC MS Terminal Server no encryption session initiation attmept ',2,2,4,2418,1),(72,'MISC rsyncd overflow attempt ',7,3,6,2048,1),(73,'WEB-MISC Phorecast remote code execution attempt ',5,1,7,1391,1),(74,'Snort Alert [1:100000837:0]',5,1,2,100000837,1),(75,'WEB-IIS view source via translate header ',3,2,9,1042,1),(76,'Snort Alert [1:100000219:0]',6,1,1,100000219,1),(77,'WEB-PHP PHP-Nuke remote file include attempt ',5,1,11,1399,1),(78,'Snort Alert [129:15:0]',0,3,1,15,129),(79,'ICMP Echo Reply',7,3,5,408,1),(80,'Snort Alert [129:16:0]',0,3,1,16,129),(81,'ICMP Destination Unreachable Port Unreachable',7,3,8,402,1),(82,'stream5: TCP Small Segment Threshold Exceeded',0,3,1,12,129),(83,'Snort Alert [120:3:0]',0,3,1,3,120),(84,'stream5: Bad segment, overlap adjusted size less than/equal 0',0,3,1,5,129),(85,'Snort Alert [137:1:0]',0,3,1,1,137),(86,'stream5: Limit on number of overlapping TCP packets reached',0,3,1,7,129),(87,'ICMP Destination Unreachable Host Unreachable',7,3,6,399,1),(88,'ICMP Destination Unreachable Fragmentation Needed and DF bit was set',7,3,7,396,1),(89,'ATTACK-RESPONSES 403 Forbidden',1,2,8,1201,1),(90,'Snort Alert [1:17317:0]',6,1,4,17317,1),(91,'SHELLCODE x86 NOOP',12,1,12,1394,1),(92,'ICMP Destination Unreachable Network Unreachable',7,3,6,401,1),(93,'Snort Alert [1:16606:0]',9,1,3,16606,1),(94,'Snort Alert [1:16008:0]',7,3,5,16008,1),(95,'SHELLCODE x86 NOOP ',12,1,10,648,1),(96,'Snort Alert [1:14610:0]',6,1,3,14610,1),(97,'Snort Alert [1:17567:0]',6,1,1,17567,1),(98,'ICMP PING',7,3,5,384,1),(99,'ICMP traceroute ',1,2,4,385,1),(100,'ICMP PING *NIX',7,3,7,366,1),(101,'SHELLCODE x86 inc ebx NOOP',12,1,8,1390,1),(102,'ICMP Timestamp Request',7,3,5,453,1),(103,'Snort Alert [1:12801:0]',12,1,3,12801,1),(104,'ICMP PING BSDtype ',7,3,6,368,1),(105,'Snort Alert [1:11837:0]',9,1,4,11837,1),(106,'Snort Alert [1:12798:0]',12,1,3,12798,1),(107,'ICMP Destination Unreachable Protocol Unreachable',7,3,7,404,1),(108,'Snort Alert [1:17484:0]',2,2,1,17484,1),(109,'Snort Alert [1:17354:0]',2,2,1,17354,1),(110,'WEB-IIS cmd.exe access',5,1,14,1002,1),(111,'Snort Alert [1:12799:0]',12,1,3,12799,1),(112,'Snort Alert [1:12802:0]',12,1,3,12802,1),(113,'ICMP Fragment Reassembly Time Exceeded',7,3,5,410,1),(114,'SHELLCODE x86 setuid 0 ',13,2,10,650,1),(115,'Snort Alert [1:18179:0]',14,3,1,18179,1),(116,'ICMP PING Windows ',7,3,7,382,1),(117,'SHELLCODE x86 setgid 0 ',13,2,10,649,1),(118,'Snort Alert [1:6403:0]',5,1,7,6403,1),(119,'ICMP PING undefined code',7,3,8,365,1),(120,'ICMP Address Mask Request',7,3,5,388,1),(121,'ICMP Information Request',7,3,5,417,1),(122,'WEB-MISC cat%20 access ',1,2,10,1147,1),(123,'POLICY IPSec PGPNet connection attempt',11,3,8,1771,1),(124,'SCAN Amanda client version request',1,2,5,634,1),(125,'Snort Alert [1:3813:0]',9,1,7,3813,1),(126,'Snort Alert [1:5897:0]',7,3,4,5897,1),(127,'Snort Alert [1:8090:0]',5,1,7,8090,1),(128,'P2P BitTorrent transfer',15,1,4,2181,1),(129,'Snort Alert [1:17536:0]',9,1,2,17536,1),(130,'Snort Alert [1:12800:0]',12,1,3,12800,1),(131,'ATTACK-RESPONSES command completed ',8,2,13,494,1),(132,'Snort Alert [1:17648:0]',1,2,1,17648,1),(133,'POLICY PPTP Start Control Request attempt',6,1,5,2044,1),(134,'Snort Alert [1:17487:0]',2,2,2,17487,1),(135,'NETBIOS DOS RFPoison ',11,3,10,529,1),(136,'RPC portmap NFS request TCP',16,2,8,1960,1),(137,'Snort Alert [1:11288:0]',16,2,2,11288,1),(138,'RPC mountd TCP mount request',1,2,7,1951,1),(139,'RPC portmap mountd request UDP ',16,2,10,579,1),(140,'RPC mountd UDP mount request',1,2,7,1952,1),(141,'RPC mountd UDP unmount request',1,2,6,2021,1),(142,'NETBIOS SMB-DS ADMIN$ share unicode access',11,3,7,2475,1),(143,'FINGER 0 query ',1,2,9,332,1),(144,'Snort Alert [1:11816:0]',6,1,1,11816,1),(145,'RPC portmap bootparam request UDP ',16,2,15,577,1),(146,'RPC portmap rusers request TCP ',16,2,15,1271,1),(147,'RPC portmap listing TCP 111 ',16,2,13,598,1),(148,'RPC portmap cachefsd request UDP ',16,2,14,1746,1),(149,'RPC portmap rstatd request TCP ',16,2,12,1270,1),(150,'RPC portmap ypupdated request TCP ',16,2,12,591,1),(151,'Snort Alert [1:15930:0]',2,2,10,15930,1),(152,'RPC portmap yppasswd request UDP ',16,2,9,589,1),(153,'FINGER search query ',1,2,11,322,1),(154,'FINGER remote command pipe execution attempt ',9,1,9,327,1),(155,'ATTACK-RESPONSES Invalid URL ',1,2,10,1200,1),(156,'FINGER version query',1,2,5,1541,1),(157,'Snort Alert [1:3218:0]',6,1,12,3218,1),(158,'NETBIOS SMB-DS C$ share unicode access',11,3,10,2472,1),(159,'NETBIOS SMB-DS D$ share unicode access',11,3,7,2469,1),(160,'Snort Alert [1:12626:0]',16,2,2,12626,1),(161,'RPC portmap sadmind request UDP ',16,2,9,585,1),(162,'Snort Alert [1:3151:0]',1,2,4,3151,1),(163,'FINGER root query ',1,2,6,323,1),(164,'FINGER redirection attempt ',1,2,10,330,1),(165,'FINGER account enumeration attempt ',1,2,6,321,1),(166,'Snort Alert [1:17524:0]',6,1,1,17524,1),(167,'Snort Alert [1:12597:0]',17,2,2,12597,1),(168,'Snort Alert [1:17483:0]',2,2,1,17483,1),(169,'Snort Alert [1:15306:0]',7,3,6,15306,1),(170,'Snort Alert [1:3655:0]',9,1,4,3655,1),(171,'RPC portmap NFS request UDP',16,2,8,1959,1),(172,'Snort Alert [1:17366:0]',9,1,1,17366,1),(173,'ATTACK-RESPONSES command error',8,2,9,495,1),(174,'ATTACK-RESPONSES file copied ok ',8,2,14,497,1),(175,'ATTACK-RESPONSES directory listing',8,2,9,1292,1),(176,'Snort Alert [1:12286:0]',9,1,5,12286,1),(177,'SMTP expn root ',1,2,12,660,1),(178,'SMTP vrfy root',1,2,8,1446,1),(179,'WEB-CLIENT Outlook EML access ',9,1,13,1233,1),(180,'Snort Alert [1:17378:0]',9,1,1,17378,1),(181,'Snort Alert [1:11267:0]',9,1,4,11267,1),(182,'Snort Alert [1:7002:0]',9,1,5,7002,1),(183,'Snort Alert [1:16295:0]',9,1,2,16295,1),(184,'Snort Alert [1:17339:0]',12,1,1,17339,1),(185,'Snort Alert [1:5712:0]',6,1,2,5712,1),(186,'RPC portmap listing UDP 111 ',16,2,11,1280,1),(187,'RPC mountd UDP export request ',1,2,8,1924,1),(188,'FINGER null request ',1,2,7,324,1),(189,'FINGER remote command execution attempt ',9,1,10,326,1),(190,'ICMP Echo Reply undefined code',7,3,7,409,1),(191,'Snort Alert [1:15363:0]',7,3,2,15363,1),(192,'Snort Alert [1:527:0]',8,2,8,527,1);
/*!40000 ALTER TABLE `signature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcphdr`
--

DROP TABLE IF EXISTS `tcphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `tcp_sport` smallint(5) unsigned NOT NULL,
  `tcp_dport` smallint(5) unsigned NOT NULL,
  `tcp_seq` int(10) unsigned DEFAULT NULL,
  `tcp_ack` int(10) unsigned DEFAULT NULL,
  `tcp_off` tinyint(3) unsigned DEFAULT NULL,
  `tcp_res` tinyint(3) unsigned DEFAULT NULL,
  `tcp_flags` tinyint(3) unsigned NOT NULL,
  `tcp_win` smallint(5) unsigned DEFAULT NULL,
  `tcp_csum` smallint(5) unsigned DEFAULT NULL,
  `tcp_urp` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `tcp_sport` (`tcp_sport`),
  KEY `tcp_dport` (`tcp_dport`),
  KEY `tcp_flags` (`tcp_flags`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcphdr`
--

LOCK TABLES `tcphdr` WRITE;
/*!40000 ALTER TABLE `tcphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_entrada`
--

DROP TABLE IF EXISTS `trafico_entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trafico_entrada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_origen` varchar(255) DEFAULT NULL,
  `mascara_origen` varchar(255) DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `estado` (`estado`),
  KEY `protocolo` (`protocolo`),
  CONSTRAINT `trafico_entrada_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`),
  CONSTRAINT `trafico_entrada_ibfk_3` FOREIGN KEY (`protocolo`) REFERENCES `ip_proto` (`id`),
  CONSTRAINT `trafico_entrada_ibfk_4` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trafico_entrada_ibfk_5` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trafico_entrada`
--

LOCK TABLES `trafico_entrada` WRITE;
/*!40000 ALTER TABLE `trafico_entrada` DISABLE KEYS */;
/*!40000 ALTER TABLE `trafico_entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_entrada_bloqueado`
--

DROP TABLE IF EXISTS `trafico_entrada_bloqueado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trafico_entrada_bloqueado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_origen` varchar(255) DEFAULT NULL,
  `mascara_origen` varchar(255) DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `estado` (`estado`),
  KEY `protocolo` (`protocolo`),
  CONSTRAINT `trafico_entrada_bloqueado_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`),
  CONSTRAINT `trafico_entrada_bloqueado_ibfk_3` FOREIGN KEY (`protocolo`) REFERENCES `ip_proto` (`id`),
  CONSTRAINT `trafico_entrada_bloqueado_ibfk_4` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trafico_entrada_bloqueado_ibfk_5` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trafico_entrada_bloqueado`
--

LOCK TABLES `trafico_entrada_bloqueado` WRITE;
/*!40000 ALTER TABLE `trafico_entrada_bloqueado` DISABLE KEYS */;
/*!40000 ALTER TABLE `trafico_entrada_bloqueado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_salida`
--

DROP TABLE IF EXISTS `trafico_salida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trafico_salida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_destino` varchar(255) DEFAULT NULL,
  `mascara_destino` varchar(255) DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `estado` (`estado`),
  KEY `protocolo` (`protocolo`),
  CONSTRAINT `trafico_salida_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`),
  CONSTRAINT `trafico_salida_ibfk_3` FOREIGN KEY (`protocolo`) REFERENCES `ip_proto` (`id`),
  CONSTRAINT `trafico_salida_ibfk_4` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trafico_salida_ibfk_5` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trafico_salida`
--

LOCK TABLES `trafico_salida` WRITE;
/*!40000 ALTER TABLE `trafico_salida` DISABLE KEYS */;
/*!40000 ALTER TABLE `trafico_salida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_salida_bloqueado`
--

DROP TABLE IF EXISTS `trafico_salida_bloqueado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trafico_salida_bloqueado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_destino` varchar(255) DEFAULT NULL,
  `mascara_destino` varchar(255) DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `habilitado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_servidor` (`id_servidor`),
  KEY `estado` (`estado`),
  KEY `protocolo` (`protocolo`),
  CONSTRAINT `trafico_salida_bloqueado_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`),
  CONSTRAINT `trafico_salida_bloqueado_ibfk_3` FOREIGN KEY (`protocolo`) REFERENCES `ip_proto` (`id`),
  CONSTRAINT `trafico_salida_bloqueado_ibfk_4` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trafico_salida_bloqueado_ibfk_5` FOREIGN KEY (`id_servidor`) REFERENCES `servidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trafico_salida_bloqueado`
--

LOCK TABLES `trafico_salida_bloqueado` WRITE;
/*!40000 ALTER TABLE `trafico_salida_bloqueado` DISABLE KEYS */;
/*!40000 ALTER TABLE `trafico_salida_bloqueado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `udphdr`
--

DROP TABLE IF EXISTS `udphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `udphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `udp_sport` smallint(5) unsigned NOT NULL,
  `udp_dport` smallint(5) unsigned NOT NULL,
  `udp_len` smallint(5) unsigned DEFAULT NULL,
  `udp_csum` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `udp_sport` (`udp_sport`),
  KEY `udp_dport` (`udp_dport`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `udphdr`
--

LOCK TABLES `udphdr` WRITE;
/*!40000 ALTER TABLE `udphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `udphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_reference`
--

DROP TABLE IF EXISTS `url_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_reference` (
  `ref_system_name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`ref_system_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_reference`
--

LOCK TABLES `url_reference` WRITE;
/*!40000 ALTER TABLE `url_reference` DISABLE KEYS */;
INSERT INTO `url_reference` VALUES ('arachNIDS',''),('bugtraq','http://www.securityfocus.com/bid/$'),('cve','http://cve.mitre.org/cgi-bin/cvename.cgi?name=$'),('icat','http://nvd.nist.gov/nvd.cfm?cvename=CAN-$'),('mcafee','http://vil.nai.com/vil/content/v_$.html'),('nessus','http://www.nessus.org/plugins/index.php?view=single&id=$'),('snort','http://www.snort.org/pub-bin/sigs.cgi?sid=$'),('url','');
/*!40000 ALTER TABLE `url_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text,
  `password` text,
  `email_address` text,
  `first_name` text,
  `last_name` text,
  `active` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','92ccacc15503be6fb8644892cdfd11976890a27b','einar.lanfranco@gmail.com','Super','Vaca',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_accion`
--

DROP TABLE IF EXISTS `user_accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_accion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `accion` varchar(255) NOT NULL,
  `cliente` varchar(255) NOT NULL,
  `desde` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_accion_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_accion`
--

LOCK TABLES `user_accion` WRITE;
/*!40000 ALTER TABLE `user_accion` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,2);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-07-05  4:53:41
