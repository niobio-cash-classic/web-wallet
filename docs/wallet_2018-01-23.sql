# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: wallet
# Generation Time: 2018-01-23 18:43:40 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(95) NOT NULL,
  `viewkey_hash` char(64) NOT NULL,
  `scanned_block_height` int(10) unsigned NOT NULL DEFAULT '0',
  `scanned_block_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_height` int(10) unsigned NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table inputs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `inputs`;

CREATE TABLE `inputs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL,
  `tx_id` bigint(20) unsigned NOT NULL,
  `output_id` bigint(20) unsigned NOT NULL,
  `key_image` varchar(64) NOT NULL DEFAULT '',
  `amount` bigint(20) unsigned zerofill NOT NULL DEFAULT '00000000000000000000',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `account_id2` (`account_id`),
  KEY `tx_id2` (`tx_id`),
  KEY `output_id2` (`output_id`),
  CONSTRAINT `account_id3_FK2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `outputs_id_FK2` FOREIGN KEY (`output_id`) REFERENCES `outputs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_id_FK2` FOREIGN KEY (`tx_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table outputs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `outputs`;

CREATE TABLE `outputs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL,
  `tx_id` bigint(20) unsigned NOT NULL,
  `out_pub_key` varchar(64) NOT NULL,
  `rct_outpk` varchar(64) NOT NULL DEFAULT '',
  `rct_mask` varchar(64) NOT NULL DEFAULT '',
  `rct_amount` varchar(64) NOT NULL DEFAULT '',
  `tx_pub_key` varchar(64) NOT NULL DEFAULT '',
  `amount` bigint(20) unsigned NOT NULL DEFAULT '0',
  `global_index` bigint(20) unsigned NOT NULL,
  `out_index` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mixin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_2` (`account_id`,`out_pub_key`),
  KEY `account_id` (`account_id`),
  KEY `tx_id` (`tx_id`),
  CONSTRAINT `account_id3_FK` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_id_FK` FOREIGN KEY (`tx_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(95) NOT NULL,
  `payment_id` varchar(64) NOT NULL,
  `tx_hash` varchar(64) NOT NULL DEFAULT '',
  `request_fulfilled` tinyint(1) NOT NULL DEFAULT '0',
  `payment_address` varchar(95) NOT NULL,
  `import_fee` bigint(20) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(64) NOT NULL,
  `prefix_hash` varchar(64) NOT NULL DEFAULT '',
  `tx_pub_key` varchar(64) NOT NULL DEFAULT '',
  `account_id` bigint(20) unsigned NOT NULL,
  `blockchain_tx_id` bigint(20) unsigned NOT NULL,
  `total_received` bigint(20) unsigned NOT NULL,
  `total_sent` bigint(20) unsigned NOT NULL,
  `unlock_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `height` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spendable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Has 10 blocks pasted since it was indexed?',
  `coinbase` tinyint(1) NOT NULL DEFAULT '0',
  `is_rct` tinyint(1) NOT NULL DEFAULT '1',
  `rct_type` int(4) NOT NULL DEFAULT '-1',
  `payment_id` varchar(64) NOT NULL DEFAULT '',
  `mixin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`,`account_id`),
  KEY `account_id_2` (`account_id`),
  CONSTRAINT `account_id_FK` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
