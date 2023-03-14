-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: appfooddb
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Do An','giam 50%'),(2,'Đồ uống',NULL),(3,'Combo',NULL),(4,'Khuyen mai','giam 74%');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_product_idx` (`product_id`),
  KEY `fk_comment_user_idx` (`user_id`),
  CONSTRAINT `fk_comment_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (10,'good',1,6,'2022-08-14 12:12:00'),(11,'nice',1,7,'2022-05-06 04:08:00'),(12,'bad',1,8,'2022-03-03 07:05:00'),(13,'hiuhi',1,6,'2022-08-24 17:10:58'),(14,'jklj',1,6,'2022-08-24 17:11:31'),(15,'j',1,6,'2022-08-24 17:35:15'),(16,'hhhhh',1,6,'2022-08-24 17:49:17'),(17,'bmn',1,6,'2022-08-24 18:15:06'),(18,'hi',1,6,'2022-08-24 21:27:12'),(19,'yehh',1,8,'2022-08-29 16:48:06'),(20,'hi',1,7,'2022-08-29 16:48:55'),(21,'jjjj',1,7,'2022-08-29 17:36:35'),(22,'hhhh',1,6,'2022-08-29 23:32:33'),(23,'jjjj',2,6,'2022-08-29 23:36:06'),(24,'jjjj',2,6,'2022-08-29 23:36:08'),(25,'jjjj',2,6,'2022-08-29 23:36:12'),(26,'jjjj',2,6,'2022-08-29 23:36:12'),(27,'jjjjj',1,6,'2022-08-29 23:36:31'),(28,'jjjjj',6,6,'2022-08-29 23:36:43'),(29,'jjjjj',6,6,'2022-08-29 23:36:44'),(30,'jjjjj',6,6,'2022-08-29 23:36:44'),(31,'jjjjj',6,6,'2022-08-29 23:36:44'),(32,'jjjjj',6,6,'2022-08-29 23:36:45'),(33,'jjjjj',6,6,'2022-08-29 23:36:45'),(34,'jjjjj',6,6,'2022-08-29 23:36:45'),(35,'gôd',16,6,'2022-08-29 23:37:06'),(36,'hay',16,6,'2022-08-29 23:38:34'),(37,'kkk',1,6,'2022-08-30 17:32:21'),(38,'hh',1,9,'2022-08-31 13:46:55'),(39,'hh',2,9,'2022-08-31 13:47:10'),(40,'yeh',4,9,'2022-08-31 13:47:28'),(41,'pp',2,9,'2022-08-31 13:47:52'),(42,'g',1,15,'2022-09-02 16:31:53'),(43,'g',1,15,'2022-09-02 16:44:38'),(44,'j',1,6,'2022-09-03 17:01:01'),(45,'j',1,6,'2022-09-03 17:01:02'),(46,'jjj',2,6,'2022-09-03 17:06:07'),(47,'jjj',2,6,'2022-09-03 17:06:09'),(48,'com',1,18,'2022-09-09 11:39:56'),(49,'com',1,18,'2022-09-09 11:39:57'),(50,'com',1,18,'2022-09-09 11:39:59'),(51,'com',1,18,'2022-09-09 11:39:59'),(52,'com',1,18,'2022-09-09 11:39:59'),(53,'com',1,18,'2022-09-09 11:39:59'),(54,'com',1,18,'2022-09-09 11:39:59'),(55,'com',1,18,'2022-09-09 11:39:59'),(56,'com',1,18,'2022-09-09 11:40:00'),(57,'com',1,18,'2022-09-09 11:40:00'),(58,'com',1,18,'2022-09-09 11:40:00'),(59,'com',1,18,'2022-09-09 11:40:01'),(60,'com',1,18,'2022-09-09 11:40:01'),(61,'com',1,18,'2022-09-09 11:40:01'),(62,'com',1,18,'2022-09-09 11:40:01'),(63,'hh',2,18,'2022-09-09 11:40:12'),(64,'jjjj',1,18,'2022-09-09 11:40:24'),(65,'jjjj',1,18,'2022-09-09 11:40:25'),(66,'hello',2,18,'2022-09-09 11:40:37'),(67,'hhi',3,18,'2022-09-09 11:40:50'),(68,'hhi',3,18,'2022-09-09 11:40:51'),(69,'hhi',3,18,'2022-09-09 11:40:52'),(70,'hhi',3,18,'2022-09-09 11:40:54'),(71,'jjj',4,18,'2022-09-09 11:41:06'),(72,'hhhh',54,18,'2022-09-09 11:44:17'),(73,'hhhh',54,18,'2022-09-09 11:44:18'),(74,'hhhh',54,18,'2022-09-09 11:44:19'),(75,'hhhh',54,18,'2022-09-09 11:44:19'),(76,'hhhh',54,18,'2022-09-09 11:44:19'),(77,'hhhh',54,18,'2022-09-09 11:44:19'),(78,'hhhh',54,18,'2022-09-09 11:44:21'),(79,'hhhh',54,18,'2022-09-09 11:44:21'),(80,'hhhh',54,18,'2022-09-09 11:44:21'),(81,'jjj',42,18,'2022-09-09 11:45:04'),(82,'jjj',42,18,'2022-09-09 11:45:05'),(83,'jjj',42,18,'2022-09-09 11:45:06'),(84,'hio',3,18,'2022-09-30 15:16:20'),(85,'hay',3,6,'2022-10-07 09:59:26'),(86,'hay 6',3,6,'2022-10-07 09:59:37'),(87,'good',2,6,'2022-10-07 11:53:42'),(88,'hh',2,18,'2022-10-19 14:12:40'),(89,'hh',41,18,'2022-10-19 14:13:02'),(90,'jj',41,18,'2022-10-19 14:13:12'),(91,'hayyyyy',2,18,'2022-10-20 01:19:45'),(92,'hay',66,20,'2022-10-21 17:29:59'),(93,'good',62,20,'2022-10-21 17:31:05'),(94,'hayyy',6,20,'2022-10-21 17:31:44'),(95,'hayyy',6,20,'2022-10-21 17:31:46'),(96,'hayyy',4,20,'2022-10-21 17:32:39'),(97,'good',37,20,'2022-10-21 17:32:54'),(98,'good',37,20,'2022-10-21 17:32:56'),(99,'good',37,20,'2022-10-21 17:32:57'),(100,'good',37,20,'2022-10-21 17:32:57'),(101,'ngon',3,20,'2022-10-21 17:33:12'),(102,'ngon',3,20,'2022-10-21 17:33:23'),(103,'ngon',3,20,'2022-10-21 17:33:24'),(104,'ngon',25,18,'2022-10-21 17:34:19'),(105,'ngon',25,18,'2022-10-21 17:34:21'),(106,'ngon',46,18,'2022-10-21 17:37:25'),(107,'ngon quá',66,9,'2022-10-25 12:46:07'),(108,'hay',66,9,'2022-10-25 12:46:18'),(109,'hay',66,9,'2022-10-25 12:46:20'),(110,'hhh',66,9,'2022-10-25 12:46:38'),(111,'hhh',66,9,'2022-10-25 12:46:39'),(112,'hhh',66,9,'2022-10-25 12:46:39'),(113,'hhh',66,9,'2022-10-25 12:46:39'),(114,'hhh',66,9,'2022-10-25 12:46:39'),(115,'hhhjjfj',45,9,'2022-10-25 12:47:02'),(116,'hhhjjfj',45,9,'2022-10-25 12:47:02'),(117,'hhhjjfj',45,9,'2022-10-25 12:47:03'),(118,'hhhjjfj',45,9,'2022-10-25 12:47:03'),(119,'hhhjjfj',45,9,'2022-10-25 12:47:03'),(120,'hhhjjfj',45,9,'2022-10-25 12:47:04'),(121,'hhhjjfj',45,9,'2022-10-25 12:47:04'),(122,'hhhjjfj',45,9,'2022-10-25 12:47:04'),(123,'hhhh',1,9,'2022-10-25 12:47:19'),(124,'hhhh',1,9,'2022-10-25 12:47:19'),(125,'hhhh',1,9,'2022-10-25 12:47:19'),(126,'hhhh',1,9,'2022-10-25 12:47:19'),(127,'hhhh',1,9,'2022-10-25 12:47:20'),(128,'hhhh',1,9,'2022-10-25 12:47:20'),(129,'hhhh',1,9,'2022-10-25 12:47:20'),(130,'hhhh',1,9,'2022-10-25 12:47:21'),(131,'hhhh',1,9,'2022-10-25 12:47:21'),(132,'hhhh',1,9,'2022-10-25 12:47:21'),(133,'hhhh',1,9,'2022-10-25 12:47:22'),(134,'hhhh',1,9,'2022-10-25 12:47:22'),(135,'hhhh',1,9,'2022-10-25 12:47:22'),(136,'hhhh',1,9,'2022-10-25 12:47:23'),(137,'hh',63,18,'2022-10-25 12:55:09'),(138,'hh',63,18,'2022-10-25 12:55:10'),(139,'hh',63,18,'2022-10-25 12:55:11'),(140,'hh',63,18,'2022-10-25 12:55:11'),(141,'hh',63,18,'2022-10-25 12:55:12'),(142,'hh',63,18,'2022-10-25 12:55:12'),(143,'hh',63,18,'2022-10-25 12:55:13'),(144,'hh',63,18,'2022-10-25 12:55:13'),(145,'hh',63,18,'2022-10-25 12:55:13'),(146,'hh',63,18,'2022-10-25 12:55:13'),(147,'hh',63,18,'2022-10-25 12:55:13'),(148,'hh',63,18,'2022-10-25 12:55:13'),(149,'hh',63,18,'2022-10-25 12:55:14'),(150,'hh',63,18,'2022-10-25 12:55:14'),(151,'hh',63,18,'2022-10-25 12:55:14'),(152,'hh',63,18,'2022-10-25 12:55:14'),(153,'hh',63,18,'2022-10-25 12:55:14'),(154,'hh',63,18,'2022-10-25 12:55:16'),(155,'hh',63,18,'2022-10-25 12:55:16'),(156,'hh',63,18,'2022-10-25 12:55:16'),(157,'ngon quá',39,18,'2022-10-25 12:57:55'),(158,'đẹp',39,18,'2022-10-25 12:58:08'),(159,'ngon quá',66,18,'2022-10-25 13:00:53'),(160,'ngon quá',66,18,'2022-10-25 13:01:02'),(161,'ngon quá',66,18,'2022-10-25 13:01:02'),(162,'hhh',80,18,'2022-11-03 10:14:29');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` decimal(10,0) DEFAULT '0',
  `num` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_ORDERDETAIL_ORDER_idx` (`order_id`),
  KEY `FK_ORDERDETAIL_PRODUCT_idx` (`product_id`),
  CONSTRAINT `FK_ORDERDETAIL_ORDER` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`),
  CONSTRAINT `FK_ORDERDETAIL_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (5,4,1,12500000,1),(6,4,2,21000000,1),(7,4,3,17000000,1),(8,5,1,12500000,1),(9,5,3,17000000,1),(10,5,7,10540000,1),(11,6,2,21000000,1),(12,7,5,18600000,1),(13,7,6,12990000,3),(14,8,1,12500000,1),(15,8,2,21000000,2),(16,8,3,17000000,1),(17,9,1,12500000,1),(18,9,2,21000000,2),(19,10,4,28000000,1),(20,10,5,18600000,5),(21,11,1,12500000,2),(22,11,2,21000000,2),(23,11,3,17000000,1),(24,13,2,0,0),(25,13,1,0,0),(26,20,1,35000,1),(27,20,2,21000,2),(28,21,1,35000,1),(29,21,3,30000,1),(30,22,1,35000,1),(31,22,2,21000,4),(32,23,3,30000,6),(33,23,4,45000,1),(34,24,2,21000,3),(35,25,1,35000,2),(36,25,2,21000,1),(37,26,1,35000,3),(38,27,1,35000,2),(39,28,2,21000,1),(40,29,1,35000,1),(41,29,2,21000,3),(42,30,2,21000,3),(43,31,39,300000,3),(44,32,1,35000,3),(45,32,7,9000,1),(46,33,2,21000,2),(47,33,6,25000,1),(48,34,42,39888,5),(49,35,16,70000,2);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT '0',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `category_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PRODUCE_CATEGORY_idx` (`category_id`),
  KEY `fk_product_user_idx` (`user_id`),
  CONSTRAINT `FK_PRODUCE_CATEGORY` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_product_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Rượu soju vị đào','Rượu soju vị đào',35000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667464865/j8w8t0sotcxafnplv03p.jpg','2022-10-03 15:41:06',_binary '',1,21),(2,'Vang đỏ chile','Vang đỏ chile',21000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465320/iwtpw7xbqwcydtuqxxa4.jpg','2022-11-03 15:48:40',_binary '',1,19),(3,'Rượu soju truyền thống','Rượu soju truyền thống',30000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465258/wn0opxf9qpewau9853tn.jpg','2022-10-03 15:47:38',_binary '',1,21),(4,'Rượu soju vị việt quất','Rượu soju vị việt quất',45000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667464949/k5koco5zcmzrek3zbpwj.jpg','2022-10-03 15:42:30',_binary '',1,21),(5,'Vang chile veo','Vang chile veo',10000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465084/pyp8dbphvgisiwyo4ihe.jpg','2022-09-03 15:43:29',_binary '',2,20),(6,'Vang chile punti','Vang chile punti',25000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667464912/nu6yywwbqoeueu6ekeyx.jpg','2022-09-03 15:41:52',_binary '',2,21),(7,'Vang pháp chateau','Vang pháp chateau',90500,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465867/y99pzzehsmrsqamp15eo.jpg','2022-08-03 15:57:48',_binary '',1,21),(16,'Rươu Soju hoa quả','Rươu Soju hoa quả',70000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667464750/juxryzfcvl9deun6plbz.jpg','2022-11-03 15:39:11',_binary '',3,21),(25,'Vang Chile casa','Vang Chile casa',77000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667464804/alclfugqgqlbfvkcyftp.jpg','2022-11-03 15:40:04',_binary '\0',1,21),(30,'Vang Australia','Vang Australia',20000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465770/m6juntq82uheqixbikgp.jpg','2022-11-03 15:56:10',_binary '\0',1,21),(31,'Vang Chile casadonoso','Vang Chile casadonoso',20000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465370/pwwzesoeela80tq41zui.jpg','2022-11-03 15:49:31',_binary '\0',1,21),(36,'Vang đỏ nam phi','Vang đỏ nam phi',300000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465543/copmg5rxxxmbzp8zz4mm.jpg','2022-11-03 15:52:23',_binary '\0',2,21),(37,'Vang đỏ Collexione','Vang đỏ Collexione',300000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465689/dpegfj4sdxu1m7b7u9ix.jpg','2022-11-03 15:54:50',_binary '\0',2,21),(38,'Vang notte','Vang notte',300000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465730/pypp0hln3bqy1qtercjo.jpg','2022-11-03 15:55:31',_binary '\0',1,21),(39,'Vang nam phi','Vang nam phi',300000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465505/bpfeb3qo3cq2lcpdhkqr.jpg','2022-11-03 15:51:45',_binary '\0',1,21),(41,'Vang đỏ italia','Vang đỏ italia',300000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465580/xsvtcvcuduo92wxcptqe.jpg','2022-11-03 15:53:01',_binary '\0',1,21),(42,'Cá trứng','Cá trứng',39888,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667463090/vwhzrsxqainqxnkjxkv5.jpg','2022-11-03 15:11:31',_binary '\0',4,20),(44,'Vang đỏ Malvasia','Vang đỏ Malvasia',347982,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465635/woa7g2lotkz5dqgkrp2r.jpg','2022-11-03 15:53:56',_binary '\0',3,21),(45,'Vang đỏ pháp crosus','Vang đỏ pháp crosus',347982,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465635/woa7g2lotkz5dqgkrp2r.jpg','2022-11-03 16:47:46',_binary '',1,20),(46,'Vang đỏ tây ban nha','Vang đỏ tây ban nha',47658,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667465459/klpfpiz07vwmlhyahufg.jpg','2022-11-03 15:51:00',_binary '\0',1,19),(47,'Combo nướng thượng hạng','Combo nướng thượng hạng',47658,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667463675/iww7mqfsno2vyok9yqlv.jpg','2022-11-03 15:21:15',_binary '\0',1,19),(53,'Combo heo nướng','Combo heo nướng',34554,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667463477/fo6k02pod2e8xxucjtkr.jpg','2022-11-03 15:17:58',_binary '\0',2,21),(54,'Combo nướng 2','Combo nướng 2',23891,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667463428/v1yngxozopiqvlhuxzab.jpg','2022-11-03 15:17:08',_binary '\0',1,19),(55,'Combo nướng 1','Combo nướng 1',34554,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667463396/iseuaqdcoagkeluwhnxd.jpg','2022-11-03 15:16:37',_binary '\0',1,20),(59,'Lươn nướng','Lươn nướng',89999,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462898/gfaa2q4hy8lfzp2qqr0c.jpg','2022-11-03 15:08:19',_binary '\0',3,21),(61,'Trứng cá hồi loại 3','Trứng cá hồi loại 3',30299,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462826/t2jxfduqqsvq4vgxya1x.jpg','2022-11-03 15:07:07',_binary '',2,20),(62,'Trứng cá hồi loại 2','Trứng cá hồi loại 2',48299,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462775/x4qnujh9kycy71y1w6u6.jpg','2022-11-03 15:06:16',_binary '',2,20),(63,'Trứng cá hồi loại 1','Trứng cá hồi loại 1',34000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462745/ljq41jxoac5v1aynwmi5.jpg','2022-11-03 15:05:45',_binary '\0',4,21),(66,'Thanh cua','Thanh cua',56009,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462428/d9etcn2dcofh1gibneou.jpg','2022-11-03 15:00:28',_binary '',1,20),(74,'Hàu sữa','Hàu sữa',12000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462198/npat4n9mwrzpzdkpjviy.jpg','2022-11-03 14:56:39',_binary '\0',1,20),(75,'Cồi điệp','Cồi điệp',12000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462139/au0ulyrpe7qffeis1p4y.jpg','2022-11-03 14:55:40',_binary '',1,20),(76,'Sò đỏ','Sò đỏ',12000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667462052/yplieeitr4qrzvfs1xrl.jpg','2022-11-03 14:54:13',_binary '\0',1,20),(77,'Cá cam','cá cam',12000,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667461999/emv5adqu90it8unsneji.jpg','2022-11-03 14:53:20',_binary '\0',1,20),(79,'Bạch tuộc','bạch tuộc nhật bản',29999,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667461939/itpfnlifppwnkpdzxbaz.jpg','2022-11-03 14:52:20',_binary '\0',1,20),(80,'cá basa','ngâm giấm',48299,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667461573/pddm1dbati0ufbaunnnq.jpg','2022-11-03 14:46:12',_binary '',1,20),(81,'cá trích ép trứng','cá trích',23455,'https://res.cloudinary.com/dtswvj7fd/image/upload/v1667461217/neqakgcgnzk7mztebfk0.jpg','2022-11-03 14:40:17',_binary '',1,21);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci,
  `location` longtext COLLATE utf8mb4_unicode_520_ci,
  `contact` longtext COLLATE utf8mb4_unicode_520_ci,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_restaurant_user_idx` (`user_id`),
  CONSTRAINT `fk_restaurant_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'nha hang chay','quan chay','tpHCM','9090',6),(2,'buffe','buffe 99K','Ha noi','1809',19),(3,'coffe 3','coffee 1','da nang 1','4001',20),(4,'highhha','lau','tpHCM','8003',21);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_order`
--

DROP TABLE IF EXISTS `sale_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,0) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `active` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_ORDER_USER_idx` (`user_id`),
  CONSTRAINT `FK_ORDER_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_order`
--

LOCK TABLES `sale_order` WRITE;
/*!40000 ALTER TABLE `sale_order` DISABLE KEYS */;
INSERT INTO `sale_order` VALUES (4,50500000,'2020-02-03 00:00:00',7,1),(5,40040000,'2020-02-03 00:00:00',7,1),(6,21000000,'2020-02-03 00:00:00',7,1),(7,57570000,'2020-02-04 00:00:00',7,1),(8,71500000,'2020-07-05 00:00:00',6,1),(9,54500000,'2020-02-05 00:00:00',7,1),(10,121000000,'2020-12-07 00:00:00',6,1),(11,84000000,'2020-12-07 00:00:00',8,1),(12,100,'2020-11-17 18:43:31',NULL,1),(13,100,'2020-11-17 18:48:11',NULL,1),(20,77000,'2022-09-01 11:54:27',6,1),(21,65000,'2022-09-01 12:03:44',6,1),(22,119000,'2022-09-01 12:04:44',9,1),(23,225000,'2022-09-01 18:56:07',9,1),(24,63000,'2022-09-02 11:23:01',12,1),(25,91000,'2022-09-03 17:05:55',6,1),(26,105000,'2022-09-04 02:29:16',20,1),(27,70000,'2022-09-08 19:52:35',19,1),(28,21000,'2022-09-09 11:39:13',18,1),(29,98000,'2022-09-27 14:29:10',18,1),(30,63000,'2022-09-28 14:39:54',18,0),(31,900000,'2022-09-30 16:23:01',18,1),(32,114000,'2022-10-01 18:04:48',18,1),(33,67000,'2022-10-19 14:12:12',18,0),(34,199440,'2022-10-25 10:45:19',18,1),(35,164000,'2022-10-25 10:51:38',20,1);
/*!40000 ALTER TABLE `sale_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `active` tinyint DEFAULT '0',
  `user_role` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `avatar` varchar(300) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6,'Admin','Admin','Admin@gmail.com','0289808827','admin','$2a$10$kteSYJWsRfou8VUGBqZAjOGdLPcMRfgqJmsoqKzN/OD6AG2m2jnY6',1,'ROLE_ADMIN','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529673/kc7ytfb9ke1dwxodh6i0.png'),(7,'Son','Tran','son@gmail.com','0471389782','transon','$2a$10$QyZXNQbgZ0gIGKKxJCPxbu34OIYsBGY0QRwOWI6YbGeFlil/Nu9na',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530085/f3r6jklznsxbtlytrlja.png'),(8,'Tuan','truong','tuan@gmail.com','0827637677','tuantruong','$2a$10$S//4KyTH9fKr8QeVrwsQNumYD.dSssCEMu6SWRWEfwYXLMp23dJsG',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530051/u2rjypl3khaibodd0bth.png'),(9,'Thien','phan','phannhatthien10a8@gmail.com','0863726776','thienthien','$2a$10$u3bsgL259K6mhq7TVhkSWOac7R3YhWBkrZtjIbp2J8JwOLWU2.nrK',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530009/tv5npmwmdxavkqudr0j0.png'),(10,'The','nguyen','the@gmail.com','1772637323','thethe','$2a$10$fD2uUWqohAWLO/i5ByegTurqty/tDg353dI9dil2b7Em2RTYPV2y6',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529973/t3hijodfqdwy41inakrw.png'),(11,'The','nguyen','the123@gmail.com','0471389782','the123','$2a$10$SYEU99eWn6wqnIQUT8vwYu5SPzHbBsds51oAtaNyU9FPmyrX3n5x2',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529938/ijkb1rotdhhkzf7zivlr.png'),(12,'Dat','truong','phannhatthien10a8@gmail.com','0827637677','datdat','$2a$10$H5vdUn98zXW/TPvVHIEFF.fecj.RnSrc8TJlhgHDv5M1vNksdxZAS',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529900/tvt2zcbzryla15phxhtf.png'),(13,'Toan','tran','toan@gmail.com','0471389782','trantoan','$2a$10$okhRS1.cnjzAbOfRtHVOK.yZjRJqnVl4jpKhuxns/qVyHdXiMdjSe',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529862/iznduc7dked5j2pe5opr.png'),(14,'Hoang','le','hoang@gmail.com','0471389782','hoanghoang','$2a$10$t9fUQt0wgmdX5LLxH1s3x.pu7ny3N03hdDYK2/XOTeCJsK9TwTXoW',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529808/n6cs1hvxaourgfkavm6q.png'),(15,'Hai','phan','the@gmail.com','0827637677','haihai','$2a$10$J3Gni5MpxdYw9FIf1gn0zO7zjuFFV3NZNTVoaXf0BrdaivR2I3PEu',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529762/sgorrmrlzjnseq3zn2n5.png'),(16,'Sy','van','phannhatthien10a8@gmail.com','0471389782','vansy','$2a$10$FTqV9dVt428cxsMUXNm8q.x12fA0C5EZP.lJUqRwX0XUPhzMz9I0K',1,'ROLE_NH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667529725/e4efxnm2ptxkxnr2lzoc.png'),(17,'Lam','le','lam@gmail.com','0827637677','lelam','$2a$10$d7hyk.OeHNJFNFWiM8cOE.yVGGgeQib9TXEchNp6p/W0DhZ371zqa',1,'ROLE_NH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530387/gjoji0rxmlj56paqgspc.jpg'),(18,'Hung','tran','hung@gmail.com','0471389782','tranhung','$2a$10$qwRn9xneB2WuG.5AY5pIU.0eB6rjxOKso995P.mkXYQi.R0v8KzMq',1,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530419/duk84erzdxew9zyxpf64.png'),(19,'Bao','van','bao@gmail.com','0827637677','vanbao','$2a$10$qeoFad33bUeinjyIP4LsM.8AXb5kqdVd.e.a4qF8fGoxpkS53ldiy',1,'ROLE_NH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530456/tcwoswd92tzedqjqd7ey.jpg'),(20,'Myhh','le','my@gmail.com','0827637677','lemy','$2a$10$ZJyAFMvrLa911rChstimuesnDiRz6ebZZE5VgYY6rE7VUOJlJ5C/a',1,'ROLE_NH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530483/zhjiesmehrocnqfq4idv.png'),(21,'Thien','Nhat','thien@gmail.com','9890809900','nhatthien','$2a$10$FBa9Hd3E1Byx5RXBM4utb.ycCAWCVAmvuPDAwEbk/NOikp3ocYGBq',1,'ROLE_NH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530521/lw5mcffoiqh1o4yoqp7v.png'),(25,'Meo Con','meo','meo@gmail.com','0827637677','meomeo','$2a$10$ENTsWtHTA4UAONSFJ93qmetoOQ3PnWjqGz/8Mc5YW2aJzteHKMiNy',0,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530611/ja9l3xdo97le1tjm3f7t.png'),(34,'Thuy123','hu','meo@gmail.com','08723987898','thuyhu','$2a$10$KuO7unfy.5cicuTcks3.4OrGHta1J5y.5Ax5pc7HptXLt3F2orLu6',0,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530725/bgg3fddjokarxv8mzkgd.png'),(38,'Hai','jkjk','hai@gmail.com','08723987898','hai123','$2a$10$RZkUSkEx33CuPlKe/zpXB.16WEMR9tV01VEhhn2aGHbTQssiE31.K',0,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530755/acfp8upafdeecj474l6z.png'),(39,'Huy Nam','huy','thien@gmail.com','0938888837','huynam','$2a$10$NyQ11Btw3/B5IzHds3vf3u.jAthEV3iV9mYic5NNhzgqh0Z5ipBTG',0,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667530836/sauimbpbbsfslyek4abw.jpg'),(40,'Haihai','hayhay','thien@gmail.com','089387283','phancam','$2a$10$4nSjTgMgQFcU42BLt0iRleJFhOe.tnqL96VcD/SdbTD5EhRIL.yM2',0,'ROLE_KH','https://res.cloudinary.com/dtswvj7fd/image/upload/v1667528971/fqxqsipt1xwcyxjmy65r.png');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-04 23:25:31
