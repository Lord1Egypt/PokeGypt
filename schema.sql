-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: pokedashpota
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_ban_history`
--

DROP TABLE IF EXISTS `account_ban_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_ban_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expired_at` bigint NOT NULL,
  `banned_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_ban_history`
--

LOCK TABLES `account_ban_history` WRITE;
/*!40000 ALTER TABLE `account_ban_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_ban_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_bans`
--

DROP TABLE IF EXISTS `account_bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_bans` (
  `account_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expires_at` bigint NOT NULL,
  `banned_by` int NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_bans`
--

LOCK TABLES `account_bans` WRITE;
/*!40000 ALTER TABLE `account_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_viplist`
--

DROP TABLE IF EXISTS `account_viplist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_viplist` (
  `account_id` int NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint unsigned NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_viplist`
--

LOCK TABLES `account_viplist` WRITE;
/*!40000 ALTER TABLE `account_viplist` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_viplist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int NOT NULL DEFAULT '1',
  `premdays` int NOT NULL DEFAULT '0',
  `lastday` int unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2766 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'gm','c9e8fabd957e325872fc340c88f143e5f3290289',NULL,6,0,0,'email@company.com',1535900202);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_invites`
--

DROP TABLE IF EXISTS `guild_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild_invites` (
  `player_id` int NOT NULL DEFAULT '0',
  `guild_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`guild_id`),
  KEY `guild_id` (`guild_id`),
  CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_invites`
--

LOCK TABLES `guild_invites` WRITE;
/*!40000 ALTER TABLE `guild_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_membership`
--

DROP TABLE IF EXISTS `guild_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild_membership` (
  `player_id` int NOT NULL,
  `guild_id` int NOT NULL,
  `rank_id` int NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`player_id`),
  KEY `guild_id` (`guild_id`),
  KEY `rank_id` (`rank_id`),
  CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_membership`
--

LOCK TABLES `guild_membership` WRITE;
/*!40000 ALTER TABLE `guild_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_ranks`
--

DROP TABLE IF EXISTS `guild_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild_ranks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guild_id` int NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else',
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`),
  CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_ranks`
--

LOCK TABLES `guild_ranks` WRITE;
/*!40000 ALTER TABLE `guild_ranks` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_wars`
--

DROP TABLE IF EXISTS `guild_wars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild_wars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guild1` int NOT NULL DEFAULT '0',
  `guild2` int NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `started` bigint NOT NULL DEFAULT '0',
  `ended` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `guild1` (`guild1`),
  KEY `guild2` (`guild2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_wars`
--

LOCK TABLES `guild_wars` WRITE;
/*!40000 ALTER TABLE `guild_wars` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_wars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guilds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerid` int NOT NULL,
  `creationdata` int NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `ownerid` (`ownerid`),
  CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilds`
--

LOCK TABLES `guilds` WRITE;
/*!40000 ALTER TABLE `guilds` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilds` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `guildwar_kills`
--

DROP TABLE IF EXISTS `guildwar_kills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guildwar_kills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int NOT NULL DEFAULT '0',
  `targetguild` int NOT NULL DEFAULT '0',
  `warid` int NOT NULL DEFAULT '0',
  `time` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `warid` (`warid`),
  CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guildwar_kills`
--

LOCK TABLES `guildwar_kills` WRITE;
/*!40000 ALTER TABLE `guildwar_kills` DISABLE KEYS */;
/*!40000 ALTER TABLE `guildwar_kills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house_lists`
--

DROP TABLE IF EXISTS `house_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `house_lists` (
  `house_id` int NOT NULL,
  `listid` int NOT NULL,
  `list` text NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house_lists`
--

LOCK TABLES `house_lists` WRITE;
/*!40000 ALTER TABLE `house_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `houses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` int NOT NULL,
  `paid` int unsigned NOT NULL DEFAULT '0',
  `warnings` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int NOT NULL DEFAULT '0',
  `town_id` int NOT NULL DEFAULT '0',
  `bid` int NOT NULL DEFAULT '0',
  `bid_end` int NOT NULL DEFAULT '0',
  `last_bid` int NOT NULL DEFAULT '0',
  `highest_bidder` int NOT NULL DEFAULT '0',
  `size` int NOT NULL DEFAULT '0',
  `beds` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `town_id` (`town_id`)
) ENGINE=InnoDB AUTO_INCREMENT=541 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `houses`
--

LOCK TABLES `houses` WRITE;
/*!40000 ALTER TABLE `houses` DISABLE KEYS */;
INSERT INTO `houses` VALUES (1,0,0,0,'Saffron House #1',24000,34,0,0,0,0,48,0),(2,0,0,0,'Saffron House #2',40000,34,0,0,0,0,70,0),(3,0,0,0,'Saffron House #3',45000,34,0,0,0,0,70,0),(4,0,0,0,'Saffron House #4',35000,34,0,0,0,0,56,0),(5,0,0,0,'Saffron House #5',20000,34,0,0,0,0,42,0),(6,0,0,0,'Saffron House #6',27000,34,0,0,0,0,55,0),(7,0,0,0,'Saffron House #7',31000,34,0,0,0,0,53,0),(8,0,0,0,'Saffron House #8',77000,34,0,0,0,0,117,0),(9,0,0,0,'Saffron House #9',49000,34,0,0,0,0,72,0),(10,0,0,0,'Saffron House #10',49000,34,0,0,0,0,81,0),(11,0,0,0,'Saffron House #11',40000,34,0,0,0,0,84,0),(12,0,0,0,'Saffron House #12',55000,34,0,0,0,0,73,0),(13,0,0,0,'Saffron House #13',40000,34,0,0,0,0,84,0),(14,0,0,0,'Saffron House #14',49000,34,0,0,0,0,80,0),(15,0,0,0,'Saffron House #15',18000,34,0,0,0,0,37,0),(16,0,0,0,'Saffron House #16',20000,34,0,0,0,0,31,0),(17,0,0,0,'Saffron House #17',25000,34,0,0,0,0,48,0),(18,0,0,0,'Saffron House #18',56000,34,0,0,0,0,80,0),(19,0,0,0,'Saffron House #19',48000,34,0,0,0,0,80,0),(20,0,0,0,'Saffron House #20',168000,34,0,0,0,0,260,0),(21,0,0,0,'Saffron House #21',144000,34,0,0,0,0,220,0),(22,0,0,0,'Saffron House #22',128000,34,0,0,0,0,173,0),(23,0,0,0,'Saffron House #23',57000,34,0,0,0,0,83,0),(24,0,0,0,'Saffron House #24',52000,34,0,0,0,0,85,0),(25,0,0,0,'Saffron House #25',60000,34,0,0,0,0,96,0),(26,0,0,0,'Saffron House #26',83000,34,0,0,0,0,144,0),(27,0,0,0,'Saffron House #27',49000,34,0,0,0,0,81,0),(28,0,0,0,'Saffron House #28',118000,34,0,0,0,0,179,0),(29,0,0,0,'Saffron House #29',49000,34,0,0,0,0,72,0),(30,0,0,0,'Saffron House #30',49000,34,0,0,0,0,81,0),(31,0,0,0,'Saffron House #31',72000,34,0,0,0,0,110,0),(32,0,0,0,'Saffron House #32',98000,34,0,0,0,0,162,0),(33,0,0,0,'Saffron House #33',49000,34,0,0,0,0,73,0),(34,0,0,0,'Saffron House #34',49000,34,0,0,0,0,80,0),(35,0,0,0,'Saffron House #35',42000,34,0,0,0,0,63,0),(36,0,0,0,'Saffron House #36',174000,34,0,0,0,0,295,0),(37,0,0,0,'Saffron House #37',84000,34,0,0,0,0,135,0),(38,0,0,0,'Saffron House #38',35000,34,0,0,0,0,55,0),(39,0,0,0,'Saffron House #39',35000,34,0,0,0,0,62,0),(40,0,0,0,'Saffron House #40',40000,34,0,0,0,0,60,0),(41,0,0,0,'Saffron House #41',40000,34,0,0,0,0,70,0),(42,0,0,0,'Saffron House #42',55000,34,0,0,0,0,90,0),(43,0,0,0,'Saffron House #43',35000,34,0,0,0,0,57,0),(44,0,0,0,'Saffron House #44',77000,34,0,0,0,0,116,0),(45,0,0,0,'Saffron House #45',16000,34,0,0,0,0,29,0),(46,0,0,0,'Saffron House #46',59000,34,0,0,0,0,99,0),(47,0,0,0,'Saffron House #47',36000,34,0,0,0,0,60,0),(48,0,0,0,'Saffron House #48',40000,34,0,0,0,0,72,0),(49,0,0,0,'Saffron House #49',64000,34,0,0,0,0,104,0),(50,0,0,0,'Saffron House #50',39000,34,0,0,0,0,70,0),(51,0,0,0,'Saffron House #51',16000,34,0,0,0,0,24,0),(52,0,0,0,'Saffron House #52',40000,34,0,0,0,0,72,0),(53,0,0,0,'Saffron House #53',49000,34,0,0,0,0,274,0),(54,0,0,0,'Saffron House #54',90000,34,0,0,0,0,132,0),(55,0,0,0,'Saffron House #55',115000,34,0,0,0,0,160,0),(56,0,0,0,'Saffron Guildhall #1',770000,34,0,0,0,0,1224,0),(57,0,0,0,'Eirian House #57',81000,15,0,0,0,0,132,0),(58,0,0,0,'Eirian House #58',54000,15,0,0,0,0,88,0),(59,0,0,0,'Eirian House #59',54000,15,0,0,0,0,88,0),(60,0,0,0,'Eirian House #60',40000,15,0,0,0,0,78,0),(61,0,0,0,'Eirian House #61',32000,15,0,0,0,0,54,0),(62,0,0,0,'Eirian House #62',32000,15,0,0,0,0,54,0),(63,0,0,0,'Eirian House #63',30000,15,0,0,0,0,56,0),(64,0,0,0,'Eirian House #64',45000,15,0,0,0,0,77,0),(65,0,0,0,'Eirian House #65',30000,15,0,0,0,0,56,0),(66,0,0,0,'Eirian House #66',35000,15,0,0,0,0,56,0),(67,0,0,0,'Eirian House #67',40000,15,0,0,0,0,63,0),(68,0,0,0,'Eirian House #68',64000,15,0,0,0,0,100,0),(69,0,0,0,'Eirian House #69',88000,15,0,0,0,0,130,0),(70,0,0,0,'Eirian House #70',112000,15,0,0,0,0,166,0),(71,0,0,0,'Eirian House #71',72000,15,0,0,0,0,104,0),(72,0,0,0,'Eirian House #72',96000,15,0,0,0,0,144,0),(73,0,0,0,'Eirian House #73',77000,15,0,0,0,0,108,0),(74,0,0,0,'Eirian House #74',72000,15,0,0,0,0,100,0),(75,0,0,0,'Eirian House #75',72000,15,0,0,0,0,100,0),(76,0,0,0,'Eirian House #76',72000,15,0,0,0,0,110,0),(77,0,0,0,'Eirian House #77',45000,15,0,0,0,0,70,0),(78,0,0,0,'Eirian House #78',45000,15,0,0,0,0,70,0),(79,0,0,0,'Eirian House #79',45000,15,0,0,0,0,77,0),(80,0,0,0,'Eirian House #80',50000,15,0,0,0,0,84,0),(81,0,0,0,'Eirian House #81',40000,15,0,0,0,0,63,0),(82,0,0,0,'Eirian House #82',45000,15,0,0,0,0,70,0),(83,0,0,0,'Eirian House #83',50000,15,0,0,0,0,84,0),(84,0,0,0,'Eirian House #84',40000,15,0,0,0,0,63,0),(85,0,0,0,'Eirian House #85',45000,15,0,0,0,0,70,0),(86,0,0,0,'Eirian House #86',50000,15,0,0,0,0,84,0),(87,0,0,0,'Eirian House #87',60000,15,0,0,0,0,91,0),(88,0,0,0,'Eirian House #88',45000,15,0,0,0,0,84,0),(89,0,0,0,'Eirian House #89',55000,15,0,0,0,0,91,0),(90,0,0,0,'R\'lyeh House #90',96000,16,0,0,0,0,140,0),(91,0,0,0,'R\'lyeh House #91',141000,16,0,0,0,0,204,0),(92,0,0,0,'R\'lyeh House #92',100000,16,0,0,0,0,144,0),(93,0,0,0,'R\'lyeh House #93',100000,16,0,0,0,0,144,0),(94,0,0,0,'R\'lyeh House #94',80000,16,0,0,0,0,120,0),(95,0,0,0,'R\'lyeh House #95',72000,16,0,0,0,0,110,0),(96,0,0,0,'R\'lyeh House #96',154000,16,0,0,0,0,208,0),(97,0,0,0,'R\'lyeh House #97',126000,16,0,0,0,0,176,0),(98,0,0,0,'R\'lyeh House #98',66000,16,0,0,0,0,94,0),(99,0,0,0,'R\'lyeh House #99',78000,16,0,0,0,0,130,0),(100,0,0,0,'Arcania House #100',91000,17,0,0,0,0,144,0),(101,0,0,0,'Arcania House #101',91000,17,0,0,0,0,144,0),(102,0,0,0,'Arcania House #102',91000,17,0,0,0,0,144,0),(103,0,0,0,'Arcania House #103',91000,17,0,0,0,0,144,0),(104,0,0,0,'Arcania House #104',91000,17,0,0,0,0,144,0),(105,0,0,0,'Arcania House #105',91000,17,0,0,0,0,144,0),(106,0,0,0,'Arcania House #106',91000,17,0,0,0,0,144,0),(107,0,0,0,'Arcania House #107',91000,17,0,0,0,0,144,0),(108,0,0,0,'Arcania House #108',91000,17,0,0,0,0,144,0),(109,0,0,0,'Arcania House #109',89000,17,0,0,0,0,144,1),(110,0,0,0,'Arcania House #110',89000,17,0,0,0,0,144,1),(111,0,0,0,'Arcania House #111',89000,17,0,0,0,0,144,1),(112,0,0,0,'Arcania House #112',89000,17,0,0,0,0,144,1),(113,0,0,0,'Arcania House #113',89000,17,0,0,0,0,144,1),(114,0,0,0,'Arcania Guildhall #1',652000,17,0,0,0,0,871,1),(115,0,0,0,'Eternia House #115',34000,18,0,0,0,0,72,0),(116,0,0,0,'Eternia Guildhall #3',66000,18,0,0,0,0,144,0),(117,0,0,0,'Eternia House #117',72000,18,0,0,0,0,128,0),(118,0,0,0,'Eternia House #118',57000,18,0,0,0,0,112,0),(119,0,0,0,'Eternia House #119',20000,18,0,0,0,0,40,0),(120,0,0,0,'Eternia House #120',39000,18,0,0,0,0,81,0),(121,0,0,0,'Eternia House #121',51000,18,0,0,0,0,104,0),(122,0,0,0,'Eternia House #122',38000,18,0,0,0,0,95,0),(123,0,0,0,'Eternia House #123',35000,18,0,0,0,0,84,1),(124,0,0,0,'Eternia House #124',25000,18,0,0,0,0,53,0),(125,0,0,0,'Eternia House #125',25000,18,0,0,0,0,45,0),(126,0,0,0,'Eternia House #126',30000,18,0,0,0,0,56,0),(127,0,0,0,'Eternia Guildhall #2',1182000,18,0,0,0,0,2217,0),(128,0,0,0,'Eternia Guildhall #1',387000,18,0,0,0,0,694,0),(129,0,0,0,'Eternia House #129',69000,18,0,0,0,0,144,0),(130,0,0,0,'Eternia House #130',18000,18,0,0,0,0,36,0),(131,0,0,0,'Eternia House #131',18000,18,0,0,0,0,45,0),(132,0,0,0,'Eternia House #132',50000,18,0,0,0,0,98,0),(133,0,0,0,'Eternia House #133',25000,18,0,0,0,0,49,0),(134,0,0,0,'Eternia House #134',75000,18,0,0,0,0,151,0),(135,0,0,0,'Eternia House #135',25000,18,0,0,0,0,49,0),(136,0,0,0,'Eternia House #136',9000,18,0,0,0,0,25,0),(137,0,0,0,'Eternia House #137',12000,18,0,0,0,0,25,0),(138,0,0,0,'Eternia House #138',9000,18,0,0,0,0,20,0),(139,0,0,0,'Eternia House #139',6000,18,0,0,0,0,20,0),(140,0,0,0,'Eternia House #140',25000,18,0,0,0,0,49,0),(141,0,0,0,'Eternia House #141',12000,18,0,0,0,0,30,0),(142,0,0,0,'Eternia House #142',30000,18,0,0,0,0,56,0),(143,0,0,0,'Eternia House #143',25000,18,0,0,0,0,56,0),(144,0,0,0,'Eternia House #144',45000,18,0,0,0,0,88,0),(145,0,0,0,'Eternia House #145',27000,18,0,0,0,0,64,0),(146,0,0,0,'Eternia House #146',22000,18,0,0,0,0,56,0),(147,0,0,0,'Eternia House #147',27000,18,0,0,0,0,48,0),(148,0,0,0,'Eternia House #148',25000,18,0,0,0,0,49,0),(149,0,0,0,'Eternia House #149',30000,18,0,0,0,0,56,0),(150,0,0,0,'Eternia House #150',25000,18,0,0,0,0,49,0),(151,0,0,0,'Eternia House #151',32000,18,0,0,0,0,72,0),(152,0,0,0,'Eternia House #152',50000,18,0,0,0,0,98,0),(153,0,0,0,'Eternia House #153',18000,18,0,0,0,0,45,0),(154,0,0,0,'Eternia House #154',25000,18,0,0,0,0,42,0),(155,0,0,0,'Eternia House #155',35000,18,0,0,0,0,70,0),(156,0,0,0,'Eternia House #156',16000,18,0,0,0,0,36,0),(157,0,0,0,'Eternia House #157',20000,18,0,0,0,0,42,0),(158,0,0,0,'Eternia House #158',20000,18,0,0,0,0,42,0),(159,0,0,0,'Eternia House #159',35000,18,0,0,0,0,63,0),(160,0,0,0,'Eternia House #160',18000,18,0,0,0,0,40,0),(161,0,0,0,'Eternia House #161',9000,18,0,0,0,0,25,0),(162,0,0,0,'Eternia House #162',23000,18,0,0,0,0,56,0),(163,0,0,0,'Eternia House #163',12000,18,0,0,0,0,30,0),(164,0,0,0,'Eternia House #164',6000,18,0,0,0,0,20,0),(165,0,0,0,'Eternia House #165',9000,18,0,0,0,0,25,0),(166,0,0,0,'Eternia House #166',9000,18,0,0,0,0,25,0),(167,0,0,0,'Eternia House #167',9000,18,0,0,0,0,25,0),(168,0,0,0,'Eternia House #168',16000,18,0,0,0,0,36,0),(169,0,0,0,'Eternia House #169',12000,18,0,0,0,0,30,0),(170,0,0,0,'Eternia House #170',16000,18,0,0,0,0,36,0),(171,0,0,0,'Eternia House #171',12000,18,0,0,0,0,30,0),(172,0,0,0,'Eternia House #172',30000,18,0,0,0,0,63,0),(173,0,0,0,'Eternia House #173',16000,18,0,0,0,0,36,0),(174,0,0,0,'Eternia House #174',16000,18,0,0,0,0,36,0),(175,0,0,0,'Eternia House #175',12000,18,0,0,0,0,40,0),(176,0,0,0,'Lunna House #176',20000,19,0,0,0,0,42,0),(177,0,0,0,'Lunna House #177',20000,19,0,0,0,0,35,0),(178,0,0,0,'Lunna House #178',20000,19,0,0,0,0,48,0),(179,0,0,0,'Lunna House #179',22000,19,0,0,0,0,46,0),(180,0,0,0,'Lunna Guildhall #1',117000,19,0,0,0,0,252,0),(181,0,0,0,'Lunna House #181',97000,19,0,0,0,0,162,0),(182,0,0,0,'Lunna House #182',15000,19,0,0,0,0,35,0),(183,0,0,0,'Lunna House #183',20000,19,0,0,0,0,42,0),(184,0,0,0,'Lunna House #184',20000,19,0,0,0,0,35,0),(185,0,0,0,'Lunna House #185',72000,19,0,0,0,0,128,0),(186,0,0,0,'Lunna House #186',12000,19,0,0,0,0,32,0),(187,0,0,0,'Lunna House #187',24000,19,0,0,0,0,52,0),(188,0,0,0,'Lunna House #188',45000,19,0,0,0,0,96,0),(189,0,0,0,'Lunna House #189',18000,19,0,0,0,0,32,0),(190,0,0,0,'Lunna House #190',36000,19,0,0,0,0,64,0),(191,0,0,0,'Lunna House #191',20000,19,0,0,0,0,42,0),(192,0,0,0,'Lunna House #192',24000,19,0,0,0,0,48,0),(193,0,0,0,'Lunna House #193',8000,19,0,0,0,0,24,0),(194,0,0,0,'Lunna House #194',12000,19,0,0,0,0,24,0),(195,0,0,0,'Lunna House #195',30000,19,0,0,0,0,56,0),(196,0,0,0,'Lunna House #196',20000,19,0,0,0,0,42,0),(197,0,0,0,'Lunna House #197',40000,19,0,0,0,0,90,0),(198,0,0,0,'Lunna House #198',32000,19,0,0,0,0,72,0),(199,0,0,0,'Lunna House #199',20000,19,0,0,0,0,42,0),(200,0,0,0,'Lunna House #200',20000,19,0,0,0,0,42,0),(201,0,0,0,'Lunna House #201',15000,19,0,0,0,0,35,0),(202,0,0,0,'Lunna House #202',23000,19,0,0,0,0,46,0),(203,0,0,0,'Lunna House #203',12000,19,0,0,0,0,30,0),(204,0,0,0,'Lunna House #204',12000,19,0,0,0,0,30,0),(205,0,0,0,'Lunna House #205',15000,19,0,0,0,0,35,0),(206,0,0,0,'Lunna House #206',25000,19,0,0,0,0,49,0),(207,0,0,0,'Lunna House #207',28000,19,0,0,0,0,49,0),(208,0,0,0,'Lunna House #208',54000,19,0,0,0,0,112,0),(209,0,0,0,'Lunna House #209',22000,19,0,0,0,0,52,0),(210,0,0,0,'Lunna House #210',4000,19,0,0,0,0,15,1),(211,0,0,0,'Lunna House #211',4000,19,0,0,0,0,20,1),(212,0,0,0,'Lunna House #212',6000,19,0,0,0,0,20,0),(213,0,0,0,'Lunna House #213',11000,19,0,0,0,0,35,2),(214,0,0,0,'Cerulean House #214',51000,35,0,0,0,0,126,0),(215,0,0,0,'Cerulean House #215',25000,35,0,0,0,0,56,0),(216,0,0,0,'Cerulean House #216',25000,35,0,0,0,0,42,0),(217,0,0,0,'Cerulean House #217',25000,35,0,0,0,0,49,0),(218,0,0,0,'Cerulean House #218',38000,35,0,0,0,0,83,0),(219,0,0,0,'Cerulean House #219',35000,35,0,0,0,0,63,0),(220,0,0,0,'Cerulean House #220',78000,35,0,0,0,0,154,0),(221,0,0,0,'Cerulean House #221',52000,35,0,0,0,0,108,0),(222,0,0,0,'Cerulean House #222',40000,35,0,0,0,0,77,0),(223,0,0,0,'Cerulean House #223',75000,35,0,0,0,0,143,0),(224,0,0,0,'Cerulean House #224',22000,35,0,0,0,0,45,0),(225,0,0,0,'Cerulean Guildhall #1',124000,35,0,0,0,0,222,0),(226,0,0,0,'Cerulean House #226',95000,35,0,0,0,0,176,0),(227,0,0,0,'Cerulean House #227',50000,35,0,0,0,0,98,0),(228,0,0,0,'Cerulean House #228',10000,35,0,0,0,0,28,0),(229,0,0,0,'Cerulean House #229',21000,35,0,0,0,0,50,0),(230,0,0,0,'Cerulean House #230',21000,35,0,0,0,0,50,0),(231,0,0,0,'Cerulean House #231',21000,35,0,0,0,0,50,0),(232,0,0,0,'Cerulean House #232',24000,35,0,0,0,0,50,0),(233,0,0,0,'Cerulean House #233',20000,35,0,0,0,0,49,0),(234,0,0,0,'Cerulean House #234',20000,35,0,0,0,0,42,0),(235,0,0,0,'Lavender House #235',45000,36,0,0,0,0,82,0),(236,0,0,0,'Lavender House #236',35000,36,0,0,0,0,63,0),(237,0,0,0,'Lavender Guildhall #1',495000,36,0,0,0,0,713,0),(238,0,0,0,'Fuchsia Guildhall #1',144000,37,0,0,0,0,291,0),(239,0,0,0,'Fuchsia House #239',98000,37,0,0,0,0,162,0),(240,0,0,0,'Fuchsia House #240',42000,37,0,0,0,0,72,0),(241,0,0,0,'Fuchsia House #241',49000,37,0,0,0,0,81,0),(242,0,0,0,'Fuchsia House #242',42000,37,0,0,0,0,72,0),(243,0,0,0,'Fuchsia House #243',49000,37,0,0,0,0,81,0),(244,0,0,0,'Fuchsia Guildhall #2',225000,37,0,0,0,0,396,0),(245,0,0,0,'Fuchsia Guildhall #3',186000,37,0,0,0,0,342,0),(246,0,0,0,'Fuchsia Guildhall #4',110000,37,0,0,0,0,207,0),(247,0,0,0,'Fuchsia Guildhall #5',156000,37,0,0,0,0,270,0),(248,0,0,0,'Fuchsia Guildhall #6',493000,37,0,0,0,0,853,0),(249,0,0,0,'Fuchsia Guildhall #7',111000,37,0,0,0,0,220,0),(250,0,0,0,'Fuchsia House #250',63000,37,0,0,0,0,141,0),(251,0,0,0,'Fuchsia House #251',44000,37,0,0,0,0,92,0),(252,0,0,0,'Fuchsia House #252',147000,37,0,0,0,0,243,0),(253,0,0,0,'Fuchsia House #253',139000,37,0,0,0,0,240,0),(254,0,0,0,'Fuchsia Guildhall #8',197000,37,0,0,0,0,366,0),(255,0,0,0,'Celadon House #255',94000,38,0,0,0,0,168,0),(256,0,0,0,'Celadon House #256',83000,38,0,0,0,0,139,0),(257,0,0,0,'Celadon House #257',69000,38,0,0,0,0,120,0),(258,0,0,0,'Celadon House #258',70000,38,0,0,0,0,120,0),(259,0,0,0,'Celadon House #259',128000,38,0,0,0,0,202,0),(260,0,0,0,'Celadon House #260',80000,38,0,0,0,0,120,0),(261,0,0,0,'Celadon House #261',70000,38,0,0,0,0,120,0),(262,0,0,0,'Celadon House #262',80000,38,0,0,0,0,120,0),(263,0,0,0,'Celadon House #263',80000,38,0,0,0,0,120,0),(264,0,0,0,'Celadon House #264',81000,38,0,0,0,0,125,0),(265,0,0,0,'Celadon House #265',44000,38,0,0,0,0,65,0),(266,0,0,0,'Celadon House #266',122000,38,0,0,0,0,189,0),(267,0,0,0,'Celadon House #267',133000,38,0,0,0,0,198,0),(268,0,0,0,'Celadon House #268',130000,38,0,0,0,0,204,0),(269,0,0,0,'Celadon House #269',151000,38,0,0,0,0,209,0),(270,0,0,0,'Celadon House #270',98000,38,0,0,0,0,162,0),(271,0,0,0,'Celadon House #271',123000,38,0,0,0,0,236,0),(272,0,0,0,'Celadon House #272',137000,38,0,0,0,0,214,0),(273,0,0,0,'Celadon House #273',126000,38,0,0,0,0,232,0),(274,0,0,0,'Celadon House #274',138000,38,0,0,0,0,234,0),(275,0,0,0,'Celadon House #275',63000,38,0,0,0,0,99,0),(276,0,0,0,'Celadon Guildhall #1',260000,38,0,0,0,0,437,0),(277,0,0,0,'Celadon House #277',85000,38,0,0,0,0,147,0),(278,0,0,0,'Celadon House #278',110000,38,0,0,0,0,169,0),(279,0,0,0,'Celadon House #279',49000,38,0,0,0,0,83,0),(280,0,0,0,'Celadon House #280',124000,38,0,0,0,0,208,0),(281,0,0,0,'Celadon House #281',84000,38,0,0,0,0,147,0),(282,0,0,0,'Celadon House #282',105000,38,0,0,0,0,169,0),(283,0,0,0,'Celadon House #283',66000,38,0,0,0,0,104,0),(284,0,0,0,'Celadon House #284',110000,38,0,0,0,0,169,0),(285,0,0,0,'Viridian House #285',54000,39,0,0,0,0,111,0),(286,0,0,0,'Viridian House #286',36000,39,0,0,0,0,64,0),(287,0,0,0,'Viridian House #287',54000,39,0,0,0,0,104,0),(288,0,0,0,'Viridian House #288',78000,39,0,0,0,0,144,0),(289,0,0,0,'Viridian House #289',40000,39,0,0,0,0,84,0),(290,0,0,0,'Viridian House #290',56000,39,0,0,0,0,108,0),(291,0,0,0,'Viridian House #291',70000,39,0,0,0,0,126,0),(292,0,0,0,'Viridian House #292',94000,39,0,0,0,0,154,0),(293,0,0,0,'Viridian House #293',56000,39,0,0,0,0,108,0),(294,0,0,0,'Viridian House #294',65000,39,0,0,0,0,108,0),(295,0,0,0,'Viridian House #295',78000,39,0,0,0,0,144,0),(296,0,0,0,'Viridian House #296',150000,39,0,0,0,0,273,0),(297,0,0,0,'Viridian House #297',134000,39,0,0,0,0,210,0),(298,0,0,0,'Viridian House #298',134000,39,0,0,0,0,210,0),(299,0,0,0,'Vermilion House #299',95000,40,0,0,0,0,150,0),(300,0,0,0,'Vermilion House #300',263000,40,0,0,0,0,390,0),(301,0,0,0,'Vermilion House #301',287000,40,0,0,0,0,419,0),(302,0,0,0,'Vermilion House #302',72000,40,0,0,0,0,120,0),(303,0,0,0,'Vermilion House #303',143000,40,0,0,0,0,234,0),(304,0,0,0,'Vermilion House #304',147000,40,0,0,0,0,216,0),(305,0,0,0,'Vermilion House #305',85000,40,0,0,0,0,148,0),(306,0,0,0,'Vermilion House #306',70000,40,0,0,0,0,124,0),(307,0,0,0,'Vermilion House #307',87000,40,0,0,0,0,126,0),(308,0,0,0,'Pewter House #308',78000,41,0,0,0,0,144,0),(309,0,0,0,'Pewter House #309',65000,41,0,0,0,0,108,0),(310,0,0,0,'Pewter House #310',50000,41,0,0,0,0,98,0),(311,0,0,0,'Pewter House #311',67000,41,0,0,0,0,128,0),(312,0,0,0,'Pewter House #312',66000,41,0,0,0,0,112,0),(313,0,0,0,'Pewter House #313',38000,41,0,0,0,0,68,0),(314,0,0,0,'Pewter House #314',28000,41,0,0,0,0,54,0),(315,0,0,0,'Pewter House #315',24000,41,0,0,0,0,48,0),(316,0,0,0,'Pewter House #316',49000,41,0,0,0,0,81,0),(317,0,0,0,'Pewter House #317',98000,41,0,0,0,0,162,0),(318,0,0,0,'Pewter House #318',98000,41,0,0,0,0,162,0),(319,0,0,0,'Pewter House #319',110000,41,0,0,0,0,188,0),(320,0,0,0,'Pewter House #320',48000,41,0,0,0,0,80,0),(321,0,0,0,'Pewter House #321',48000,41,0,0,0,0,82,0),(322,0,0,0,'Pewter House #322',36000,41,0,0,0,0,62,0),(323,0,0,0,'Pewter House #323',42000,41,0,0,0,0,72,0),(324,0,0,0,'Pallet Guildhall #1',194000,42,0,0,0,0,352,0),(325,0,0,0,'Cinnabar House #325',111000,43,0,0,0,0,197,0),(326,0,0,0,'Cinnabar House #326',19000,43,0,0,0,0,41,0),(327,0,0,0,'Cinnabar House #327',38000,43,0,0,0,0,78,0),(328,0,0,0,'Cinnabar House #328',83000,43,0,0,0,0,125,0),(329,0,0,0,'Cinnabar House #329',62000,43,0,0,0,0,104,0),(330,0,0,0,'Cinnabar House #330',46000,43,0,0,0,0,80,0),(331,0,0,0,'Cinnabar House #331',79000,43,0,0,0,0,150,0),(332,0,0,0,'Cinnabar House #332',144000,43,0,0,0,0,220,0),(333,0,0,0,'Snow House #333',64000,44,0,0,0,0,104,1),(334,0,0,0,'Snow House #334',54000,44,0,0,0,0,90,1),(335,0,0,0,'Snow House #335',33000,44,0,0,0,0,63,1),(336,0,0,0,'Snow House #336',39000,44,0,0,0,0,73,1),(337,0,0,0,'Snow House #337',47000,44,0,0,0,0,81,1),(338,0,0,0,'Snow House #338',33000,44,0,0,0,0,63,1),(339,0,0,0,'Snow House #339',93000,44,0,0,0,0,184,1),(340,0,0,0,'Snow House #340',244000,44,0,0,0,0,352,2),(341,0,0,0,'Snow House #341',62000,44,0,0,0,0,96,1),(342,0,0,0,'Snow House #342',82000,44,0,0,0,0,126,1),(343,0,0,0,'Snow House #343',86000,44,0,0,0,0,178,2),(344,0,0,0,'Snow House #344',67000,44,0,0,0,0,144,1),(345,0,0,0,'Snow House #345',161000,44,0,0,0,0,284,2),(346,0,0,0,'Snow House #346',59000,44,0,0,0,0,103,0),(347,0,0,0,'Snow Guildhall #1',223000,44,0,0,0,0,405,0),(348,0,0,0,'Nostrus House #348',12000,45,0,0,0,0,30,0),(349,0,0,0,'Nostrus House #349',15000,45,0,0,0,0,35,0),(350,0,0,0,'Nostrus House #350',15000,45,0,0,0,0,35,0),(351,0,0,0,'Nostrus House #351',42000,45,0,0,0,0,90,0),(352,0,0,0,'Nostrus House #352',48000,45,0,0,0,0,96,0),(353,0,0,0,'Nostrus House #353',30000,45,0,0,0,0,56,0),(354,0,0,0,'Nostrus House #354',49000,45,0,0,0,0,81,0),(355,0,0,0,'Nostrus House #355',49000,45,0,0,0,0,72,0),(356,0,0,0,'Nostrus House #356',49000,45,0,0,0,0,81,0),(357,0,0,0,'Nostrus House #357',49000,45,0,0,0,0,72,0),(358,0,0,0,'Natturu House #358',48000,47,0,0,0,0,80,0),(359,0,0,0,'Natturu House #359',117000,47,0,0,0,0,165,0),(360,0,0,0,'Natturu House #360',105000,47,0,0,0,0,162,0),(361,0,0,0,'Natturu House #361',105000,47,0,0,0,0,162,0),(362,0,0,0,'Natturu House #362',117000,47,0,0,0,0,165,0),(363,0,0,0,'Natturu House #363',29000,47,0,0,0,0,57,1),(364,0,0,0,'Natturu House #364',191000,47,0,0,0,0,266,0),(365,0,0,0,'Natturu House #365',192000,47,0,0,0,0,266,0),(366,0,0,0,'Eirian House #366',40000,15,0,0,0,0,55,0),(367,0,0,0,'Cherrygrove House #367',27000,51,0,0,0,0,40,0),(368,0,0,0,'Cherrygrove House #368',20000,51,0,0,0,0,30,0),(369,0,0,0,'Cherrygrove House #369',20000,51,0,0,0,0,31,0),(370,0,0,0,'Cherrygrove House #370',33000,51,0,0,0,0,43,0),(371,0,0,0,'Cherrygrove House #371',20000,51,0,0,0,0,30,0),(372,0,0,0,'Cherrygrove House #372',20000,51,0,0,0,0,30,0),(373,0,0,0,'Cherrygrove House #373',28000,51,0,0,0,0,44,0),(374,0,0,0,'Cherrygrove House #374',18000,51,0,0,0,0,23,0),(375,0,0,0,'Cherrygrove House #375',12000,51,0,0,0,0,30,0),(376,0,0,0,'Cherrygrove House #376',48000,51,0,0,0,0,63,0),(377,0,0,0,'Cherrygrove House #377',25000,51,0,0,0,0,42,0),(378,0,0,0,'Cherrygrove House #378',20000,51,0,0,0,0,30,0),(379,0,0,0,'Cherrygrove House #379',16000,51,0,0,0,0,30,0),(380,0,0,0,'Cherrygrove House #380',12000,51,0,0,0,0,21,0),(381,0,0,0,'Cherrygrove House #381',20000,51,0,0,0,0,36,0),(382,0,0,0,'Cherrygrove House #382',15000,51,0,0,0,0,24,0),(383,0,0,0,'Cherrygrove House #383',23000,51,0,0,0,0,39,0),(384,0,0,0,'Cherrygrove House #384',24000,51,0,0,0,0,42,0),(385,0,0,0,'Cherrygrove House #385',23000,51,0,0,0,0,36,0),(386,0,0,0,'Cherrygrove House #386',14000,51,0,0,0,0,28,0),(387,0,0,0,'Cherrygrove House #387',20000,51,0,0,0,0,30,0),(388,0,0,0,'Cherrygrove House #388',16000,51,0,0,0,0,25,0),(389,0,0,0,'Cherrygrove House #389',20000,51,0,0,0,0,30,0),(390,0,0,0,'Violet House #390',46000,52,0,0,0,0,70,0),(391,0,0,0,'Violet House #391',43000,52,0,0,0,0,63,0),(392,0,0,0,'Violet House #392',48000,52,0,0,0,0,63,0),(393,0,0,0,'Violet House #393',42000,52,0,0,0,0,63,0),(394,0,0,0,'Violet House #394',32000,52,0,0,0,0,49,0),(395,0,0,0,'Violet House #395',31000,52,0,0,0,0,49,0),(396,0,0,0,'Violet House #396',26000,52,0,0,0,0,42,0),(397,0,0,0,'Violet House #397',56000,52,0,0,0,0,100,0),(398,0,0,0,'Violet House #398',30000,52,0,0,0,0,48,0),(399,0,0,0,'Violet House #399',30000,52,0,0,0,0,56,0),(400,0,0,0,'Violet House #400',31000,52,0,0,0,0,48,0),(401,0,0,0,'Violet House #401',35000,52,0,0,0,0,54,0),(402,0,0,0,'Violet House #402',33000,52,0,0,0,0,54,0),(403,0,0,0,'Violet House #403',51000,52,0,0,0,0,72,0),(404,0,0,0,'Violet House #404',43000,52,0,0,0,0,63,0),(405,0,0,0,'Violet House #405',37000,52,0,0,0,0,56,0),(406,0,0,0,'Violet House #406',43000,52,0,0,0,0,64,0),(407,0,0,0,'Violet House #407',54000,52,0,0,0,0,78,0),(408,0,0,0,'Violet House #408',43000,52,0,0,0,0,64,0),(409,0,0,0,'Violet House #409',36000,52,0,0,0,0,54,0),(410,0,0,0,'Violet House #410',57000,52,0,0,0,0,81,0),(411,0,0,0,'Violet House #411',54000,52,0,0,0,0,81,0),(412,0,0,0,'Violet House #412',43000,52,0,0,0,0,70,0),(413,0,0,0,'Violet House #413',37000,52,0,0,0,0,56,0),(414,0,0,0,'Violet House #414',37000,52,0,0,0,0,56,0),(415,0,0,0,'Violet House #415',37000,52,0,0,0,0,57,0),(416,0,0,0,'Violet House #416',31000,52,0,0,0,0,50,0),(417,0,0,0,'Violet House #417',43000,52,0,0,0,0,65,0),(418,0,0,0,'Violet House #418',37000,52,0,0,0,0,57,0),(419,0,0,0,'Violet House #419',36000,52,0,0,0,0,50,0),(420,0,0,0,'Violet House #420',42000,52,0,0,0,0,57,0),(421,0,0,0,'Violet House #421',50000,52,0,0,0,0,72,0),(422,0,0,0,'Violet House #422',57000,52,0,0,0,0,81,0),(423,0,0,0,'Azalea House #423',39000,53,0,0,0,0,60,1),(424,0,0,0,'Azalea House #424',51000,53,0,0,0,0,84,2),(425,0,0,0,'Azalea House #425',13000,53,0,0,0,0,28,1),(426,0,0,0,'Azalea House #426',35000,53,0,0,0,0,57,1),(427,0,0,0,'Azalea House #427',51000,53,0,0,0,0,72,0),(428,0,0,0,'Azalea House #428',61000,53,0,0,0,0,85,0),(429,0,0,0,'Azalea House #429',55000,53,0,0,0,0,81,0),(430,0,0,0,'Azalea House #430',67000,53,0,0,0,0,90,0),(431,0,0,0,'Azalea House #431',13000,53,0,0,0,0,25,1),(432,0,0,0,'Azalea House #432',29000,53,0,0,0,0,49,1),(433,0,0,0,'Azalea House #433',46000,53,0,0,0,0,64,1),(434,0,0,0,'Azalea House #434',89000,53,0,0,0,0,122,1),(435,0,0,0,'Azalea House #435',64000,53,0,0,0,0,91,1),(436,0,0,0,'Azalea House #436',57000,53,0,0,0,0,85,2),(437,0,0,0,'Azalea House #437',51000,53,0,0,0,0,72,0),(438,0,0,0,'Azalea House #438',34000,53,0,0,0,0,49,1),(439,0,0,0,'Azalea House #439',22000,53,0,0,0,0,35,1),(440,0,0,0,'Azalea House #440',55000,53,0,0,0,0,80,1),(441,0,0,0,'Goldenrod House #441',16000,54,0,0,0,0,25,0),(442,0,0,0,'Goldenrod House #442',16000,54,0,0,0,0,20,0),(443,0,0,0,'Goldenrod House #443',16000,54,0,0,0,0,25,0),(444,0,0,0,'Goldenrod House #444',16000,54,0,0,0,0,25,0),(445,0,0,0,'Goldenrod House #445',16000,54,0,0,0,0,25,0),(446,0,0,0,'Goldenrod House #446',16000,54,0,0,0,0,25,0),(447,0,0,0,'Goldenrod House #447',25000,54,0,0,0,0,36,0),(448,0,0,0,'Goldenrod House #448',20000,54,0,0,0,0,30,0),(449,0,0,0,'Goldenrod House #449',16000,54,0,0,0,0,25,0),(450,0,0,0,'Goldenrod House #450',16000,54,0,0,0,0,26,0),(451,0,0,0,'Goldenrod House #451',20000,54,0,0,0,0,30,0),(452,0,0,0,'Goldenrod House #452',20000,54,0,0,0,0,30,0),(453,0,0,0,'Goldenrod House #453',20000,54,0,0,0,0,31,0),(454,0,0,0,'Goldenrod House #454',28000,54,0,0,0,0,44,0),(455,0,0,0,'Goldenrod House #455',29000,54,0,0,0,0,46,0),(456,0,0,0,'Goldenrod House #456',16000,54,0,0,0,0,26,0),(457,0,0,0,'Goldenrod House #457',16000,54,0,0,0,0,25,0),(458,0,0,0,'Goldenrod House #458',12000,54,0,0,0,0,20,0),(459,0,0,0,'Goldenrod House #459',9000,54,0,0,0,0,16,0),(460,0,0,0,'Goldenrod House #460',16000,54,0,0,0,0,26,0),(461,0,0,0,'Goldenrod House #461',12000,54,0,0,0,0,26,0),(462,0,0,0,'Goldenrod House #462',12000,54,0,0,0,0,21,0),(463,0,0,0,'Goldenrod House #463',12000,54,0,0,0,0,21,0),(464,0,0,0,'Goldenrod House #464',12000,54,0,0,0,0,21,0),(465,0,0,0,'Goldenrod House #465',34000,54,0,0,0,0,64,0),(466,0,0,0,'Goldenrod House #466',76000,54,0,0,0,0,117,0),(467,0,0,0,'Goldenrod House #467',49000,54,0,0,0,0,64,0),(468,0,0,0,'Ecruteak House #468',59000,55,0,0,0,0,88,0),(469,0,0,0,'Ecruteak House #469',42000,55,0,0,0,0,64,0),(470,0,0,0,'Ecruteak House #470',36000,55,0,0,0,0,56,0),(471,0,0,0,'Ecruteak House #471',56000,55,0,0,0,0,80,0),(472,0,0,0,'Ecruteak House #472',48000,55,0,0,0,0,71,0),(473,0,0,0,'Ecruteak House #473',40000,55,0,0,0,0,60,0),(474,0,0,0,'Ecruteak House #474',40000,55,0,0,0,0,54,0),(475,0,0,0,'Ecruteak House #475',32000,55,0,0,0,0,45,0),(476,0,0,0,'Ecruteak House #476',50000,55,0,0,0,0,72,0),(477,0,0,0,'Ecruteak House #477',50000,55,0,0,0,0,73,0),(478,0,0,0,'Ecruteak House #478',42000,55,0,0,0,0,65,0),(479,0,0,0,'Ecruteak House #479',56000,55,0,0,0,0,87,0),(480,0,0,0,'Ecruteak House #480',54000,55,0,0,0,0,77,0),(481,0,0,0,'Cianwood House #481',66000,56,0,0,0,0,84,0),(482,0,0,0,'Cianwood House #482',45000,56,0,0,0,0,61,0),(483,0,0,0,'Cianwood House #483',54000,56,0,0,0,0,70,0),(484,0,0,0,'Cianwood House #484',54000,56,0,0,0,0,71,0),(485,0,0,0,'Cianwood House #485',48000,56,0,0,0,0,64,0),(486,0,0,0,'Olivine House #486',78000,57,0,0,0,0,110,0),(487,0,0,0,'Olivine House #487',53000,57,0,0,0,0,81,0),(488,0,0,0,'Olivine House #488',55000,57,0,0,0,0,80,0),(489,0,0,0,'Olivine House #489',91000,57,0,0,0,0,121,0),(490,0,0,0,'Olivine House #490',64000,57,0,0,0,0,90,0),(491,0,0,0,'Olivine House #491',43000,57,0,0,0,0,64,0),(492,0,0,0,'Olivine House #492',49000,57,0,0,0,0,72,0),(493,0,0,0,'Olivine House #493',61000,57,0,0,0,0,91,0),(494,0,0,0,'Olivine House #494',87000,57,0,0,0,0,120,0),(495,0,0,0,'Mahogany House #495',34000,58,0,0,0,0,52,1),(496,0,0,0,'Mahogany House #496',33000,58,0,0,0,0,48,1),(497,0,0,0,'Mahogany House #497',33000,58,0,0,0,0,48,1),(498,0,0,0,'Mahogany House #498',62000,58,0,0,0,0,89,1),(499,0,0,0,'Mahogany House #499',19000,58,0,0,0,0,33,1),(500,0,0,0,'Mahogany House #500',38000,58,0,0,0,0,55,1),(501,0,0,0,'Mahogany House #501',26000,58,0,0,0,0,41,1),(502,0,0,0,'Blackthorn House #502',51000,59,0,0,0,0,72,0),(503,0,0,0,'Blackthorn House #503',36000,59,0,0,0,0,56,0),(504,0,0,0,'Blackthorn House #504',21000,59,0,0,0,0,35,0),(505,0,0,0,'Blackthorn House #505',26000,59,0,0,0,0,42,0),(506,0,0,0,'Blackthorn House #506',36000,59,0,0,0,0,55,0),(507,0,0,0,'Blackthorn House #507',25000,59,0,0,0,0,37,0),(508,0,0,0,'Blackthorn House #508',31000,59,0,0,0,0,49,0),(509,0,0,0,'Blackthorn House #509',20000,59,0,0,0,0,31,0),(510,0,0,0,'Blackthorn House #510',24000,59,0,0,0,0,36,0),(511,0,0,0,'Blackthorn House #511',20000,59,0,0,0,0,31,0),(512,0,0,0,'Blackthorn House #512',24000,59,0,0,0,0,35,0),(513,0,0,0,'Blackthorn House #513',16000,59,0,0,0,0,25,0),(514,0,0,0,'Blackthorn House #514',29000,59,0,0,0,0,45,0),(515,0,0,0,'Blackthorn House #515',36000,59,0,0,0,0,54,0),(516,0,0,0,'Blackthorn House #516',29000,59,0,0,0,0,45,0),(517,0,0,0,'Blackthorn House #517',29000,59,0,0,0,0,45,0),(518,0,0,0,'Blackthorn House #518',37000,59,0,0,0,0,56,0),(519,0,0,0,'Blackthorn House #519',29000,59,0,0,0,0,43,0),(520,0,0,0,'Blackthorn House #520',24000,59,0,0,0,0,36,0),(521,0,0,0,'Blackthorn House #521',31000,59,0,0,0,0,49,0),(522,0,0,0,'Blackthorn House #522',41000,59,0,0,0,0,60,0),(523,0,0,0,'Blackthorn House #523',33000,59,0,0,0,0,50,0),(524,0,0,0,'Blackthorn House #524',24000,59,0,0,0,0,36,0),(525,0,0,0,'Blackthorn House #525',20000,59,0,0,0,0,31,0),(526,0,0,0,'Blackthorn House #526',15000,59,0,0,0,0,25,0),(527,0,0,0,'Blackthorn House #527',20000,59,0,0,0,0,31,0),(528,0,0,0,'Blackthorn House #528',25000,59,0,0,0,0,36,0),(529,0,0,0,'Blackthorn House #529',73000,59,0,0,0,0,99,0),(530,0,0,0,'Blackthorn House #530',36000,59,0,0,0,0,49,0),(531,0,0,0,'Blackthorn House #531',35000,59,0,0,0,0,49,0),(532,0,0,0,'Blackthorn House #532',25000,59,0,0,0,0,36,0),(533,0,0,0,'Blackthorn House #533',20000,59,0,0,0,0,30,0),(534,0,0,0,'Blackthorn House #534',25000,59,0,0,0,0,36,0),(535,0,0,0,'Blackthorn House #535',24000,59,0,0,0,0,38,0),(536,0,0,0,'Blackthorn House #536',21000,59,0,0,0,0,33,0),(537,0,0,0,'Blackthorn House #537',18000,59,0,0,0,0,29,0),(538,0,0,0,'Blackthorn House #538',45000,59,0,0,0,0,60,0),(539,0,0,0,'Blackthorn House #539',25000,59,0,0,0,0,36,0),(540,0,0,0,'Blackthorn House #540',35000,59,0,0,0,0,48,0);
/*!40000 ALTER TABLE `houses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_bans`
--

DROP TABLE IF EXISTS `ip_bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip_bans` (
  `ip` int unsigned NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint NOT NULL,
  `expires_at` bigint NOT NULL,
  `banned_by` int NOT NULL,
  PRIMARY KEY (`ip`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_bans`
--

LOCK TABLES `ip_bans` WRITE;
/*!40000 ALTER TABLE `ip_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_history`
--

DROP TABLE IF EXISTS `market_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int unsigned NOT NULL,
  `amount` smallint unsigned NOT NULL,
  `price` int unsigned NOT NULL DEFAULT '0',
  `expires_at` bigint unsigned NOT NULL,
  `inserted` bigint unsigned NOT NULL,
  `state` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`,`sale`),
  CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1300 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_history`
--

LOCK TABLES `market_history` WRITE;
/*!40000 ALTER TABLE `market_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_offers`
--

DROP TABLE IF EXISTS `market_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_offers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int unsigned NOT NULL,
  `amount` smallint unsigned NOT NULL,
  `created` bigint unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sale` (`sale`,`itemtype`),
  KEY `created` (`created`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_offers`
--

LOCK TABLES `market_offers` WRITE;
/*!40000 ALTER TABLE `market_offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_deaths`
--

DROP TABLE IF EXISTS `player_deaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_deaths` (
  `player_id` int NOT NULL,
  `time` bigint unsigned NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`),
  KEY `killed_by` (`killed_by`),
  KEY `mostdamage_by` (`mostdamage_by`),
  CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_deaths`
--

LOCK TABLES `player_deaths` WRITE;
/*!40000 ALTER TABLE `player_deaths` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_deaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_depotitems`
--

DROP TABLE IF EXISTS `player_depotitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_depotitems` (
  `player_id` int NOT NULL,
  `sid` int NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int NOT NULL DEFAULT '0',
  `itemtype` mediumint NOT NULL,
  `count` smallint NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_depotitems`
--

LOCK TABLES `player_depotitems` WRITE;
/*!40000 ALTER TABLE `player_depotitems` DISABLE KEYS */;
INSERT INTO `player_depotitems` VALUES (2,101,0,26688,5,_binary ''),(2,102,34,1988,1,''),(2,103,34,26688,5,_binary ''),(2,104,34,26688,5,_binary ''),(2,105,34,26688,5,_binary ''),(2,106,34,26688,5,_binary ''),(2,107,34,26688,63,_binary '?'),(2,108,34,2152,15,_binary ''),(2,109,34,2152,5,_binary ''),(2,110,34,2152,5,_binary ''),(2,111,34,2152,5,_binary ''),(2,112,34,26727,10,_binary '\n'),(2,113,34,26727,100,_binary 'd'),(2,114,34,26734,100,_binary 'd'),(2,115,34,2160,4,_binary ''),(2,116,34,26670,1,_binary '\"ˆ\0{[\"pokeMaxHealth\"] = 2009,[\"pokeHealth\"] = 2009,[\"pokeExperience\"] = 0,[\"pokeName\"] = \"Tentacruel\",[\"pokeBoost\"] = 0,[\"pokeLevel\"] = 1,}'),(2,117,34,26670,1,_binary '\"†\0{[\"pokeMaxHealth\"] = 1507,[\"pokeHealth\"] = 1507,[\"pokeExperience\"] = 0,[\"pokeName\"] = \"Kabutops\",[\"pokeBoost\"] = 0,[\"pokeLevel\"] = 1,}'),(2,118,34,26670,1,_binary '\"‡\0{[\"pokeMaxHealth\"] = 2512,[\"pokeHealth\"] = 2512,[\"pokeExperience\"] = 0,[\"pokeName\"] = \"Tyranitar\",[\"pokeBoost\"] = 0,[\"pokeLevel\"] = 1,}'),(2,119,34,26670,1,_binary '\"µ\0{[\"pokeLevel\"] = 100,[\"cd1\"] = 1537917845,[\"pokeExperience\"] = 0,[\"pokeLookDir\"] = 1,[\"pokeBoost\"] = 31,[\"pokeHealth\"] = 4965,[\"pokeName\"] = \"Shiny golem\",[\"pokeMaxHealth\"] = 4965,}'),(2,120,34,26670,1,_binary '\"ž\0{[\"pokeBoost\"] = 0,[\"pokeExperience\"] = 0,[\"pokeLookDir\"] = 2,[\"pokeMaxHealth\"] = 3750,[\"pokeHealth\"] = 939,[\"pokeName\"] = \"Shiny flygon\",[\"pokeLevel\"] = 50,}'),(2,121,34,26670,1,_binary '\"8{[\"cd3\"] = 1538090729,[\"pokeHealth\"] = 82315,[\"cd6\"] = 1538090558,[\"cd1\"] = 1538090733,[\"cd8\"] = 1538090741,[\"pokeLevel\"] = 200,[\"cd4\"] = 1537736425,[\"cd2\"] = 1538090727,[\"pokeMaxHealth\"] = 50880,[\"pokeLookDir\"] = 3,[\"pokeExperience\"] = 0,[\"pokeBoost\"] = 200,[\"pokeName\"] = \"Shiny moltres\",[\"cd7\"] = 1538090736,}'),(2,122,34,26670,1,_binary '\" \0{[\"pokeLookDir\"] = 3,[\"pokeMaxHealth\"] = 3577,[\"pokeName\"] = \"Shiny gyarados\",[\"pokeHealth\"] = 3577,[\"pokeBoost\"] = 0,[\"pokeExperience\"] = 0,[\"pokeLevel\"] = 1,}'),(2,123,34,26670,1,_binary '\"Ÿ\0{[\"pokeHealth\"] = 2633,[\"pokeLevel\"] = 1,[\"pokeMaxHealth\"] = 1889,[\"pokeLookDir\"] = 2,[\"pokeBoost\"] = 0,[\"pokeExperience\"] = 0,[\"pokeName\"] = \"Shiny Pupitar\",}'),(2,124,34,26670,1,_binary '\"{[\"cd3\"] = 1537918511,[\"cd6\"] = 1537918534,[\"cd5\"] = 1537918536,[\"pokeLookDir\"] = 0,[\"cd2\"] = 1537918501,[\"pokeMaxHealth\"] = 4380,[\"pokeExperience\"] = 0,[\"pokeBoost\"] = 0,[\"pokeName\"] = \"Shiny charizard\",[\"pokeHealth\"] = 4380,[\"cd4\"] = 1537918530,[\"pokeLevel\"] = 100,}'),(2,125,34,26670,1,_binary '\"–\0{[\"pokeBoost\"] = 0,[\"pokeExperience\"] = 0,[\"pokeLookDir\"] = 0,[\"pokeMaxHealth\"] = 20,[\"pokeHealth\"] = 20,[\"pokeName\"] = \"Shedinja\",[\"pokeLevel\"] = 1,}'),(2,126,34,26681,1,_binary '\"„\0{[\"pokeBoost\"] = 0,[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 1320,[\"pokeHealth\"] = 0,[\"pokeName\"] = \"Pikachu\",[\"pokeLevel\"] = 100,}'),(2,127,34,26670,1,_binary '\"\î\0{[\"cd3\"] = 1538000165,[\"pokeLookDir\"] = 2,[\"pokeMaxHealth\"] = 984,[\"cd2\"] = 1538000160,[\"cd4\"] = 1538000179,[\"pokeExperience\"] = 0,[\"pokeBoost\"] = 0,[\"pokeName\"] = \"Charmander\",[\"pokeHealth\"] = 713,[\"cd1\"] = 1538000165,[\"pokeLevel\"] = 1,}'),(2,128,34,26662,99,_binary 'c');
/*!40000 ALTER TABLE `player_depotitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_inboxitems`
--

DROP TABLE IF EXISTS `player_inboxitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_inboxitems` (
  `player_id` int NOT NULL,
  `sid` int NOT NULL,
  `pid` int NOT NULL DEFAULT '0',
  `itemtype` mediumint NOT NULL,
  `count` smallint NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_inboxitems`
--

LOCK TABLES `player_inboxitems` WRITE;
/*!40000 ALTER TABLE `player_inboxitems` DISABLE KEYS */;
INSERT INTO `player_inboxitems` VALUES (1,101,0,26670,1,_binary '\"{[\"pokeExperience\"] = 2718,[\"cd1\"] = 1543870160,[\"cd5\"] = 1543870164,[\"cd3\"] = 1544748565,[\"pokeBoost\"] = 0,[\"pokeLookDir\"] = 3,[\"pokeMaxHealth\"] = 1135,[\"pokeLevel\"] = 7,[\"pokeHealth\"] = 1271,[\"cd2\"] = 1543870167,[\"cd6\"] = 1544748549,[\"pokeName\"] = \"Shiny gengar\",[\"cd4\"] = 1543870168,}'),(2,101,0,26670,1,_binary '\"¯\0{[\"pokeMaxHealth\"] = 1989,[\"isBeingUsed\"] = 0,[\"pokeHealth\"] = 1645,[\"pokeExperience\"] = 0,[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Blastoise\",[\"pokeLookDir\"] = 1,[\"pokeBoost\"] = 0,}'),(2,102,0,26733,32,_binary ' '),(2,103,0,26727,42,_binary '*'),(2,104,0,26724,1,_binary ''),(2,105,0,2160,5,_binary ''),(2,106,0,2160,5,_binary ''),(2,107,0,27645,5,_binary ''),(2,108,0,26670,1,_binary '\"€\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Onix\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 884,[\"pokeHealth\"] = 884,[\"pokeBoost\"] = 0,}'),(2,109,0,27646,5,_binary ''),(2,110,0,26670,1,_binary '\"ƒ\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Pikachu\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 884,[\"pokeHealth\"] = 884,[\"pokeBoost\"] = 0,}'),(2,111,0,26670,1,_binary '\"„\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Raichu\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 1507,[\"pokeHealth\"] = 1507,[\"pokeBoost\"] = 0,}'),(2,112,0,26670,1,_binary '\"‡\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Blastoise\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 1989,[\"pokeHealth\"] = 1989,[\"pokeBoost\"] = 0,}'),(2,113,0,26670,1,_binary '\"†\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Venusaur\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 2009,[\"pokeHealth\"] = 2009,[\"pokeBoost\"] = 0,}'),(2,114,0,26670,1,_binary '\"‡\0{[\"pokeLevel\"] = 1,[\"pokeName\"] = \"Charizard\",[\"pokeExperience\"] = 0,[\"pokeMaxHealth\"] = 1969,[\"pokeHealth\"] = 1969,[\"pokeBoost\"] = 0,}');
/*!40000 ALTER TABLE `player_inboxitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_items`
--

DROP TABLE IF EXISTS `player_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_items` (
  `player_id` int NOT NULL DEFAULT '0',
  `pid` int NOT NULL DEFAULT '0',
  `sid` int NOT NULL DEFAULT '0',
  `itemtype` mediumint NOT NULL DEFAULT '0',
  `count` smallint NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  KEY `player_id` (`player_id`),
  KEY `sid` (`sid`),
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_items`
--

LOCK TABLES `player_items` WRITE;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` VALUES (1,2,101,26820,1,''),(1,3,102,1988,1,''),(1,6,103,8922,1,''),(1,7,104,38681,1,''),(1,8,105,38680,1,''),(1,9,106,38682,1,''),(1,11,107,2270,1,''),(1,12,108,2263,1,''),(1,102,109,26670,1,_binary '\"P{[\"cd4\"] = 1537048933,[\"cd2\"] = 1537048940,[\"pokeMaxHealth\"] = 456,[\"pokeExperience\"] = 385932,[\"cd7\"] = 1537048914,[\"pokeBoost\"] = 2,[\"pokeLookDir\"] = 3,[\"pokeLevel\"] = 30,[\"cd5\"] = 1537048937,[\"pokeHealth\"] = 100000,[\"cd3\"] = 1537048937,[\"cd6\"] = 1537048932,[\"pokeName\"] = \"Shiny Charizard\",[\"cd8\"] = 1537048915,[\"cd1\"] = 1537048942,}'),(1,102,110,26670,1,_binary '\"g{[\"cd4\"] = 1543870129,[\"pokeLevel\"] = 40,[\"cd2\"] = 1543870129,[\"pokeMaxHealth\"] = 3650,[\"pokeExperience\"] = 210304,[\"cd7\"] = 1543870123,[\"pokeHealth\"] = 100000,[\"cd9\"] = 1543870123,[\"pokeBoost\"] = 10,[\"pokeLookDir\"] = 0,[\"cd5\"] = 1543870128,[\"cd3\"] = 1543870136,[\"pokeName\"] = \"Shiny charizard\",[\"cd6\"] = 1543870137,[\"cd8\"] = 1543870129,[\"cd1\"] = 1543870130,}'),(1,102,111,26683,65,_binary 'A'),(1,102,112,2160,7,_binary ''),(1,102,113,2148,80,_binary 'P'),(1,102,114,23782,1,''),(1,102,115,23782,1,''),(1,102,116,2152,2,_binary ''),(1,102,117,27645,7,_binary ''),(1,102,118,27646,23,_binary ''),(1,102,119,2120,1,''),(1,105,120,38687,1,''),(1,105,121,38686,1,''),(1,105,122,38688,1,''),(1,105,123,38684,1,''),(1,105,124,38690,1,''),(1,105,125,38685,1,''),(1,105,126,38683,1,''),(1,105,127,38689,1,''),(1,105,128,26611,1,''),(1,105,129,26610,1,''),(1,105,130,26616,1,''),(1,105,131,26613,1,''),(1,105,132,26612,1,''),(1,105,133,26615,1,''),(1,105,134,26609,1,''),(1,105,135,26614,1,''),(1,114,136,26662,73,_binary 'I'),(1,114,137,26659,58,_binary ':'),(1,114,138,26688,16,_binary ''),(1,115,139,26661,1,_binary '\"{[\"pokeMaxHealth\"] = 223,[\"cd2\"] = 1536090837,[\"pokeLevel\"] = 12,[\"cd4\"] = 1536090847,[\"pokeHealth\"] = 655,[\"cd3\"] = 1536090839,[\"pokeLookDir\"] = 1,[\"cd5\"] = 1536090854,[\"isBeingUsed\"] = 0,[\"cd1\"] = 1536090835,[\"pokeExperience\"] = 17776,[\"pokeBoost\"] = 0,[\"pokeName\"] = \"Pikachu\",}'),(1,115,140,26669,1,_binary '\"\ï\0{[\"pokeMaxHealth\"] = 343,[\"pokeBoost\"] = 0,[\"pokeLevel\"] = 5,[\"pokeHealth\"] = 888,[\"cd3\"] = 1536088285,[\"pokeLookDir\"] = 1,[\"isBeingUsed\"] = 0,[\"cd1\"] = 1536088280,[\"pokeExperience\"] = 854,[\"cd2\"] = 1536088284,[\"pokeName\"] = \"Bellsprout\",}'),(1,115,141,26661,1,_binary '\"{[\"pokeMaxHealth\"] = 199,[\"cd2\"] = 1535909824,[\"pokeLevel\"] = 2,[\"cd4\"] = 1535909830,[\"pokeHealth\"] = 464,[\"cd3\"] = 1535909831,[\"pokeLookDir\"] = 0,[\"isBeingUsed\"] = 0,[\"cd1\"] = 1535909819,[\"pokeExperience\"] = 100,[\"pokeBoost\"] = 0,[\"pokeName\"] = \"Rattata\",}'),(2,2,101,26820,1,''),(2,3,102,26760,1,''),(2,6,103,8922,1,''),(2,7,104,38681,1,''),(2,8,105,38680,1,''),(2,9,106,38682,1,''),(2,11,107,2270,1,''),(2,12,108,2263,1,''),(2,102,109,26683,70,_binary 'F'),(2,102,110,26670,1,_binary '\"£{[\"cd1\"] = 1549666423.25,[\"pokeBoost\"] = 50,[\"cd3\"] = 1549666427.5,[\"cd10\"] = 1549666420,[\"pokeHealth\"] = 68850,[\"pokeMaxHealth\"] = 141750,[\"cd4\"] = 1549666427.25,[\"pokeLookDir\"] = 3,[\"pokeLevel\"] = 100,[\"cd9\"] = 1548716063.25,[\"cd6\"] = 1549666361.25,[\"cd7\"] = 1549666373.75,[\"isBeingUsed\"] = 0,[\"pokeName\"] = \"Shiny moltres\",[\"pokeExperience\"] = 0,[\"cd2\"] = 1549666422.75,[\"cd5\"] = 1545260597.75,[\"cd8\"] = 1549666387,}'),(2,102,111,26670,1,_binary '\"-{[\"cd5\"] = 1634510261,[\"pokeMaxHealth\"] = 1645,[\"cd6\"] = 1634510228,[\"pokeLookDir\"] = 0,[\"cd3\"] = 1634510250,[\"pokeLevel\"] = 1,[\"cd2\"] = 1634510244,[\"cd4\"] = 1634510246,[\"isBeingUsed\"] = 0,[\"pokeName\"] = \"Blastoise\",[\"cd7\"] = 1634510260,[\"pokeExperience\"] = 0,[\"pokeHealth\"] = 1570,[\"pokeBoost\"] = 0,}'),(2,102,112,2160,100,_binary 'd'),(2,102,113,26749,1,_binary ''),(2,102,114,27646,96,_binary '`'),(2,102,115,27634,1,''),(2,102,116,2120,1,''),(2,102,117,27645,66,_binary 'B'),(2,105,118,38687,1,''),(2,105,119,38686,1,''),(2,105,120,38688,1,''),(2,105,121,38684,1,''),(2,105,122,38690,1,''),(2,105,123,38685,1,''),(2,105,124,38683,1,''),(2,105,125,38689,1,''),(2,105,126,26611,1,''),(2,105,127,26610,1,''),(2,105,128,26616,1,''),(2,105,129,26613,1,''),(2,105,130,26602,1,''),(2,105,131,26615,1,''),(2,105,132,26609,1,''),(2,105,133,26614,1,'');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_namelocks`
--

DROP TABLE IF EXISTS `player_namelocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_namelocks` (
  `player_id` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint NOT NULL,
  `namelocked_by` int NOT NULL,
  PRIMARY KEY (`player_id`),
  KEY `namelocked_by` (`namelocked_by`),
  CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_namelocks`
--

LOCK TABLES `player_namelocks` WRITE;
/*!40000 ALTER TABLE `player_namelocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_namelocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_spells`
--

DROP TABLE IF EXISTS `player_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_spells` (
  `player_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_spells`
--

LOCK TABLES `player_spells` WRITE;
/*!40000 ALTER TABLE `player_spells` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_storage`
--

DROP TABLE IF EXISTS `player_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_storage` (
  `player_id` int NOT NULL DEFAULT '0',
  `key` int unsigned NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`key`),
  CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_storage`
--

LOCK TABLES `player_storage` WRITE;
/*!40000 ALTER TABLE `player_storage` DISABLE KEYS */;
INSERT INTO `player_storage` VALUES (1,1000,1541245853),(1,5004,1),(1,5021,240),(1,10252,0),(1,30018,1),(1,61011,6),(1,61019,51),(1,61021,4),(1,61041,8),(1,61044,3),(1,61069,16),(1,61070,3),(1,61114,3),(1,61163,3),(1,61234,2),(1,63019,2),(1,63069,1),(1,64019,2),(1,64041,1),(1,64069,1),(1,67006,0),(1,67011,0),(1,67019,0),(1,67025,0),(1,67041,0),(1,67044,0),(1,67069,0),(1,67070,0),(1,67199,0),(1,67234,0),(1,69006,0),(1,69071,0),(1,69101,0),(1,91000,1),(1,91014,0),(1,92000,0),(1,92001,0),(1,92002,0),(1,92003,0),(1,92004,0),(1,92005,0),(1,92006,0),(1,92007,0),(1,92008,0),(1,92009,0),(1,92010,0),(1,92011,0),(1,92012,0),(1,92013,0),(1,92014,0),(1,92015,0),(1,92016,0),(1,92017,0),(1,92018,0),(1,92019,0),(1,92020,0),(2,0,2),(2,1000,1550104100),(2,1001,1550434805),(2,5004,1),(2,5005,1537221840),(2,5007,1536779377),(2,5015,1545261208),(2,5017,3),(2,5018,50),(2,5019,1),(2,5021,1500),(2,10200,0),(2,10201,0),(2,10202,0),(2,10203,1),(2,10204,1),(2,10205,0),(2,10209,0),(2,10210,0),(2,10211,0),(2,10212,0),(2,10213,0),(2,10214,0),(2,10215,0),(2,10216,0),(2,10217,0),(2,10218,0),(2,10219,0),(2,10220,0),(2,10221,0),(2,10222,0),(2,10223,0),(2,10224,0),(2,10225,0),(2,10226,0),(2,10227,0),(2,10228,0),(2,10229,1),(2,10230,0),(2,10231,0),(2,10232,0),(2,10233,0),(2,10234,0),(2,10235,0),(2,10236,0),(2,10237,0),(2,10238,0),(2,10239,0),(2,10240,0),(2,10241,1),(2,10242,1),(2,10243,0),(2,10244,0),(2,10245,0),(2,10246,0),(2,10247,1),(2,10248,0),(2,10249,0),(2,10250,0),(2,10251,0),(2,10252,0),(2,30018,1),(2,61000,1),(2,61019,51),(2,61105,1),(2,61259,1),(2,61267,1),(2,61304,1),(2,63309,1),(2,64019,4),(2,64035,1),(2,67003,0),(2,67004,0),(2,67009,0),(2,67016,0),(2,67017,0),(2,67020,0),(2,67025,0),(2,67045,0),(2,67051,0),(2,67065,0),(2,67066,0),(2,67080,0),(2,67094,0),(2,67101,0),(2,67106,0),(2,67107,0),(2,67130,0),(2,67132,0),(2,67133,0),(2,67135,0),(2,67143,0),(2,67146,0),(2,67199,0),(2,67201,0),(2,67202,0),(2,67208,0),(2,67212,0),(2,67242,0),(2,67259,0),(2,67267,0),(2,67282,0),(2,67286,0),(2,67292,0),(2,67304,0),(2,67309,0),(2,67350,0),(2,67375,0),(2,67467,0),(2,69003,0),(2,69006,0),(2,69009,0),(2,69045,0),(2,69047,0),(2,69065,0),(2,69071,0),(2,69075,0),(2,69076,0),(2,69082,0),(2,69089,0),(2,69094,0),(2,69095,0),(2,69103,0),(2,69115,0),(2,69122,0),(2,69124,0),(2,69131,0),(2,69133,0),(2,69143,0),(2,69146,0),(2,69160,0),(2,69168,0),(2,69171,0),(2,69196,0),(2,69197,0),(2,69199,0),(2,69200,0),(2,69202,0),(2,69203,0),(2,69218,0),(2,69230,0),(2,69237,0),(2,69242,0),(2,69246,0),(2,69247,0),(2,69260,0),(2,69282,0),(2,69289,0),(2,69297,0),(2,69306,0),(2,69309,0),(2,69315,0),(2,69330,0),(2,69376,0),(2,69445,0),(2,69462,0),(2,69466,0),(2,69467,0),(2,70002,0),(2,70003,0),(2,70009,0),(2,70011,0),(2,70014,0),(2,70015,0),(2,70016,0),(2,70017,0),(2,70020,0),(2,70038,0),(2,70046,0),(2,91000,1),(2,91007,0),(2,91008,1547594166),(2,91009,0),(2,91014,0),(2,92000,0),(2,92001,0),(2,92002,0),(2,92003,1),(2,92004,0),(2,92005,0),(2,92006,0),(2,92007,0),(2,92008,0),(2,92009,0),(2,92010,0),(2,92011,0),(2,92012,0),(2,92013,0),(2,92014,0),(2,92015,0),(2,92016,0),(2,92017,0),(2,92018,0),(2,92019,1),(2,92020,0),(2,910010,0);
/*!40000 ALTER TABLE `player_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group_id` int NOT NULL DEFAULT '1',
  `account_id` int NOT NULL DEFAULT '0',
  `level` int NOT NULL DEFAULT '1',
  `vocation` int NOT NULL DEFAULT '0',
  `health` int NOT NULL DEFAULT '150',
  `healthmax` int NOT NULL DEFAULT '150',
  `experience` bigint NOT NULL DEFAULT '0',
  `lookbody` int NOT NULL DEFAULT '0',
  `lookfeet` int NOT NULL DEFAULT '0',
  `lookhead` int NOT NULL DEFAULT '0',
  `looklegs` int NOT NULL DEFAULT '0',
  `looktype` int NOT NULL DEFAULT '136',
  `lookaddons` int NOT NULL DEFAULT '0',
  `maglevel` int NOT NULL DEFAULT '0',
  `mana` int NOT NULL DEFAULT '0',
  `manamax` int NOT NULL DEFAULT '0',
  `manaspent` int unsigned NOT NULL DEFAULT '0',
  `soul` int unsigned NOT NULL DEFAULT '0',
  `town_id` int NOT NULL DEFAULT '0',
  `posx` int NOT NULL DEFAULT '0',
  `posy` int NOT NULL DEFAULT '0',
  `posz` int NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int NOT NULL DEFAULT '0',
  `sex` int NOT NULL DEFAULT '0',
  `lastlogin` bigint unsigned NOT NULL DEFAULT '0',
  `lastip` int unsigned NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` int NOT NULL DEFAULT '0',
  `lastlogout` bigint unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint NOT NULL DEFAULT '0',
  `onlinetime` int NOT NULL DEFAULT '0',
  `deletion` bigint NOT NULL DEFAULT '0',
  `balance` bigint unsigned NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int NOT NULL DEFAULT '-1',
  `stamina` smallint unsigned NOT NULL DEFAULT '2520',
  `skill_fist` int unsigned NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_club` int unsigned NOT NULL DEFAULT '10',
  `skill_club_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_sword` int unsigned NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_axe` int unsigned NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_dist` int unsigned NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_shielding` int unsigned NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint unsigned NOT NULL DEFAULT '0',
  `skill_fishing` int unsigned NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `account_id` (`account_id`),
  KEY `vocation` (`vocation`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2985 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Pota',1,1,11,0,1010,1010,13752,81,114,114,81,1974,0,0,125,125,0,100,34,1060,1052,7,'',6,1,1550185404,3580628823,1,0,0,1550185910,0,36409,0,0,43200,-1,2518,0,0,0,0,0,0,0,0,0,0,1,0,1,0),(2,'GOD Pota',3,1,200,0,960,960,129506428,114,1,114,1,75,0,0,75,75,0,100,34,1050,1051,7,'',6,1,1634510186,16777343,1,0,0,1634510259,0,15282646,0,904070,43200,-1,2520,0,0,0,0,0,0,0,0,0,0,1,0,20,0);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `players_online`
--

DROP TABLE IF EXISTS `players_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players_online` (
  `player_id` int NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players_online`
--

LOCK TABLES `players_online` WRITE;
/*!40000 ALTER TABLE `players_online` DISABLE KEYS */;
INSERT INTO `players_online` VALUES (2);
/*!40000 ALTER TABLE `players_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_config`
--

DROP TABLE IF EXISTS `server_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_config`
--

LOCK TABLES `server_config` WRITE;
/*!40000 ALTER TABLE `server_config` DISABLE KEYS */;
INSERT INTO `server_config` VALUES ('db_version','19'),('motd_hash','cb4834797fe34582d1903b61a9e154617e891ddd'),('motd_num','1'),('players_record','41');
/*!40000 ALTER TABLE `server_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tile_store`
--

DROP TABLE IF EXISTS `tile_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tile_store` (
  `house_id` int NOT NULL,
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tile_store`
--

LOCK TABLES `tile_store` WRITE;
/*!40000 ALTER TABLE `tile_store` DISABLE KEYS */;
INSERT INTO `tile_store` VALUES (1,_binary '(ý\0\0\0‰\0'),(2,_binary '!\0\0\0‰\0'),(3,_binary '\0\0\0‰\0'),(4,_binary '\0\0\0‰\0'),(5,_binary '\0\0\0‰\0'),(6,_binary '\0\0\0‰\0'),(7,_binary '	\0\0\0‰\0'),(8,_binary '\0\0\0‰\0'),(9,_binary 'ü\'\0\0\0‰\0'),(10,_binary '\ô\'\0\0\0‰\0'),(11,_binary '\ì\'\0\0\0‰\0'),(12,_binary '\÷1\0\0\0‰\0'),(13,_binary '\ì.\0\0\0‰\0'),(14,_binary '\÷:\0\0\0‰\0'),(15,_binary 'ý<\0\0\0‰\0'),(16,_binary '?\0\0\0‰\0'),(17,_binary 'E\0\0\0‰\0'),(18,_binary 'F\0\0\0‰\0'),(19,_binary '	A\0\0\0‰\0'),(20,_binary '<\0\0\0‰\0'),(20,_binary ' <\0\0\0‰\0'),(21,_binary '*?\0\0\0‰\0'),(22,_binary '*J\0\0\0‰\0'),(23,_binary ')Q\0\0\0‰\0'),(24,_binary 'Q\0\0\0‰\0'),(25,_binary '9#\0\0\0‰\0'),(26,_binary '6\0\0\0‰\0'),(27,_binary '4\0\0\0‰\0'),(28,_binary 'Q\0\0\0‰\0'),(29,_binary 'K\0\0\0‰\0'),(30,_binary 'B\0\0\0‰\0'),(31,_binary '2\0\0\0‰\0'),(32,_binary '2þ\0\0\0‰\0'),(33,_binary 'Cú\0\0\0‰\0'),(34,_binary 'Lú\0\0\0‰\0'),(35,_binary 'Sú\0\0\0‰\0'),(36,_binary '-\0\0\0‰\0'),(36,_binary ',\0\0\0‰\0'),(36,_binary '$-\0\0\0‰\0'),(37,_binary '#,\0\0\0‰\0'),(38,_binary '\0\0\0‰\0'),(39,_binary '\0\0\0‰\0'),(40,_binary '\0\0\0‰\0'),(41,_binary '\0\0\0‰\0'),(42,_binary '\0\0\0‰\0'),(42,_binary '#\0\0\0‰\0'),(43,_binary '\0\0\0‰\0'),(44,_binary '\0\0\0‰\0'),(45,_binary 'E\0\0\0‰\0'),(46,_binary 'A\0\0\0‰\0'),(47,_binary 'A\0\0\0‰\0'),(48,_binary 'E\0\0\0‰\0'),(49,_binary 'D\0\0\0‰\0'),(50,_binary '\n@\0\0\0‰\0'),(51,_binary '\rC\0\0\0‰\0'),(52,_binary '\nE\0\0\0‰\0'),(53,_binary 'F\ö\0\0\0‰\0'),(53,_binary 'K\ö\0\0\0‰\0'),(54,_binary '\n\0\0\0‰\0'),(55,_binary '\n\0\0\0‰\0'),(56,_binary '-v\0\0\0‰\0'),(56,_binary '3s\0\0\0‰\0'),(56,_binary '2s\0\0\0‰\0'),(56,_binary '2s\0\0\0‰\0'),(56,_binary '5s\0\0\0‰\0'),(56,_binary '5s\0\0\0‰\0'),(56,_binary '7t\0\0\0‰\0'),(56,_binary '7v\0\0\0‰\0'),(56,_binary '9t\0\0\0‰\0'),(56,_binary '3x\0\0\0‰\0'),(56,_binary '2x\0\0\0‰\0'),(56,_binary '2x\0\0\0‰\0'),(56,_binary '5y\0\0\0‰\0'),(56,_binary '5x\0\0\0‰\0'),(57,_binary '/-\0\0\0‰\0'),(57,_binary '.5\0\0\0‰\0'),(58,_binary 'C1\0\0\0‰\0'),(59,_binary 'M1\0\0\0‰\0'),(60,_binary '@8\0\0\0‰\0'),(60,_binary 'A;\0\0\0‰\0'),(61,_binary 'K8\0\0\0‰\0'),(62,_binary 'R8\0\0\0‰\0'),(63,_binary '`3\0\0\0‰\0'),(64,_binary 'j1\0\0\0‰\0'),(65,_binary '`7\0\0\0‰\0'),(66,_binary 'i7\0\0\0‰\0'),(67,_binary 'o7\0\0\0‰\0'),(68,_binary 'a\0\0\0‰\0'),(69,_binary 'R\0\0\0‰\0'),(70,_binary '*\n\0\0\0‰\0'),(71,_binary '0\0\0\0‰\0'),(72,_binary '&\0\0\0‰\0'),(73,_binary '!\0\0\0‰\0'),(74,_binary '2\0\0\0‰\0'),(75,_binary ')\0\0\0‰\0'),(76,_binary '\0\0\0‰\0'),(77,_binary '2\0\0\0‰\0'),(78,_binary ')\0\0\0‰\0'),(79,_binary '\0\0\0‰\0'),(80,_binary '?3\0\0\0‰\0'),(81,_binary 'H3\0\0\0‰\0'),(82,_binary 'R3\0\0\0‰\0'),(83,_binary '?7\0\0\0‰\0'),(84,_binary 'I7\0\0\0‰\0'),(85,_binary 'R7\0\0\0‰\0'),(86,_binary 'a3\0\0\0‰\0'),(87,_binary 'o3\0\0\0‰\0'),(88,_binary 'a7\0\0\0‰\0'),(88,_binary 'c;\0\0\0‰\0'),(89,_binary 'o7\0\0\0‰\0'),(89,_binary 'k:\0\0\0‰\0'),(90,_binary '\×\Ü\0\0\0\0'),(90,_binary '\×\Þ\0\0\0E\0'),(90,_binary '\à\Ù\0\0\0D\0'),(90,_binary '\Ý\â\0\0\0D\0'),(91,_binary '\é\Õ\0\0\0E\0'),(91,_binary '\é\Ù\0\0\0\0'),(91,_binary '\é\ß\0\0\0E\0'),(91,_binary '\í\Ü\0\0\0þ\0'),(91,_binary '\ï\â\0\0\0D\0'),(92,_binary '\é\Ç\0\0\0E\0'),(92,_binary '\é\Ê\0\0\0\0'),(93,_binary '\é¹\0\0\0E\0'),(93,_binary '\é¼\0\0\0\0'),(94,_binary '\é¬\0\0\0E\0'),(94,_binary '\é¯\0\0\0\0'),(95,_binary '\Û¢\0\0\0E\0'),(95,_binary '\å£\0\0\0E\0'),(95,_binary '\à¦\0\0\0ý\0'),(96,_binary '\É¢\0\0\0\0'),(96,_binary '\Õ \0\0\0E\0'),(96,_binary '\Õ¦\0\0\0E\0'),(97,_binary 'ºŸ\0\0\0E\0'),(97,_binary 'º¥\0\0\0E\0'),(97,_binary '\Ä¢\0\0\0\0'),(98,_binary '¿\Ï\0\0\0D\0'),(98,_binary '\Ä\Ë\0\0\0\0'),(99,_binary '¿Á\0\0\0D\0'),(99,_binary '\Ë\Ã\0\0\0E\0'),(99,_binary '\Ã\Å\0\0\0ý\0'),(100,_binary 'µ»\0\0\0\î\Z\0'),(100,_binary '±¾\0\0\0t\0'),(100,_binary '¹¾\0\0\0t\0'),(100,_binary '±Á\0\0\0t\0'),(100,_binary '¹Á\0\0\0t\0'),(101,_binary '\Ä»\0\0\0\î\Z\0'),(101,_binary 'À¾\0\0\0t\0'),(101,_binary '\È¾\0\0\0t\0'),(101,_binary 'ÀÁ\0\0\0t\0'),(101,_binary '\ÈÁ\0\0\0t\0'),(102,_binary '\Ì¾\0\0\0t\0'),(102,_binary '\Ð»\0\0\0\î\Z\0'),(102,_binary '\Ô¾\0\0\0t\0'),(102,_binary '\ÌÁ\0\0\0t\0'),(102,_binary '\ÔÁ\0\0\0t\0'),(103,_binary '\Ü»\0\0\0\î\Z\0'),(103,_binary '\Ø¾\0\0\0t\0'),(103,_binary '\à¾\0\0\0t\0'),(103,_binary '\ØÁ\0\0\0t\0'),(103,_binary '\àÁ\0\0\0t\0'),(104,_binary '\é»\0\0\0\î\Z\0'),(104,_binary '\å¾\0\0\0t\0'),(104,_binary '\í¾\0\0\0t\0'),(104,_binary '\åÁ\0\0\0t\0'),(104,_binary '\íÁ\0\0\0t\0'),(105,_binary '\É\Ê\0\0\0\î\Z\0'),(105,_binary '\Å\Í\0\0\0t\0'),(105,_binary '\Å\Ï\0\0\0t\0'),(105,_binary '\Í\Í\0\0\0t\0'),(105,_binary '\Í\Ð\0\0\0t\0'),(106,_binary '\Ö\Ê\0\0\0\î\Z\0'),(106,_binary '\Ò\Í\0\0\0t\0'),(106,_binary '\Ú\Í\0\0\0t\0'),(106,_binary '\Ò\Ð\0\0\0t\0'),(106,_binary '\Ú\Ð\0\0\0t\0'),(107,_binary '\ß\Ì\0\0\0t\0'),(107,_binary '\ß\Ï\0\0\0t\0'),(107,_binary '\ã\É\0\0\0\î\Z\0'),(107,_binary '\ç\Ì\0\0\0t\0'),(107,_binary '\ç\Ï\0\0\0t\0'),(108,_binary '\ð­\0\0\0s\0'),(108,_binary '\ô­\0\0\0s\0'),(108,_binary '\î±\0\0\0\÷\Z\0'),(108,_binary '\ñµ\0\0\0s\0'),(108,_binary '\ôµ\0\0\0s\0'),(109,_binary 'ª«\0\0\0\à\0'),(109,_binary '««\0\0\0\á\0'),(109,_binary '«©\0\0\0s\0'),(109,_binary '¯©\0\0\0s\0'),(109,_binary '±®\0\0\0\÷\Z\0'),(109,_binary '«±\0\0\0s\0'),(109,_binary '¯±\0\0\0s\0'),(110,_binary '¼—\0\0\0t\0'),(110,_binary '¼›\0\0\0t\0'),(110,_binary '¾œ\0\0\0\à\0'),(110,_binary '¿œ\0\0\0\á\0'),(110,_binary '\Ä˜\0\0\0t\0'),(110,_binary '\Ä›\0\0\0t\0'),(110,_binary 'À\0\0\0\î\Z\0'),(111,_binary '\Ð—\0\0\0t\0'),(111,_binary '\Ø—\0\0\0t\0'),(111,_binary '\Ð›\0\0\0t\0'),(111,_binary '\Ø›\0\0\0t\0'),(111,_binary '\Òœ\0\0\0\à\0'),(111,_binary '\Óœ\0\0\0\á\0'),(111,_binary '\Ô\0\0\0\î\Z\0'),(112,_binary '\Æˆ\0\0\0t\0'),(112,_binary '\Æ‹\0\0\0t\0'),(112,_binary '\Îˆ\0\0\0t\0'),(112,_binary '\Î‹\0\0\0t\0'),(112,_binary '\ÈŒ\0\0\0\à\0'),(112,_binary '\ÉŒ\0\0\0\á\0'),(112,_binary '\Ê\0\0\0\î\Z\0'),(113,_binary '\Øˆ\0\0\0t\0'),(113,_binary '\Ø‹\0\0\0t\0'),(113,_binary '\ÚŒ\0\0\0\à\0'),(113,_binary '\ÛŒ\0\0\0\á\0'),(113,_binary '\Ü\0\0\0\î\Z\0'),(113,_binary '\àˆ\0\0\0t\0'),(113,_binary '\àŒ\0\0\0t\0'),(114,_binary '\â™\0\0\0t\0'),(114,_binary '\ê™\0\0\0\÷\Z\0'),(114,_binary '\âŸ\0\0\0t\0'),(114,_binary '\äž\0\0\0\à\0'),(114,_binary '\åž\0\0\0\á\0'),(114,_binary '\ò›\0\0\0t\0'),(114,_binary '\é \0\0\0\÷\Z\0'),(114,_binary '\ê¥\0\0\0\î\Z\0'),(114,_binary '\ò \0\0\0t\0'),(115,_binary 'ƒ›\0\0\0%\0'),(115,_binary '†™\0\0\0$\0'),(115,_binary '‰™\0\0\0$\0'),(115,_binary '‹›\0\0\0\Ã\0'),(115,_binary 'ƒž\0\0\0%\0'),(115,_binary 'ˆž\0\0\0\Ã\0'),(115,_binary '‹Ÿ\0\0\0%\0'),(116,_binary 'œ¥\0\0\0-\0'),(116,_binary 'Ÿ¦\0\0\0o\0'),(116,_binary 'œ¨\0\0\0-\0'),(116,_binary 'œ©\0\0\0-\0'),(116,_binary 'žª\0\0\0q\0'),(116,_binary ' ¥\0\0\0o\0'),(116,_binary ' ¨\0\0\0o\0'),(116,_binary '¢ª\0\0\0,\0'),(116,_binary '¡ª\0\0\0,\0'),(117,_binary '¬¥\0\0\0-\0'),(117,_binary '¨ª\0\0\0,\0'),(117,_binary 'ªª\0\0\0q\0'),(117,_binary '¬©\0\0\0-\0'),(118,_binary '³§\0\0\0,\0'),(118,_binary '³§\0\0\0,\0'),(118,_binary '°ª\0\0\0-\0'),(118,_binary '°©\0\0\0o\0'),(118,_binary '°ª\0\0\0-\0'),(118,_binary '°­\0\0\0-\0'),(119,_binary '¸§\0\0\0,\0'),(119,_binary '¹§\0\0\0q\0'),(119,_binary '»©\0\0\0-\0'),(119,_binary '»«\0\0\0-\0'),(119,_binary 'º¬\0\0\0m\0'),(120,_binary 'œ›\0\0\0-\0'),(120,_binary 'ž™\0\0\0,\0'),(120,_binary 'œŸ\0\0\0o\0'),(120,_binary 'ž\0\0\0q\0'),(120,_binary '£™\0\0\0,\0'),(120,_binary ' Ÿ\0\0\0o\0'),(120,_binary 'œ \0\0\0-\0'),(121,_binary '©™\0\0\0,\0'),(121,_binary '©™\0\0\0q\0'),(121,_binary '«™\0\0\0,\0'),(121,_binary '¬›\0\0\0-\0'),(121,_binary '¬Ÿ\0\0\0-\0'),(122,_binary '²™\0\0\0,\0'),(122,_binary '³™\0\0\0q\0'),(122,_binary '´™\0\0\0,\0'),(122,_binary 'µ›\0\0\0-\0'),(122,_binary '°\0\0\0-\0'),(122,_binary '³ž\0\0\0m\0'),(122,_binary '°\0\0\0-\0'),(122,_binary '´\0\0\0j\0'),(123,_binary '¼œ\0\0\0,\0'),(123,_binary '¾Ÿ\0\0\0-\0'),(123,_binary '¼œ\0\0\0,\0'),(123,_binary '¾Ÿ\0\0\0-\0'),(123,_binary '¼¡\0\0\0\à\0'),(123,_binary '¼¢\0\0\0,\0'),(123,_binary '½¡\0\0\0\á\0'),(123,_binary '¼¢\0\0\0q\0'),(123,_binary '½¢\0\0\0,\0'),(124,_binary 'i‹\0\0\0,\0'),(124,_binary 'l‹\0\0\0,\0'),(124,_binary 'j‘\0\0\0q\0'),(124,_binary 'l‘\0\0\0,\0'),(125,_binary 'p‹\0\0\0,\0'),(125,_binary 's‹\0\0\0,\0'),(125,_binary 'p‘\0\0\0,\0'),(125,_binary 'r‘\0\0\0q\0'),(126,_binary 'x‹\0\0\0,\0'),(126,_binary '|‹\0\0\0,\0'),(126,_binary '}\0\0\0-\0'),(126,_binary 'x‘\0\0\0,\0'),(126,_binary 'z‘\0\0\0q\0'),(126,_binary '}\0\0\0-\0'),(127,_binary 'Mž\0\0\0n\0'),(127,_binary 'Oœ\0\0\0j\0'),(127,_binary 'Nœ\0\0\0k\0'),(127,_binary 'XŸ\0\0\0m\0'),(127,_binary 'aœ\0\0\0j\0'),(127,_binary 'bœ\0\0\0k\0'),(127,_binary '`\0\0\0j\0'),(127,_binary 'cŸ\0\0\0m\0'),(127,_binary 'dž\0\0\0n\0'),(127,_binary 'M¤\0\0\0n\0'),(127,_binary 'O§\0\0\0j\0'),(127,_binary 'N§\0\0\0k\0'),(127,_binary 'X£\0\0\0m\0'),(127,_binary '[¡\0\0\0k\0'),(127,_binary '[¢\0\0\0k\0'),(127,_binary 'c£\0\0\0m\0'),(127,_binary 'k¢\0\0\0i\0'),(127,_binary 'a§\0\0\0j\0'),(127,_binary 'b§\0\0\0k\0'),(127,_binary '`¦\0\0\0i\0'),(127,_binary 'd¤\0\0\0n\0'),(128,_binary 'n|\0\0\0-\0'),(128,_binary 'n|\0\0\0-\0'),(128,_binary 'n\0\0\0-\0'),(128,_binary 'qy\0\0\0,\0'),(128,_binary 'ry\0\0\0,\0'),(128,_binary 'py\0\0\0,\0'),(128,_binary 't{\0\0\0o\0'),(128,_binary 'vy\0\0\0,\0'),(128,_binary 'ty\0\0\0,\0'),(128,_binary 'yy\0\0\0,\0'),(128,_binary '{y\0\0\0,\0'),(128,_binary 'v|\0\0\0q\0'),(128,_binary '{}\0\0\0q\0'),(128,_binary 'x}\0\0\0q\0'),(128,_binary '}|\0\0\0-\0'),(128,_binary '|}\0\0\0q\0'),(128,_binary '}|\0\0\0-\0'),(128,_binary 'nƒ\0\0\0-\0'),(128,_binary 'n€\0\0\0-\0'),(128,_binary 'nƒ\0\0\0-\0'),(128,_binary 'sƒ\0\0\0o\0'),(128,_binary 'v€\0\0\0q\0'),(128,_binary 'uƒ\0\0\0o\0'),(128,_binary 'w\0\0\0q\0'),(128,_binary '{€\0\0\0q\0'),(128,_binary '}ƒ\0\0\0-\0'),(128,_binary '|\0\0\0q\0'),(128,_binary '}€\0\0\0o\0'),(128,_binary '}ƒ\0\0\0-\0'),(128,_binary 'q…\0\0\0,\0'),(128,_binary 'p…\0\0\0,\0'),(128,_binary 'v…\0\0\0,\0'),(128,_binary 't…\0\0\0,\0'),(128,_binary 'z…\0\0\0,\0'),(128,_binary '{…\0\0\0,\0'),(129,_binary '…‹\0\0\0$\0'),(129,_binary '‰‹\0\0\0$\0'),(129,_binary 'ƒ\0\0\0%\0'),(129,_binary 'ƒ\0\0\0%\0'),(129,_binary '…\0\0\0\Å\0'),(129,_binary '†\0\0\0\Ã\0'),(129,_binary 'ƒ’\0\0\0%\0'),(129,_binary '‡\0\0\0\Å\0'),(129,_binary '…“\0\0\0$\0'),(129,_binary '‡“\0\0\0\Å\0'),(129,_binary '‰\0\0\0$\0'),(129,_binary '‰“\0\0\0$\0'),(130,_binary '“\0\0\0$\0'),(130,_binary '’\0\0\0\Ã\0'),(130,_binary '’“\0\0\0$\0'),(130,_binary '““\0\0\0\Å\0'),(130,_binary '”’\0\0\0%\0'),(131,_binary '‹\0\0\0$\0'),(131,_binary '\0\0\0¹\0'),(131,_binary '”\0\0\0\Ã\0'),(132,_binary 'ž\0\0\0-\0'),(132,_binary '¡\0\0\0,\0'),(132,_binary '¡“\0\0\0q\0'),(132,_binary '¢“\0\0\0,\0'),(132,_binary '£’\0\0\0-\0'),(133,_binary '§\0\0\0%\0'),(133,_binary '§’\0\0\0%\0'),(133,_binary 'ª“\0\0\0\Å\0'),(133,_binary '¬“\0\0\0$\0'),(134,_binary 'µ\0\0\0º\0'),(134,_binary '±“\0\0\0$\0'),(134,_binary '±\0\0\0\Å\0'),(134,_binary '²“\0\0\0\Å\0'),(134,_binary '´“\0\0\0$\0'),(134,_binary 'µ\0\0\0%\0'),(134,_binary 'µ’\0\0\0\Ã\0'),(134,_binary '´“\0\0\0&\0'),(134,_binary 'µ‘\0\0\0%\0'),(135,_binary '²…\0\0\0q\0'),(135,_binary '´…\0\0\0,\0'),(136,_binary '¹…\0\0\0$\0'),(136,_binary 'º…\0\0\0\Å\0'),(137,_binary '¾…\0\0\0\Å\0'),(137,_binary '¿…\0\0\0$\0'),(138,_binary '\Â…\0\0\0\Å\0'),(138,_binary '\Ä‡\0\0\0%\0'),(139,_binary '¼“\0\0\0,\0'),(139,_binary '½‘\0\0\0-\0'),(139,_binary '½’\0\0\0o\0'),(140,_binary '©…\0\0\0$\0'),(140,_binary '¬…\0\0\0$\0'),(140,_binary '§ˆ\0\0\0\Ã\0'),(140,_binary '§Š\0\0\0%\0'),(141,_binary '£‚\0\0\0%\0'),(141,_binary '¡…\0\0\0$\0'),(141,_binary '¢…\0\0\0\Å\0'),(141,_binary '£„\0\0\0%\0'),(142,_binary '€\0\0\0%\0'),(142,_binary 'š…\0\0\0\Å\0'),(142,_binary 'œ…\0\0\0$\0'),(142,_binary '„\0\0\0%\0'),(143,_binary '‘‚\0\0\0\Å\0'),(143,_binary '‘…\0\0\0\Å\0'),(143,_binary '”…\0\0\0$\0'),(144,_binary 'ƒ€\0\0\0%\0'),(144,_binary '‰€\0\0\0\Ã\0'),(144,_binary 'ƒ„\0\0\0%\0'),(144,_binary '†…\0\0\0\Å\0'),(144,_binary 'ˆ…\0\0\0$\0'),(144,_binary '‰„\0\0\0\Ã\0'),(145,_binary 'ƒw\0\0\0%\0'),(145,_binary '…u\0\0\0$\0'),(145,_binary '‡u\0\0\0\Å\0'),(145,_binary 'ƒz\0\0\0%\0'),(145,_binary '‡{\0\0\0\Ã\0'),(145,_binary '‰x\0\0\0½\0'),(146,_binary 'u\0\0\0\Å\0'),(146,_binary 'Žx\0\0\0\Å\0'),(146,_binary '{\0\0\0\Ã\0'),(146,_binary '‘u\0\0\0$\0'),(147,_binary '•u\0\0\0q\0'),(147,_binary '–u\0\0\0,\0'),(148,_binary '¨\0\0\0-\0'),(148,_binary 'ª€\0\0\0q\0'),(149,_binary '±|\0\0\0o\0'),(149,_binary '´€\0\0\0q\0'),(149,_binary 'µ€\0\0\0,\0'),(150,_binary 'º€\0\0\0,\0'),(150,_binary '¼€\0\0\0q\0'),(151,_binary '´s\0\0\0\Å\0'),(151,_binary 'µs\0\0\0$\0'),(151,_binary '±u\0\0\0%\0'),(151,_binary '±w\0\0\0%\0'),(151,_binary '¶v\0\0\0%\0'),(152,_binary '¨u\0\0\0%\0'),(152,_binary '¨w\0\0\0\Ã\0'),(152,_binary '®t\0\0\0%\0'),(152,_binary '®w\0\0\0%\0'),(152,_binary 'ªx\0\0\0$\0'),(152,_binary '­x\0\0\0$\0'),(153,_binary 'v¶\0\0\0i\0'),(153,_binary 'u¸\0\0\0m\0'),(154,_binary '„¯\0\0\0,\0'),(154,_binary '€²\0\0\0o\0'),(154,_binary '€´\0\0\0-\0'),(155,_binary '€·\0\0\0-\0'),(155,_binary '€¸\0\0\0o\0'),(155,_binary 'ƒº\0\0\0q\0'),(155,_binary '€½\0\0\0-\0'),(155,_binary 'ƒ¾\0\0\0,\0'),(156,_binary '”´\0\0\0q\0'),(157,_binary 'ƒ´\0\0\0q\0'),(158,_binary 'ƒ¹\0\0\0q\0'),(159,_binary 'ˆ¤\0\0\0\Ã\0'),(159,_binary 'ˆ¥\0\0\0%\0'),(159,_binary 'Š¦\0\0\0¼\0'),(159,_binary '¤\0\0\0%\0'),(159,_binary 'ˆ¨\0\0\0%\0'),(159,_binary '‹©\0\0\0$\0'),(160,_binary 'ƒ›\0\0\0%\0'),(160,_binary '†™\0\0\0$\0'),(160,_binary '‡›\0\0\0\Ã\0'),(160,_binary 'ƒŸ\0\0\0%\0'),(160,_binary '‡œ\0\0\0%\0'),(160,_binary '‡ž\0\0\0%\0'),(161,_binary '‹œ\0\0\0$\0'),(161,_binary 'ž\0\0\0\Ã\0'),(161,_binary 'Ÿ\0\0\0%\0'),(162,_binary '§®\0\0\0F\0'),(162,_binary '«®\0\0\0F\0'),(162,_binary '¥³\0\0\0G\0'),(162,_binary '§±\0\0\0¦\0'),(162,_binary '¨³\0\0\0¤\0'),(162,_binary '¬±\0\0\0¤\0'),(162,_binary '¬³\0\0\0G\0'),(163,_binary '¤¶\0\0\0F\0'),(163,_binary '¡¸\0\0\0¤\0'),(163,_binary '¡¹\0\0\0G\0'),(164,_binary '«¹\0\0\0F\0'),(164,_binary '¬¸\0\0\0¤\0'),(165,_binary '¢¿\0\0\0G\0'),(165,_binary '¤À\0\0\0¦\0'),(165,_binary '¥À\0\0\0F\0'),(166,_binary 'ª¿\0\0\0F\0'),(166,_binary '¬½\0\0\0¤\0'),(167,_binary '¯³\0\0\0G\0'),(167,_binary '±±\0\0\0¦\0'),(167,_binary '²±\0\0\0F\0'),(167,_binary '³³\0\0\0G\0'),(168,_binary '¸±\0\0\0F\0'),(168,_binary '¹±\0\0\0¦\0'),(168,_binary '¶´\0\0\0G\0'),(168,_binary '»´\0\0\0G\0'),(169,_binary '¾±\0\0\0¤\0'),(169,_binary '¾²\0\0\0G\0'),(169,_binary 'Á¯\0\0\0F\0'),(169,_binary 'Á³\0\0\0F\0'),(170,_binary '¯»\0\0\0G\0'),(170,_binary '²¸\0\0\0F\0'),(170,_binary '±½\0\0\0F\0'),(170,_binary '²½\0\0\0¦\0'),(171,_binary '»º\0\0\0G\0'),(171,_binary '¸¼\0\0\0F\0'),(171,_binary '¹¼\0\0\0¦\0'),(172,_binary '¾¸\0\0\0G\0'),(172,_binary '¾»\0\0\0¤\0'),(172,_binary '\Æ¸\0\0\0G\0'),(172,_binary '\Æ»\0\0\0G\0'),(172,_binary 'À¼\0\0\0F\0'),(173,_binary '¾¿\0\0\0¦\0'),(173,_binary '¿¿\0\0\0F\0'),(173,_binary '»\Â\0\0\0G\0'),(173,_binary '½\Ä\0\0\0F\0'),(174,_binary '\Ä¿\0\0\0F\0'),(174,_binary '\Å¿\0\0\0¦\0'),(174,_binary '\Ç\Â\0\0\0G\0'),(174,_binary '\Æ\Ä\0\0\0F\0'),(175,_binary '±\Ã\0\0\0¦\0'),(175,_binary '²\Â\0\0\0G\0'),(175,_binary '´\Ã\0\0\0¦\0'),(175,_binary 'µ\Ã\0\0\0I\0'),(176,_binary 'Xr\0\0\0)\0'),(176,_binary 'Zs\0\0\0(\0'),(176,_binary '[s\0\0\0\í\0'),(177,_binary '_m\0\0\0(\0'),(177,_binary '_s\0\0\0(\0'),(177,_binary '`s\0\0\0\í\0'),(178,_binary 'ss\0\0\0%\0'),(178,_binary 'wq\0\0\0$\0'),(178,_binary 'sv\0\0\0\Ã\0'),(178,_binary 'sw\0\0\0%\0'),(178,_binary 'vt\0\0\0d\0'),(178,_binary 'vx\0\0\0$\0'),(179,_binary '|q\0\0\0$\0'),(179,_binary '}q\0\0\0\Å\0'),(179,_binary 'v\0\0\0%\0'),(179,_binary '~x\0\0\0$\0'),(180,_binary '¢s\0\0\0\Å\0'),(180,_binary '¡p\0\0\0$\0'),(180,_binary '¢r\0\0\0\Ã\0'),(180,_binary '¥s\0\0\0\Å\0'),(180,_binary '§s\0\0\0\Å\0'),(180,_binary '§p\0\0\0$\0'),(180,_binary '¥q\0\0\0\Ã\0'),(180,_binary '¨r\0\0\0%\0'),(180,_binary '¢u\0\0\0\Å\0'),(180,_binary '£v\0\0\0\Ã\0'),(180,_binary '¢v\0\0\0\Ã\0'),(180,_binary '§u\0\0\0\Å\0'),(180,_binary '¦t\0\0\0\Å\0'),(180,_binary '§t\0\0\0\0'),(180,_binary '¥t\0\0\0\Ã\0'),(180,_binary '¨t\0\0\0%\0'),(180,_binary '¨w\0\0\0%\0'),(180,_binary '¡x\0\0\0$\0'),(180,_binary '¤x\0\0\0\Å\0'),(180,_binary '§x\0\0\0$\0'),(181,_binary 'Tx\0\0\0$\0'),(181,_binary 'Yz\0\0\0%\0'),(181,_binary 'Q|\0\0\0%\0'),(181,_binary 'Y|\0\0\0\Ã\0'),(181,_binary 'Y~\0\0\0%\0'),(182,_binary '_}\0\0\0%\0'),(182,_binary 'ax\0\0\0\Å\0'),(182,_binary 'bx\0\0\0$\0'),(182,_binary 'b~\0\0\0$\0'),(183,_binary 'gx\0\0\0$\0'),(183,_binary 'hx\0\0\0\Å\0'),(183,_binary 'g~\0\0\0$\0'),(184,_binary 'lx\0\0\0$\0'),(184,_binary 'mx\0\0\0\Å\0'),(184,_binary 'oz\0\0\0%\0'),(185,_binary '„~\0\0\0%\0'),(185,_binary '„~\0\0\0%\0'),(185,_binary '‰|\0\0\0$\0'),(185,_binary '„\0\0\0%\0'),(185,_binary '„‚\0\0\0%\0'),(185,_binary '†ƒ\0\0\0\Å\0'),(185,_binary 'ˆƒ\0\0\0$\0'),(185,_binary 'Šƒ\0\0\0$\0'),(186,_binary '|\0\0\0$\0'),(186,_binary '\0\0\0\Ã\0'),(186,_binary 'ƒ\0\0\0$\0'),(187,_binary '|\0\0\0$\0'),(187,_binary '~\0\0\0\Ã\0'),(187,_binary '“\0\0\0$\0'),(187,_binary '‘ƒ\0\0\0$\0'),(188,_binary '˜ƒ\0\0\0¾\0'),(189,_binary '›|\0\0\0$\0'),(189,_binary '~\0\0\0%\0'),(189,_binary '›ƒ\0\0\0\Å\0'),(189,_binary 'œƒ\0\0\0$\0'),(189,_binary '‚\0\0\0%\0'),(190,_binary ' ~\0\0\0%\0'),(190,_binary '¥|\0\0\0$\0'),(190,_binary '§~\0\0\0%\0'),(190,_binary ' ‚\0\0\0%\0'),(190,_binary '¥ƒ\0\0\0\Å\0'),(190,_binary '¦ƒ\0\0\0$\0'),(190,_binary '§‚\0\0\0%\0'),(191,_binary ']\0\0\0-\0'),(191,_binary '`Œ\0\0\0q\0'),(191,_binary 'aŒ\0\0\0,\0'),(192,_binary 'fŒ\0\0\0$(\0'),(192,_binary 'k’\0\0\0(\0'),(193,_binary ']•\0\0\0-\0'),(193,_binary ']–\0\0\0o\0'),(194,_binary ']™\0\0\0o\0'),(194,_binary ']š\0\0\0-\0'),(194,_binary '`›\0\0\0,\0'),(195,_binary 'k—\0\0\0-\0'),(195,_binary 'k™\0\0\0\Ã\0'),(196,_binary 'pŽ\0\0\0-\0'),(196,_binary 'sŒ\0\0\0q\0'),(196,_binary 'uŒ\0\0\0,\0'),(196,_binary 'p\0\0\0-\0'),(197,_binary '{Œ\0\0\0,\0'),(197,_binary 'zŒ\0\0\0,\0'),(197,_binary '}Ž\0\0\0i\0'),(197,_binary '}Œ\0\0\0,\0'),(197,_binary '~Ž\0\0\0-\0'),(197,_binary '~\0\0\0o\0'),(197,_binary '}\0\0\0i\0'),(198,_binary 'p•\0\0\0-\0'),(198,_binary 'p—\0\0\0-\0'),(198,_binary 'r˜\0\0\0q\0'),(198,_binary 't˜\0\0\0,\0'),(199,_binary '~•\0\0\0-\0'),(199,_binary '~–\0\0\0o\0'),(199,_binary 'z˜\0\0\0,\0'),(199,_binary '}˜\0\0\0,\0'),(200,_binary '„’\0\0\0\"(\0'),(200,_binary '„“\0\0\0(\0'),(200,_binary 'Š’\0\0\0(\0'),(200,_binary '‰”\0\0\0(\0'),(201,_binary '‘‰\0\0\0\ö\0'),(202,_binary '‘‰\0\0\0\ö\0'),(203,_binary '˜‡\0\0\0$\0'),(203,_binary 'š‡\0\0\0$\0'),(203,_binary '™‹\0\0\0$\0'),(203,_binary '›‰\0\0\0\Ã\0'),(203,_binary '›Š\0\0\0%\0'),(204,_binary '–\0\0\0%\0'),(204,_binary '™\0\0\0\Å\0'),(204,_binary 'š\0\0\0$\0'),(204,_binary '˜‘\0\0\0$\0'),(204,_binary '›\0\0\0%\0'),(205,_binary 'N¤\0\0\0(\0'),(205,_binary 'P¢\0\0\0(\0'),(205,_binary 'Q¢\0\0\0\Z(\0'),(205,_binary 'R¤\0\0\0(\0'),(206,_binary 'pŸ\0\0\0\"(\0'),(206,_binary 'sœ\0\0\0(\0'),(206,_binary 'p¡\0\0\0(\0'),(207,_binary 'zœ\0\0\0(\0'),(207,_binary '}œ\0\0\0$(\0'),(208,_binary 'œ\0\0\0(\0'),(208,_binary '‚œ\0\0\0$(\0'),(208,_binary '…œ\0\0\0(\0'),(208,_binary '†ž\0\0\0(\0'),(208,_binary '…œ\0\0\0(\0'),(208,_binary '†Ÿ\0\0\0(\0'),(208,_binary '†¡\0\0\0(\0'),(208,_binary '† \0\0\0(\0'),(209,_binary 'hŒ\0\0\0(\0'),(209,_binary 'jŒ\0\0\0(\0'),(209,_binary 'kŽ\0\0\0\"(\0'),(209,_binary 'k\0\0\0(\0'),(210,_binary '^…\0\0\0%\0'),(210,_binary '_„\0\0\0\à\0'),(210,_binary '`„\0\0\0\á\0'),(210,_binary '`†\0\0\0$\0'),(210,_binary 'b„\0\0\0%\0'),(210,_binary 'b…\0\0\0\Ã\0'),(211,_binary '^‚\0\0\0%\0'),(211,_binary '_\0\0\0\à\0'),(211,_binary '`\0\0\0\á\0'),(211,_binary 'b\0\0\0\Ã\0'),(212,_binary 'd‚\0\0\0\Ã\0'),(212,_binary 'dƒ\0\0\0%\0'),(212,_binary 'f„\0\0\0$\0'),(213,_binary '_\0\0\0\à\0'),(213,_binary '^„\0\0\0%\0'),(213,_binary '_…\0\0\0\à\0'),(213,_binary '`\0\0\0\á\0'),(213,_binary 'b‚\0\0\0\Ã\0'),(213,_binary '`…\0\0\0\á\0'),(213,_binary 'a†\0\0\0$\0'),(213,_binary 'b…\0\0\0%\0'),(214,_binary 'ƒ\0\0\0‰\0'),(214,_binary '	ƒ\0\0\0‰\0'),(214,_binary 'ƒ\0\0\0‰\0'),(214,_binary '…\0\0\0‰\0'),(215,_binary 'Œ\0\0\0‰\0'),(215,_binary '\0\0\0‰\0'),(216,_binary 'Š\0\0\0‰\0'),(217,_binary '†\0\0\0‰\0'),(218,_binary '†\0\0\0‰\0'),(218,_binary 'ˆ\0\0\0‰\0'),(218,_binary 'Œ\0\0\0‰\0'),(219,_binary 'ú¡\0\0\0‰\0'),(220,_binary '\0\0\0‰\0'),(220,_binary '	ž\0\0\0‰\0'),(220,_binary '\0\0\0‰\0'),(221,_binary '—\0\0\0‰\0'),(221,_binary '™\0\0\0‰\0'),(222,_binary '™\0\0\0‰\0'),(222,_binary 'Ÿ\0\0\0‰\0'),(223,_binary '¥\0\0\0‰\0'),(223,_binary 'ª\0\0\0‰\0'),(224,_binary ' ¬\0\0\0‰\0'),(225,_binary '\'¤\0\0\0‰\0'),(225,_binary '(©\0\0\0‰\0'),(225,_binary '#­\0\0\0‰\0'),(226,_binary '+™\0\0\0‰\0'),(226,_binary ',›\0\0\0‰\0'),(226,_binary '*ž\0\0\0‰\0'),(227,_binary 'Ež\0\0\0‰\0'),(228,_binary 'J™\0\0\0‰\0'),(229,_binary '7“\0\0\0‰\0'),(229,_binary '9\0\0\0‰\0'),(230,_binary '=“\0\0\0‰\0'),(230,_binary '?‘\0\0\0‰\0'),(231,_binary '7“\0\0\0‰\0'),(231,_binary '9\0\0\0‰\0'),(232,_binary '=”\0\0\0‰\0'),(233,_binary '7‘\0\0\0‰\0'),(233,_binary '8”\0\0\0‰\0'),(234,_binary '>‘\0\0\0‰\0'),(234,_binary '>”\0\0\0‰\0'),(235,_binary '«$\0\0\0\'\0'),(235,_binary '° \0\0\0¼\0'),(235,_binary '²&\0\0\0&\0'),(235,_binary 'µ$\0\0\0\'\0'),(236,_binary '¹#\0\0\0\'\0'),(236,_binary '¾ \0\0\0¼\0'),(237,_binary '\Ó\0\0\0%\0'),(237,_binary '\Ú\0\0\0¼\0'),(237,_binary '\Ó\0\0\0%\0'),(237,_binary '\à\Z\0\0\0¹\0'),(237,_binary '\à\0\0\0¼\0'),(237,_binary '\ç\0\0\0¼\0'),(237,_binary '\è\0\0\0¹\0'),(237,_binary '\Î$\0\0\0%\0'),(237,_binary '\Ð$\0\0\0¼\0'),(237,_binary '\à \0\0\0¹\0'),(237,_binary '\à%\0\0\0¹\0'),(238,_binary '²\"\0\0\0q\0'),(238,_binary '²\"\0\0\0q\0'),(238,_binary 'º\"\0\0\0q\0'),(238,_binary '°$\0\0\0r\0'),(238,_binary '°%\0\0\0r\0'),(238,_binary '´$\0\0\0\ë\Z\0'),(238,_binary '´\'\0\0\0\ë\Z\0'),(238,_binary '·$\0\0\0\ô\Z\0'),(238,_binary '´&\0\0\0\ë\Z\0'),(238,_binary '¶$\0\0\0\ô\Z\0'),(238,_binary 'º&\0\0\0q\0'),(238,_binary 'º&\0\0\0q\0'),(238,_binary '¼$\0\0\0r\0'),(238,_binary '¼$\0\0\0r\0'),(238,_binary '²*\0\0\0q\0'),(238,_binary '²*\0\0\0q\0'),(238,_binary '³*\0\0\0\ë\Z\0'),(238,_binary 'µ*\0\0\0q\0'),(238,_binary 'µ*\0\0\0q\0'),(239,_binary 'ª\"\0\0\0q\0'),(239,_binary 'ª\"\0\0\0q\0'),(239,_binary '¦$\0\0\0r\0'),(239,_binary '¦$\0\0\0r\0'),(239,_binary '®$\0\0\0r\0'),(239,_binary '®$\0\0\0r\0'),(239,_binary '¦)\0\0\0r\0'),(239,_binary '¦)\0\0\0r\0'),(239,_binary '©*\0\0\0q\0'),(239,_binary '©*\0\0\0q\0'),(239,_binary '®)\0\0\0r\0'),(239,_binary '¬*\0\0\0\ë\Z\0'),(239,_binary '®)\0\0\0r\0'),(240,_binary '˜#\0\0\0q\0'),(240,_binary '”\'\0\0\0r\0'),(240,_binary 'œ\'\0\0\0r\0'),(240,_binary '˜*\0\0\0\ë\Z\0'),(241,_binary '˜.\0\0\0\ë\Z\0'),(241,_binary '”2\0\0\0r\0'),(241,_binary 'œ2\0\0\0r\0'),(241,_binary '˜6\0\0\0q\0'),(242,_binary '˜*\0\0\0\ë\Z\0'),(243,_binary '˜.\0\0\0\ë\Z\0'),(243,_binary '”2\0\0\0r\0'),(243,_binary 'œ2\0\0\0r\0'),(243,_binary '˜6\0\0\0q\0'),(244,_binary 'Ÿ2\0\0\0q\0'),(244,_binary 'ž:\0\0\0r\0'),(244,_binary 'Ÿ<\0\0\0q\0'),(244,_binary 'Ÿ<\0\0\0q\0'),(244,_binary 'Ÿ<\0\0\0q\0'),(244,_binary '§2\0\0\0q\0'),(244,_binary ' 7\0\0\0\ë\Z\0'),(244,_binary '¡7\0\0\0\ë\Z\0'),(244,_binary '¥7\0\0\0\ô\Z\0'),(244,_binary '¤4\0\0\0\ô\Z\0'),(244,_binary '¦7\0\0\0\ë\Z\0'),(244,_binary '§5\0\0\0\ë\Z\0'),(244,_binary '©4\0\0\0r\0'),(244,_binary '©7\0\0\0\ô\Z\0'),(244,_binary '£:\0\0\0\ô\Z\0'),(244,_binary '¤:\0\0\0\ô\Z\0'),(244,_binary '©;\0\0\0r\0'),(244,_binary '©;\0\0\0r\0'),(244,_binary '¤<\0\0\0q\0'),(244,_binary '¨<\0\0\0q\0'),(245,_binary '?\0\0\0q\0'),(245,_binary '‘?\0\0\0q\0'),(245,_binary '‘?\0\0\0q\0'),(245,_binary '—?\0\0\0q\0'),(245,_binary 'B\0\0\0r\0'),(245,_binary 'B\0\0\0r\0'),(245,_binary 'B\0\0\0r\0'),(245,_binary 'D\0\0\0q\0'),(245,_binary 'D\0\0\0q\0'),(245,_binary 'D\0\0\0q\0'),(245,_binary '”B\0\0\0\ô\Z\0'),(245,_binary '•B\0\0\0\ô\Z\0'),(245,_binary '”B\0\0\0\ô\Z\0'),(245,_binary '™A\0\0\0r\0'),(245,_binary '™A\0\0\0r\0'),(245,_binary '’D\0\0\0q\0'),(245,_binary '’D\0\0\0q\0'),(245,_binary '’D\0\0\0q\0'),(245,_binary '—D\0\0\0\ë\Z\0'),(245,_binary '”I\0\0\0r\0'),(245,_binary '–J\0\0\0q\0'),(245,_binary '”I\0\0\0r\0'),(245,_binary '–J\0\0\0q\0'),(245,_binary '—J\0\0\0\ë\Z\0'),(245,_binary '™I\0\0\0r\0'),(245,_binary '™I\0\0\0r\0'),(246,_binary '›A\0\0\0r\0'),(246,_binary '›A\0\0\0r\0'),(246,_binary 'ŸC\0\0\0\ë\Z\0'),(246,_binary 'žC\0\0\0\ë\Z\0'),(246,_binary '›G\0\0\0r\0'),(246,_binary '›G\0\0\0r\0'),(246,_binary 'œH\0\0\0q\0'),(246,_binary 'œH\0\0\0q\0'),(246,_binary '¢@\0\0\0\ô\Z\0'),(246,_binary ' A\0\0\0\ô\Z\0'),(246,_binary '¤@\0\0\0\ô\Z\0'),(246,_binary '£G\0\0\0r\0'),(246,_binary '£G\0\0\0r\0'),(246,_binary '¢H\0\0\0q\0'),(246,_binary '¢H\0\0\0q\0'),(247,_binary 'ŠF\0\0\0q\0'),(247,_binary 'ŠF\0\0\0q\0'),(247,_binary 'I\0\0\0\ô\Z\0'),(247,_binary 'H\0\0\0\ô\Z\0'),(247,_binary 'ˆL\0\0\0r\0'),(247,_binary '‹L\0\0\0\ë\Z\0'),(247,_binary 'N\0\0\0r\0'),(247,_binary 'N\0\0\0r\0'),(247,_binary '’H\0\0\0r\0'),(247,_binary 'ŠP\0\0\0q\0'),(247,_binary '‹P\0\0\0\ë\Z\0'),(247,_binary 'P\0\0\0q\0'),(247,_binary 'Q\0\0\0\ô\Z\0'),(247,_binary 'ŠT\0\0\0q\0'),(247,_binary 'T\0\0\0q\0'),(248,_binary '³?\0\0\0r\0'),(248,_binary 'µ=\0\0\0q\0'),(248,_binary 'µ=\0\0\0q\0'),(248,_binary '»?\0\0\0r\0'),(248,_binary '¹=\0\0\0q\0'),(248,_binary '»?\0\0\0r\0'),(248,_binary '¹=\0\0\0q\0'),(248,_binary '»?\0\0\0r\0'),(248,_binary '°C\0\0\0r\0'),(248,_binary '³C\0\0\0\ô\Z\0'),(248,_binary '°C\0\0\0r\0'),(248,_binary '»C\0\0\0r\0'),(248,_binary '¸B\0\0\0\ë\Z\0'),(248,_binary '³E\0\0\0\ô\Z\0'),(248,_binary '·G\0\0\0\ë\Z\0'),(248,_binary '¶G\0\0\0\ô\Z\0'),(248,_binary 'µE\0\0\0\ë\Z\0'),(248,_binary '·G\0\0\0\ë\Z\0'),(248,_binary '¹D\0\0\0\ë\Z\0'),(248,_binary '¹D\0\0\0\ë\Z\0'),(248,_binary '»F\0\0\0r\0'),(248,_binary '»D\0\0\0r\0'),(248,_binary '»F\0\0\0r\0'),(248,_binary '»D\0\0\0r\0'),(248,_binary '»E\0\0\0\ô\Z\0'),(248,_binary '»F\0\0\0r\0'),(248,_binary '³J\0\0\0r\0'),(248,_binary '³J\0\0\0r\0'),(248,_binary '·J\0\0\0\ô\Z\0'),(248,_binary '»K\0\0\0r\0'),(248,_binary '»K\0\0\0r\0'),(248,_binary '»K\0\0\0r\0'),(248,_binary '·L\0\0\0q\0'),(248,_binary 'µL\0\0\0q\0'),(248,_binary 'µL\0\0\0q\0'),(248,_binary 'ºL\0\0\0q\0'),(248,_binary 'ºL\0\0\0q\0'),(248,_binary 'ºL\0\0\0q\0'),(249,_binary '¾=\0\0\0r\0'),(249,_binary '¾=\0\0\0r\0'),(249,_binary '\Ä7\0\0\0q\0'),(249,_binary 'À;\0\0\0q\0'),(249,_binary 'Á9\0\0\0r\0'),(249,_binary '\Ä;\0\0\0\ë\Z\0'),(249,_binary '\Æ;\0\0\0\ô\Z\0'),(249,_binary '\È9\0\0\0q\0'),(249,_binary '\Ê;\0\0\0\ô\Z\0'),(249,_binary 'Á=\0\0\0\ô\Z\0'),(249,_binary '\Æ=\0\0\0\ô\Z\0'),(249,_binary '¾@\0\0\0r\0'),(249,_binary '¾A\0\0\0r\0'),(249,_binary 'ÀB\0\0\0q\0'),(249,_binary '\ÃB\0\0\0q\0'),(249,_binary 'ÀB\0\0\0q\0'),(249,_binary '\ÃB\0\0\0q\0'),(249,_binary '\ÄA\0\0\0r\0'),(250,_binary '\ÃJ\0\0\0q\0'),(250,_binary 'ÁM\0\0\0\ô\Z\0'),(250,_binary '\ÂO\0\0\0q\0'),(250,_binary '\ÈM\0\0\0r\0'),(251,_binary '\ÉG\0\0\0\ô\Z\0'),(252,_binary '\Ñ;\0\0\0r\0'),(252,_binary '\Ô9\0\0\0q\0'),(252,_binary '\Ô9\0\0\0q\0'),(252,_binary '\Ñ?\0\0\0r\0'),(252,_binary '\Ñ=\0\0\0\ô\Z\0'),(252,_binary '\Ù?\0\0\0r\0'),(252,_binary '\Ù?\0\0\0r\0'),(252,_binary '\ÓA\0\0\0q\0'),(252,_binary '\ÓA\0\0\0q\0'),(252,_binary '\ØA\0\0\0q\0'),(252,_binary '\ØA\0\0\0q\0'),(253,_binary '\Ö&\0\0\0q\0'),(253,_binary '\Ö*\0\0\0\ë\Z\0'),(253,_binary '\Ô,\0\0\0r\0'),(253,_binary '\Ø/\0\0\0\ë\Z\0'),(253,_binary '\Û,\0\0\0r\0'),(253,_binary '\Ô2\0\0\0r\0'),(253,_binary '\Ý2\0\0\0r\0'),(253,_binary '\Ö4\0\0\0q\0'),(253,_binary '\Ù4\0\0\0\ë\Z\0'),(254,_binary '¿\0\0\0r\0'),(254,_binary '¾#\0\0\0r\0'),(254,_binary 'Á\0\0\0r\0'),(254,_binary '\Ã\0\0\0q\0'),(254,_binary '\Ã\0\0\0q\0'),(254,_binary '\Ã\0\0\0\ô\Z\0'),(254,_binary '\Å\0\0\0q\0'),(254,_binary '\Ä\0\0\0\ô\Z\0'),(254,_binary '\Æ\0\0\0q\0'),(254,_binary 'Á\"\0\0\0\ô\Z\0'),(254,_binary '\Â\"\0\0\0\ë\Z\0'),(254,_binary 'À\"\0\0\0\ë\Z\0'),(254,_binary '\Æ\"\0\0\0\ë\Z\0'),(254,_binary '\É \0\0\0r\0'),(254,_binary '\É \0\0\0r\0'),(254,_binary '\É\"\0\0\0\ô\Z\0'),(254,_binary '\Ã&\0\0\0q\0'),(254,_binary 'À&\0\0\0q\0'),(254,_binary '\Ã&\0\0\0q\0'),(254,_binary 'À&\0\0\0q\0'),(254,_binary '\Ã$\0\0\0\ô\Z\0'),(254,_binary '\Ç$\0\0\0\ô\Z\0'),(254,_binary '\É$\0\0\0r\0'),(254,_binary '\É$\0\0\0r\0'),(255,_binary ']P\0\0\0‰\0'),(255,_binary 'bS\0\0\0‰\0'),(256,_binary 'bA\0\0\0‰\0'),(257,_binary 'mD\0\0\0‰\0'),(257,_binary 'oG\0\0\0‰\0'),(258,_binary 'oK\0\0\0‰\0'),(258,_binary 'oO\0\0\0‰\0'),(259,_binary 'J\0\0\0‰\0'),(259,_binary 'yO\0\0\0‰\0'),(259,_binary 'zT\0\0\0‰\0'),(260,_binary 'oK\0\0\0‰\0'),(261,_binary 'oE\0\0\0‰\0'),(261,_binary 'qG\0\0\0‰\0'),(262,_binary 'pG\0\0\0‰\0'),(263,_binary 'oK\0\0\0‰\0'),(264,_binary '|S\0\0\0‰\0'),(265,_binary 'Q\0\0\0‰\0'),(266,_binary 'zL\0\0\0‰\0'),(266,_binary '}P\0\0\0‰\0'),(267,_binary '|M\0\0\0‰\0'),(267,_binary 'R\0\0\0‰\0'),(268,_binary 'R\0\0\0‰\0'),(269,_binary '–R\0\0\0‰\0'),(270,_binary '¡W\0\0\0‰\0'),(271,_binary '?\0\0\0‰\0'),(271,_binary 'Œ>\0\0\0‰\0'),(271,_binary 'Œ>\0\0\0‰\0'),(271,_binary 'Ž?\0\0\0‰\0'),(272,_binary '`_\0\0\0‰\0'),(272,_binary '^e\0\0\0‰\0'),(272,_binary '`e\0\0\0‰\0'),(272,_binary 'be\0\0\0‰\0'),(273,_binary 'Z_\0\0\0‰\0'),(273,_binary 'Tc\0\0\0‰\0'),(273,_binary 'Yd\0\0\0‰\0'),(273,_binary 'Yd\0\0\0‰\0'),(274,_binary 'n\\\0\0\0‰\0'),(274,_binary 'oa\0\0\0‰\0'),(274,_binary 'na\0\0\0‰\0'),(275,_binary 'y\\\0\0\0‰\0'),(276,_binary '~k\0\0\0‰\0'),(276,_binary 'wm\0\0\0‰\0'),(276,_binary 'xl\0\0\0‰\0'),(276,_binary '{o\0\0\0‰\0'),(276,_binary 'yo\0\0\0‰\0'),(277,_binary 'Žj\0\0\0‰\0'),(277,_binary '‹n\0\0\0‰\0'),(277,_binary 'Žq\0\0\0‰\0'),(278,_binary 'Ž_\0\0\0‰\0'),(278,_binary 'Žf\0\0\0‰\0'),(279,_binary '™h\0\0\0‰\0'),(280,_binary '¡^\0\0\0‰\0'),(281,_binary 'Žj\0\0\0‰\0'),(281,_binary 'Œm\0\0\0‰\0'),(281,_binary 'Šq\0\0\0‰\0'),(282,_binary 'Ž]\0\0\0‰\0'),(282,_binary '‹`\0\0\0‰\0'),(282,_binary 'Žf\0\0\0‰\0'),(283,_binary 'Žj\0\0\0‰\0'),(284,_binary 'Ž`\0\0\0‰\0'),(284,_binary 'Žf\0\0\0‰\0'),(285,_binary '\Ò?\0\0\0%\0'),(285,_binary '\ÎA\0\0\0\Å\0'),(285,_binary '\ÏC\0\0\0\Å\0'),(285,_binary '\ÐA\0\0\0$\0'),(286,_binary '\ÆG\0\0\0\Å\0'),(286,_binary '\ÈG\0\0\0$\0'),(286,_binary '\ÃI\0\0\0%\0'),(286,_binary '\ÃL\0\0\0%\0'),(286,_binary '\ÈN\0\0\0\Å\0'),(287,_binary '\ÍG\0\0\0\Å\0'),(287,_binary '\ÏG\0\0\0$\0'),(287,_binary '\ÎI\0\0\0%\0'),(287,_binary '\ÎK\0\0\0\Ã\0'),(287,_binary '\ÌN\0\0\0$\0'),(287,_binary '\ÍN\0\0\0$\0'),(287,_binary '\ÐJ\0\0\0%\0'),(288,_binary '\ÚG\0\0\0$\0'),(288,_binary '\ÖI\0\0\0%\0'),(288,_binary '\ÖK\0\0\0\Ã\0'),(288,_binary '\ØK\0\0\0$\0'),(288,_binary '\ÚK\0\0\0\Å\0'),(288,_binary '\ÜK\0\0\0$\0'),(288,_binary '\ÝI\0\0\0%\0'),(288,_binary '\ÖM\0\0\0%\0'),(288,_binary '\ØO\0\0\0$\0'),(288,_binary '\ÝM\0\0\0%\0'),(289,_binary '\ãC\0\0\0\Å\0'),(290,_binary '\Ë6\0\0\0%\0'),(290,_binary '\Î8\0\0\0$\0'),(290,_binary '\Ó6\0\0\0\Ã\0'),(290,_binary '\Ó7\0\0\0%\0'),(290,_binary '\Ò8\0\0\0$\0'),(291,_binary '\Í,\0\0\0$\0'),(291,_binary '\Ñ,\0\0\0$\0'),(291,_binary '\Ó-\0\0\0%\0'),(291,_binary '\Ó/\0\0\0\Ã\0'),(291,_binary '\Ë0\0\0\0%\0'),(291,_binary '\Ó1\0\0\0%\0'),(292,_binary '\Ù.\0\0\0%\0'),(292,_binary '\Ý,\0\0\0$\0'),(292,_binary '\â,\0\0\0$\0'),(292,_binary '\Ü3\0\0\0\Å\0'),(292,_binary '\Ù5\0\0\0%\0'),(292,_binary '\Ù7\0\0\0%\0'),(292,_binary '\Þ7\0\0\0\Ã\0'),(292,_binary '\Ü9\0\0\0\Å\0'),(292,_binary '\Ý9\0\0\0$\0'),(292,_binary '\ã0\0\0\0%\0'),(292,_binary '\ã5\0\0\0%\0'),(292,_binary '\ã8\0\0\0%\0'),(293,_binary '\êG\0\0\0%\0'),(293,_binary '\ìE\0\0\0$\0'),(293,_binary '\êJ\0\0\0\Ã\0'),(293,_binary '\ïH\0\0\0%\0'),(293,_binary '\íM\0\0\0$\0'),(294,_binary 'ûK\0\0\0%\0'),(294,_binary '\óL\0\0\0\Ã\0'),(294,_binary '\÷L\0\0\0\Ã\0'),(294,_binary '\öO\0\0\0$\0'),(294,_binary 'ùO\0\0\0$\0'),(295,_binary '\öB\0\0\0$\0'),(295,_binary '\óE\0\0\0\Ã\0'),(295,_binary '\óG\0\0\0%\0'),(295,_binary '\÷F\0\0\0\Ã\0'),(295,_binary 'ûE\0\0\0%\0'),(296,_binary 'ýE\0\0\0%\0'),(296,_binary 'ýD\0\0\0%\0'),(296,_binary 'ÿI\0\0\0$\0'),(296,_binary 'ýK\0\0\0%\0'),(296,_binary 'ÿO\0\0\0$\0'),(296,_binary '\0B\0\0\0$\0'),(296,_binary 'D\0\0\0%\0'),(296,_binary 'G\0\0\0%\0'),(296,_binary 'E\0\0\0%\0'),(296,_binary 'E\0\0\0%\0'),(296,_binary '\0I\0\0\0\Å\0'),(296,_binary 'I\0\0\0$\0'),(296,_binary 'H\0\0\0\Å\0'),(296,_binary 'J\0\0\0%\0'),(296,_binary 'H\0\0\0\Ã\0'),(296,_binary 'J\0\0\0%\0'),(296,_binary '\0L\0\0\0\Å\0'),(297,_binary 'þ,\0\0\0$\0'),(297,_binary 'ü0\0\0\0%\0'),(297,_binary 'ÿ3\0\0\0\Å\0'),(297,_binary 'ü6\0\0\0%\0'),(297,_binary 'ü;\0\0\0%\0'),(297,_binary 'þ9\0\0\0\Å\0'),(297,_binary ',\0\0\0$\0'),(297,_binary '0\0\0\0%\0'),(297,_binary '6\0\0\0%\0'),(297,_binary '9\0\0\0%\0'),(297,_binary '=\0\0\0\Å\0'),(298,_binary 'þ,\0\0\0$\0'),(298,_binary 'ü1\0\0\0%\0'),(298,_binary 'ÿ4\0\0\0\Å\0'),(298,_binary ',\0\0\0$\0'),(298,_binary '0\0\0\0%\0'),(298,_binary '7\0\0\0\Ã\0'),(298,_binary '6\0\0\0%\0'),(298,_binary ';\0\0\0\Ã\0'),(298,_binary '9\0\0\0\Ã\0'),(299,_binary '\Æ\0\0\0‰\0'),(299,_binary '\Ï\0\0\0‰\0'),(300,_binary '6\Ã\0\0\0‰\0'),(300,_binary ';\Æ\0\0\0‰\0'),(300,_binary '=\Ä\0\0\0‰\0'),(300,_binary '7\È\0\0\0‰\0'),(301,_binary 'J\Î\0\0\0‰\0'),(301,_binary 'D\Ó\0\0\0‰\0'),(301,_binary 'G\Ñ\0\0\0\å\0'),(301,_binary 'J\Ô\0\0\0‰\0'),(302,_binary 'K\Û\0\0\0‰\0'),(302,_binary 'D\Ý\0\0\0‰\0'),(303,_binary '0\ä\0\0\0‰\0'),(303,_binary '1\è\0\0\0‰\0'),(304,_binary '<\è\0\0\0‰\0'),(304,_binary 'A\ä\0\0\0‰\0'),(305,_binary '?ù\0\0\0‰\0'),(306,_binary '-\÷\0\0\0‰\0'),(306,_binary '3\÷\0\0\0‰\0'),(307,_binary '\'ÿ\0\0\0‰\0'),(307,_binary '5ÿ\0\0\0‰\0'),(308,_binary '\ÏA\0\0\0\0'),(308,_binary '\ÍD\0\0\0ÿ\0'),(309,_binary '\Ï:\0\0\0\0'),(309,_binary '\Ñ:\0\0\0\0'),(310,_binary '\×6\0\0\0\0'),(311,_binary '\ÚB\0\0\0\0\0'),(311,_binary '\ÛD\0\0\0ÿ\0'),(312,_binary '\áB\0\0\0ÿ\0'),(312,_binary '\áD\0\0\0ÿ\0'),(313,_binary '\éF\0\0\0\0'),(314,_binary '\ßN\0\0\0\0'),(315,_binary '\ßT\0\0\0\0'),(316,_binary 'ÀT\0\0\0ÿ\0'),(317,_binary '·T\0\0\0ÿ\0'),(318,_binary '·^\0\0\0\0'),(318,_binary '»^\0\0\0\0'),(319,_binary '·f\0\0\0\0'),(319,_binary '¼f\0\0\0\0'),(320,_binary '\àa\0\0\0ÿ\0'),(321,_binary '\ëg\0\0\0\0'),(322,_binary '\çj\0\0\0ÿ\0'),(323,_binary '¤^\0\0\0\0'),(324,_binary '\Ìœ\0\0\0$\0$\0'),(324,_binary '\ÎŸ\0\0\0\Ã\0'),(324,_binary '\Ìœ\0\0\0$\0'),(324,_binary '\ÔŸ\0\0\0\Å\0'),(324,_binary '\ÙŸ\0\0\0\Å\0'),(324,_binary '\ÞŸ\0\0\0\Å\0'),(324,_binary '\Ë£\0\0\0&\0'),(324,_binary '\Í£\0\0\0$\0'),(324,_binary '\Í£\0\0\0\Å\0'),(324,_binary '\Ï£\0\0\0&\0'),(324,_binary '\Ý£\0\0\0$\0'),(324,_binary '\ã¡\0\0\0%\0'),(324,_binary '\à£\0\0\0$\0'),(324,_binary '\ã¡\0\0\0%\0'),(325,_binary 'Av\0\0\0(\0'),(325,_binary 'Bv\0\0\0\ê\0'),(325,_binary 'Dv\0\0\0(\0'),(325,_binary 'Gv\0\0\0(\0'),(325,_binary '@x\0\0\0)\0'),(325,_binary 'C{\0\0\0\ê\0'),(325,_binary '@}\0\0\0)\0'),(325,_binary 'C\0\0\0\ê\0'),(325,_binary '@‚\0\0\0)\0'),(325,_binary 'Iƒ\0\0\0\ó\0'),(326,_binary 'DŒ\0\0\0\ê\0'),(327,_binary 'Ie\0\0\0(\0'),(327,_binary 'Me\0\0\0(\0'),(327,_binary 'Ki\0\0\0(\0'),(327,_binary 'Li\0\0\0\ê\0'),(327,_binary 'Mi\0\0\0(\0'),(327,_binary 'Qe\0\0\0(\0'),(327,_binary 'Qi\0\0\0(\0'),(328,_binary 'GW\0\0\0)\0'),(328,_binary 'IU\0\0\0(\0'),(328,_binary 'LT\0\0\0(\0'),(328,_binary 'OT\0\0\0(\0'),(328,_binary 'GY\0\0\0\ó\0'),(328,_binary 'G]\0\0\0)\0'),(328,_binary 'I_\0\0\0(\0'),(328,_binary 'O_\0\0\0(\0'),(328,_binary 'PV\0\0\0)\0'),(328,_binary 'QZ\0\0\0)\0'),(328,_binary 'Q^\0\0\0)\0'),(329,_binary 'L\\\0\0\0\ê\0'),(330,_binary ';S\0\0\0(\0'),(330,_binary ':[\0\0\0(\0'),(330,_binary '=[\0\0\0(\0'),(330,_binary 'AW\0\0\0)\0'),(330,_binary '@[\0\0\0(\0'),(330,_binary 'AX\0\0\0\ó\0'),(330,_binary 'AY\0\0\0)\0'),(331,_binary 'A•\0\0\0\ó\0'),(331,_binary 'E–\0\0\0\ó\0'),(331,_binary 'I”\0\0\0\ê\0'),(331,_binary 'I—\0\0\0\ê\0'),(332,_binary '%…\0\0\0‰\0'),(333,_binary 'y.\0\0\0‡\0'),(333,_binary 'y/\0\0\0ˆ\0'),(333,_binary '}6\0\0\0q\0'),(333,_binary '‚/\0\0\0r\0'),(333,_binary '‚2\0\0\0r\0'),(333,_binary '€6\0\0\0q\0'),(333,_binary '‚4\0\0\0\ô\Z\0'),(334,_binary '…*\0\0\0‡\0'),(334,_binary '…+\0\0\0ˆ\0'),(334,_binary '‡)\0\0\0q\0'),(334,_binary 'Š)\0\0\0q\0'),(334,_binary '„,\0\0\0r\0'),(334,_binary '„/\0\0\0r\0'),(334,_binary 'Œ,\0\0\0r\0'),(334,_binary 'Œ/\0\0\0r\0'),(334,_binary '†2\0\0\0q\0'),(334,_binary 'ˆ2\0\0\0\ë\Z\0'),(334,_binary 'Š2\0\0\0q\0'),(335,_binary '\"\0\0\0r\0'),(335,_binary 'ž!\0\0\0‡\0'),(335,_binary 'ž\"\0\0\0ˆ\0'),(335,_binary '%\0\0\0r\0'),(335,_binary '  \0\0\0q\0'),(335,_binary '£ \0\0\0q\0'),(335,_binary '¢&\0\0\0\ë\Z\0'),(336,_binary 'ž*\0\0\0‡\0'),(336,_binary 'ž+\0\0\0ˆ\0'),(336,_binary ',\0\0\0r\0'),(336,_binary '¢)\0\0\0\ë\Z\0'),(336,_binary '£1\0\0\0q\0'),(337,_binary 'ª*\0\0\0‡\0'),(337,_binary 'ª+\0\0\0ˆ\0'),(337,_binary '­)\0\0\0\ë\Z\0'),(337,_binary '±,\0\0\0r\0'),(337,_binary '±/\0\0\0r\0'),(337,_binary '¬1\0\0\0q\0'),(337,_binary '¯1\0\0\0q\0'),(338,_binary 'ª!\0\0\0‡\0'),(338,_binary 'ª\"\0\0\0ˆ\0'),(338,_binary '¬ \0\0\0q\0'),(338,_binary '¯ \0\0\0q\0'),(338,_binary '­&\0\0\0\ë\Z\0'),(338,_binary '±\"\0\0\0r\0'),(338,_binary '±%\0\0\0r\0'),(339,_binary '´6\0\0\0q\0'),(339,_binary '¸6\0\0\0q\0'),(339,_binary '²8\0\0\0r\0'),(339,_binary '²:\0\0\0\ô\Z\0'),(339,_binary '³;\0\0\0‡\0'),(339,_binary '²:\0\0\0\ô\Z\0'),(339,_binary '·:\0\0\0\ô\Z\0'),(339,_binary '¹9\0\0\0\ë\Z\0'),(339,_binary '³<\0\0\0ˆ\0'),(339,_binary '´=\0\0\0q\0'),(339,_binary '¶=\0\0\0q\0'),(339,_binary 'º=\0\0\0q\0'),(340,_binary '±A\0\0\0t\0'),(340,_binary '¸@\0\0\0s\0'),(340,_binary '½@\0\0\0s\0'),(340,_binary '±E\0\0\0\ô\Z\0'),(340,_binary '¾F\0\0\0‰\0'),(340,_binary '¿F\0\0\0Š\0'),(340,_binary '±P\0\0\0t\0'),(340,_binary '´R\0\0\0s\0'),(340,_binary '¼Q\0\0\0‰\0'),(340,_binary '¼R\0\0\0s\0'),(340,_binary '½Q\0\0\0Š\0'),(340,_binary '¾P\0\0\0t\0'),(340,_binary 'ÀC\0\0\0r\0'),(340,_binary 'ÀD\0\0\0\ö\Z\0'),(340,_binary 'ÀE\0\0\0r\0'),(340,_binary 'ÀK\0\0\0r\0'),(340,_binary 'ÀL\0\0\0\ö\Z\0'),(340,_binary 'ÀM\0\0\0r\0'),(341,_binary '¨R\0\0\0s\0'),(341,_binary '«R\0\0\0\ë\Z\0'),(341,_binary '¦W\0\0\0‡\0'),(341,_binary '¦X\0\0\0ˆ\0'),(341,_binary '©Y\0\0\0s\0'),(341,_binary '®Y\0\0\0s\0'),(341,_binary '°T\0\0\0s\0'),(341,_binary '²W\0\0\0t\0'),(342,_binary 'œR\0\0\0s\0'),(342,_binary 'šY\0\0\0‡\0'),(342,_binary 'šZ\0\0\0ˆ\0'),(342,_binary '›[\0\0\0s\0'),(342,_binary 'ž[\0\0\0\ë\Z\0'),(342,_binary ' R\0\0\0s\0'),(342,_binary '¡[\0\0\0s\0'),(343,_binary '¨[\0\0\0s\0'),(343,_binary '¬[\0\0\0s\0'),(343,_binary '¥^\0\0\0\ö\Z\0'),(343,_binary '«^\0\0\0\ë\Z\0'),(343,_binary '¯^\0\0\0t\0'),(343,_binary '§a\0\0\0‡\0'),(343,_binary '§b\0\0\0ˆ\0'),(343,_binary '§a\0\0\0‡\0'),(343,_binary '§b\0\0\0ˆ\0'),(343,_binary '¨c\0\0\0s\0'),(343,_binary '¬a\0\0\0\ô\Z\0'),(343,_binary '¯`\0\0\0t\0'),(344,_binary '˜a\0\0\0\ë\Z\0'),(344,_binary '’f\0\0\0‡\0'),(344,_binary '’g\0\0\0ˆ\0'),(344,_binary '•d\0\0\0\ô\Z\0'),(344,_binary '”d\0\0\0\ë\Z\0'),(345,_binary '‰Q\0\0\0s\0'),(345,_binary '‰Q\0\0\0q\0'),(345,_binary 'Q\0\0\0s\0'),(345,_binary 'ŒQ\0\0\0\ë\Z\0'),(345,_binary 'Q\0\0\0q\0'),(345,_binary '‰U\0\0\0\ë\Z\0'),(345,_binary '‰W\0\0\0\ë\Z\0'),(345,_binary '‡X\0\0\0‡\0'),(345,_binary '‡Y\0\0\0ˆ\0'),(345,_binary '‡X\0\0\0‡\0'),(345,_binary '‡Y\0\0\0ˆ\0'),(345,_binary 'ŒY\0\0\0\ô\Z\0'),(345,_binary 'Š\\\0\0\0s\0'),(345,_binary 'Š\\\0\0\0s\0'),(345,_binary '\\\0\0\0s\0'),(345,_binary '\\\0\0\0s\0'),(345,_binary '‘T\0\0\0t\0'),(345,_binary '‘T\0\0\0t\0'),(345,_binary '‘X\0\0\0t\0'),(345,_binary '‘Z\0\0\0t\0'),(345,_binary '‘X\0\0\0t\0'),(346,_binary '|I\0\0\0q\0'),(346,_binary 'I\0\0\0q\0'),(346,_binary 'ƒL\0\0\0\ë\Z\0'),(346,_binary '„O\0\0\0t\0'),(346,_binary '„S\0\0\0t\0'),(348,_binary '7l\0\0\0‰\0'),(349,_binary '.l\0\0\0‰\0'),(350,_binary '+s\0\0\0‰\0'),(351,_binary '%c\0\0\0‰\0'),(352,_binary 'Qe\0\0\0‰\0'),(353,_binary 'Pl\0\0\0‰\0'),(354,_binary 'Yn\0\0\0‰\0'),(355,_binary '`n\0\0\0‰\0'),(356,_binary 'jn\0\0\0‰\0'),(357,_binary 'on\0\0\0‰\0'),(358,_binary '¨\à\0\0\0q\0'),(358,_binary '¬\à\0\0\04\0'),(358,_binary '¦\ä\0\0\0r\0'),(358,_binary '«\ç\0\0\0q\0'),(359,_binary '¶\â\0\0\0q\0'),(359,_binary '¼\â\0\0\04\0'),(359,_binary '¿\â\0\0\0q\0'),(359,_binary '³\è\0\0\0r\0'),(359,_binary '¹\ì\0\0\0q\0'),(360,_binary '\È\â\0\0\0q\0'),(360,_binary '\Ì\â\0\0\04\0'),(360,_binary '\Ï\â\0\0\0q\0'),(360,_binary '\Æ\å\0\0\0r\0'),(360,_binary '\Í\ê\0\0\0q\0'),(360,_binary '\Õ\â\0\0\0q\0'),(360,_binary '\Ò\æ\0\0\01\0'),(360,_binary '\×\ç\0\0\0r\0'),(361,_binary '\Ì\æ\0\0\01\0'),(361,_binary '\×\æ\0\0\01\0'),(362,_binary 'Á\ç\0\0\01\0'),(363,_binary '\Õ\×\0\0\01\0'),(363,_binary '\Ú\Ô\0\0\0q\0'),(363,_binary '\Ú\Õ\0\0\0\à\0'),(363,_binary '\Û\Õ\0\0\0\á\0'),(364,_binary '©\Ã\0\0\0r\0'),(364,_binary '¬À\0\0\0q\0'),(364,_binary '©\Ê\0\0\0r\0'),(364,_binary '¬\Í\0\0\0q\0'),(364,_binary '·À\0\0\0q\0'),(364,_binary '·\Å\0\0\04\0'),(364,_binary '»\Ê\0\0\0r\0'),(364,_binary '±\Í\0\0\04\0'),(364,_binary '¸\Í\0\0\0q\0'),(365,_binary '©\Ê\0\0\01\0'),(365,_binary '´\Ç\0\0\01\0'),(366,_binary '#\0\0\0‰\0'),(367,_binary '\0\0\0‰\0'),(368,_binary '‹\0\0\0‰\0'),(369,_binary 'ˆ\0\0\0‰\0'),(370,_binary 'ƒ\0\0\0‰\0'),(371,_binary '‚!\0\0\0‰\0'),(372,_binary 'Š!\0\0\0‰\0'),(373,_binary 'ƒ&\0\0\0‰\0'),(374,_binary '‹+\0\0\0‰\0'),(375,_binary 'Ž,\0\0\0‰\0'),(376,_binary '˜/\0\0\0‰\0'),(377,_binary '” \0\0\0‰\0'),(378,_binary 'œ%\0\0\0‰\0'),(379,_binary ' -\0\0\0‰\0'),(380,_binary '§,\0\0\0‰\0'),(381,_binary '©+\0\0\0‰\0'),(382,_binary '¤\'\0\0\0‰\0'),(383,_binary '¥\0\0\0‰\0'),(384,_binary '«\0\0\0‰\0'),(385,_binary '§\0\0\0‰\0'),(386,_binary 'ª\0\0\0‰\0'),(387,_binary '§\0\0\0‰\0'),(388,_binary ' \n\0\0\0‰\0'),(389,_binary '˜\n\0\0\0‰\0'),(390,_binary '\Þ\n|\0\0\0&\0'),(390,_binary '\á\ny\0\0\0¾\0'),(390,_binary '\å\nx\0\0\0\'\0'),(390,_binary '\á\n|\0\0\0¼\0'),(390,_binary '\ã\n|\0\0\0&\0'),(391,_binary '\ë\n{\0\0\0»\0'),(391,_binary '\é\n|\0\0\0¼\0'),(391,_binary '\ê\n|\0\0\0&\0'),(391,_binary '\î\n|\0\0\0&\0'),(391,_binary '\ð\nw\0\0\0\'\0'),(391,_binary '\ð\n{\0\0\0\'\0'),(392,_binary 'û\ny\0\0\0\'\0'),(392,_binary '\ô\n|\0\0\0¼\0'),(392,_binary '\ö\n|\0\0\0&\0'),(392,_binary 'ù\n|\0\0\0&\0'),(393,_binary 'ÿ\n|\0\0\0&\0'),(393,_binary '{\0\0\0»\0'),(393,_binary 'x\0\0\0\'\0'),(393,_binary '{\0\0\0\'\0'),(393,_binary '\0|\0\0\0¼\0'),(393,_binary '|\0\0\0&\0'),(394,_binary '{\0\0\0»\0'),(394,_binary '\r|\0\0\0¼\0'),(394,_binary '|\0\0\0&\0'),(395,_binary 'y\0\0\0¾\0'),(395,_binary '|\0\0\0¼\0'),(395,_binary '|\0\0\0&\0'),(396,_binary 'y\0\0\0¾\0'),(396,_binary 'x\0\0\0\'\0'),(396,_binary '{\0\0\0\'\0'),(396,_binary '|\0\0\0¼\0'),(396,_binary '|\0\0\0&\0'),(397,_binary '\"{\0\0\0\'\0'),(397,_binary '\'{\0\0\0»\0'),(397,_binary '+{\0\0\0\'\0'),(397,_binary '\"\0\0\0¹\0'),(397,_binary '%}\0\0\0¾\0'),(397,_binary '\"‚\0\0\0\'\0'),(397,_binary '%ƒ\0\0\0&\0'),(397,_binary '\'€\0\0\0¾\0'),(397,_binary ')ƒ\0\0\0&\0'),(397,_binary '+‚\0\0\0\'\0'),(398,_binary '‡\0\0\0&\0'),(398,_binary '†\0\0\0»\0'),(398,_binary '‡\0\0\0¼\0'),(398,_binary ' ƒ\0\0\0\'\0'),(398,_binary ' †\0\0\0\'\0'),(399,_binary '\0\0\0¼\0'),(399,_binary 'ƒ\0\0\0»\0'),(399,_binary '\0\0\0&\0'),(399,_binary 'ƒ\0\0\0\'\0'),(399,_binary '‡\0\0\0&\0'),(399,_binary '‡\0\0\0&\0'),(399,_binary '†\0\0\0\'\0'),(400,_binary '	ƒ\0\0\0\'\0'),(400,_binary '‡\0\0\0&\0'),(400,_binary '„\0\0\0»\0'),(400,_binary '‡\0\0\0¼\0'),(400,_binary '‡\0\0\0&\0'),(400,_binary '	†\0\0\0\'\0'),(401,_binary 'ú\n‡\0\0\0¼\0'),(401,_binary 'û\n‡\0\0\0&\0'),(401,_binary 'ü\n†\0\0\0»\0'),(401,_binary '\0‡\0\0\0&\0'),(402,_binary '\ì\n‡\0\0\0&\0'),(402,_binary '\í\n‡\0\0\0¼\0'),(402,_binary '\ò\nƒ\0\0\0\'\0'),(402,_binary '\ð\n„\0\0\0¾\0'),(402,_binary '\ð\n‡\0\0\0&\0'),(402,_binary '\ò\n†\0\0\0\'\0'),(403,_binary '\ä\nƒ\0\0\0¹\0'),(403,_binary '\ã\n…\0\0\0¾\0'),(403,_binary '\ä\n‡\0\0\0\'\0'),(404,_binary '\ä\n‹\0\0\0\'\0'),(404,_binary '\ã\nŒ\0\0\0¾\0'),(404,_binary '\ä\n\0\0\0¹\0'),(404,_binary '\Þ\n\0\0\0&\0'),(404,_binary '\ã\n\0\0\0&\0'),(405,_binary '\Þ\n™\0\0\0&\0'),(405,_binary '\á\n–\0\0\0¾\0'),(405,_binary '\ã\n•\0\0\0\'\0'),(405,_binary '\á\n™\0\0\0&\0'),(405,_binary '\ã\n˜\0\0\0¹\0'),(406,_binary '\ß\nŸ\0\0\0¾\0'),(406,_binary '\ã\n\0\0\0¹\0'),(406,_binary '\ã\nž\0\0\0\'\0'),(406,_binary '\Ý\n£\0\0\0&\0'),(406,_binary '\á\n£\0\0\0&\0'),(406,_binary '\ã\n¡\0\0\0\'\0'),(407,_binary '\Ý\n¬\0\0\0&\0'),(407,_binary '\á\n§\0\0\0»\0'),(407,_binary '\å\n¥\0\0\0¼\0'),(407,_binary '\æ\n§\0\0\0\'\0'),(407,_binary '\æ\n«\0\0\0\'\0'),(407,_binary '\ã\n¬\0\0\0&\0'),(408,_binary '\î\n§\0\0\0»\0'),(408,_binary '\ì\n¬\0\0\0&\0'),(408,_binary '\ñ\n¥\0\0\0¼\0'),(408,_binary '\ò\n§\0\0\0\'\0'),(408,_binary '\ò\n«\0\0\0\'\0'),(408,_binary '\ð\n¬\0\0\0&\0'),(409,_binary '\î\n²\0\0\0»\0'),(409,_binary '\ì\n´\0\0\0&\0'),(409,_binary '\ò\n°\0\0\0\'\0'),(409,_binary '\ò\n²\0\0\0¹\0'),(409,_binary '\ò\n³\0\0\0\'\0'),(409,_binary '\ð\n´\0\0\0&\0'),(410,_binary '\ò\nš\0\0\0¹\0'),(410,_binary '\ñ\nœ\0\0\0¾\0'),(410,_binary '\ò\nŸ\0\0\0\'\0'),(410,_binary '\ì\n \0\0\0&\0'),(410,_binary '\ð\n \0\0\0&\0'),(411,_binary '\ò\n\0\0\0\'\0'),(411,_binary '\ì\n\0\0\0¾\0'),(411,_binary '\ì\n•\0\0\0&\0'),(411,_binary '\ð\n\0\0\0¾\0'),(411,_binary '\ò\n“\0\0\0¹\0'),(411,_binary '\ñ\n•\0\0\0&\0'),(412,_binary 'ø\n¤\0\0\0¹\0'),(412,_binary 'ø\n§\0\0\0\'\0'),(412,_binary 'ú\n¦\0\0\0¾\0'),(412,_binary 'ú\n©\0\0\0&\0'),(412,_binary 'þ\n©\0\0\0&\0'),(413,_binary '¥\0\0\0¾\0'),(413,_binary '	¤\0\0\0\'\0'),(413,_binary '	§\0\0\0\'\0'),(413,_binary '©\0\0\0&\0'),(413,_binary '©\0\0\0&\0'),(413,_binary '	¨\0\0\0¹\0'),(414,_binary '	®\0\0\0\'\0'),(414,_binary '³\0\0\0¼\0'),(414,_binary '²\0\0\0»\0'),(414,_binary '³\0\0\0&\0'),(414,_binary '	²\0\0\0\'\0'),(415,_binary 'ÿ\n™\0\0\0¼\0'),(415,_binary 'ü\n\0\0\0»\0'),(415,_binary 'û\n \0\0\0&\0'),(415,_binary 'þ\n \0\0\0&\0'),(415,_binary '\0œ\0\0\0\'\0'),(415,_binary '\0Ÿ\0\0\0\'\0'),(416,_binary '™\0\0\0¼\0'),(416,_binary '›\0\0\0»\0'),(416,_binary '	›\0\0\0\'\0'),(416,_binary '	ž\0\0\0\'\0'),(416,_binary ' \0\0\0&\0'),(416,_binary ' \0\0\0&\0'),(417,_binary '®\0\0\0»\0'),(417,_binary '®\0\0\0\'\0'),(417,_binary '°\0\0\0¹\0'),(417,_binary '³\0\0\0&\0'),(417,_binary '³\0\0\0&\0'),(417,_binary '²\0\0\0\'\0'),(418,_binary '§\0\0\0¹\0'),(418,_binary '¥\0\0\0¾\0'),(418,_binary '¤\0\0\0\'\0'),(418,_binary '§\0\0\0\'\0'),(418,_binary '©\0\0\0&\0'),(418,_binary '©\0\0\0&\0'),(419,_binary '\0\0\0¹\0'),(419,_binary '›\0\0\0\'\0'),(419,_binary 'ž\0\0\0\'\0'),(419,_binary ' \0\0\0&\0'),(419,_binary ' \0\0\0&\0'),(420,_binary '™\0\0\0¼\0'),(420,_binary '›\0\0\0\'\0'),(420,_binary 'ž\0\0\0\'\0'),(420,_binary '\Z \0\0\0&\0'),(420,_binary ' \0\0\0&\0'),(421,_binary '\0\0\0\'\0'),(421,_binary '•\0\0\0&\0'),(421,_binary '“\0\0\0»\0'),(421,_binary '“\0\0\0\'\0'),(421,_binary '•\0\0\0¼\0'),(422,_binary '\0\0\0\'\0'),(422,_binary '“\0\0\0\'\0'),(422,_binary '•\0\0\0¼\0'),(422,_binary '”\0\0\0»\0'),(422,_binary '•\0\0\0&\0'),(423,_binary '\n“\0\0\0\â\0'),(423,_binary '\n\n•\0\0\0\Ú\0'),(423,_binary '\n\n–\0\0\0\Û\0'),(423,_binary '\n”\0\0\0\æ\0'),(424,_binary '\nœ\0\0\0\à\0'),(424,_binary '\nœ\0\0\0\á\0'),(424,_binary '\nŸ\0\0\0\æ\0'),(424,_binary '\nŸ\0\0\0\â\0'),(424,_binary '\n¡\0\0\0\à\0'),(424,_binary '\n¡\0\0\0\á\0'),(424,_binary '\n¡\0\0\0\ã\0'),(425,_binary '\n£\0\0\0\ä\0'),(425,_binary '\n¤\0\0\0\à\0'),(425,_binary '\n¤\0\0\0\á\0'),(425,_binary '\n¥\0\0\0\ã\0'),(426,_binary '\n§\0\0\0\à\0'),(426,_binary '\n§\0\0\0\á\0'),(426,_binary '\n¨\0\0\0\ã\0'),(426,_binary ' \n¨\0\0\0\â\0'),(427,_binary '\n­\0\0\0\ã\0'),(427,_binary ' \n­\0\0\0\â\0'),(428,_binary '\nµ\0\0\0\á\0'),(428,_binary '\n·\0\0\0\æ\0'),(429,_binary '\n»\0\0\0\ã\0'),(429,_binary '\n\Â\0\0\0\ä\0'),(429,_binary '\nÀ\0\0\0\ã\0'),(430,_binary '\'\n\Â\0\0\0\ä\0'),(430,_binary '(\nÁ\0\0\0\ã\0'),(431,_binary '\'\n£\0\0\0\Ú\0'),(431,_binary '*\n¢\0\0\0\ä\0'),(431,_binary '\'\n¤\0\0\0\Û\0'),(432,_binary '+\n§\0\0\0\Ú\0'),(432,_binary '&\n©\0\0\0\â\0'),(432,_binary ')\nª\0\0\0\æ\0'),(432,_binary '+\n¨\0\0\0\Û\0'),(433,_binary '7\n¯\0\0\0\ä\0'),(433,_binary '3\n°\0\0\0\Ú\0'),(433,_binary '3\n±\0\0\0\Û\0'),(434,_binary 'H\n¶\0\0\0\ä\0'),(434,_binary 'G\nº\0\0\0\Ú\0'),(434,_binary 'G\n»\0\0\0\Û\0'),(434,_binary 'K\nº\0\0\0\ã\0'),(435,_binary 'M\n«\0\0\0\Ú\0'),(435,_binary 'K\n­\0\0\0\á\0'),(435,_binary 'M\n¬\0\0\0\Û\0'),(435,_binary 'M\n¯\0\0\0\æ\0'),(436,_binary '8\n•\0\0\0\Ú\0'),(436,_binary '8\n–\0\0\0\Û\0'),(436,_binary '=\n•\0\0\0\Ú\0'),(436,_binary '=\n–\0\0\0\Û\0'),(436,_binary '7\n›\0\0\0\â\0'),(436,_binary ';\n™\0\0\0\æ\0'),(437,_binary 'F\n—\0\0\0\â\0'),(437,_binary 'C\nš\0\0\0\æ\0'),(438,_binary '3\nŠ\0\0\0\Ú\0'),(438,_binary '3\n‹\0\0\0\Û\0'),(438,_binary '6\n\0\0\0\ä\0'),(439,_binary ':\nŠ\0\0\0\Ú\0'),(439,_binary ':\n‹\0\0\0\Û\0'),(439,_binary '<\n\0\0\0\ä\0'),(440,_binary '\nˆ\0\0\0\à\0'),(440,_binary '\nˆ\0\0\0\á\0'),(440,_binary '\n‹\0\0\0\ä\0'),(440,_binary '\n‰\0\0\0\ã\0'),(441,_binary '©	½\0\0\0\ä\0'),(442,_binary '«	\Ä\0\0\0\á\0'),(443,_binary '¸	\Ä\0\0\0\á\0'),(444,_binary 'º	¼\0\0\0\ä\0'),(445,_binary '\Â	¼\0\0\0\ä\0'),(446,_binary '\Ë	¼\0\0\0\ä\0'),(447,_binary '\Ô	¼\0\0\0\ä\0'),(448,_binary '\Â	\Ä\0\0\0\á\0'),(449,_binary '\Ë	\Å\0\0\0\á\0'),(450,_binary '\Ñ	\Ê\0\0\0\á\0'),(451,_binary '\Ä	\Ì\0\0\0\á\0'),(452,_binary '\Ä	\Ø\0\0\0\á\0'),(453,_binary '\Ï	\Ø\0\0\0\á\0'),(454,_binary '\Ä	\ã\0\0\0\á\0'),(455,_binary '\Ë	\ã\0\0\0\á\0'),(456,_binary '¶	\ã\0\0\0\ä\0'),(457,_binary '}	\ä\0\0\0\á\0'),(458,_binary 'Š	\ã\0\0\0\ä\0'),(459,_binary '‘	\ä\0\0\0\ä\0'),(460,_binary 'Œ	\ê\0\0\0\ä\0'),(461,_binary 'ƒ	\ç\0\0\0\ä\0'),(462,_binary '¦	\î\0\0\0\ä\0'),(463,_binary '®	\î\0\0\0\ä\0'),(464,_binary '¶	\î\0\0\0\ä\0'),(465,_binary 'œ	ø\0\0\0\á\0'),(465,_binary 'ž	û\0\0\0\ä\0'),(465,_binary 'Ÿ	þ\0\0\0\ä\0'),(466,_binary '­	û\0\0\0\á\0'),(466,_binary '±	ù\0\0\0\ä\0'),(466,_binary '¬	\0\0\0\ä\0'),(467,_binary '·	ý\0\0\0\ä\0'),(486,_binary '\ô_\0\0\0\Ñ\0'),(486,_binary 'ù_\0\0\09\0'),(486,_binary 'ùa\0\0\0\Ï\0'),(486,_binary '\òg\0\0\08\0'),(486,_binary '\ôe\0\0\0\Ñ\0'),(486,_binary '\÷g\0\0\08\0'),(486,_binary 'ùe\0\0\09\0'),(487,_binary 'ÿr\0\0\08\0'),(487,_binary '\0	m\0\0\0\Ñ\0'),(487,_binary '	o\0\0\0\Ô\0'),(487,_binary '	m\0\0\09\0'),(487,_binary '	r\0\0\0\Ò\0'),(487,_binary '	q\0\0\09\0'),(488,_binary '	x\0\0\0\Ô\0'),(488,_binary '	|\0\0\08\0'),(488,_binary '	|\0\0\0\Ò\0'),(488,_binary '	v\0\0\09\0'),(488,_binary '	z\0\0\09\0'),(488,_binary '	|\0\0\08\0'),(489,_binary '	i\0\0\0\Ï\0'),(489,_binary '*	g\0\0\09\0'),(489,_binary '#	h\0\0\0\Ñ\0'),(489,_binary '*	k\0\0\09\0'),(489,_binary '!	l\0\0\08\0'),(489,_binary '\'	l\0\0\08\0'),(490,_binary ';	s\0\0\09\0'),(490,_binary '5	u\0\0\0\Ô\0'),(490,_binary ';	w\0\0\09\0'),(490,_binary '4	y\0\0\08\0'),(490,_binary '6	y\0\0\0\Ò\0'),(490,_binary '8	y\0\0\08\0'),(491,_binary '!	ƒ\0\0\0\Ò\0'),(491,_binary ' 	‡\0\0\0\Ô\0'),(491,_binary '!	Œ\0\0\08\0'),(492,_binary ',	…\0\0\09\0'),(492,_binary '(	ˆ\0\0\0\Ñ\0'),(492,_binary ',	ˆ\0\0\0\Ï\0'),(492,_binary ',	Š\0\0\09\0'),(492,_binary '&	Œ\0\0\08\0'),(492,_binary '+	Œ\0\0\08\0'),(493,_binary ':	‚\0\0\0\Ò\0'),(493,_binary '8	†\0\0\0\Ô\0'),(493,_binary '?	„\0\0\09\0'),(493,_binary '8	‹\0\0\08\0'),(493,_binary ':	‰\0\0\0\Ñ\0'),(493,_binary '<	‹\0\0\08\0'),(493,_binary '?	‰\0\0\09\0'),(494,_binary ';	’\0\0\0\Ñ\0'),(494,_binary '9	”\0\0\0\Ô\0'),(494,_binary '9	™\0\0\08\0'),(494,_binary '>	™\0\0\08\0'),(494,_binary 'A	’\0\0\09\0'),(494,_binary 'A	”\0\0\0\Ï\0'),(494,_binary 'A	—\0\0\09\0'),(495,_binary 'y\á\0\0\0\Ú\0'),(495,_binary 'y\â\0\0\0\Û\0'),(495,_binary '\ä\0\0\0\ä\0'),(496,_binary 'dø\0\0\0\Ú\0'),(496,_binary 'dù\0\0\0\Û\0'),(496,_binary 'fÿ\0\0\0\ä\0'),(497,_binary 'o\õ\0\0\0\Ú\0'),(497,_binary 'o\ö\0\0\0\Û\0'),(497,_binary 'qü\0\0\0\ä\0'),(498,_binary 'l\0\0\0\à\0'),(498,_binary 'm\0\0\0\á\0'),(498,_binary 'n\0\0\0\ã\0'),(498,_binary 'p\0\0\0\ä\0'),(499,_binary '’\0\0\0\Ú\0'),(499,_binary '’\0\0\0\Û\0'),(499,_binary '‘\0\0\0\á\0'),(500,_binary '–ø\0\0\0\Ú\0'),(500,_binary '–ù\0\0\0\Û\0'),(500,_binary '•ü\0\0\0\á\0'),(501,_binary 'š\è\0\0\0\Ú\0'),(501,_binary 'š\é\0\0\0\Û\0'),(501,_binary '™\ì\0\0\0\á\0'),(502,_binary '6°\0\0\0\æ\0'),(502,_binary '9±\0\0\0\á\0'),(503,_binary '6½\0\0\0\ã\0'),(503,_binary '9¿\0\0\0\á\0'),(504,_binary '6\Ä\0\0\0\ã\0'),(504,_binary '9\Ä\0\0\0\á\0'),(505,_binary '6\É\0\0\0\ã\0'),(505,_binary '9\É\0\0\0\á\0'),(506,_binary '?µ\0\0\0\á\0'),(506,_binary 'B´\0\0\0\æ\0'),(507,_binary '?»\0\0\0\á\0'),(508,_binary '?Á\0\0\0\á\0'),(508,_binary 'B\Â\0\0\0\æ\0'),(509,_binary 'C\Ó\0\0\0\ä\0'),(510,_binary 'H\Ó\0\0\0\ä\0'),(511,_binary 'O\Ó\0\0\0\ä\0'),(512,_binary 'H\Í\0\0\0\ä\0'),(513,_binary 'M\Í\0\0\0\ä\0'),(514,_binary 'L³\0\0\0\ã\0'),(514,_binary 'Q³\0\0\0\á\0'),(515,_binary 'L¸\0\0\0\ã\0'),(515,_binary 'Q¶\0\0\0\á\0'),(516,_binary 'L¼\0\0\0\ã\0'),(516,_binary 'Q½\0\0\0\á\0'),(517,_binary 'LÁ\0\0\0\ã\0'),(517,_binary 'Q\Â\0\0\0\á\0'),(518,_binary '[\Æ\0\0\0\ä\0'),(518,_binary 'X\É\0\0\0\ã\0'),(519,_binary '[\Ï\0\0\0\ä\0'),(519,_binary 'V\Ó\0\0\0\ã\0'),(520,_binary 'a\Ó\0\0\0\á\0'),(521,_binary 'a\É\0\0\0\á\0'),(521,_binary 'd\É\0\0\0\ã\0'),(522,_binary 'm\É\0\0\0\ã\0'),(522,_binary 'n\Ì\0\0\0\ä\0'),(523,_binary 'y\É\0\0\0\æ\0'),(523,_binary 'z\Î\0\0\0\ä\0'),(524,_binary 'z\Ò\0\0\0\ä\0'),(525,_binary 'ƒ\Í\0\0\0\â\0'),(526,_binary 'ƒ\È\0\0\0\á\0'),(527,_binary 'ƒ\Ä\0\0\0\á\0'),(528,_binary '}¿\0\0\0\ä\0'),(529,_binary 'o»\0\0\0\æ\0'),(529,_binary 's¿\0\0\0\ä\0'),(530,_binary 'v¯\0\0\0\ä\0'),(531,_binary 'a«\0\0\0\á\0'),(532,_binary 'a¤\0\0\0\ä\0'),(533,_binary 'f¤\0\0\0\ä\0'),(534,_binary 'k¤\0\0\0\ä\0'),(535,_binary '[ª\0\0\0\ã\0'),(535,_binary ']«\0\0\0\á\0'),(536,_binary 'I©\0\0\0\ä\0'),(537,_binary 'M©\0\0\0\ä\0'),(538,_binary 'H¥\0\0\0\ä\0'),(539,_binary 'N¥\0\0\0\ä\0'),(540,_binary 'U¥\0\0\0\ä\0');
/*!40000 ALTER TABLE `tile_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote`
--

DROP TABLE IF EXISTS `znote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(30) NOT NULL COMMENT 'Znote AAC version',
  `installed` int NOT NULL,
  `cached` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote`
--

LOCK TABLES `znote` WRITE;
/*!40000 ALTER TABLE `znote` DISABLE KEYS */;
INSERT INTO `znote` VALUES (1,'1.5_SVN',1535753961,1540374381);
/*!40000 ALTER TABLE `znote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_accounts`
--

DROP TABLE IF EXISTS `znote_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `ip` int unsigned NOT NULL,
  `created` int NOT NULL,
  `points` int DEFAULT '0',
  `cooldown` int DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  `activekey` int NOT NULL DEFAULT '0',
  `flag` varchar(20) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2767 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_accounts`
--

LOCK TABLES `znote_accounts` WRITE;
/*!40000 ALTER TABLE `znote_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_changelog`
--

DROP TABLE IF EXISTS `znote_changelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_changelog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `time` int NOT NULL,
  `report_id` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_changelog`
--

LOCK TABLES `znote_changelog` WRITE;
/*!40000 ALTER TABLE `znote_changelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_changelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_deleted_characters`
--

DROP TABLE IF EXISTS `znote_deleted_characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_deleted_characters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_account_id` int NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `done` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_deleted_characters`
--

LOCK TABLES `znote_deleted_characters` WRITE;
/*!40000 ALTER TABLE `znote_deleted_characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_deleted_characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_forum`
--

DROP TABLE IF EXISTS `znote_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_forum` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `access` tinyint NOT NULL,
  `closed` tinyint NOT NULL,
  `hidden` tinyint NOT NULL,
  `guild_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_forum`
--

LOCK TABLES `znote_forum` WRITE;
/*!40000 ALTER TABLE `znote_forum` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_forum_posts`
--

DROP TABLE IF EXISTS `znote_forum_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_forum_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `thread_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int NOT NULL,
  `updated` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_forum_posts`
--

LOCK TABLES `znote_forum_posts` WRITE;
/*!40000 ALTER TABLE `znote_forum_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_forum_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_forum_threads`
--

DROP TABLE IF EXISTS `znote_forum_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_forum_threads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `forum_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int NOT NULL,
  `updated` int NOT NULL,
  `sticky` tinyint NOT NULL,
  `hidden` tinyint NOT NULL,
  `closed` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_forum_threads`
--

LOCK TABLES `znote_forum_threads` WRITE;
/*!40000 ALTER TABLE `znote_forum_threads` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_forum_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_global_storage`
--

DROP TABLE IF EXISTS `znote_global_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL,
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_global_storage`
--

LOCK TABLES `znote_global_storage` WRITE;
/*!40000 ALTER TABLE `znote_global_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_global_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_guild_wars`
--

DROP TABLE IF EXISTS `znote_guild_wars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_guild_wars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `limit` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `znote_guild_wars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_guild_wars`
--

LOCK TABLES `znote_guild_wars` WRITE;
/*!40000 ALTER TABLE `znote_guild_wars` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_guild_wars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_images`
--

DROP TABLE IF EXISTS `znote_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `desc` text NOT NULL,
  `date` int NOT NULL,
  `status` int NOT NULL,
  `image` varchar(30) NOT NULL,
  `account_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_images`
--

LOCK TABLES `znote_images` WRITE;
/*!40000 ALTER TABLE `znote_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_news`
--

DROP TABLE IF EXISTS `znote_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `date` int NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_news`
--

LOCK TABLES `znote_news` WRITE;
/*!40000 ALTER TABLE `znote_news` DISABLE KEYS */;
INSERT INTO `znote_news` VALUES (1,'LanÃƒÂ§amento','<font size=\"3\">Server oficialmente lanÃƒÂ§ado 02/09/2018!</font><div><font size=\"3\">Use o menu ao lado para criar sua conta!</font></div><div><font size=\"3\"><br></font></div><div><font size=\"3\">Staff PokeDash.</font></div>',1535927918,2),(2,'Mapa!','<img src=\"https://i.imgur.com/8yU4sma.png\" width=\"692\"><br>',1536787933,2),(3,'Mapa Outland!','Saiu o Outland com 10 quests! Mapa:<div><img src=\"https://i.imgur.com/4Odljlk.png\" width=\"692\"><br></div>',1537296243,2),(4,'ATUALIZAÃƒâ€¡ÃƒÆ’O','<div><span style=\"font-size: 15.36px;\"><b>O moveset (ataques) de todos os pokemons foram finalizados e balanceados, assim como cada um de seus moves. Em breve teremos a atualizaÃƒÂ§ÃƒÂ£o para a implementaÃƒÂ§ÃƒÂ£o das atualizaÃƒÂ§ÃƒÂµes.</b></span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>OBS 1</b>: O cooldown de cada ataque ÃƒÂ© padronizado, nÃƒÂ£o irÃƒÂ¡ ser alterado por hora.</span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>OBS 2</b>: JÃƒÂ¡ estÃƒÂ¡ implementado o sistema de vantagem/fraqueza entre os tipos de pokemons.</span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>OBS 3</b>: AlÃƒÂ©m do tipo elemental, os moves (ataques/spells) sÃƒÂ£o divididos em trÃƒÂªs categorias: FÃƒÂ­sico (physical), MÃƒÂ¡gico (magical), ou suporte (status). Por exemplo, um ataque fÃƒÂ­sico irÃƒÂ¡ levar em conta o Attack do pokemon atacante e a Defense do pokemon defensor. Analogamente, ataques mÃƒÂ¡gicos utilizarÃƒÂ£o para o cÃƒÂ¡lculo do dano o Magic Attack e Magic Defense.</span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>OBS 4</b>: O level mÃƒÂ­nimo para usar um pokemon ÃƒÂ©/serÃƒÂ¡ dado pelo seguinte cÃƒÂ¡lculo: Pokemon level + Boost level - 50 &lt; Player level. Por exemplo, um pokemon lvl 62+16 requer que o player tenha no mÃƒÂ­nimo level 62+16-50 = 28</span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>CURIOSIDADE</b>: Foram necessÃƒÂ¡rio 4 semanas de trabalho intenso da equipe do Pokedash somente para a idealizaÃƒÂ§ÃƒÂ£o, planejamento, produÃƒÂ§ÃƒÂ£o, validaÃƒÂ§ÃƒÂ£o e testes do moveset, portanto peÃƒÂ§o que compreendam que todo e qualquer tipo de melhoria no server requer bastante tempo dedicado e esforÃƒÂ§o por nossa parte.</span></div><div><span style=\"font-size: 15.36px;\"><br></span></div><div><span style=\"font-size: 15.36px;\"><b>Nossa motivaÃƒÂ§ÃƒÂ£o ÃƒÂ© ver o server crescer, entÃƒÂ£o divulguem e compartilhem.</b></span></div><div><span style=\"font-size: 15.36px;\"><b><br></b></span></div><div><span style=\"font-size: 15.36px;\"><b>Equipe Pokedash.</b></span></div>',1539939122,2),(5,'ATUALIZAÃƒâ€¡ÃƒÆ’O','<font size=\"4\">O up de jogadores level baixo se tornou mais fÃƒÂ¡cil! O primeiro catch em pokemons recebeu um bÃƒÂ´nus considerÃƒÂ¡vel de experiÃƒÂªncia, assim como a primeira dex! Aproveitem!</font><br>',1540290392,2),(6,'[UPDATE][ATUALIZAÃƒâ€¡ÃƒÆ’O]','<div><font size=\"4\" face=\"arial\">Uma nova atualizaÃƒÂ§ÃƒÂ£o acaba de ser aplicada em nosso server. Entre as mudanÃƒÂ§as, destacamos:<br></font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\"><b>- ImplementaÃƒÂ§ÃƒÂ£o de profissÃƒÂµes, sendo elas:</b></font></div><div><font size=\"4\" face=\"arial\">Catcher: 3.5% mais chance de capturar um Pokemon.</font></div><div><font size=\"4\" face=\"arial\">Hunter: 10% mais status de dano para o seu Pokemon (tanto magico quanto fisico).</font></div><div><font size=\"4\" face=\"arial\">Blocker: 25% mais vida para seus Pokemons.</font></div><div><font size=\"4\" face=\"arial\">Healer: 100% mais cura que aplica tanto em potions quando moves dos seus Pokemons.</font></div><div><font size=\"4\" face=\"arial\">Explorer: 15% mais experiencia para seu personagem durante a caÃƒÂ§a.</font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\"><b>- LanÃƒÂ§amento do nosso blog com o intuito de ajudar os jogadores que buscam informaÃƒÂ§ÃƒÂµes sobre o jogo</b>. Atualmente, ÃƒÂ© possÃƒÂ­vel encontrar dicas para as quests e uma pokedex que mostra o status/dificuldade de catch de todos os Pokemons do server. para acessar entre em: http://blog.pokedashgames.com/</font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\"><b>- Tokens</b>. Uma nova moeda de troca foi implementada no server. Os tokens podem ser trocados por itens raros (dentre eles premier ball e bags personalizadas - veja figura) alÃƒÂ©m de pagar seu curso com o NPC Job Manager para aprender uma das profissÃƒÂµes acima. Uma das maneiras de conseguir tokens ÃƒÂ© fazendo tasks diÃƒÂ¡rias na NPC Julie do CP de Saffron.</font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\">- Ultimate potion teve sua cura reduzida de 1/2 da vida do Pokemon para 1/3.</font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\">- CorreÃƒÂ§ÃƒÂ£o nos efeitos de alguns moves/ bugs em geral</font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\"><img src=\"https://i.imgur.com/tWbJqrq.png\" width=\"677\"><br></font></div><div><font size=\"4\" face=\"arial\"><br></font></div><div><font size=\"4\" face=\"arial\">Equipe Pokedash</font></div><div><br></div>',1540686148,2),(7,'[HALLOWEEN POKEDASH]','<div><font size=\"4\">O Halloween do Pokedash acaba de ser iniciado! De hoje atÃƒÂ© domingo zumbis e abÃƒÂ³boras estarÃƒÂ£o assombrando as cidades periodicamente!<br></font></div><div><font size=\"4\">Pokemons, outfits e itens exclusivos dessa ÃƒÂ©poca serÃƒÂ£o as recompensas para aqueles que ajudarem a proteger nosso mundo!</font></div><div><br></div><div><font size=\"4\">Equipe Pokedash</font></div><div><font size=\"4\"><br></font></div><div><img src=\"https://i.imgur.com/4V40v80.png\" width=\"692\"><font size=\"4\"><br></font></div>',1541045225,2),(8,'[UPDATE][ATUALIZAÃƒâ€¡ÃƒÆ’O]','<div><span style=\"font-size: large;\">Boa tarde a todos, hoje temos mais uma atualizaÃƒÂ§ÃƒÂ£o!!! As seguintes novidades serÃƒÂ£o incluidas no jogo:</span><br></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">1. Finalmente os lÃƒÂ­deres de ginÃƒÂ¡sios chegaram as cidades. Eles possuem pokemons bem fortes em seu time, aconselho a cada um estudar o adversario antes de desafia-lo.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">2. A Liga Indigo pokemon foi formada, contando com a Victory Road antes da liga, a Elite Four e tambÃƒÂ©m o CampeÃƒÂ£o. Prove ser o mestre pokemon derrotando a Liga.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">3. Professor Oak retornou de sua jornada e agora encontra-se em Pallet, converse com ele para saber em que ele precisa da sua ajuda e lembre-se de tempo em tempo visitÃƒÂ¡-lo, ele pode lhe trazer surpresas.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">4. O ex-campeÃƒÂ£o da liga se perdeu em sua jornada, mostre sua empatia e ajude-o!</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">5. Parece que um cidadÃƒÂ£o de muitos anos de idade em Kanto (continente principal) estÃƒÂ¡ prestes a desvendar o segredo sobre a forma ancestral/anciÃƒÂ£ dos pokemons, junte pistas e ajude-o vocÃƒÂª tambÃƒÂ©m.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">AtualizaÃƒÂ§ÃƒÂµes menores:</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- Novos respawns</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- Novas quests para level 125,150,175,200</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- IntroduÃƒÂ§ÃƒÂ£o dos ancients.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- Possibilidade de pescar shiny.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- Inventario atualizado.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Aproveitem!!</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Equipe Pokedash.</font></div>',1541971747,2),(9,'NOVA OUTLAND ANCIENTS','<div><font size=\"4\">Adicionamos hoje no mapa um novo local de caÃƒÂ§a para treinadores level 175+. Trata-se de um local em Nostrus que possui apenas respawn de Ancients. O acesso ÃƒÂ© feito pelos portais localizados em um prÃƒÂ©dio prÃƒÂ³ximo a saÃƒÂ­da leste de Nostrus!</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Equipe PokeDash</font></div><div><img src=\"https://i.imgur.com/4ksMJsF.jpg\" width=\"692\"><font size=\"4\"><br></font></div>',1542538916,2),(10,' [NEW CLIENT]','<div><font size=\"4\">LanÃƒÂ§amos ontem nosso novo cliente! Ele possui uma ÃƒÂ¡rea ÃƒÂºtil muito maior e janelas transparentes que podem ser organizadas como quiserem. Para jogar, todos devem baixÃƒÂ¡-lo.</font></div><br><div><img src=\"https://i.imgur.com/OIxD2Id.jpg\" width=\"692\"><span style=\"color: rgb(29, 33, 41); font-family: Helvetica, Arial, sans-serif; font-size: 14px; background-color: rgb(255, 255, 255);\"><br></span></div>',1543617748,2),(11,'[POKES NATAL]','<div><font size=\"4\">Confiram em primeira mÃƒÂ£o os pokes que estarÃƒÂ£o disponÃƒÂ­veis durante nosso evento de natal! Eles serÃƒÂ£o exclusivos e estarÃƒÂ£o disponÃƒÂ­veis para catch a partir da prÃƒÂ³xima atualizaÃƒÂ§ÃƒÂ£o, com duraÃƒÂ§ÃƒÂ£o atÃƒÂ© o inÃƒÂ­cio de janeiro.&nbsp;</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Aproveitem!</font><br></div><div><br></div><div><br></div><div><img src=\"https://i.imgur.com/KvlKmw3.jpg\" width=\"692\"><br></div>',1544483144,2),(12,'[MOVE BAR]','<div><font size=\"4\">Acabamos de adicionar a move bar ao cliente. Agora ÃƒÂ© possivel soltar os moves de seus pokes e observar o cooldown diretamente nela.<br></font></div><div><font size=\"4\">Para que ela apareÃƒÂ§a, vocÃƒÂª deve baixar o novo cliente (v7).</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Equipe Pokedash</font></div><div><font size=\"4\"><br></font></div><div><img src=\"https://i.imgur.com/9cw3mD1.jpg\" width=\"692\"><font size=\"4\"><br></font></div>',1544956988,2),(13,'[UPDATE]','<div><font size=\"4\">No update de hoje:<br></font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">- O level mÃƒÂ¡ximo dos Pokemons passa a ser 200. O ganho de status por level foi levemente diminuido, mas mesmo assim um Pokemon level 200 serÃƒÂ¡ bem mais forte que um lvl 100 atual.</font></div><div><font size=\"4\">- A vida basica de todos os Pokemons foi aumentada.<br></font></div><div><font size=\"4\">- O bonus no status do Pokemon devido ao level do player foi diminuido.</font></div><div><font size=\"4\">- As magias ultimates (que tem um cooldown bem maior que as outras) receberam um buff consideravel.</font></div><div><font size=\"4\">- O status dos Pokemons, alÃƒÂ©m de estar presente na Pokedex, agora tambÃƒÂ©m pode ser consultado dando look neles.</font></div><div><font size=\"4\"><br></font></div><div><font size=\"4\">Para baixar o jogo/criar conta entra em:</font></div><div><font size=\"4\">www.pokedashgames.com</font></div>',1544976459,2),(14,'[UPDATE]','<div><span style=\"font-size: large;\">Algumas cidades foram reformuladas e foi adicionada a barra para trocar de poke com 1 click. AlÃƒÂ©m disso, diversas correÃƒÂ§ÃƒÂµes de bugs e uma diminuiÃƒÂ§ÃƒÂ£o no intervalo das passivas.</span><br></div><div><span style=\"font-size: large;\"><br></span></div><div><img src=\"https://i.imgur.com/T3dB8Q1.jpg\" width=\"692\"><span style=\"font-size: large;\"><br></span></div>',1548356321,2),(15,'[UPDATE]','GeraÃƒÂ§ÃƒÂ£o 4 liberada!<div><br><div><img src=\"https://i.imgur.com/0NfcHNa.jpg\" width=\"692\"><br></div></div>',1550177038,2);
/*!40000 ALTER TABLE `znote_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_pagseguro`
--

DROP TABLE IF EXISTS `znote_pagseguro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_pagseguro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction` varchar(36) NOT NULL,
  `account` int NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `points` int NOT NULL,
  `payment_status` tinyint(1) NOT NULL,
  `completed` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account` (`account`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_pagseguro`
--

LOCK TABLES `znote_pagseguro` WRITE;
/*!40000 ALTER TABLE `znote_pagseguro` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_pagseguro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_pagseguro_notifications`
--

DROP TABLE IF EXISTS `znote_pagseguro_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_pagseguro_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_code` varchar(40) NOT NULL,
  `details` text NOT NULL,
  `receive_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_pagseguro_notifications`
--

LOCK TABLES `znote_pagseguro_notifications` WRITE;
/*!40000 ALTER TABLE `znote_pagseguro_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_pagseguro_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_paygol`
--

DROP TABLE IF EXISTS `znote_paygol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_paygol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `price` int NOT NULL,
  `points` int NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_paygol`
--

LOCK TABLES `znote_paygol` WRITE;
/*!40000 ALTER TABLE `znote_paygol` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_paygol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_paypal`
--

DROP TABLE IF EXISTS `znote_paypal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_paypal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `txn_id` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accid` int NOT NULL,
  `price` int NOT NULL,
  `points` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_paypal`
--

LOCK TABLES `znote_paypal` WRITE;
/*!40000 ALTER TABLE `znote_paypal` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_paypal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_player_reports`
--

DROP TABLE IF EXISTS `znote_player_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_player_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `posx` int NOT NULL,
  `posy` int NOT NULL,
  `posz` int NOT NULL,
  `report_description` varchar(255) NOT NULL,
  `date` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_player_reports`
--

LOCK TABLES `znote_player_reports` WRITE;
/*!40000 ALTER TABLE `znote_player_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_player_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_players`
--

DROP TABLE IF EXISTS `znote_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `created` int NOT NULL,
  `hide_char` tinyint NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2986 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_players`
--

LOCK TABLES `znote_players` WRITE;
/*!40000 ALTER TABLE `znote_players` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_shop`
--

DROP TABLE IF EXISTS `znote_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `itemid` int DEFAULT NULL,
  `count` int NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL,
  `points` int NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_shop`
--

LOCK TABLES `znote_shop` WRITE;
/*!40000 ALTER TABLE `znote_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_shop_logs`
--

DROP TABLE IF EXISTS `znote_shop_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_shop_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `player_id` int NOT NULL,
  `type` int NOT NULL,
  `itemid` int NOT NULL,
  `count` int NOT NULL,
  `points` int NOT NULL,
  `time` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_shop_logs`
--

LOCK TABLES `znote_shop_logs` WRITE;
/*!40000 ALTER TABLE `znote_shop_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_shop_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_shop_orders`
--

DROP TABLE IF EXISTS `znote_shop_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_shop_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `type` int NOT NULL,
  `itemid` int NOT NULL,
  `count` int NOT NULL,
  `time` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_shop_orders`
--

LOCK TABLES `znote_shop_orders` WRITE;
/*!40000 ALTER TABLE `znote_shop_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_shop_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_tickets`
--

DROP TABLE IF EXISTS `znote_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` int NOT NULL,
  `username` varchar(32) NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `ip` bigint NOT NULL,
  `creation` int NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_tickets`
--

LOCK TABLES `znote_tickets` WRITE;
/*!40000 ALTER TABLE `znote_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_tickets_replies`
--

DROP TABLE IF EXISTS `znote_tickets_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_tickets_replies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tid` int NOT NULL,
  `username` varchar(32) NOT NULL,
  `message` text NOT NULL,
  `created` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_tickets_replies`
--

LOCK TABLES `znote_tickets_replies` WRITE;
/*!40000 ALTER TABLE `znote_tickets_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_tickets_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_visitors`
--

DROP TABLE IF EXISTS `znote_visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_visitors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` int NOT NULL,
  `value` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_visitors`
--

LOCK TABLES `znote_visitors` WRITE;
/*!40000 ALTER TABLE `znote_visitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_visitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `znote_visitors_details`
--

DROP TABLE IF EXISTS `znote_visitors_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `znote_visitors_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` int NOT NULL,
  `time` int NOT NULL,
  `type` tinyint NOT NULL,
  `account_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znote_visitors_details`
--

LOCK TABLES `znote_visitors_details` WRITE;
/*!40000 ALTER TABLE `znote_visitors_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `znote_visitors_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-17 20:28:04
