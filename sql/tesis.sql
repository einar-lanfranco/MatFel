set names utf8;

-- MySQL dump 10.11
--
-- Host: localhost    Database: tesis
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny2-log

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
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL auto_increment,
  `estado` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'RELATED',''),(2,'ESTABLISHED',''),(3,'NEW',''),(4,'ESTABLISHED,RELATED',''),(6,'NEW,ESTABLISHED,RELATED','');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_estado`
--

DROP TABLE IF EXISTS `ov_estado`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ov_estado` (
  `id` char(1) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ov_estado`
--

LOCK TABLES `ov_estado` WRITE;
/*!40000 ALTER TABLE `ov_estado` DISABLE KEYS */;
INSERT INTO `ov_estado` VALUES ('I','Inicial'),('S','Escaneando'),('F','Fin');
/*!40000 ALTER TABLE `ov_estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_frecuencia`
--

DROP TABLE IF EXISTS `ov_frecuencia`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ov_frecuencia` (
  `id` char(1) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ov_frecuencia`
--

LOCK TABLES `ov_frecuencia` WRITE;
/*!40000 ALTER TABLE `ov_frecuencia` DISABLE KEYS */;
INSERT INTO `ov_frecuencia` VALUES ('U','Única Vez'),('D','Diario'),('S','Semanal'),('M','Mensual');
/*!40000 ALTER TABLE `ov_frecuencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_risk_factor`
--

DROP TABLE IF EXISTS `ov_risk_factor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ov_risk_factor` (
  `id` tinyint(4) NOT NULL auto_increment,
  `descripcion` varchar(250) NOT NULL,
  `prioridad` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ov_risk_factor`
--

LOCK TABLES `ov_risk_factor` WRITE;
/*!40000 ALTER TABLE `ov_risk_factor` DISABLE KEYS */;
INSERT INTO `ov_risk_factor` VALUES (1,'Critical',1),(2,'From None to High',2),(3,'High',1),(4,'High (If UseLogin is enabled, and locally)',1),(5,'High (Local) / None (remote with no account)',1),(6,'High (local) / None (remote)',1),(7,'High (locally)',1),(8,'High if your configuration file is not well setup',1),(9,'Low',3),(10,'Low (Windows NT, Windows 2000) / High (Windows 2003)',2),(11,'Low (if you are not using Kerberos) or High (if kerberos is',2),(12,'Low (remotely) / High (locally)',2),(13,'Low to High',2),(14,'Low to High, depending on the function of the web site',2),(15,'Low/Medium',2),(16,'Low/None',3),(17,'Medium',2),(18,'Medium / High (depending on the sensitivity of your web',1),(19,'Medium [remote] / High [local].',2),(20,'Medium if not running snmp - because someone could enable ',2),(21,'Medium/High',1),(22,'Medium/Low',2),(23,'Medium/Serious',1),(24,'Moderate',2),(25,'None',7),(26,'None / High',3),(27,'None / Medium',3),(28,'Serious',1),(29,'Serious / Low',1),(30,'Very low / none',3),(31,'n/a',7),(0,'-',10),(33,'Low / CVSS',3);
/*!40000 ALTER TABLE `ov_risk_factor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_scan`
--

DROP TABLE IF EXISTS `ov_scan`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ov_scan` (
  `id` int(11) NOT NULL auto_increment,
  `id_servidor` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `estado` varchar(1) NOT NULL,
  `frecuencia` varchar(1) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ov_scan`
--

LOCK TABLES `ov_scan` WRITE;
/*!40000 ALTER TABLE `ov_scan` DISABLE KEYS */;
INSERT INTO `ov_scan` VALUES (1,9,'2010-03-02 16:45:30','I','U'),(2,9,'2010-03-02 18:41:18','I','S');
/*!40000 ALTER TABLE `ov_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ov_scanresults`
--

DROP TABLE IF EXISTS `ov_scanresults`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ov_scanresults` (
  `id` int(10) unsigned NOT NULL,
  `ip` text NOT NULL,
  `port` text NOT NULL,
  `OID` varchar(50) NOT NULL,
  `type` text NOT NULL,
  `description` text NOT NULL,
  `timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `false_positive` tinyint(1) NOT NULL default '0',
  `risk` int(10) NOT NULL,
  `CVE` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `preferencia` (
  `id` int(11) NOT NULL auto_increment,
  `nombre` varchar(255) NOT NULL,
  `valor` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `preferencia`
--

LOCK TABLES `preferencia` WRITE;
/*!40000 ALTER TABLE `preferencia` DISABLE KEYS */;
INSERT INTO `preferencia` VALUES (1,'reload_firewall','true'),(2,'openvas-server','localhost'),(3,'openvas-port','1241'),(4,'openvas-user','matiasp'),(5,'openvas-pass','passdelopenvas'),(6,'openvas-client','/usr/bin/openvas-client'),(7,'report-dir','/var/www/nessusw/cgi-bin/reports/'),(8,'log','/var/log/nw/openvas.log'),(9,'cfg','/var/www/nessusw/cgi-bin/.nessusrc'),(10,'OIDs-url','http://www.openvas.org/?oid='),(11,'CVEs-url','http://cve.mitre.org/cgi-bin/cvename.cgi?name='),(12,'send_report','1'),(13,'mail_dir','matiasp@linti.unlp.edu.ar'),(14,'ip_firewall','192.168.56.12');
/*!40000 ALTER TABLE `preferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protocolo`
--

DROP TABLE IF EXISTS `protocolo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `protocolo` (
  `id` int(11) NOT NULL auto_increment,
  `nombre` varchar(4) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `protocolo`
--

LOCK TABLES `protocolo` WRITE;
/*!40000 ALTER TABLE `protocolo` DISABLE KEYS */;
INSERT INTO `protocolo` VALUES (1,'udp'),(2,'tcp'),(3,'icmp');
/*!40000 ALTER TABLE `protocolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Usuario'),(2,'Administrador');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servidor`
--

DROP TABLE IF EXISTS `servidor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `servidor` (
  `id` int(11) NOT NULL auto_increment,
  `nombre` varchar(255) NOT NULL,
  `alta` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `examinado` timestamp NOT NULL default '0000-00-00 00:00:00',
  `habilitado` tinyint(1) NOT NULL,
  `activo` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `ipv6` varchar(255) NOT NULL,
  `ipv4` varchar(15) NOT NULL,
  `mascarav4` varchar(15) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `servidor`
--

LOCK TABLES `servidor` WRITE;
/*!40000 ALTER TABLE `servidor` DISABLE KEYS */;
INSERT INTO `servidor` VALUES (9,'Servidor Windows','2010-03-02 13:19:13',1,'0000-00-00 00:00:00',0,0,'Servidor Windows Liviano','','163.10.10.67','255.255.255.0'),(6,'aaaaa','2010-01-21 19:04:40',1,'0000-00-00 00:00:00',0,0,'aaaa','','aaa','aaa'),(5,'mikel','2010-01-21 18:19:35',1,'0000-00-00 00:00:00',0,0,'pepe2','','123.123.123.127','255.255.255.0'),(8,'jj','2010-01-22 15:34:19',1,'0000-00-00 00:00:00',0,0,'jj','','jj','jj');
/*!40000 ALTER TABLE `servidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_entrada`
--

DROP TABLE IF EXISTS `trafico_entrada`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `trafico_entrada` (
  `id` int(11) NOT NULL auto_increment,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_origen` varchar(255) default NULL,
  `mascara_origen` varchar(255) default NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `trafico_entrada`
--

LOCK TABLES `trafico_entrada` WRITE;
/*!40000 ALTER TABLE `trafico_entrada` DISABLE KEYS */;
INSERT INTO `trafico_entrada` VALUES (12,9,1,111,'aaa','aa',1),(11,9,1,111,'aaa','aa',1),(10,9,1,111,'aaa','aa',1),(9,9,1,111,'aaa','aa',1),(13,9,1,111,'aaa','aa',1),(14,9,1,2323,'aaa','aaa',1);
/*!40000 ALTER TABLE `trafico_entrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafico_salida`
--

DROP TABLE IF EXISTS `trafico_salida`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `trafico_salida` (
  `id` int(11) NOT NULL auto_increment,
  `id_servidor` int(11) NOT NULL,
  `protocolo` int(11) NOT NULL,
  `puerto` int(11) NOT NULL,
  `ip_destino` varchar(255) default NULL,
  `mascara_destino` varchar(255) default NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `trafico_salida`
--

LOCK TABLES `trafico_salida` WRITE;
/*!40000 ALTER TABLE `trafico_salida` DISABLE KEYS */;
INSERT INTO `trafico_salida` VALUES (12,9,1,121,'asdas','sadas',1);
/*!40000 ALTER TABLE `trafico_salida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `username` text,
  `password` text,
  `email_address` text,
  `first_name` text,
  `last_name` text,
  `active` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','d033e22ae348aeb5660fc2140aec35850c4da997','admin@info.com','Super','Vaca',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL default '0',
  `role_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1),(1,2);
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

-- Dump completed on 2010-03-20 12:28:56
