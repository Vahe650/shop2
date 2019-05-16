/*
SQLyog Ultimate v11.5 (32 bit)
MySQL - 5.7.18-log : Database - shop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE `shop`;

/*Table structure for table `atribute_value` */

DROP TABLE IF EXISTS `atribute_value`;

CREATE TABLE `atribute_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  `atributes_id` int(11) NOT NULL,
  KEY `id` (`id`),
  KEY `post_id` (`post_id`),
  KEY `atribute_value_ibfk_2` (`atributes_id`),
  CONSTRAINT `atribute_value_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `atribute_value_ibfk_2` FOREIGN KEY (`atributes_id`) REFERENCES `atributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;

/*Data for the table `atribute_value` */



/*Table structure for table `atributes` */

DROP TABLE IF EXISTS `atributes`;

CREATE TABLE `atributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `atributes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

/*Data for the table `atributes` */

insert  into `atributes`(`id`,`name`,`category_id`) values (42,'pol',45),(43,'krish',45),(44,'lusamut',45),(45,'sanhanguyc',45),(46,'kafel',45),(47,'meqena',45),(48,'zal',45),(49,'kalos',49),(50,'harker',50),(51,'varker',50),(52,'marker',50),(53,'akkumlyator',52),(54,'zaryadchnik',52),(55,'chxol',52),(56,'ekran',53),(57,'pult',53),(58,'gin',56),(59,'hamar',56),(60,'senyak',56),(61,'taq jur',56),(62,'7texani',57),(63,'blblac',60),(64,'qar',66),(65,'tesak',68),(66,'tariq',69),(67,'taretiv',71);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`name`,`parent_id`) values (44,'ansharj guyq',0),(45,'tun',44),(47,'shenq',44),(48,'transport',0),(49,'avto',48),(50,'visotni',44),(51,'Texnika',0),(52,'Heraqxosner',51),(53,'herustacuyc',51),(56,'Hyuranoc',44),(57,'Avtobus',48),(60,'shinutyun',44),(66,'kisaqand',44),(67,'kendaniner',0),(68,'trchunner',67),(69,'shner',67),(70,'sermer ev buyser',0),(71,'gyuxtexnika',48);

/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `region` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

/*Data for the table `country` */

insert  into `country`(`id`,`region`,`parent_id`) values (11,'Shirak',0),(12,'Gyumri',11),(13,'artik',11),(14,'lori',0),(15,'vanadzor',14),(16,'alaverdi',14),(38,'Tavush',0),(39,'Ijevan',38),(40,'Dilijan',38),(41,'Aragacotn',0),(42,'Ashtarak',41),(43,'Aparan',41),(44,'Talin',41),(45,'Kotayq',0),(46,'Abovyan',45),(47,'Hrazdan',45),(48,'Gexarquniq',0),(49,'Sevan',48),(50,'Gavar',48),(51,'Vayoc Dzor',0),(52,'Exegnadzor',51),(53,'Vayq',51),(54,'Syuniq',0),(55,'Sisian',54),(56,'Kapan',55),(57,'Goris',54),(60,'brnakot',54),(62,'Maralik',11);

/*Table structure for table `flyway_schema_history` */



DROP TABLE IF EXISTS `picture`;

CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic_pat` varchar(255) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=458 DEFAULT CHARSET=utf8;

/*Data for the table `picture` */

insert  into `picture`(`id`,`pic_pat`,`post_id`) values (454,'1555262185487_1522507676967_blog-4 - Copy.jpg',51),(455,'1555262185534_1522507676967_blog-4.jpg',51),(456,'1555262185549_1522508440987_blog - Copy.jpg',51),(457,'1555262185580_1522508440987_blog.jpg',51);

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `view` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `post_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
  CONSTRAINT `post_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `post` */

insert  into `post`(`id`,`title`,`description`,`price`,`timestamp`,`user_id`,`category_id`,`country_id`,`view`) values (51,'om','ail.com',60000,'2019-04-14 21:17:02',87,53,39,1);

/*Table structure for table `post_picture` */

DROP TABLE IF EXISTS `post_picture`;

CREATE TABLE `post_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic_pat` varchar(255) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `post_picture_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `post_picture` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_pic_pat` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `tel_1` varchar(255) DEFAULT NULL,
  `tel_2` varchar(255) DEFAULT NULL,
  `type` enum('USER','ADMIN','FB_USER') NOT NULL DEFAULT 'USER',
  `gender` enum('MALE','FEMALE') NOT NULL DEFAULT 'MALE',
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `token` varchar(255) DEFAULT NULL,
  `verify` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_pic_id` (`user_pic_pat`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

/*Data for the table `user` */


/*Table structure for table `userconnection` */

create table UserConnection (userId varchar(255) not null,
	providerId varchar(255) not null,
	providerUserId varchar(255),
	rank int not null,
	displayName varchar(255),
	profileUrl varchar(512),
	imageUrl varchar(512),
	accessToken varchar(512) not null,
	secret varchar(512),
	refreshToken varchar(512),
	expireTime bigint,
	primary key (userId, providerId, providerUserId));
create unique index UserConnectionRank on UserConnection(userId, providerId, rank);

/*Data for the table `userconnection` */



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
