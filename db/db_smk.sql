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
) ENGINE=InnoDB AUTO_INCREMENT=1057 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_product`
--

LOCK TABLES `tb_product` WRITE;
/*!40000 ALTER TABLE `tb_product` DISABLE KEYS */;
INSERT INTO `tb_product` VALUES (1000,1000,1003,'Quạt cây hehe',120000,'Hàng mới mua về mới sử dụng có 2-3 lần và không có nhu cầu sử dụng nữa','còn hàng','2023-10-22 21:47:39',0),(1001,1000,1011,'đồng hồ Rolex nek',200000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.','còn hàng','2023-10-23 05:18:32',0),(1002,1000,1011,'đồng hồ Rolex nek',200000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.','hết hàng','2023-10-23 06:07:47',0),(1003,1001,1003,'Quạt sạc tích điẹn SUNCA',150000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe','còn hàng','2023-10-23 16:59:26',0),(1004,1001,1003,'Quạt sạc tích điẹn SUNCA',150000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe','còn hàng','2023-10-23 16:59:31',0),(1005,1002,1008,'Đèn học cảm ứng hêhe',170000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe\nĐèn có chức năng tự sạc bằng niềm tin','còn hàng','2023-10-23 17:02:25',0),(1006,1002,1008,'Đèn học cảm ứng hêhe',170000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe\nĐèn có chức năng tự sạc bằng niềm tin','còn hàng','2023-10-23 17:02:29',0),(1007,1003,1004,'Cần pass lại iphone XR còn mới',2700000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe\nĐèn có chức năng tự sạc bằng niềm tin','còn hàng','2023-10-23 17:07:37',0),(1008,1003,1004,'Cần pass lại iphone XR còn mới',2700000,'Quà nyc tặng nhưng có ny mới nên cần pass lại.\nhehe\nĐèn có chức năng tự sạc bằng niềm tin','còn hàng','2023-10-23 17:07:41',0),(1009,1003,1004,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-10-23 17:14:44',0),(1010,1003,1004,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-10-23 17:14:48',0),(1011,1003,1004,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-10-23 17:15:12',0),(1012,1003,1004,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-10-23 17:15:14',0),(1013,1003,1004,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-10-27 07:09:04',0),(1014,1003,1002,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-11-27 17:54:48',0),(1015,1003,1002,'Cần thanh lý em Acer Nitro 5 này cho ae',19000000,'Máy còn mới anh em yên tâm có bảo hành trọn đời nhá =))','còn hàng','2023-11-27 19:04:34',0),(1018,1002,1000,'ádfasdf',2323232,'asdfasdf','còn hàng','2023-11-27 19:16:53',1),(1021,1002,1006,'hehe vippro',120000,'asdfdf','còn hàng','2023-11-27 19:27:40',1),(1022,1002,1003,'hehe memem',232322,'dfdfdfdfdf','còn hàng','2023-11-27 19:28:56',1),(1023,1002,1001,'ádfasdf',3434343,'zxcvxczvzxcv','hết hàng','2023-12-04 13:25:20',1),(1024,1002,1003,'hehe vippro',2323232,'sdfsdf','hết hàng','2023-12-08 02:11:47',1),(1026,1033,1003,'bánh kem dứa',12000,'không có chi\r\n','còn hàng','2023-12-23 10:23:24',1),(1028,1033,1000,'Vinfast VF8',1700000000,'Khoong co chi','hết hàng','2023-12-24 15:14:45',1),(1029,1033,1009,'Xu kem',3434343,'','còn hàng','2023-12-24 15:15:49',1),(1031,1033,1003,'Quạt tích điện',200000,'Quạt hỏng rồi\r\n','còn hàng','2023-12-24 15:33:11',0),(1036,1033,1003,'bánh gạo',1200000,'123434','hết hàng','2023-12-24 16:35:18',1),(1037,1033,1001,'hehe vippro',120000,'12121212','hết hàng','2023-12-28 07:12:31',1),(1038,1033,1009,'bánh tráng trộn',12000,'121212','còn hàng','2023-12-28 07:14:59',1),(1040,1033,1002,'hehe vippro',1212121,'','còn hàng','2023-12-28 13:38:01',1),(1041,1033,1005,'hehe vippro',120000,'','còn hàng','2023-12-28 14:03:41',1),(1043,1002,1008,'Bàn nhân viên chân sắt chữ U giá rẻ mã',400000,'Bàn nhân viên chân sắt chữ U giá rẻ mã UTP_1206 thuộc dòng sản phẩm bàn văn phòng, bàn học tập, bàn làm việc tai nhà được yêu thích nhất hiện nay. Mẫu bàn đơn giản, chắc chắn, có thể dễ dàng tháo lắp và vận chuyển ','còn hàng','2024-01-05 01:34:46',0),(1044,1002,1007,'Bàn Học Gấp Gọn Ngồi Bệt Kumo Làm Việc Thông Minh Để LapTop Có Ngăn Kéo',200000,'BÀN HỌC GẤP GỌN MINI\r\n\r\n\r\n\r\n1.THÔNG TIN SẢN PHẨM:\r\n\r\n-Bàn làm việc gập gọn thuận tiện để tận hưởng cuộc sống\r\n\r\n-Mặt bàn gấp mini di động tiết kiệm không gian chất lượng cao chịu lực tốt, thiết kế tinh tế và mặt bàn mịn dầy dặn\r\n\r\n-Để được máy tình để bàn lớn\r\n\r\n-Có thể điều chỉnh góc nhìn thuận tiện\r\n\r\n-Thiết kế bàn học mini đa năng \r\n\r\n-Cấu trúc chắc chắn ổn định\r\n\r\n-Thiết kế bàn học tích hợp cổng sạc usb tiện ích phù hợp với thói quen sử dụng, trải nghiệm cảm giác thoải mái khi làm việc\r\n\r\n-Mặt bàn có kích thước 58*38Cm\r\n\r\n-Chứa được nhiều đồ và không gian làm việc lớn\r\n\r\n-Thiết kế bàn gấp mini di động tiết kiệm không gian gọn, nhẹ dễ dàng điều chỉnh góc độ cao phù hợp với tư thế ngồi\r\n\r\n-Chân bàn học mini đa năng dạng trượt, bàn có thể đẩy ra kéo vào thoải mái mà không cần nhấc bàn lên, dễ dàng di chuyển\r\n\r\n+ Bản Pro Kèm Giá Sách + Giá Đỡ Điện Thoại + Ngăn Kéo \r\n\r\n+ Bản Pro Max kết nối nguồn điện qua dây usb 1.5m Kèm Giá Sách + Giá Đỡ Điện Thoại + Ngăn Kéo + Sạc không dây cho điện thoại + Cổng sạc Usb + Đèn học ','còn hàng','2024-01-05 01:38:07',0),(1045,1002,1004,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1',2500000,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1\r\n\r\n\r\n️ Đã có Android 11 Quốc Tế đầy đủ Tiếng Việt.\r\n------\r\n️  Máy new mới 100% Fullbox tặng kèm cường lực, bao da.\r\n️  Bảo hành 6 tháng mọi lỗi, bao gồm cả nguồn, màn hình. Đổi mới trong 15 ngày.\r\n-----\r\nCấu hình máy:\r\n Màn hình: 11 inches tràn viện, độ phân giải Full HD tấm nền IPS.\r\n Camera: 13MP.\r\n Camera trước: 8MP.\r\n CPU: SnapDragon 662, 8 nhân.\r\n Rom/Ram: 128GB/6GB.\r\n 4 loa xung quanh máy.\r\n Full Tiếng Việt.\r\n Pin: 7700 mAh.\r\n Kết nối: Wi-Fi 802.11 a/b/g/n/ac/6, dual-band, Wi-Fi Direct.','còn hàng','2024-01-05 01:41:37',1),(1046,1002,1004,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1',2323232,'Máy tính bảng Lenovo Tab P11 2021 6GB Ram Bộ nhớ 128GB - Chính hãng, Nguyên seal, Bh 12 tháng, Lỗi 1 đổi 1\r\n\r\n\r\n️ Đã có Android 11 Quốc Tế đầy đủ Tiếng Việt.\r\n------\r\n️  Máy new mới 100% Fullbox tặng kèm cường lực, bao da.\r\n️  Bảo hành 6 tháng mọi lỗi, bao gồm cả nguồn, màn hình. Đổi mới trong 15 ngày.\r\n-----\r\nCấu hình máy:\r\n Màn hình: 11 inches tràn viện, độ phân giải Full HD tấm nền IPS.\r\n Camera: 13MP.\r\n Camera trước: 8MP.\r\n CPU: SnapDragon 662, 8 nhân.\r\n Rom/Ram: 128GB/6GB.\r\n 4 loa xung quanh máy.\r\n Full Tiếng Việt.\r\n Pin: 7700 mAh.\r\n Kết nối: Wi-Fi 802.11 a/b/g/n/ac/6, dual-band, Wi-Fi Direct.\r\n-----\r\nPhù hợp với:\r\n Nhu cầu sử dụng nâng cao, có thể chơi các games đòi hỏi đồ họa như PUBG, Liên quân, Đấu Trường Chân Lý ở mức thiết lập trung bình - cao.\r\n Hệ thống 4 Loa mang lại trải nghiệm âm thanh rất tốt.\r\n 6GB Ram cho khả năng đa nhiệm chạy nhiều ứng dụng rất tốt.\r\n Bộ nhớ 128GB cho khả năng lưu trữ video, âm nhạc, hình ảnh rất thoải mái.\r\n Lướt web, sử dụng mạng xã hội.\r\n Xem video liên tục khoảng 8-9 tiếng (màn hình tỉ lệ 5:3 tối ưu hóa kích thước hiển thị video so với các máy tỉ lệ 4:3).\r\n Học Zoom hoặc các ứng dụng học tập Online.','còn hàng','2024-01-05 01:44:46',0),(1047,1002,1009,'Giá để giày 5 tầng kiểu mới đa năng thông minh chất liệu nhựa cao cấp 3646',199000,'?MÔ TẢ SẢN PHẨM \r\nChất liệu chính: nhựa\r\nLoại vật liệu: PVC\r\nCó hỗ trợ tùy chỉnh hay không: không hỗ trợ tùy chỉnh\r\nChiều sâu: cao 60cm, rộng 24.5cm, sâu 27cm,\r\nPhương pháp cài đặt: không đục lỗ\r\nPhong cách: phong cách Bắc Âu','còn hàng','2024-01-05 01:48:52',0),(1048,1033,1009,'kệ để giày, Giá để giày 5 tầng kiểu mới đa năng thông minh chất liệu nhựa cao cấp 3646',100000,'?MÔ TẢ SẢN PHẨM \r\nChất liệu chính: nhựa\r\nLoại vật liệu: PVC\r\nCó hỗ trợ tùy chỉnh hay không: không hỗ trợ tùy chỉnh\r\nChiều sâu: cao 60cm, rộng 24.5cm, sâu 27cm,\r\nPhương pháp cài đặt: không đục lỗ\r\nPhong cách: phong cách Bắc Âu','còn hàng','2024-01-05 01:50:30',0),(1049,1033,1010,'GỐC HOA HỒNG SIÊU NỤ (KHÁCH ĐƯỢC CHỌN MÀU)',12000,'GỐC HỒNG NGOẠI SIÊU NỤ\r\n- Cây đã khỏe khoắn, cứng cáp, mang 100% ưu điểm vượt trội, thuần chủng k lai tạp.\r\n-Cây có khả năng kháng bệnh tốt, màu sắc đồng đều, bông to, lặp hoa liên tục và rất sai\r\n- Người-mới tập trồng nên chọn loại này vì vừa rẻ lại vừa dễ trồng, k sợ lụi dần theo thời gian\r\n- Còn người chơi lâu năm chọn loại này về tha hồ tạo dáng kiểu theo ý muốn.','còn hàng','2024-01-05 01:53:37',0),(1050,1033,1010,'Nệm Topper Euro Hometex dày 7cm tấm topper tiện nghi cao cấp không lo bị xẹp gấp gọn gàng khi không sử dụng',175000,'Euro Hometex Nệm Topper bông trải sàn hàng cao cấp xuất khẩu kích thước 1m×2m, 1m2×2m, 1m4×2m, 1m6×2m, 1m8×2m ,2mx2m\r\nTopper là một tấm tiện ích trải trên mặt sàn hoặc trên mặt đệm. Đây là một lớp đệm mỏng chỉ khoảng 6-9cm được thiết kế theo phong cách đơn giản,tiện nghi,nhẹ gọn,có thể mang đi chơi thoải mái trong khi chi phí rất rẻ.\r\nVà đặc biệt thêm một tấm Topper trên bề mặt đệm sẽ giúp tăng tiện nghi sử dụng đệm lên rất nhiều, mang lại cảm giác êm ái hơn, thoáng mát, bồng bềnh hơn và tôn vẻ sang trọng, lãng mạn của giường ngủ.','còn hàng','2024-01-05 01:56:21',0),(1051,1033,1009,'Kệ Đựng Đồ Nhà Tắm Dán Tường Hình Chữ Nhật , Kệ Thép Sơn Tĩnh Điện Cao Cấp Không Rỉ Siêu Chắc',30000,'\r\n\r\n* THÔNG TIN SẢN PHẨM : \r\n\r\n1 : Loại Kệ inox MP01\r\n\r\n- Kích Thước Dài 35cm Rộng 12cm  Cao 6cm\r\n\r\n- Số lượng sản phẩm: 01 kệ + 01 miếng dán Đôi (bạc hoặc trong)\r\n\r\n- Tiện ích:\r\n\r\n- Kệ mỹ phẩm chất liệu inox cứng cáp, bền vững.\r\n\r\n- Miếng dán siêu chắc, tiết kiệm không gian nhà bạn.\r\n\r\n- Không cần khoan tường, hư hỏng tường.\r\n\r\n- Mẫu mã đẹp, sang trọng.\r\n\r\n- Tiện lợi: đựng gia vị, kệ đựng mỹ phẩm... phù hợp cho cả nhà tắm, phòng bếp, phòng ngủ','còn hàng','2024-01-05 02:01:55',0),(1052,1033,1009,'Chổi Lau Nhà Tím Xoay 360 Độ - Cây Lau Nhà Tự Vắt Nhỏ Gọn Cho Gia Đình',99000,'Chổi Lau Nhà Tím Xoay 360 Độ - Cây Lau Nhà Tự Vắt Nhỏ Gọn Cho Gia Đình\r\nBộ phụ kiện gồm: 1 thân Cây lau nhà, 1 đầu xoay 360 độ, 1 đầu bông lau.\r\nMâm inox xoay chuyển 360 độ, dễ dàng lau chùi các ngóc ngách trên sàn nhà, xe hơi, bề mặt kính…\r\nBông lau làm từ các sợi bông đan chéo, thấm hút tốt hơn, khô nhanh hơn, lau sạch bụi bẩn.\r\nChất liệu: nhựa, inox. chắc chắn. \r\n✅ Chất liệu siêu bền, kiểu dáng hiện đại đáp ứng được nhu cầu ngày càng cao của thị trường. Bạn nên lựa chọn những sản phẩm tốt nhất trên thị trường để việc lau nhà của mình dễ dàng hơn.\r\n✅ Với cây lau nhà thì việc lau chùi, dọn dẹp nhà cửa hết sức đơn giản. Bạn sẽ tiết kiệm được nhiều thời gian chăm sóc những người thân yêu trong gia đình.','hết hàng','2024-01-05 02:03:48',0),(1053,1033,1011,'ÁO POLO CIRCLE M MÀU XANH RÊU CHÍNH HÃNG MARCHLAND',200000,'✔️Áo Polo Circle M\r\n- Chất liệu: 95% cotton 5% spandex \r\n- Logo thêu sắc nét, đường may chắc chắn\r\n\r\nĐiều kiện đổi hàng:\r\n1. Có video unbox chi tiết, rõ ràng và bao quát (điều kiện quan trọng để shop hỗ trợ đổi nhanh hơn ạ)\r\n2. Sản phẩm chưa qua sử dụng, giặt ủi và còn nguyên nhãn mác, chỉ hỗ trợ đổi size, không hỗ trợ đổi mẫu.','hết hàng','2024-01-05 02:06:23',0),(1055,1033,1003,'hehe vippro',1212121,'','còn hàng','2024-01-05 03:05:29',0),(1056,1002,1004,'bánh tráng trộn',2323232,'dfdfdf','còn hàng','2024-03-10 16:30:38',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=1176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_product_images`
--

LOCK TABLES `tb_product_images` WRITE;
/*!40000 ALTER TABLE `tb_product_images` DISABLE KEYS */;
INSERT INTO `tb_product_images` VALUES (1000,1001,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698063511/SMarket/product/l6gjui8bp3q81ccc6tud.jpg','main',0),(1001,1001,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698063511/SMarket/product/cl2awap1duznr4iiceam.jpg','sub',0),(1002,1001,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698063511/SMarket/product/utczridonxvkzg3qar81.jpg','sub',0),(1003,1002,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698066464/SMarket/product/onrwlokmipkulvlptygf.jpg','main',0),(1004,1002,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698066464/SMarket/product/om6w99wkqzopixmcgwsn.jpg','sub',0),(1005,1002,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698066464/SMarket/product/k9kjfmsvn5a2uxr1bibf.jpg','sub',0),(1006,1003,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105564/SMarket/product/vajmnmwettzdbpvo70uv.jpg','main',0),(1007,1003,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105563/SMarket/product/rgckrmjoavljn0ihadrq.jpg','sub',0),(1008,1003,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105563/SMarket/product/rhhtcdd5bgitcyfbk6wm.jpg','sub',0),(1009,1004,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105569/SMarket/product/jl5m2q5k1ptjj1geqjfm.jpg','main',0),(1010,1004,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105568/SMarket/product/wrmsbg1iaxitk2dfmb97.jpg','sub',0),(1011,1004,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105569/SMarket/product/isua2ufvlz8brtmrn2xj.jpg','sub',0),(1012,1005,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105743/SMarket/product/k3xonekqqibqzs5usi6s.jpg','main',0),(1013,1005,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105743/SMarket/product/m0fata9jf8gsvi4la19o.jpg','sub',0),(1014,1005,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105743/SMarket/product/jwavo2ttbjmmpwpvjdux.jpg','sub',0),(1015,1006,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105748/SMarket/product/tmjamdx8acgyggmdovkz.jpg','main',0),(1016,1006,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105748/SMarket/product/mbiueg3rfiljeunbzkud.jpg','sub',0),(1017,1006,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698105748/SMarket/product/ywvazzol890z3evo3cmf.jpg','sub',0),(1018,1007,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106055/SMarket/product/srqduc0qtema37bjjcrc.jpg','main',0),(1019,1007,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106055/SMarket/product/ezsvskn55nsspboetsxn.jpg','sub',0),(1020,1007,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106055/SMarket/product/zf5ckk7kp7fzewlobgds.jpg','sub',0),(1021,1007,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106055/SMarket/product/kaglezfhy2p51j8hgott.jpg','sub',0),(1022,1007,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106056/SMarket/product/ccn50xfoeuud6vcfv9fm.jpg','sub',0),(1023,1008,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106059/SMarket/product/swqgkgpyybqvyknowrpq.jpg','main',0),(1024,1008,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106059/SMarket/product/kqk6pstfk1kvkizo10f1.jpg','sub',0),(1025,1008,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106059/SMarket/product/eeug1pbcmoyeaihifjkk.jpg','sub',0),(1026,1008,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106059/SMarket/product/ucxougueu0rildl78kts.jpg','sub',0),(1027,1008,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106060/SMarket/product/plo3cja99guqg5rjt3va.jpg','sub',0),(1028,1009,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106483/SMarket/product/ir9lhgonw9ksa1jsuokb.jpg','main',0),(1029,1009,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106483/SMarket/product/qr9xagrfbu6a6bsi42ne.jpg','sub',0),(1030,1010,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106486/SMarket/product/ggp9ieextq9xcldqele1.jpg','main',0),(1031,1010,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106486/SMarket/product/t4d71orr2hcshjunsbsn.jpg','sub',0),(1032,1011,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106510/SMarket/product/r2zsczo791nkkcx1ljyo.jpg','main',0),(1033,1011,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106510/SMarket/product/yif4uzlmn8vtnkthztcs.jpg','sub',0),(1034,1012,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106513/SMarket/product/uo2ifnpju6ivemd1amzb.jpg','main',0),(1035,1012,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698106513/SMarket/product/gofepf0bk2arojn5f7za.jpg','sub',0),(1036,1013,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698390542/SMarket/product/g206lv3bh54umategen7.jpg','main',0),(1037,1013,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1698390542/SMarket/product/mobk38av9yavpldgya8o.jpg','sub',0),(1038,1014,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701107688/SMarket/product/urdnfptjgcjgecun0m01.jpg','main',0),(1039,1014,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701107688/SMarket/product/bxpi6rizioszehk1urbu.jpg','sub',0),(1040,1015,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701111873/SMarket/product/vtj31o5hhus7oszn1b7u.jpg','main',0),(1041,1015,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701111873/SMarket/product/zntapbzg4tzfareyjnl8.jpg','sub',0),(1050,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112610/SMarket/product/rkdh8dnj5rdqvo3eacj2.png','main',0),(1051,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112610/SMarket/product/qodznzwgsijfqufu8ue7.png','sub',0),(1052,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112611/SMarket/product/a6cas9qvxopqxbbb84y4.png','sub',0),(1053,1018,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701112612/SMarket/product/brjkcvgvme6kp68r2mws.png','sub',0),(1063,1021,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113259/SMarket/product/fxtl3pixp30qbefscsrv.png','main',0),(1064,1021,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113260/SMarket/product/wjsy6m7bl1rncrfyeezs.png','sub',0),(1065,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113333/SMarket/product/nkflndjqctzcn5ta1eot.png','main',0),(1066,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113335/SMarket/product/sh81vakttrvbo8f8iqkb.png','sub',0),(1067,1022,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701113335/SMarket/product/rkvss0fnky9n834wk4b2.png','sub',0),(1068,1023,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701696318/SMarket/product/fpb3bzemc3jzpk4rh1om.png','main',0),(1069,1023,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701696316/SMarket/product/rgql16uuhwmcz7sj6uyw.png','sub',0),(1070,1023,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701696315/SMarket/product/dza4y7x9laqambjqxjzt.png','sub',0),(1071,1023,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1701696316/SMarket/product/rbfdbzpg2f7ekdy2gsx6.png','sub',0),(1072,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001502/SMarket/product/qexio0jp1h43eifwg008.png','main',0),(1073,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001503/SMarket/product/cqzvskw0uioqqg0owal4.png','sub',0),(1074,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001504/SMarket/product/fpfzrkgibaqa7u81gkwn.png','sub',0),(1075,1024,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1702001505/SMarket/product/ztqa6fvbnxuwdgamfkmq.png','sub',0),(1079,1026,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703327001/SMarket/product/svivlb3qzdbb2pufgrai.png','main',0),(1080,1026,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703327003/SMarket/product/tkgylomy56d8xia8mdam.png','sub',0),(1081,1026,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703327002/SMarket/product/pibqbnjv2j7yv9xuqw59.png','sub',0),(1082,1026,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703327003/SMarket/product/c148tvelkllycisezq9g.png','sub',0),(1088,1028,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430880/SMarket/product/utk6b9pp2h1lv2rx6wek.jpg','main',0),(1089,1028,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430880/SMarket/product/njexwz7ziidudisnwi5h.jpg','sub',0),(1090,1028,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430881/SMarket/product/e2qkagvxrdwks168ogif.jpg','sub',0),(1091,1028,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430881/SMarket/product/oott43bhorlchwsf0rcm.jpg','sub',0),(1092,1029,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430946/SMarket/product/n0ojhn4hemvmsnat19hi.jpg','main',0),(1093,1029,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430946/SMarket/product/uqokgkuzakix1bu0gxpt.jpg','sub',0),(1094,1029,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430946/SMarket/product/ka8inmgx2r6azyjqluph.jpg','sub',0),(1095,1029,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703430946/SMarket/product/zzgopxg47mohfrk0bw0l.jpg','sub',0),(1101,1031,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703431986/SMarket/product/rfzg0x4rt1vmddb6nwfz.jpg','main',0),(1102,1031,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703431988/SMarket/product/syvx8o8x806cgu3woxvi.jpg','sub',0),(1103,1031,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703431985/SMarket/product/aj7te99ur5qp79hgwtt9.jpg','sub',0),(1104,1031,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703431986/SMarket/product/qyrtpr7oyhk8xjjvgva3.jpg','sub',0),(1121,1036,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703435713/SMarket/product/iszggwlcf5zll5kofhdo.jpg','main',0),(1122,1036,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703435713/SMarket/product/xt8uqomnfudnyab9em7t.jpg','sub',0),(1123,1036,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703435714/SMarket/product/qzhmpfii3xyjeo0hatkc.jpg','sub',0),(1124,1036,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703435715/SMarket/product/sodw7w1iiyy8oja4vygm.jpg','sub',0),(1125,1037,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703747549/SMarket/product/itigxhbgopllldwqwtwd.png','main',0),(1126,1037,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703747549/SMarket/product/c9n1ml063swcuvxymimz.jpg','sub',0),(1127,1037,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703747549/SMarket/product/hm3g5k1wqhy8wztzkr0t.png','sub',0),(1128,1038,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703747697/SMarket/product/zdlz5vkkpygssbf7ttos.png','main',0),(1129,1038,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703747696/SMarket/product/ibgorliutxrmkazysv35.jpg','sub',0),(1133,1040,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703770676/SMarket/product/wpubbkhwhtjbfucb2ldy.jpg','main',0),(1134,1040,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703770677/SMarket/product/xvc3p2uxj1jj31s2xfe3.png','sub',0),(1135,1040,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703770679/SMarket/product/ujgcbgfszefiijnsxkz7.jpg','sub',0),(1136,1041,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703772216/SMarket/product/igdlea8d3tqizkunxvpi.jpg','main',0),(1137,1041,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1703772220/SMarket/product/a4w9xj4nlcplicq5t8b1.jpg','sub',0),(1141,1043,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418486/SMarket/product/i10euscafl1cqyihjr77.webp','main',0),(1142,1043,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418483/SMarket/product/mqjslbcoabnlgkbosrkj.jpg','sub',0),(1143,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418686/SMarket/product/dva1nmvppz1pdncyo1yj.jpg','main',0),(1144,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418684/SMarket/product/q6jtwp7zguxhbivcunog.jpg','sub',0),(1145,1044,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418684/SMarket/product/jaxqbmwuq07srykhwqvg.jpg','sub',0),(1146,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418896/SMarket/product/umkezolpes6syqsozpdi.png','main',0),(1147,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418897/SMarket/product/keguqz6tstlay0cz6e6r.jpg','sub',0),(1148,1045,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704418897/SMarket/product/n5bxnamxyddx9e8ffy4n.jpg','sub',0),(1149,1046,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419084/SMarket/product/gzgrnaubcdtzwj4kvb6e.jpg','main',0),(1150,1046,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419086/SMarket/product/afd7pu1hd2hefifrbgrp.jpg','sub',0),(1151,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419330/SMarket/product/bzhf3tceesnk7uli4smc.jpg','main',0),(1152,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419330/SMarket/product/cwxpxcisu1iuijakxy8r.jpg','sub',0),(1153,1047,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419332/SMarket/product/r7qnlntqv0seajlebupy.jpg','sub',0),(1154,1048,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419428/SMarket/product/pi6c0f1qci6upmhwdyhg.jpg','main',0),(1155,1048,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419430/SMarket/product/wbqou1mpuh61uzaajcvv.jpg','sub',0),(1156,1048,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419427/SMarket/product/pmouquoawzrxzevg1thq.jpg','sub',0),(1157,1049,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419616/SMarket/product/q6b5dqihdl8uihzwuag4.jpg','main',0),(1158,1049,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419615/SMarket/product/bebybns8rjuf76pp2gsg.jpg','sub',0),(1159,1050,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419778/SMarket/product/assooabljjuf9rszkuvh.jpg','main',0),(1160,1050,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704419780/SMarket/product/aenybdgyrql4nb6ect8b.jpg','sub',0),(1161,1051,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420115/SMarket/product/b5z7s3mdv4vys0ygqui0.jpg','main',0),(1162,1051,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420114/SMarket/product/heojzacsdfeptcjqtklt.jpg','sub',0),(1163,1052,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420228/SMarket/product/lwczftrvs2kksaopi8ip.jpg','main',0),(1164,1052,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420226/SMarket/product/yjg5fjkguu8cxmsckdin.jpg','sub',0),(1165,1053,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420382/SMarket/product/ybvl0ctxkkwwrhouvjjv.jpg','main',0),(1166,1053,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704420381/SMarket/product/zppuujqba2rfx2pomshb.jpg','sub',0),(1169,1055,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704423925/SMarket/product/qckoevhug3denadd8w9d.jpg','main',0),(1170,1055,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1704423928/SMarket/product/qr8pbp2l9ufkbpplirod.jpg','sub',0),(1171,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088233/SMarket/product/ju0i6oyzsnbrrmckeewu.jpg','main',0),(1172,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088236/SMarket/product/kjpczr4yzqykroctl0q7.jpg','sub',0),(1173,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088233/SMarket/product/mdcckg7uhp6rrjstj3wj.jpg','sub',0),(1174,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088234/SMarket/product/b4mfiuwhpvwsuukbumwl.jpg','sub',0),(1175,1056,'https://res.cloudinary.com/djz9u9dcc/image/upload/v1710088235/SMarket/product/w5brdohrxtyxdc337r3p.jpg','sub',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=1038 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1000,'vinh thanh nek','user',NULL,NULL,'google','https://cdn.chotot.com/cF0tOBS0g0NiVGfUdarOnuFaHY5l3msXY2bkgRndklg/preset:listing/plain/7274771d608b08694c4257ae9ea74eb2-2839824952567390247.jpg','0337083194','Nam Tu Liem, Ha Noi',NULL,'2023-10-27 07:03:36',0),(1001,'Huu Tuan','user',NULL,NULL,'google','https://cdn.chotot.com/cF0tOBS0g0NiVGfUdarOnuFaHY5l3msXY2bkgRndklg/preset:listing/plain/7274771d608b08694c4257ae9ea74eb2-2839824952567390247.jpg','0337083194','Nam Tu Liem, Ha Noi',NULL,'2023-10-27 07:03:36',0),(1002,'Vũ Thành Vinh','user',NULL,NULL,'google','https://cdn.chotot.com/cF0tOBS0g0NiVGfUdarOnuFaHY5l3msXY2bkgRndklg/preset:listing/plain/7274771d608b08694c4257ae9ea74eb2-2839824952567390247.jpg','0337083194','Quoc Tu Giam, Dong Da, Ha Noi',NULL,'2023-10-27 07:03:36',0),(1003,'Nguyễn Trung Quân','user',NULL,NULL,'google','https://cdn.chotot.com/cF0tOBS0g0NiVGfUdarOnuFaHY5l3msXY2bkgRndklg/preset:listing/plain/7274771d608b08694c4257ae9ea74eb2-2839824952567390247.jpg','0337083194','Nam Tu Liem, Ha Noi',NULL,'2023-10-27 07:03:36',0),(1004,'Beo thúi','user','$2b$10$j98abxAo3akNrFG790ZMf.cvcxtimERXtI3yTvBMrfRMGFAOafEy6',NULL,'',NULL,'12345',NULL,NULL,'2023-11-04 10:03:29',0),(1006,'Beo nek','user','$2b$10$vU4JUR0SDuSYLLsCcmh0luR9RR/YWelBIxZ3yZcD9vhjT5zmDE5C6',NULL,'',NULL,'123456789',NULL,NULL,'2023-11-04 10:12:37',0),(1016,'andrezz@gmail.com','user','$2b$10$Mqj8OYSOcOVHYQx5VxCohuOenwc82Qny0B34d71Tn0iO2zt70jF/C',NULL,'',NULL,'123456',NULL,NULL,'2023-11-04 10:50:28',0),(1018,'hông bé ơi','user','$2b$10$xwvuZGBRjtOCQA4utfNoYeIjEetmXjWeHqmACdSilApaEqYezm7iq',NULL,'',NULL,'123456',NULL,NULL,'2023-11-04 10:51:39',0),(1024,'vuthanhvinh438@gmail.com','user','$2b$10$GDpZYQCOnjWd6kwRbFazjepbJPdOFlnltFKfn/Xo/34w3B9zioiPi',NULL,'',NULL,'1244346',NULL,NULL,'2023-11-04 11:00:45',0),(1033,'Thành Vinh','user',NULL,NULL,'google','https://lh3.googleusercontent.com/a/ACg8ocJBLMJi7kBsO81KVzwsEczbeT53NGPsRhRyASKmh989I-w=s96-c',NULL,NULL,NULL,'2023-11-04 14:31:05',0),(1034,'Vinh Thành','user',NULL,NULL,'google','https://lh3.googleusercontent.com/a/ACg8ocL1IpnobJJii76EZucCg4Kd2lukpGhd8N7_RrGu13hX=s96-c',NULL,NULL,NULL,'2023-11-04 14:35:25',0),(1035,'admin','admin','$2b$10$H2YElQ/Jeg58b2GTKVSQEuQGfjBi.9DSnUQzncKAF4ViPbVVcP0Pi',NULL,'','/imgs/user.png','0337083194',NULL,NULL,'2023-12-31 14:59:55',0),(1036,'Vinh Vũ Thành','user',NULL,NULL,'google','https://lh3.googleusercontent.com/a/ACg8ocL3kpFfxH4BtRS3obYoQV0_wPEMq5MJcXYlgVbNVSeZVA=s96-c',NULL,NULL,NULL,'2024-03-10 15:57:27',0),(1037,'haui','user','$2b$10$uU2NPT0ukhzG5j0MBBAxJeXTvhpiQFqeRiUi6TKTInZAw6QiUqWAC',NULL,'',NULL,'12312312',NULL,NULL,'2024-03-10 16:16:23',0);
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

-- Dump completed on 2024-04-06 17:48:20
