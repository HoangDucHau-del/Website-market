CREATE DATABASE  IF NOT EXISTS `db_smarket` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_smarket`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_smarket
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `tb_category`
--

DROP TABLE IF EXISTS `tb_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_category`
--

LOCK TABLES `tb_category` WRITE;
/*!40000 ALTER TABLE `tb_category` DISABLE KEYS */;
INSERT INTO `tb_category` VALUES (1000,'Xe cộ'),(1001,'Xe máy'),(1002,'Xe đạp'),(1003,'Đồ điện tử'),(1004,'Điện thoại, laptop'),(1005,'Phụ kiện điện tử'),(1006,'Đồ dùng học tập'),(1007,'Bàn, ghế'),(1008,'Đèn học'),(1009,'Đồ gia dụng'),(1010,'Đồ trang trí'),(1011,'Thời trang');
/*!40000 ALTER TABLE `tb_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_favorite`
--

DROP TABLE IF EXISTS `tb_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_favorite` (
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`user_id`),
  KEY `fk_fv_u` (`user_id`),
  CONSTRAINT `fk_fv_p` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`),
  CONSTRAINT `fk_fv_u` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_favorite`
--

LOCK TABLES `tb_favorite` WRITE;
/*!40000 ALTER TABLE `tb_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order`
--

DROP TABLE IF EXISTS `tb_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_order` (
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `state` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'đang xử lý',
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `fk_order_p` (`product_id`),
  CONSTRAINT `fk_order_p` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`),
  CONSTRAINT `fk_order_u` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order`
--

LOCK TABLES `tb_order` WRITE;
/*!40000 ALTER TABLE `tb_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_product`
--

DROP TABLE IF EXISTS `tb_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `price` bigint NOT NULL,
  `description` text,
  `state` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'còn hàng',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `fk_product_u` (`user_id`),
  KEY `fk_product_ctg` (`category_id`),
  CONSTRAINT `fk_product_ctg` FOREIGN KEY (`category_id`) REFERENCES `tb_category` (`category_id`),
  CONSTRAINT `fk_product_u` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1060 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_product`
--

LOCK TABLES `tb_product` WRITE;
/*!40000 ALTER TABLE `tb_product` DISABLE KEYS */;
INSERT INTO `tb_product` VALUES (1018,1002,1000,'ádfasdf',2323232,'asdfasdf','còn hàng','2023-11-27 19:16:53',1),(1021,1002,1006,'hehe vippro',120000,'asdfdf','còn hàng','2023-11-27 19:27:40',1),(1022,1002,1003,'hehe memem',232322,'dfdfdfdfdf','còn hàng','2023-11-27 19:28:56',1),(1024,1002,1003,'hehe vippro',2323232,'sdfsdf','hết hàng','2023-12-08 02:11:47',1),(1043,1002,1008,'Bàn nhân viên chân sắt chữ U giá rẻ mã',400000,'Bàn nhân viên chân sắt chữ U giá rẻ mã UTP_1206 thuộc dòng sản phẩm bàn văn phòng, bàn học tập, bàn làm việc tai nhà được yêu thích nhất hiện nay. Mẫu bàn đơn giản, chắc chắn, có thể dễ dàng tháo lắp và vận chuyển ','còn hàng','2024-01-05 01:34:46',0),(1044,1002,1007,'Bàn Học Gấp Gọn Ngồi Bệt Kumo Làm Việc Thông Minh Để LapTop Có Ngăn Kéo',200000,'BÀN HỌC GẤP GỌN MINI\r\n\r\n\r\n\r\n1.THÔNG TIN SẢN PHẨM:\r\n\r\n-Bàn làm việc gập gọn thuận tiện để tận hưởng cuộc sống\r\n\r\n-Mặt bàn gấp mini di động tiết kiệm không gian chất lượng cao chịu lực tốt, thiết kế tinh tế và mặt bàn mịn dầy dặn\r\n\r\n-Để được máy tình để bàn lớn\r\n\r\n-Có thể điều chỉnh góc nhìn thuận tiện\r\n\r\n-Thiết kế bàn học mini đa năng \r\n\r\n-Cấu trúc chắc chắn ổn định\r\n\r\n-Thiết kế bàn học tích hợp cổng sạc usb tiện ích phù hợp với thói quen sử dụng, trải nghiệm cảm giác thoải mái khi làm việc\r\n\r\n-Mặt bàn có kích thước 58*38Cm\r\n\r\n-Chứa được nhiều đồ và không gian làm việc lớn\r\n\r\n-Thiết kế bàn gấp mini di động tiết kiệm không gian gọn, nhẹ dễ dàng điều chỉnh góc độ cao phù hợp với tư thế ngồi\r\n\r\n-Chân bàn học mini đa năng dạng trượt, bàn có thể đẩy ra kéo vào thoải mái mà không cần nhấc bàn lên, dễ dàng di chuyển\r\n\r\n+ Bản Pro Kèm Giá Sách + Giá Đỡ Điện Thoại + Ngăn Kéo \r\n\r\n+ Bản Pro Max kết nối nguồn điện qua dây usb 1.5m Kèm Giá Sách + Giá Đỡ Điện Thoại + Ngăn Kéo + Sạc không dây cho điện thoại + Cổng sạc Usb + Đèn học ','còn hàng','2024-01-05 01:38:07',0),(1045,1002,1004,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1',2500000,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1\r\n\r\n\r\n️ Đã có Android 11 Quốc Tế đầy đủ Tiếng Việt.\r\n------\r\n️  Máy new mới 100% Fullbox tặng kèm cường lực, bao da.\r\n️  Bảo hành 6 tháng mọi lỗi, bao gồm cả nguồn, màn hình. Đổi mới trong 15 ngày.\r\n-----\r\nCấu hình máy:\r\n Màn hình: 11 inches tràn viện, độ phân giải Full HD tấm nền IPS.\r\n Camera: 13MP.\r\n Camera trước: 8MP.\r\n CPU: SnapDragon 662, 8 nhân.\r\n Rom/Ram: 128GB/6GB.\r\n 4 loa xung quanh máy.\r\n Full Tiếng Việt.\r\n Pin: 7700 mAh.\r\n Kết nối: Wi-Fi 802.11 a/b/g/n/ac/6, dual-band, Wi-Fi Direct.','còn hàng','2024-01-05 01:41:37',1),(1046,1002,1004,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1',2323232,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1\r\n\r\n\r\n️ Đã có Android 11 Quốc Tế đầy đủ Tiếng Việt.\r\n------\r\n️  Máy new mới 100% Fullbox tặng kèm cường lực, bao da.\r\n️  Bảo hành 6 tháng mọi lỗi, bao gồm cả nguồn, màn hình. Đổi mới trong 15 ngày.\r\n-----\r\nCấu hình máy:\r\n Màn hình: 11 inches tràn viện, độ phân giải Full HD tấm nền IPS.\r\n Camera: 13MP.\r\n Camera trước: 8MP.\r\n CPU: SnapDragon 662, 8 nhân.\r\n Rom/Ram: 128GB/6GB.\r\n 4 loa xung quanh máy.\r\n Full Tiếng Việt.\r\n Pin: 7700 mAh.\r\n Kết nối: Wi-Fi 802.11 a/b/g/n/ac/6, dual-band, Wi-Fi Direct.\r\n-----\r\nPhù hợp với:\r\n Nhu cầu sử dụng nâng cao, có thể chơi các games đòi hỏi đồ họa như PUBG, Liên quân, Đấu Trường Chân Lý ở mức thiết lập trung bình - cao.\r\n Hệ thống 4 Loa mang lại trải nghiệm âm thanh rất tốt.\r\n 6GB Ram cho khả năng đa nhiệm chạy nhiều ứng dụng rất tốt.\r\n Bộ nhớ 128GB cho khả năng lưu trữ video, âm nhạc, hình ảnh rất thoải mái.\r\n Lướt web, sử dụng mạng xã hội.\r\n Xem video liên tục khoảng 8-9 tiếng (màn hình tỉ lệ 5:3 tối ưu hóa kích thước hiển thị video so với các máy tỉ lệ 4:3).\r\n Học Zoom hoặc các ứng dụng học tập Online.','còn hàng','2024-01-05 01:44:46',0),(1047,1002,1009,'Giá để giày 5 tầng kiểu mới đa năng thông minh chất liệu nhựa cao cấp 3646',199000,'?MÔ TẢ SẢN PHẨM \r\nChất liệu chính: nhựa\r\nLoại vật liệu: PVC\r\nCó hỗ trợ tùy chỉnh hay không: không hỗ trợ tùy chỉnh\r\nChiều sâu: cao 60cm, rộng 24.5cm, sâu 27cm,\r\nPhương pháp cài đặt: không đục lỗ\r\nPhong cách: phong cách Bắc Âu','còn hàng','2024-01-05 01:48:52',0),(1056,1002,1004,'bánh tráng trộn',2323232,'dfdfdf','còn hàng','2024-03-10 16:30:38',0),(1057,1039,1002,'Xe đạp',500000,'xe đạp cũ cần bán gấp ','hết hàng','2024-04-26 09:58:55',1),(1058,1039,1001,'xe máy',1000000,'xe cũ giá rẻ','còn hàng','2024-04-27 02:51:53',0),(1059,1039,1001,'xe máy',1000000,'xe cũ giá rẻ','hết hàng','2024-04-27 02:51:59',0);
/*!40000 ALTER TABLE `tb_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_product_images`
--

DROP TABLE IF EXISTS `tb_product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_product_images` (
  `product_img_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_link` text NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_img_id`),
  KEY `fk_p_i` (`product_id`),
  CONSTRAINT `fk_p_i` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_product_images`
--

LOCK TABLES `tb_product_images` WRITE;
/*!40000 ALTER TABLE `tb_product_images` DISABLE KEYS */;
INSERT INTO `tb_product_images` VALUES (1050,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112610/SMarket/product/rkdh8dnj5rdqvo3eacj2.png','main',0),(1051,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112610/SMarket/product/qodznzwgsijfqufu8ue7.png','sub',0),(1052,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112611/SMarket/product/a6cas9qvxopqxbbb84y4.png','sub',0),(1053,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112612/SMarket/product/brjkcvgvme6kp68r2mws.png','sub',0),(1063,1021,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113259/SMarket/product/fxtl3pixp30qbefscsrv.png','main',0),(1064,1021,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113260/SMarket/product/wjsy6m7bl1rncrfyeezs.png','sub',0),(1065,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113333/SMarket/product/nkflndjqctzcn5ta1eot.png','main',0),(1066,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113335/SMarket/product/sh81vakttrvbo8f8iqkb.png','sub',0),(1067,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113335/SMarket/product/rkvss0fnky9n834wk4b2.png','sub',0),(1072,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001502/SMarket/product/qexio0jp1h43eifwg008.png','main',0),(1073,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001503/SMarket/product/cqzvskw0uioqqg0owal4.png','sub',0),(1074,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001504/SMarket/product/fpfzrkgibaqa7u81gkwn.png','sub',0),(1075,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001505/SMarket/product/ztqa6fvbnxuwdgamfkmq.png','sub',0),(1141,1043,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418486/SMarket/product/i10euscafl1cqyihjr77.webp','main',0),(1142,1043,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418483/SMarket/product/mqjslbcoabnlgkbosrkj.jpg','sub',0),(1143,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418686/SMarket/product/dva1nmvppz1pdncyo1yj.jpg','main',0),(1144,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418684/SMarket/product/q6jtwp7zguxhbivcunog.jpg','sub',0),(1145,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418684/SMarket/product/jaxqbmwuq07srykhwqvg.jpg','sub',0),(1146,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418896/SMarket/product/umkezolpes6syqsozpdi.png','main',0),(1147,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418897/SMarket/product/keguqz6tstlay0cz6e6r.jpg','sub',0),(1148,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418897/SMarket/product/n5bxnamxyddx9e8ffy4n.jpg','sub',0),(1149,1046,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419084/SMarket/product/gzgrnaubcdtzwj4kvb6e.jpg','main',0),(1150,1046,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419086/SMarket/product/afd7pu1hd2hefifrbgrp.jpg','sub',0),(1151,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419330/SMarket/product/bzhf3tceesnk7uli4smc.jpg','main',0),(1152,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419330/SMarket/product/cwxpxcisu1iuijakxy8r.jpg','sub',0),(1153,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419332/SMarket/product/r7qnlntqv0seajlebupy.jpg','sub',0),(1171,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088233/SMarket/product/ju0i6oyzsnbrrmckeewu.jpg','main',0),(1172,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088236/SMarket/product/kjpczr4yzqykroctl0q7.jpg','sub',0),(1173,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088233/SMarket/product/mdcckg7uhp6rrjstj3wj.jpg','sub',0),(1174,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088234/SMarket/product/b4mfiuwhpvwsuukbumwl.jpg','sub',0),(1175,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088235/SMarket/product/w5brdohrxtyxdc337r3p.jpg','sub',0),(1176,1057,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714125532/SMarket/product/t5wiiw0cnzx8xzcuwfr1.jpg','main',0),(1177,1057,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714125530/SMarket/product/qwwl839zlncwrjnhkpkk.png','sub',0),(1178,1058,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714186310/SMarket/product/hsdzsmmoyl59dhl2rjni.jpg','main',0),(1179,1058,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714186311/SMarket/product/erbuxv72f7vcmxcgwglo.png','sub',0),(1180,1059,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714186316/SMarket/product/vplgxqlto4ccpxflr7iu.jpg','main',0),(1181,1059,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1714186317/SMarket/product/ougmosuyevxlh2o34ipb.png','sub',0);
/*!40000 ALTER TABLE `tb_product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_social_links`
--

DROP TABLE IF EXISTS `tb_social_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_social_links` (
  `user_sl_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `link` text NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_sl_id`),
  KEY `fk_sl` (`user_id`),
  CONSTRAINT `fk_sl` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_social_links`
--

LOCK TABLES `tb_social_links` WRITE;
/*!40000 ALTER TABLE `tb_social_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_social_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_role` varchar(10) NOT NULL DEFAULT 'user',
  `user_password` text,
  `account_id` text,
  `provider` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `avatar` text,
  `phone_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` text,
  `rate` int DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1002,'Vũ Thành Vinh','user',NULL,NULL,'','https://cdn.chotot.com/cF0tOBS0g0NiVGfUdarOnuFaHY5l3msXY2bkgRndklg/preset:listing/plain/7274771d608b08694c4257ae9ea74eb2-2839824952567390247.jpg','0337083194','hehe\r\n',NULL,'2023-10-27 07:03:36',0),(1004,'Beo thúi','user','$2b$10$j98abxAo3akNrFG790ZMf.cvcxtimERXtI3yTvBMrfRMGFAOafEy6',NULL,'',NULL,'12345',NULL,NULL,'2023-11-04 10:03:29',0),(1006,'Beo nek','user','$2b$10$vU4JUR0SDuSYLLsCcmh0luR9RR/YWelBIxZ3yZcD9vhjT5zmDE5C6',NULL,'',NULL,'123456789',NULL,NULL,'2023-11-04 10:12:37',0),(1016,'andrezz@gmail.com','user','$2b$10$Mqj8OYSOcOVHYQx5VxCohuOenwc82Qny0B34d71Tn0iO2zt70jF/C',NULL,'',NULL,'123456',NULL,NULL,'2023-11-04 10:50:28',0),(1018,'hông bé ơi','user','$2b$10$xwvuZGBRjtOCQA4utfNoYeIjEetmXjWeHqmACdSilApaEqYezm7iq',NULL,'',NULL,'123456',NULL,NULL,'2023-11-04 10:51:39',0),(1024,'vuthanhvinh438@gmail.com','user','$2b$10$GDpZYQCOnjWd6kwRbFazjepbJPdOFlnltFKfn/Xo/34w3B9zioiPi',NULL,'',NULL,'1244346',NULL,NULL,'2023-11-04 11:00:45',0),(1034,'Vinh Thành','user',NULL,NULL,'google','https://lh3.googleusercontent.com/a/ACg8ocL1IpnobJJii76EZucCg4Kd2lukpGhd8N7_RrGu13hX=s96-c',NULL,NULL,NULL,'2023-11-04 14:35:25',0),(1035,'admin','admin','$2b$10$H2YElQ/Jeg58b2GTKVSQEuQGfjBi.9DSnUQzncKAF4ViPbVVcP0Pi',NULL,'','/imgs/user.png','0337083194',NULL,NULL,'2023-12-31 14:59:55',0),(1036,'Vinh Vũ Thành','user',NULL,NULL,'','https://lh3.googleusercontent.com/a/ACg8ocL3kpFfxH4BtRS3obYoQV0_wPEMq5MJcXYlgVbNVSeZVA=s96-c',NULL,NULL,NULL,'2024-03-10 15:57:27',0),(1039,'Hoàng Đức Hậu','user','$2b$10$qvW0VxGj2uzdAwIQsFAZeOW9xUl4gahU1XCDcuf7WE3Ose0WUGhTS',NULL,'',NULL,'0345261446',NULL,NULL,'2024-04-26 08:20:30',0),(1040,'Hoàng Đức Hậu','user','$2b$10$eKFxWK2Dbm/PpXVTPvr/N.AfuI5HLZw/ZXEnzV.w65I2GMiqt8JBG',NULL,'',NULL,'',NULL,NULL,'2024-04-26 08:22:48',0),(1041,'Hoàng Đức Hậu','user','$2b$10$Z2/DswcvEsNNgR6skCxZnOWL2YydjEh/ii6QX0W7r0Lx8SE4gHf22',NULL,'',NULL,'0345261446',NULL,NULL,'2024-04-26 08:23:32',0),(1043,'Vũ Thành Vinh','user',NULL,NULL,'google','https://lh3.googleusercontent.com/a/ACg8ocIlFobYoSvEcT5MMCFkk6FerHkGWqO20CP3E9gYa6GKeN3lwn6D=s96-c','','heheeh',NULL,'2024-04-27 16:24:20',0);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-27 23:29:59
