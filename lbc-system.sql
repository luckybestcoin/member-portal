/*
 Navicat Premium Data Transfer

 Source Server         : Localhost 57
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : lbc-system

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 04/03/2021 09:11:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for achievement
-- ----------------------------
DROP TABLE IF EXISTS `achievement`;
CREATE TABLE `achievement`  (
  `achievement_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rating_id` bigint(20) NULL DEFAULT NULL,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `process` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`achievement_id`) USING BTREE,
  INDEX `peringkat_id`(`rating_id`) USING BTREE,
  INDEX `anggota_id`(`member_id`) USING BTREE,
  CONSTRAINT `achievement_ibfk_1` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `achievement_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coinpayment_transaction_items
-- ----------------------------
DROP TABLE IF EXISTS `coinpayment_transaction_items`;
CREATE TABLE `coinpayment_transaction_items`  (
  `coinpayment_transaction_id` bigint(20) NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `qty` decimal(10, 2) NOT NULL,
  `subtotal` decimal(10, 2) NOT NULL,
  `currency_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  INDEX `coinpayment_transaction_id`(`coinpayment_transaction_id`) USING BTREE,
  CONSTRAINT `coinpayment_transaction_items_ibfk_1` FOREIGN KEY (`coinpayment_transaction_id`) REFERENCES `coinpayment_transactions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coinpayment_transaction_items
-- ----------------------------
INSERT INTO `coinpayment_transaction_items` VALUES (3, 'Lucky Best Coin', 12.50, 2.00, 25.00, 'USD', NULL, NULL, '2021-03-01 12:59:45', '2021-03-01 12:59:45');
INSERT INTO `coinpayment_transaction_items` VALUES (4, 'Lucky Best Coin', 12.50, 800.00, 10000.00, 'USD', NULL, NULL, '2021-03-03 15:44:34', '2021-03-03 15:44:34');

-- ----------------------------
-- Table structure for coinpayment_transactions
-- ----------------------------
DROP TABLE IF EXISTS `coinpayment_transactions`;
CREATE TABLE `coinpayment_transactions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` char(36) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `txn_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `order_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `buyer_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `buyer_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `currency_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `time_expires` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `amount_total_fiat` decimal(10, 2) NULL DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `amountf` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `coin` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `confirms_needed` int(11) NULL DEFAULT NULL,
  `payment_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `qrcode_url` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `received` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `receivedf` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `recv_confirms` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_text` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_url` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `timeout` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `checkout_url` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `redirect_url` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cancel_url` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `payload` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `coinpayment_transactions_uuid_unique`(`uuid`) USING BTREE,
  UNIQUE INDEX `coinpayment_transactions_txn_id_unique`(`txn_id`) USING BTREE,
  UNIQUE INDEX `coinpayment_transactions_order_id_unique`(`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coinpayment_transactions
-- ----------------------------
INSERT INTO `coinpayment_transactions` VALUES (3, '523a7f77-3901-4f92-9b54-c909eaf1df18', 'CPFC5JJMBKSUW23YEZYHVBBPWM', '603ce3b36ebb5', 'andifajarlah@gmail.com', 'andifajarlah@gmail.com', 'USD', '1614689984', 'bnb16mqe68ncdq7klv4eprrukp969qwsyk66f8a52f', 25.00, '10015000', '0.10015000', 'BNB', 10, 'bnb16mqe68ncdq7klv4eprrukp969qwsyk66f8a52f', 'https://www.coinpayments.net/qrgen.php?id=CPFC5JJMBKSUW23YEZYHVBBPWM&key=785716bddc5106859423c50f30d5f8c0', '0', '0.00000000', '0', '0', 'Waiting for buyer funds...', 'https://www.coinpayments.net/index.php?cmd=status&id=CPFC5JJMBKSUW23YEZYHVBBPWM&key=785716bddc5106859423c50f30d5f8c0', '86400', 'https://member.luckybestcoin.com/coinpayment/make/eyJpdiI6Ikkzc2hyM1FCdHZ3eVJYV1g0YlAyQXc9PSIsInZhbHVlIjoiRkVnQVR1MzFndmhoaVRRclpNSHROZktHWGliQi9ER2xMYTQxZ2YrOFhkSHFjK1dadEt5eTlRWWgwNE5CWTgxMWdvY21aMkMrMkR4WGpKc2lnNmJvQzYvSitoNWdIaFYrcTFmZG5UQWV6TkZmMjhtYlpDWmltQWxRZi9vMlNNa3BGQTF5L2xobVAwVisxL1Q4RVg0N0x5V2lLWTd3QnY4aHZrS0VzQk9zbzQ2YzEwT2V4d21oODV0bzdsQ0dXTTR6QldOTGdxYW16QmhtMzl0N08rQlJ1UVhOWFpqaWdHcDFaUWtzcjNQRHRsWm5yaSs2S2ZDb0VubFBpcmpNMEdUMzUwenRhQndHMlNZM0oxcE5sa3hUUGUzY1R4cU5tNU95M3VoWHdRamFJQ1I1ZVd1QjlzKzdQRGpReFNlUUVMWHZvT1ZmcHhHYWdremNJVHlMK29qMEFmRS9IS1ZYcWRMNko0THRHVHJxZ0NHVHJWYlZtM284eWxKZjlkN3hyWUVBUFAwZ21aTHFBTlBpaGFIQzZMRFR2QUVlaWxJNTkyOEJmMUMwdnJ0c01VMjJjaDBDbG9LSWh3NXFmV2xPYjUzYlFwVVJEdFMxcitOQm5nQWRrTG1ZemdGaDlPQkl2a2RXNTViYlR3M3A1Z2lPUnFOanhRMkxpcjVhTnRHZVgrY0xUemNLUzA5dDBwVmV3NUd3ZmpEWkZ3K05uenZVU1lWMkU3VndWWWhQMHVGQ3Q2anB0L1gydVZndWlXS1p0VG1ZczZUYldUTnR2RysxMFduNkl5NXJmMmdrb2I5UFE1dWVxWmVZdmdkQklJVVFaRjhaQnM2ekI5bmR3UXAwaGk5ck9zRGRnbUswcnBlMVlNVkN6Y1dGV09keXBGSENoV3h6bFJQcnVhMks1NE1kUk9GNWFndWpRTzBXeXFoT2o3cTU5bTZteEJ1WVdSeWZaRHRtMVU0UmxRPT0iLCJtYWMiOiIyMmIxZWY0ODQzZGQxNjc1NDk4M2Q3NjA4ODM2NGVjZDlhMzYzZWU2YTQ5Y2ViOTlkM2M4ZDgwNzE2NGIyZTc4In0=', 'https://member.luckybestcoin.com/wallet/deposit', 'https://member.luckybestcoin.com/wallet/deposit', 'coins', '{`foo`:{`bar`:`baz`}}', '2021-03-01 12:59:45', '2021-03-01 12:59:45');
INSERT INTO `coinpayment_transactions` VALUES (4, '2b5f5ab6-400f-4e9c-96e9-58b6fdfb7d0a', 'CPFC6KD7PLG3NB3U34Q48Z3FDJ', '603faeab2ea48', 'PapaOnline', 'aliassebatik@gmail.com', 'USD', '1614883473', '3P4BdwWJspLyr2zvgu98ZH1QCCxPtYkpH7', 10000.00, '19666000', '0.19666000', 'BTC', 2, '3P4BdwWJspLyr2zvgu98ZH1QCCxPtYkpH7', 'https://www.coinpayments.net/qrgen.php?id=CPFC6KD7PLG3NB3U34Q48Z3FDJ&key=efe79055e70d39d2d8cb3dad137a9599', '0', '0.00000000', '0', '0', 'Waiting for buyer funds...', 'https://www.coinpayments.net/index.php?cmd=status&id=CPFC6KD7PLG3NB3U34Q48Z3FDJ&key=efe79055e70d39d2d8cb3dad137a9599', '97200', 'https://member.luckybestcoin.com/coinpayment/make/eyJpdiI6Ijc2bGl3cTBMNXhNSEs2cml1Sm1kZXc9PSIsInZhbHVlIjoicnRrUkxNa0FHOHZsZld5dU8zdzhGSm1yV1dyZklQTUtLZk9tb0QxWGpTYmNURXd4cm8xZmR6NjBEcVZ2N0VMTU10b0xIZjNEZ3orUUR5WDBVTVE1MkROK0R2UlFhM3YzTEpiNEJHc05nbWE4ZG9MYytBbGNsZklYZGloSnp2UmNHYms3cjhoaW9NWU9GYVNaVmN2dlRteVRHdmdILytJSXlRbU1GYkhEWlMra1lvSm9TUjlnY1Z1U01qQ1piT0tvdmpxeElJWnJNMnBWSVRyQnplK0xhdnNobEJzV0Y1anR3aThzOENtSnh0amZsM0hRdjZjZ0V6QWVpanpSYUpWVDduaUhnTGRDOGtpa1RxT1h5ekZjd1lzRVQwNktBVGZpcGF1WVVOK0JiRG1TMmdFTFdaK2lEWXoxcXh0L2JmUFhEa3R1MG56TDVSK3ZCYzdIMDV1dnVTVmJNYTBkOEl0eWxPRGltb3Flam5nblhQYXo0UGRKNnNncFFxR3lTeGZBWXZ2S3RMZVloMWZvQ1N4akN2cERyRUlSM0lrNUgxUmVPUHZydEVOenZ0VVFYYlpaVVNDc2NxMzFHV1FXZ09sVDdjeWFsYXRkOCszMVJ1YWQxUmVOaDBlZ2g1NWd4UmFWYVoraG8ydURGWDhGeFdFVG9QdXR0SDkxQU9veU1uRkJldHJFanBOc1RlZEFGRzg2RTdhSEZMUFpaVUFMUmhkL1ZxY0dLSkZIOXhPaStkMFRCTFRJY0FLQ09ndnVCdFhVbHdENTRyaEJzeTJWaHhkaEZMTDlOSXdHTm5neHFEZ2dEb1BSYUhCVjA0RHB1d0Y5U3AxdC9oUUQ2TVpEcEpBV1BXY3FEdmVPODhoaXEzclg5KytXSFR1dEs4a3dJWXlXZG5IV2ovMXdiS3U5ODkva0FjNWtoWEdVUEJJUUxGZk9NWlN1S3NSVlAxaFBKT3ZLTTlGdzNWT0pYZ1FaY3J3cHZ3RlRmcWg4eHZ3YndOSkJzVjRNNFRUL1N6cHJTU3dhIiwibWFjIjoiNmE2ZDdjZDczNjc5ODdiODEyMjZlNjlhNjc1NmFiOWZiYmZkYTc4NjA4NDcyYzNiY2UzYWMwNGYxMjczY2Q0MSJ9', 'https://member.luckybestcoin.com/wallet/deposit', 'https://member.luckybestcoin.com/wallet/deposit', 'coins', '{`foo`:{`bar`:`baz`}}', '2021-03-03 15:44:34', '2021-03-03 15:44:34');

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `contract_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contract_price` decimal(65, 2) NOT NULL,
  `contract_pin` tinyint(4) NOT NULL,
  `contract_reward_exchange_fee` decimal(60, 2) NULL DEFAULT NULL,
  `contract_reward_exchange_min` decimal(60, 2) NULL DEFAULT NULL,
  `contract_reward_exchange_max` decimal(60, 2) NULL DEFAULT NULL,
  `contract_pin_reward_exchange_fee` decimal(60, 2) NULL DEFAULT NULL,
  `contract_pin_reward_exchange_min` decimal(60, 2) NULL DEFAULT NULL,
  `contract_pin_reward_exchange_max` decimal(60, 2) NULL DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE,
  INDEX `pengguna_id`(`user_id`) USING BTREE,
  CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES (1, 'PREMIUM', 100.00, 1, 2.00, 10.00, 100.00, 3.00, 10.00, 100.00, 1, '2021-01-15 03:09:38', '2021-01-24 12:41:50', NULL);
INSERT INTO `contract` VALUES (2, 'BRONZE', 200.00, 1, 3.00, 20.00, 200.00, 3.00, 10.00, 200.00, 1, '2021-01-15 03:13:35', '2021-01-24 12:41:57', NULL);
INSERT INTO `contract` VALUES (3, 'SILVER', 500.00, 1, 4.00, 50.00, 500.00, 3.00, 10.00, 500.00, 1, '2021-01-15 03:14:11', '2021-01-24 12:41:58', NULL);
INSERT INTO `contract` VALUES (4, 'GOLD', 1000.00, 1, 7.00, 100.00, 1000.00, 3.00, 10.00, 1000.00, 1, '2021-01-15 10:39:09', '2021-01-24 12:41:59', NULL);
INSERT INTO `contract` VALUES (5, 'PLATINUM', 2000.00, 3, 7.00, 100.00, 2000.00, 3.00, 10.00, 1000.00, 1, '2021-01-17 00:30:00', '2021-01-24 12:42:00', NULL);
INSERT INTO `contract` VALUES (6, 'DIAMOND', 5000.00, 5, 7.00, 250.00, 5000.00, 3.00, 10.00, 1000.00, 1, '2021-01-17 00:30:35', '2021-01-24 12:42:01', NULL);
INSERT INTO `contract` VALUES (7, 'CROWN', 10000.00, 9, 7.00, 500.00, 10000.00, 3.00, 10.00, 1000.00, 1, '2021-01-24 13:26:44', '2021-01-24 13:26:44', NULL);

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country`  (
  `country_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `country_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`) USING BTREE,
  INDEX `pengguna_id`(`user_id`) USING BTREE,
  CONSTRAINT `country_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 197 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO `country` VALUES (1, 'Afganistan', '93', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (2, 'Afrika Selatan', '27', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (3, 'Afrika Tengah', '236', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (4, 'Albania', '355', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (5, 'Algeria', '213', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (6, 'Amerika Serikat', '1', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (7, 'Andorra', '376', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (8, 'Angola', '244', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (9, 'Antigua & Barbuda', '1-268', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (10, 'Arab Saudi', '966', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (11, 'Argentina', '54', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (12, 'Armenia', '374', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (13, 'Australia', '61', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (14, 'Austria', '43', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (15, 'Azerbaijan', '994', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (16, 'Bahama', '1-242', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (17, 'Bahrain', '973', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (18, 'Bangladesh', '880', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (19, 'Barbados', '1-246', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (20, 'Belanda', '31', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (21, 'Belarus', '375', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (22, 'Belgia', '32', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (23, 'Belize', '501', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (24, 'Benin', '229', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (25, 'Bhutan', '975', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (26, 'Bolivia', '591', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (27, 'Bosnia & Herzegovina', '387', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (28, 'Botswana', '267', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (29, 'Brasil', '55', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (30, 'Britania Raya (Inggris)', '44', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (31, 'Brunei Darussalam', '673', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (32, 'Bulgaria', '359', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (33, 'Burkina Faso', '226', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (34, 'Burundi', '257', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (35, 'Ceko', '420', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (36, 'Chad', '235', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (37, 'Chili', '56', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (38, 'China', '86', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (39, 'Denmark', '45', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (40, 'Djibouti', '253', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (41, 'Domikia', '1-767', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (42, 'Ekuador', '593', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (43, 'El Salvador', '503', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (44, 'Eritrea', '291', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (45, 'Estonia', '372', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (46, 'Ethiopia', '251', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (47, 'Fiji', '679', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (48, 'Filipina', '63', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (49, 'Finlandia', '358', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (50, 'Gabon', '241', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (51, 'Gambia', '220', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (52, 'Georgia', '995', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (53, 'Ghana', '233', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (54, 'Grenada', '1-473', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (55, 'Guatemala', '502', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (56, 'Guinea', '224', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (57, 'Guinea Bissau', '245', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (58, 'Guinea Khatulistiwa', '240', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (59, 'Guyana', '592', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (60, 'Haiti', '509', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (61, 'Honduras', '504', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (62, 'Hongaria', '36', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (63, 'Hongkong', '852', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (64, 'India', '91', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (65, 'Indonesia', '62', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (66, 'Irak', '964', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (67, 'Iran', '98', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (68, 'Irlandia', '353', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (69, 'Islandia', '354', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (70, 'Israel', '972', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (71, 'Italia', '39', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (72, 'Jamaika', '1-876', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (73, 'Jepang', '81', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (74, 'Jerman', '49', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (75, 'Jordan', '962', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (76, 'Kamboja', '855', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (77, 'Kamerun', '237', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (78, 'Kanada', '1', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (79, 'Kazakhstan', '7', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (80, 'Kenya', '254', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (81, 'Kirgizstan', '996', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (82, 'Kiribati', '686', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (83, 'Kolombia', '57', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (84, 'Komoro', '269', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (85, 'Republik Kongo', '243', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (86, 'Korea Selatan', '82', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (87, 'Korea Utara', '850', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (88, 'Kosta Rika', '506', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (89, 'Kroasia', '385', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (90, 'Kuba', '53', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (91, 'Kuwait', '965', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (92, 'Laos', '856', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (93, 'Latvia', '371', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (94, 'Lebanon', '961', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (95, 'Lesotho', '266', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (96, 'Liberia', '231', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (97, 'Libya', '218', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (98, 'Liechtenstein', '423', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (99, 'Lituania', '370', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (100, 'Luksemburg', '352', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (101, 'Madagaskar', '261', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (102, 'Makao', '853', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (103, 'Makedonia', '389', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (104, 'Maladewa', '960', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (105, 'Malawi', '265', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (106, 'Malaysia', '60', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (107, 'Mali', '223', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (108, 'Malta', '356', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (109, 'Maroko', '212', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (110, 'Marshall (Kep.)', '692', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (111, 'Mauritania', '222', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (112, 'Mauritius', '230', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (113, 'Meksiko', '52', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (114, 'Mesir', '20', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (115, 'Mikronesia (Kep.)', '691', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (116, 'Moldova', '373', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (117, 'Monako', '377', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (118, 'Mongolia', '976', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (119, 'Montenegro', '382', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (120, 'Mozambik', '258', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (121, 'Myanmar', '95', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (122, 'Namibia', '264', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (123, 'Nauru', '674', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (124, 'Nepal', '977', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (125, 'Niger', '227', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (126, 'Nigeria', '234', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (127, 'Nikaragua', '505', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (128, 'Norwegia', '47', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (129, 'Oman', '968', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (130, 'Pakistan', '92', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (131, 'Palau', '680', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (132, 'Panama', '507', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (133, 'Pantai Gading', '225', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (134, 'Papua Nugini', '675', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (135, 'Paraguay', '595', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (136, 'Perancis', '33', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (137, 'Peru', '51', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (138, 'Polandia', '48', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (139, 'Portugal', '351', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (140, 'Qatar', '974', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (141, 'Rep. Dem. Kongo', '242', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (142, 'Republik Dominika', '1-809; 1-829', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (143, 'Rumania', '40', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (144, 'Rusia', '7', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (145, 'Rwanda', '250', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (146, 'Saint Kitts and Nevis', '1-869', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (147, 'Saint Lucia', '1-758', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (148, 'Saint Vincent & the Grenadines', '1-784', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (149, 'Samoa', '685', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (150, 'San Marino', '378', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (151, 'Sao Tome & Principe', '239', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (152, 'Selandia Baru', '64', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (153, 'Senegal', '221', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (154, 'Serbia', '381', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (155, 'Seychelles', '248', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (156, 'Sierra Leone', '232', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (157, 'Singapura', '65', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (158, 'Siprus', '357', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (159, 'Slovenia', '386', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (160, 'Slowakia', '421', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (161, 'Solomon (Kep.)', '677', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (162, 'Somalia', '252', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (163, 'Spanyol', '34', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (164, 'Sri Lanka', '94', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (165, 'Sudan', '249', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (166, 'Sudan Selatan', '211', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (167, 'Suriah', '963', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (168, 'Suriname', '597', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (169, 'Swaziland', '268', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (170, 'Swedia', '46', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (171, 'Swiss', '41', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (172, 'Tajikistan', '992', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (173, 'Tanjung Verde', '238', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (174, 'Tanzania', '255', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (175, 'Taiwan', '886', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (176, 'Thailand', '66', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (177, 'Timor Leste', '670', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (178, 'Togo', '228', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (179, 'Tonga', '676', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (180, 'Trinidad & Tobago', '1-868', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (181, 'Tunisia', '216', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (182, 'Turki', '90', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (183, 'Turkmenistan', '993', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (184, 'Tuvalu', '688', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (185, 'Uganda', '256', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (186, 'Ukraina', '380', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (187, 'Uni Emirat Arab', '971', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (188, 'Uruguay', '598', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (189, 'Uzbekistan', '998', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (190, 'Vanuatu', '678', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (191, 'Venezuela', '58', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (192, 'Vietnam', '84', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (193, 'Yaman', '967', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (194, 'Yunani', '30', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (195, 'Zambia', '260', 1, NULL, NULL, NULL);
INSERT INTO `country` VALUES (196, 'Zimbabwe', '263', 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `connection` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `queue` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `payload` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `exception` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for holiday
-- ----------------------------
DROP TABLE IF EXISTS `holiday`;
CREATE TABLE `holiday`  (
  `holiday_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `holiday_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `holiday_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`holiday_id`) USING BTREE,
  UNIQUE INDEX `hari_besar_hari_besar_tanggal_idx`(`holiday_date`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `holiday_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for invalid_turnover
-- ----------------------------
DROP TABLE IF EXISTS `invalid_turnover`;
CREATE TABLE `invalid_turnover`  (
  `invalid_turnover_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invalid_turnover_amount` decimal(65, 2) NOT NULL,
  `invalid_turnover_position` tinyint(1) NOT NULL,
  `invalid_turnover_from` bigint(20) NULL DEFAULT NULL,
  `member_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`invalid_turnover_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `member_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `member_password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `member_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `member_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `member_phone` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `member_network` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `member_parent` bigint(20) NULL DEFAULT NULL,
  `member_position` smallint(6) NULL DEFAULT NULL,
  `contract_id` bigint(20) NOT NULL,
  `contract_price` decimal(65, 2) NOT NULL,
  `country_id` bigint(20) NOT NULL,
  `due_date` date NULL DEFAULT NULL,
  `extension` int(11) NOT NULL DEFAULT 1,
  `rating_id` bigint(20) NULL DEFAULT NULL,
  `remember_token` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`) USING BTREE,
  INDEX `anggota_paket_id_fkey`(`contract_price`) USING BTREE,
  INDEX `anggota_peringkat_id_fkey`(`rating_id`) USING BTREE,
  INDEX `paket_id`(`contract_id`) USING BTREE,
  CONSTRAINT `anggota_peringkat_id_fkey` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `contract` (`contract_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, 'andifajarlah@gmail.com', '$2y$10$MsR6IRDF2P.ck.bnP7FxPuYUE38hqVJYrASdVyPNriMp7exCD9TAK', 'Andi Fajar Nugraha', 'andifajarlah@gmail.com', '6281803747336', '', NULL, NULL, 7, 10000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 10:14:27', '2021-03-03 02:50:35', NULL);
INSERT INTO `member` VALUES (3, 'SuperTeam', '$2y$10$q3Nuzd2Zr4PQ3MWx8tfHxuDOHns0KsbDzTdKSXQj8nN3COGWG8KaG', 'Rayyan anwar hidayat', 'lombokberkah01@gmail.com', '6285139083660', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 13:17:55', '2021-03-03 17:06:04', NULL);
INSERT INTO `member` VALUES (4, 'Excellent', '$2y$10$WTSgqvm2paSiwFOextQAfuSZmHcqgGI0bjP3FCZ0WPJKREiAtL4wC', 'Suratman', 'bbemailku78@gmail.com', '6287864651010', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 13:31:38', '2021-03-03 13:55:26', NULL);
INSERT INTO `member` VALUES (5, 'PapaOnline', '$2y$10$01lp2OLle/tlbZkA94h6jOwW63RkKzqaATTTzOtq/REcJ8H2VyTfS', 'Alias', 'aliassebatik@gmail.com', '6282353468257', '', NULL, NULL, 6, 5000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 14:28:02', '2021-03-03 23:47:22', NULL);
INSERT INTO `member` VALUES (6, 'GAJAHMADA', '$2y$10$dNY1j3ibng0N0XVrnbxzauVC5WGNhiZPfBysas0rUWMHJLeG4sp4W', 'I Wayan Gina', 'wayanginajaya@gmail.com', '62818544080', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 14:39:37', '2021-03-03 23:54:08', NULL);
INSERT INTO `member` VALUES (7, 'SemutMerah', '$2y$10$HbyBFTRsU63K6QuQRCHtfuW0RjxUpCFCLUp246wVF8cB1wcNSnyvy', 'Zainul Wasti', 'semutmerah012021@gmail.com', '6287761477717', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 15:13:33', '2021-03-03 13:44:02', NULL);
INSERT INTO `member` VALUES (8, 'GUNTURTKER', '$2y$10$/W3XfjhKo3fWJ2KwS9iGwOdBqMpR0Ovfat04ZLKaHxLzgoP7jPNXS', 'Lalu Muhammad Saleh', 'lalusaleh2016@gmail.com', '6281907986621', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 15:20:37', '2021-03-03 16:20:03', NULL);
INSERT INTO `member` VALUES (9, 'Antmaster01', '$2y$10$eFMZTwtuBfChQ218PdFTiueCu.AcndUNLnifxFJt27dI6hv9dlAJa', 'Anthony', 'msquaremedan@gmail.com', '62811637369', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-01 23:45:13', '2021-03-03 08:37:30', NULL);
INSERT INTO `member` VALUES (12, 'Super01', '$2y$10$PvccZeNdGoDaIwWnqjqsF.ItVCTsttg3mJDiDg5I0YGwXOv1K3QIe', 'Anwar', 'lombokberkah02@gmail.com', '6285139083660', '3ki', 3, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 06:40:44', '2021-03-03 16:02:17', NULL);
INSERT INTO `member` VALUES (13, 'Team01', '$2y$10$kBXxB55JuVAEbEb8OfxTOu2YY5gEY64PrIJW8faXC3XenjEKp4Syu', 'Asmini', 'lombokberkah03@gmail.com', '6285139083660', '3ka', 3, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:05:17', '2021-03-03 15:45:42', NULL);
INSERT INTO `member` VALUES (14, 'PapaOnline2', '$2y$10$I31k.GCb09MddoXvpsHuJuKH8ME08.3npt1qZItiLEmreGkOV0vEG', 'alias', 'papaonlaine@gmail.com', '6282353468257', '5ki', 5, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:12:43', '2021-03-03 15:05:07', NULL);
INSERT INTO `member` VALUES (15, 'PapaOnline3', '$2y$10$mdC/4rxsMjmox.QgSVmnGeymRIOv.da7ON8xnk9J4NG2E3Z/KH2di', 'alias', 'papaonline6@gmail.com', '6282353468257', '5ka', 5, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:16:56', '2021-03-03 15:17:17', NULL);
INSERT INTO `member` VALUES (16, 'qilara', '$2y$10$PtT.9KWw7bKaATlnx7C94e1xyRW7TiS/VlD.7zedGuKYKz06Yyqye', 'Hendro Sutrisno', 'motor.hendro@gmail.com', '6281907075000', '5ka15ka', 15, 1, 6, 5000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:23:27', '2021-03-03 16:58:08', NULL);
INSERT INTO `member` VALUES (17, 'GAJAHMADA01', '$2y$10$EEu0vHpC/GMtrrxo7j42ieirGf4CO.aYiPzWSPgePeoBInQGR5r7y', 'I Wayan Gina', 'wayanginajaya999@gmail.com', '62818544080', '6ki', 6, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:35:09', '2021-03-03 14:19:18', NULL);
INSERT INTO `member` VALUES (18, 'SM01202101', '$2y$10$oRG4ixMNxRIMnYQNq8Y9.OwDkAyV6IYmWmufsmZbroRbHxNtfu9xO', 'Zainul wasti', 'sm01202101@gmail.com', '6287761477717', '7ki', 7, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:35:43', '2021-03-02 07:37:00', NULL);
INSERT INTO `member` VALUES (19, 'master', '$2y$10$kOw.42f8aymrRjFDPfCHyuDcbnQgdg25u13KCwhNTs.9UXeSowh8.', 'NURUL WATHANI', 'thonystar@gmail.com', '6281917223398', '5ka15ka16ka', 16, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:38:47', '2021-03-03 17:03:15', NULL);
INSERT INTO `member` VALUES (20, 'GAJAHMADA02', '$2y$10$vWXBpYgggiyhOtTyM.qu8OkxG/kX8UKNhk0nNz/FI0HPAswLIefxu', 'I Wayan Gina', 'wayanginajaya888@gmail.com', '62818544080', '6ka', 6, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:44:05', '2021-03-03 14:09:37', NULL);
INSERT INTO `member` VALUES (21, 'Super02', '$2y$10$ZhzLc0A0i6McaYQ1yObFh.yVto5Qcbw9YBuYkQBbQ5YRRFrliF9T6', 'Rayyan', 'lombokberkah04@gmail.com', '6285139083660', '3ki12ki', 12, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:48:59', '2021-03-03 16:03:01', NULL);
INSERT INTO `member` VALUES (22, 'Team02', '$2y$10$BTZjdoGRM2MTlqAmXGuCaOKvkqizowsASRGRZ08.xEIWHoscn6HQu', 'Fitriana junisa', 'lombokberkah05@gmail.com', '6285139083660', '3ka13ka', 13, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 07:54:16', '2021-03-03 16:03:26', NULL);
INSERT INTO `member` VALUES (24, 'HHT CENTER', '$2y$10$/Z10ZtwVoCnbFw7hLCvN.e03YQWWKIVwlXDmgD57Xn0ivOzw.GJ2C', 'H HENDI ASMAHESA PUTRA', 'hhtcenter1@gmail.com', '6285237155540', '3ka13ka22ka', 22, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 10:21:22', '2021-03-03 22:47:38', NULL);
INSERT INTO `member` VALUES (25, 'MUHAMMAD', '$2y$10$vAsYEyR3MT5BsbDSKgmQheU27qY5KFiYER09t/b4wiiuS1sdh5lnO', 'MUHAMMAD WAHYUDI', 'muhammadmw1983@gmail.com', '6285337916119', '3ki12ka', 12, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 10:52:13', '2021-03-03 23:58:50', NULL);
INSERT INTO `member` VALUES (26, 'SM01202102', '$2y$10$J48nbuZVADzueh9hpundFeSxv04Z7xZlmbahX10PIMEEvhdfXSHMS', 'SM02', 'sm01202102@gmail.com', '6287761477717', '7ka', 7, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 11:12:32', '2021-03-03 04:36:49', NULL);
INSERT INTO `member` VALUES (27, 'JENDRAL', '$2y$10$6mKGOUITEZkeQ4Gm.GrwZeSk2PHDhCohKoXIPayOmxsueS6payEiS', 'H.yusril hamdani', 'yusrilhamdani.yh@gmail.com', '6281907815055', '3ka13ki', 13, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 11:35:07', '2021-03-03 16:39:24', NULL);
INSERT INTO `member` VALUES (28, 'Agung01', '$2y$10$oJ3l/879ShoUZordemywY.eTXtnhYKU.5wULsTm4Ap0AwZbpz1CQ2', 'Hamid', 'hamidagung433@gmail.com', '6287765045877', '3ka13ka22ki', 22, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 11:42:21', '2021-03-03 21:20:13', NULL);
INSERT INTO `member` VALUES (29, 'HWSLOMBOK', '$2y$10$AKjptxiStmdoP57OdBTzX.vRQ7OU5PpHw2QEaDXXBhr45glD6bSu.', 'HAMZANWADI ', 'hwsoundlombok@gmail.com', '6281907858333', '3ki12ki21ki', 21, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 11:57:12', '2021-03-03 23:47:12', NULL);
INSERT INTO `member` VALUES (30, 'ArniLbc', '$2y$10$TGoPIORlYiJpC9/s7uP9CuS7iSKVOrl6eB1MXNlQi1Dkw7CjYUbLu', 'Arni', 'arnimariani70@gmail.com', '6281344478920', '3ki12ki21ka', 21, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 12:00:28', '2021-03-03 15:58:02', NULL);
INSERT INTO `member` VALUES (31, 'JENDRAL2', '$2y$10$XSTR2BYTK63AM/1c76wdeOgT1aIvojy6mL.YBoPYlOhBdutdfTETu', 'H. YUSRIL HAMDANI', 'yusrilhy212@gmail.com', '62081907815055', '3ka13ki27ka', 27, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 12:40:44', '2021-03-03 07:34:59', NULL);
INSERT INTO `member` VALUES (32, 'JENDRAL3', '$2y$10$9llDXsMAJARD7bIDBJklnuSGregLCXiCKO5iA2GguzMok/3VbMMkC', 'JENDRAL3', 'dimashiporia@gmail.com', '62081907815055', '3ka13ki27ki', 27, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 12:52:25', '2021-03-03 22:37:31', NULL);
INSERT INTO `member` VALUES (33, 'mzwfam03', '$2y$10$eXRr3uoi6y/QAUTKJ9CPGOVpK6USiIG8FbGnFV5ghhSoeOdcR853m', 'MZW family', 'mzw032021@gmail.com', '6282310079978', '7ka26ki', 26, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 13:59:57', '2021-03-02 19:48:08', NULL);
INSERT INTO `member` VALUES (34, 'SM_Team08', '$2y$10$IChpkV2VgUsifDPWGxVUEOQy12D/ZZAZWhQyr5dMELkcDRRXbPy4W', 'SemutMerah_Team', 'smteam052021@gmail.com', '6282310079978', '7ki', 7, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 14:18:18', '2021-03-03 09:47:17', NULL);
INSERT INTO `member` VALUES (35, 'SM_Team06', '$2y$10$EaoMh7tF4GUufT7CAtxIHONZUYUalQqUiZQ52inAIc6gMNqWYJagG', 'SM_Team06', 'smteam062021@gmail.com', '6282310079978', '7ka26ki33ki', 33, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 15:04:28', '2021-03-03 11:48:42', NULL);
INSERT INTO `member` VALUES (36, 'Taoke_01', '$2y$10$cqrFqjqcWSqvt1tR6zNGRu.TUtbaBx0xJ/D0HcySalZnoikD99jbe', 'MUHAMAD AZAM ASRORI ', 'asroriazam@gmail.com', '6287750008595', '7ka26ki33ki35ki', 35, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 15:19:28', '2021-03-03 14:08:32', NULL);
INSERT INTO `member` VALUES (37, 'Taoke_02', '$2y$10$v5mD8l0V27sSwseMti8xUOChtt6R5NWQh1aG6cymYysHyISEhqCEO', 'DHIA ANISA RUQYATIL ASROR', 'dhiaanisara@gmail.com', '6287750008595', '7ka26ki33ki35ki36ki', 36, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 15:41:44', '2021-03-03 13:55:59', NULL);
INSERT INTO `member` VALUES (38, 'Taoke_03', '$2y$10$DH0vpRXbAYe6UOZVqa52YuDY.tlDreR2ZXlKcOJkBeamYzefk80ya', 'FAIDA NATHANIA ASROR', 'nathaniaasror@gmail.com', '6287750008595', '7ka26ki33ki35ki36ka', 36, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 15:48:18', '2021-03-03 12:37:05', NULL);
INSERT INTO `member` VALUES (39, 'Johana', '$2y$10$LlSWCxnz8RFUNwfelTkWBei//f0DXfCV88mBtsNRffrI1M20CeQPC', 'johana', 'a.liassebatik@gmail.com', '6282353468257', '5ki14ki', 14, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 16:39:32', '2021-03-03 19:39:08', NULL);
INSERT INTO `member` VALUES (40, 'ABU BAKAR', '$2y$10$krp1cp4hE9lA5LXeMQ0WEO/u1lYj9AfUDMXuTdTPpn/ipTWXhfPnm', 'HAMZAH DJAMALLULAIL', 'djamallulailhamzah@gmail.com', '6281907553999', '3ki12ka25ka', 25, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 18:19:10', '2021-03-03 10:32:54', NULL);
INSERT INTO `member` VALUES (41, 'UMAR', '$2y$10$Oo1fYJxza6yTALya3w9/FOi/8wBzjIwgAN42IaFgTxzWEjqRCr9wS', 'Muhammad Asman', 'asmanjaya016@gmail.com', '6281217678788', '3ki12ka25ki', 25, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 18:28:34', '2021-03-03 10:46:34', NULL);
INSERT INTO `member` VALUES (42, 'mzwfam', '$2y$10$pAMDg4/xHXK67QBHuU.ewuq8qyp5PLpdVI6V.PtU2F39X0LqQULlm', 'mzwfam', 'mzw042021@gmail.com', '6287761477717', '7ka26ka', 26, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 19:56:24', '2021-03-02 20:05:13', NULL);
INSERT INTO `member` VALUES (43, 'sugihmotah01', '$2y$10$G3JCyrrd.pngCIWMArFA3Ores7yQA.VKljJe5FAFZRGf8EqIip7Mi', 'LUKMANUL HAKIM', 'lukmanulhakim474@gmail.com', '6281917047317', '', NULL, NULL, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 22:45:18', '2021-03-03 22:33:14', NULL);
INSERT INTO `member` VALUES (44, NULL, NULL, 'Lalu Muhammad Saleh', 'salehlalu596@gmail.com', '6281907986621', '8ki', 8, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 22:53:33', '2021-03-02 22:53:33', NULL);
INSERT INTO `member` VALUES (45, 'GUNTURTKER1', '$2y$10$xbXeI6kKs9yelGWOyttSRe864I1sus1lUAUuQ5bKMK3SspqztagVm', 'Lalu Muhammad Saleh', 'lalumuhammadsaleh181@gmail.com', '6281907986621', '8ka', 8, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-02 22:57:38', '2021-03-03 12:35:22', NULL);
INSERT INTO `member` VALUES (46, 'dayock1', '$2y$10$r5.QKragqyACVbwBjua7U.4W/508ACiNSN77n39YTUGusaTnDybrm', 'Nurul Hidayati', 'dayock1982@gmail.com', '62087762617503', '43ki', 43, 0, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 23:07:08', '2021-03-04 00:02:54', NULL);
INSERT INTO `member` VALUES (47, 'sugihmotah02', '$2y$10$dKqkLvCGSWpSdD3BYT/PX.BL3Syt2zy66TSUuNqKWjzV50w/2mLtq', 'lukmanul hakim', 'lukmanulhakim974@gmail.com', '62082359249648', '43ka', 43, 1, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 23:14:32', '2021-03-02 23:20:41', NULL);
INSERT INTO `member` VALUES (48, 'FIRMANJUNDI', '$2y$10$yecf8LKekP4JaTNnWcKs0.jzRGtXmJV6yiyAc2qje7JFelLRlyZui', 'Lalu firman Jundi Hidayatullah', 'salehraden098@gmail.com', '628594200161', '8ki', 8, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-02 23:29:54', '2021-03-03 12:48:50', NULL);
INSERT INTO `member` VALUES (49, NULL, NULL, 'Baiq raodatul hamdiati', 'tkerguntur098@gmail.com', '6285954487288', '8ka', 8, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-02 23:38:50', '2021-03-02 23:38:50', NULL);
INSERT INTO `member` VALUES (50, 'Andra88', '$2y$10$yjbijbZvVnbbi5tpX4ywjulZZJI1wsNTECabc.bvPnfC.AaCFzYQu', 'Suratman', 'bbemailku80@gmail.com', '6287864651010', '4ki', 4, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-02 23:58:34', '2021-03-03 00:32:57', NULL);
INSERT INTO `member` VALUES (51, 'Excellent88', '$2y$10$4npiJtZYm/aqEdh9z9Z9RO/gOdwUUbZcMyRMxuzoaZnJTpeyJJAa.', 'Suratman', 'bbemailku81@gmail.com', '6287864651010', '4ka', 4, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 00:06:17', '2021-03-03 00:09:51', NULL);
INSERT INTO `member` VALUES (52, 'hibarisatria', '$2y$10$P.S2LmFzq8qlcrwv9SMwouO1cxdukhwiCOMWGAd5FvsqQLwsNKSom', 'Lalu Satria malaca', 'hibarisatria@gmail.com', '6287803274249', '4ki50ki', 50, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 00:24:22', '2021-03-03 15:48:40', NULL);
INSERT INTO `member` VALUES (53, 'DOAIBU', '$2y$10$k1qI9H7PzalNASlpzEnKNOX..ttBkTR4s.jdZU.cCggmbYWhZ1kX2', 'SUMINTO', 'mintojaya1405@gmail.com', '6281936781404', '6ki17ki', 17, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 01:17:35', '2021-03-03 01:57:45', NULL);
INSERT INTO `member` VALUES (54, 'Andilove02', '$2y$10$dD2ZZtnL0sD1wWK8WfcGzO8m5dEQu7f/ijkQe3z92LQJOj.rHrEEe', 'Asmawati', 'bongor1976@gmail.com', '6282340940765', '4ki50ki52ki', 52, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 01:46:56', '2021-03-03 02:08:06', NULL);
INSERT INTO `member` VALUES (55, 'DatuPejanggik', '$2y$10$BVDEnLqf7MSoLSV/AVMPouxXMAZ73CLI3BPy4h0dyuluvUqE90cSC', 'Januari Lesmana', 'lerylesmana9@gmail.com', '6285338941988', '4ki50ki52ki54ki', 54, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 02:05:38', '2021-03-03 18:08:38', NULL);
INSERT INTO `member` VALUES (56, 'DatuSelaparang', '$2y$10$UASHNmgWEd5pnRrNxhHx8emQmtkH.hgUWv.4tx6VypCIYdF46SQq.', 'Januari lesmana', 'soldierwinter782@gmail.com', '6285338941988', '4ki50ki52ki54ki55ki', 55, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 02:11:35', '2021-03-03 18:05:00', NULL);
INSERT INTO `member` VALUES (57, 'Lilik01', '$2y$10$tL4ZIpLQ3B5dlZcPr3f2RuhGyqe2ij0GpJvPCSMaI0SkvQcQoCT7W', 'Lilik Indrawati', 'lilikindrawati182@gmail.com', '6282186967844', '4ki50ki52ki54ki55ki56ki', 56, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 02:55:25', '2021-03-03 17:15:13', NULL);
INSERT INTO `member` VALUES (58, 'BEGER1', '$2y$10$TU6NZp/6rq6FuN3Tmq83juf4j/e.scjM.AQ2Ut3aTSCJvpcq6PZq6', 'Lalu alwanul hamdi', 'alwanulhamdi76@gmail.com', '6281805286533', '8ka', 8, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 04:56:43', '2021-03-03 23:07:48', NULL);
INSERT INTO `member` VALUES (59, NULL, NULL, 'NURDIN', 'dinn44554@gmail.com', '6281946576108', '8ki', 8, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 05:09:15', '2021-03-03 05:09:15', NULL);
INSERT INTO `member` VALUES (60, 'toyadirich', '$2y$10$jrMmNJsh2klpgjPyIQXrp.znnLDpGDQH7pasVFxYs.psi5ReXjG5K', 'Wayan Toyadi', 'toyadi2017@gmail.com', '6281337043330', '6ka20ki', 20, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 05:29:53', '2021-03-03 22:58:29', NULL);
INSERT INTO `member` VALUES (61, 'ARGANTA1', '$2y$10$IyGhzfpN2JXzvNNTxkLgGOZA/5F97g3HRulw8UdEOeMB60ly3DakK', 'Lamtanus S.H', 'lamtanuss@gmail.com', '6281805777260', '8ki', 8, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 07:34:15', '2021-03-03 21:07:02', NULL);
INSERT INTO `member` VALUES (62, 'ARGANTA2', '$2y$10$YnSF5qPWBfjkSwumnHrxjed8398znpECgRwP6UoYhrzvs9V16L1pu', 'Lamtanus SH', 'lamtanusimam@gmail.com', '6281805777260', '8ki61ki', 61, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 08:03:19', '2021-03-03 08:04:32', NULL);
INSERT INTO `member` VALUES (63, 'ALWANUL01', '$2y$10$wZ0N0IMgkw3Wm9dsKg81MOYQRLqGx3w9DS4E7W.nNPlAOe3KZFKX.', 'Lalu alwanul hamdi', 'albytsaqib20@gmail.com', '6281805286533', '8ka58ka', 58, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 08:06:59', '2021-03-03 13:16:54', NULL);
INSERT INTO `member` VALUES (64, 'ALWANUL02', '$2y$10$Zg4vsSX4KIwEB5QL4hr8D.HMV1zd9sPyst77ngtnVjmiBiqPC81wS', 'Lalu alwanul hamdi', 'hamdilalu76@gmail.com', '6281805286533', '8ka58ki', 58, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 08:12:04', '2021-03-03 13:36:13', NULL);
INSERT INTO `member` VALUES (65, 'SAMSUL881', '$2y$10$rqsr6Uf/AQdjTaoBkTD5juWb1X8dlHc76HBsT8eeQKQuMoNjILrB.', 'SAMSUL HADI', 'samsulrina31@gmail.com', '6281914833867', '8ki61ka', 61, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 08:17:08', '2021-03-03 12:30:46', NULL);
INSERT INTO `member` VALUES (66, 'ALWANUL03', '$2y$10$ngdG6EBWXrp6lD/6T1gdNuM5xfIagkVXssYt5myBBVgJ7eeDBC8yW', 'Lalu Alwanul Hamdi', 'hannabaiq76@gmail.com', '6281805286533', '8ka58ka', 58, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 08:26:34', '2021-03-03 13:37:34', NULL);
INSERT INTO `member` VALUES (67, 'Chikofam_a', '$2y$10$l4xg5H/HdXLG1jeZqGrmHucqnYc8noFW0rPLga1JAkIdu9Fqup49S', 'mzwfam', 'mzw012021@gmail.com', '6282310079978', '7ki34ki', 34, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 09:34:42', '2021-03-03 12:21:59', NULL);
INSERT INTO `member` VALUES (68, 'Chikofam_b', '$2y$10$kyIHiHJlblFp9D4sjSXVXe2M1FVGffz0hOwKiuPC0onCzavZ1h9d6', 'mzw family', 'mzw022021@gmail.com', '6282310079978', '7ki34ka', 34, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 09:42:56', '2021-03-03 11:09:02', NULL);
INSERT INTO `member` VALUES (69, 'smteam$', '$2y$10$c/P5icYSXIfNtawUHO4T4.De/lhK2Q0vFjouzqGYuW3Nqq6dgmdbu', 'SM Team', 'smteam012021@gmail.com', '6287761477717', '7ki34ki67ki', 67, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 09:59:11', '2021-03-03 11:38:33', NULL);
INSERT INTO `member` VALUES (70, 'smteam#', '$2y$10$lR7eJfFv9oKA8bIb0Z5RkOYqdcA0oNUv4M9xO9UkLKYVQIGvUmCJy', 'SM Team', 'smteam022021@gmail.com', '6287761477717', '7ki34ki67ka', 67, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 10:00:43', '2021-03-03 12:38:11', NULL);
INSERT INTO `member` VALUES (71, 'WAHYURICH', '$2y$10$U.4MczhUs3FMzB5Cm7c3MO5y2JY3KoVzuU2FQFkW5mdtmQ65qiFp6', 'Muhammad Wahyudi', 'wahyurich2019@gmail.com', '6285337916119', '3ki12ka25ka40ki', 40, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 10:30:43', '2021-03-03 10:32:54', NULL);
INSERT INTO `member` VALUES (72, 'HAMZAH01', '$2y$10$paRufz.cOtb5tcsnyDktO.0/8opYvCkUHG6BywDL1bGMk.v72IRmq', 'Hamzah Djamallulail', 'hamzahlbc1@gmail.com', '6281907553999', '3ki12ka25ki41ki', 41, 0, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 10:43:25', '2021-03-03 23:17:19', NULL);
INSERT INTO `member` VALUES (73, NULL, NULL, 'Nengah Suta Antara', 'sutaantara14@gmail.com', '6282339912622', '6ka20ki60ki', 60, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 10:52:32', '2021-03-03 10:52:32', NULL);
INSERT INTO `member` VALUES (74, 'HAMZAH02', '$2y$10$dc5zbcoDHyxPWeJ52.ky2.XmmHcIIZEC1a9PQbi.xsgdve9K7MUVK', 'Hamzah Djamallulail', 'hamzahlbc2@gmail.com', '6281907553999', '3ki12ka25ki41ki72ki', 72, 0, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:06:18', '2021-03-03 23:19:30', NULL);
INSERT INTO `member` VALUES (75, NULL, NULL, 'Sulham', 'sulham027@gmailcom', '6287851669851', '7ki34ki67ki69ki', 69, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:17:03', '2021-03-03 11:17:03', NULL);
INSERT INTO `member` VALUES (76, 'Rinjanilombok', '$2y$10$0bMrF7oxTVUaJULLO.7y2.vmN5x6q8bE/t/GzF6.FYsYGc28ONH2q', 'SAGGAP', 'saggafzianzian@gmail.com', '6281805442233', '7ki34ki67ki69ka', 69, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:23:02', '2021-03-03 23:50:02', NULL);
INSERT INTO `member` VALUES (77, NULL, NULL, 'Gede Eka Puja Dyatmika', 'gedeekapuja@gmail.com', '62081338544538', '6ki17ka', 17, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:28:24', '2021-03-03 11:28:24', NULL);
INSERT INTO `member` VALUES (78, 'Leadersaok', '$2y$10$7GeY6uTC.PDQ.BYmJJ8a3utyxz4QWeV5j.gVSz2y2USzzZBfuPSWW', 'Sulhamna', 'sulham027@gmail.com', '6287851669851', '7ki34ki67ki69ki', 69, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:41:25', '2021-03-03 12:39:57', NULL);
INSERT INTO `member` VALUES (79, 'Hafizib7', '$2y$10$jiMz/guGhy3gkIwq5kiEfecpb259cmjbQSY70tnbF/tMWJCav.IdK', 'HAFIZ IBRAHIM', 'hafiz.ibam7@gmail.com', '6285337454858', '7ka26ki33ki35ki36ki', 36, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:42:11', '2021-03-03 23:19:05', NULL);
INSERT INTO `member` VALUES (80, 'Haqqi2021', '$2y$10$htLfCUsFr9I9eZOvzb2bdecvMx91FG9DlN1ZLJAtkpaVvWR5tRc6W', 'Saggap', 'hazanalhaqqidarojat@gmail.com', '62801805442233', '7ki34ki67ki69ka76ki', 76, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:42:50', '2021-03-03 17:44:40', NULL);
INSERT INTO `member` VALUES (81, 'Aripianhazami', '$2y$10$qA.zNqf9iPuQhBH1NyMdeeSpn/WEYkpeiSGup.r63gAht.b7TIFGy', 'Saggap', 'aripianhazami@gmail.com', '6281805442233', '7ki34ki67ki69ka76ka', 76, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:55:02', '2021-03-03 23:45:23', NULL);
INSERT INTO `member` VALUES (82, 'sudaesallomboki', '$2y$10$wvA6tSuQQKfKTHks3D9hLeAImxWDaYaXTXIwr08zxDmOpeb5a6QEK', 'H Sudaes', 'abdurrahmanassudaes9@gmail.com', '6283832178549', '7ka26ki33ki35ka', 35, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 11:58:10', '2021-03-03 16:43:31', NULL);
INSERT INTO `member` VALUES (83, 'Leadersaok01', '$2y$10$e2akUCym7ImJY2t9N5MHDu3gKoptEIWizBbb3/wQifGdep.0RgacW', 'Sulham', 'sul121751@gmail.com', '6287851669851', '7ki34ki67ki69ki78ki', 78, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:11:46', '2021-03-03 12:17:04', NULL);
INSERT INTO `member` VALUES (84, 'datudahe', '$2y$10$VGrc6qZXTwbhtfyIS8vKlOaFmelX949TImLcet4cC863AiUfjtxxS', 'MUHAMMAD RODHI TAUFIK', 'datudahe1983@gmail.com', '6285238577473', '7ka26ki33ki35ki36ka38ka', 38, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:21:21', '2021-03-03 21:36:43', NULL);
INSERT INTO `member` VALUES (85, 'Leadersaok02', '$2y$10$ZYfOoci4FvhZ9V78F9fXqO/N21IhYM5oJWI7hoAeVd7/1eNi99nP2', 'Sulham', 'sulh8315@gmail.com', '6287851669851', '7ki34ki67ki69ki78ka', 78, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:27:02', '2021-03-03 12:37:35', NULL);
INSERT INTO `member` VALUES (86, 'Kaloskaya', '$2y$10$ZKBAzfffrPizkg03sI/1p.INUF2iMEGxAQXxQMVGpCg3hiIob6n4O', 'MUHAMMAD NURDAUD FATONI', 'dreamtofuture.76@gmail.com', '6282339046449', '7ka26ki33ki35ki36ka38ka84ki', 84, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:32:56', '2021-03-03 12:59:38', NULL);
INSERT INTO `member` VALUES (87, 'LBC_SMzaini', '$2y$10$.sIbKIkfe6CDPDoBHurQEudIHCGvVIQ1HWlTlYe85kdb3zqnSmMP.', 'Zaini Usman', 'putrawanzaini123@gmail.com', '6281805785513', '7ki34ki67ka70ki', 70, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:33:08', '2021-03-03 23:52:48', NULL);
INSERT INTO `member` VALUES (88, 'ERWIN11', '$2y$10$XFr..W9GNLHO3vU0CG1wQONh4BJUo0OQkL3zUSbaBLRkOTIRn5CRq', 'Erwin efendi', 'revaazahra85@gmail.com', '62087754501894', '8ka45ki', 45, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:33:09', '2021-03-03 23:46:21', NULL);
INSERT INTO `member` VALUES (89, 'ERWIN22', '$2y$10$UT1/JwDomNM/dAjOEyOOg.alxZ4Rg6Afz7BobFjmKCk5wlxfGFz8q', 'Erwin efendi', 'erwinefendi4445@gmail.com', '6287754501894', '8ka45ki88ka', 88, 1, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:38:38', '2021-03-03 12:50:09', NULL);
INSERT INTO `member` VALUES (90, 'ERWIN33', '$2y$10$hpfYSOlc3U1AGDSYntXHGuuaZv6u6Kjw/PXEpprXMRbtg84JpBEt2', 'Erwin efendi', 'wiendy780@gmail.com', '6287754501894', '8ka45ki88ki', 88, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:42:26', '2021-03-03 12:52:25', NULL);
INSERT INTO `member` VALUES (91, 'NURDIN1986', '$2y$10$gqK70Cj7cn5i/i/HhOWfL.tgE4y9qXR50e1cN.xnD5HudAmthPHwy', 'NURDIN', 'dinn45544@gmail.com', '6281946576108', '8ki48ki', 48, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:45:23', '2021-03-03 23:18:27', NULL);
INSERT INTO `member` VALUES (92, 'Lbcsmputriz', '$2y$10$Z5ZdAUdsZOusU45pZE9kguI3ulyJSqExlb9gBA9EO7BQRAOtShUJi', 'PUTRI ZASKIA ZAINI', 'putrizaskiya9@gmail.com', '6281805785513', '7ki34ki67ka70ki87ki', 87, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:53:13', '2021-03-03 22:07:28', NULL);
INSERT INTO `member` VALUES (93, 'MAJID01', '$2y$10$NL8Rbl3FjdaVZ4NTd2vmZO6pV.cXZiJPaU98F6DKIFbOiaz1KY9OG', 'LALU ABDUL MAJID', 'laluabdulmajid120876@gmail.com', '6285237052949', '8ka58ka66ka', 66, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 12:56:36', '2021-03-03 23:29:19', NULL);
INSERT INTO `member` VALUES (94, 'lbcsmniha', '$2y$10$jK56qlgkVCsimWiRUzKrmeKIABY5udMzOYhxZMp1/kZDEJIx9toX2', 'NEHAYATUZZEN', 'nihazaini4@gmail.com', '6281805785513', '7ki34ki67ka70ki87ka', 87, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:05:06', '2021-03-03 23:49:26', NULL);
INSERT INTO `member` VALUES (95, 'ALWANUL04', '$2y$10$13sXJInaEfcl3I9vXk3rS.92d4hul.KUHqv9bLpCeODgris82uux6', 'Lalu Alwanul hamdi', 'baiqsahuri50@gmail.com', '6281805286533', '8ka58ki', 58, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:09:08', '2021-03-03 14:00:40', NULL);
INSERT INTO `member` VALUES (96, 'NURDIN198601', '$2y$10$FKhuxPQJsMWafcXFV6/DQ.mzRzGRjPNtAYHMuVDjyAJwL8EsTeFUe', 'Nurdin', 'muhammadnizar3334@gmail.com', '6281946576108', '8ki48ki91ka', 91, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:14:23', '2021-03-03 13:37:02', NULL);
INSERT INTO `member` VALUES (97, 'MAJID02', '$2y$10$MEaQtdhLGoCTtDwzmlnsLuSxwLLEkBwxOVrOpZgExEhtJcXqreWyG', 'Lalu Abdul Majid', 'halil123haji@gmail.com', '6285237052949', '8ka58ka66ka93ka', 93, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:17:30', '2021-03-03 23:23:05', NULL);
INSERT INTO `member` VALUES (98, 'JAWARASASAK01', '$2y$10$N6/KxWTy3Mf7JlFi/nM9Uuko0wcsFZs42NPnjrPoOnaLE41Fq6OtG', 'Haji murgasih', 'hjmurgasih@gmail.com', '6281775000727', '8ki48ki91ka96ka', 96, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:23:19', '2021-03-03 23:35:40', NULL);
INSERT INTO `member` VALUES (99, 'MYUNUS01', '$2y$10$uQ6m534zwHy73clmvq.jj.TmyI9UKJQ1tpJ8fcn/KSnNRvlr9JES6', 'MUHAMMAD YUNUS', 'myunusyuan@gmail.com', '6281929050299', '8ka58ki95ka', 95, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:26:38', '2021-03-03 14:10:31', NULL);
INSERT INTO `member` VALUES (100, 'MYUNUS02', '$2y$10$R/nIQ4K44tzj1XrDaq1I1ukKrb78a1KuDbctu91D.08u/QESq/CbS', 'Muhammad Yunus', 'yunusyuan01@gmail.com', '6281929050299', '8ka58ki95ka99ka', 99, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:38:49', '2021-03-03 13:43:26', NULL);
INSERT INTO `member` VALUES (101, 'MAJID03', '$2y$10$hViWPnW5knQOVY/qzynf0el2ywEzSOT.3klcMZAsN1GqbLCaTW8H6', 'Lalu Abdul Majid', 'lalupanjipparawangsa@gmail.com', '6287865593118', '8ka58ka66ka93ki', 93, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:42:52', '2021-03-03 22:45:08', NULL);
INSERT INTO `member` VALUES (102, 'JAWARASASAK02', '$2y$10$ofF7xX4xJfnfE2OIujYfquc6GBlKyNxUprw5VrOGByyrwL4FzbFjm', 'Haji murgasih', 'satryasasak@gmail.com', '6281775000727', '8ki48ki91ka96ka98ka', 98, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:49:12', '2021-03-03 23:34:58', NULL);
INSERT INTO `member` VALUES (103, 'MYUNUS03', '$2y$10$/NDUYT.4Ke9XmpHB.Ic8r.Fmw311d19EqYdd1QegDP/QuGnf5g096', 'Muhammad Yunus', 'myunusyuan02@gmail.com', '6281929050299', '8ka58ki95ka99ki', 99, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 13:53:59', '2021-03-03 14:09:53', NULL);
INSERT INTO `member` VALUES (104, 'Ihsan1997', '$2y$10$TsCq0vhN0qOTPEw852/RDO0kzLUuFiXrvb6s9LxwZYBH7jFYNSOne', 'MISJARUDDIN', 'misjaruddin73@gmail.com', '6287863481750', '7ki34ki67ki69ka76ki', 76, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:00:39', '2021-03-03 23:33:26', NULL);
INSERT INTO `member` VALUES (105, 'Puspita01', '$2y$10$AaNzDdbnMOxuQRJ.UlndoeTVFUwOI6zrbLPAdeIbTerwO7.K9reQq', 'Leni puspita Dewi', 'lenipuspitadewi97@gmail.com', '6282186967844', '4ki50ki52ki54ki55ki56ki57ki', 57, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:03:00', '2021-03-03 18:17:19', NULL);
INSERT INTO `member` VALUES (106, 'RINJANI007', '$2y$10$afv4GePMCIZTotoXXREY7eJjuRGaKZsCu7JUAZrfaNoFyntErq/gm', 'Muhammad fikri', 'Opickchocolatos007@gmail.com', '6285337501468', '4ki50ki52ki54ki55ki56ki57ki105ki', 105, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:12:40', '2021-03-03 15:25:36', NULL);
INSERT INTO `member` VALUES (107, 'Zalila2006', '$2y$10$hd6YZTlfcqi/KbG0bKQHjuYv.8BMSSMPOkD5V4Sj/1eP4o1EHSfga', 'Misjaruddin', 'muaddah77@gmail.com', '6287863481750', '7ki34ki67ki69ka76ki104ki', 104, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:22:19', '2021-03-03 14:31:55', NULL);
INSERT INTO `member` VALUES (108, 'PRABU BAKE 007', '$2y$10$u/tVGOht5Dd15g8vWSRh2.Q/TyouSX3iWEtOEwuJDkOeJhx.U7z5m', 'Muhammad fikri', 'Bangfikri007@gmail.com', '6285337501468', '4ki50ki52ki54ki55ki56ki57ki105ki106ki', 106, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:24:05', '2021-03-03 14:52:58', NULL);
INSERT INTO `member` VALUES (109, 'Muhar1986', '$2y$10$FWzyKEsbtO1KLJN65wPCOO1xqGJnJi7T8.UuDkuyzDIHpCwIGPgFO', 'Misjaruddin', 'muharuddin968@gmail.com', '6287863481750', '7ki34ki67ki69ka76ki104ka', 104, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:28:56', '2021-03-03 16:43:28', NULL);
INSERT INTO `member` VALUES (110, 'DatuBayan', '$2y$10$XxUlZTaPGf8pQ.2kmw9xhe3reVuPsEbbpnss3wRRcHFym2dezjGiO', 'Januari lesmana', 'lerylesmana10@gmail.com', '6285338941988', '4ki50ki52ki54ki55ki', 55, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:37:25', '2021-03-03 17:50:56', NULL);
INSERT INTO `member` VALUES (111, 'RADEN PANJI TILAR', '$2y$10$6HIJB7eoUzrUptAWfLe/rOHgmTOy9WLFvIyQZrhmK6Vz44Cd0UHSS', 'Muhammad fikri', 'Opickchocolatos008@gmail.com', '6285337501468', '4ki50ki52ki54ki55ki56ki57ki105ki106ki', 106, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 14:39:29', '2021-03-03 14:45:43', NULL);
INSERT INTO `member` VALUES (112, 'QueenRich', '$2y$10$wT7NIiIYycr5s76gjFZ/luoSheNW.Yjbm4wEzGwdUJkzVgjttqRIm', 'Nona Berlian Ratu', 'luckybestrich@gmail.com', '6282144235990', '5ka15ka16ki', 16, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:09:22', '2021-03-03 15:36:53', NULL);
INSERT INTO `member` VALUES (113, 'QueenRich2', '$2y$10$hYU1PLeh.87oMimopUHZP.RD7AMsmvkxZxK76MnL7Mi9MI7zCHERa', 'Nona Berlian Ratu', 'l.uckybestrich@gmail.com', '6282144235990', '5ka15ka16ki112ki', 112, 0, 6, 5000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:19:22', '2021-03-03 16:39:56', NULL);
INSERT INTO `member` VALUES (114, 'RINJANI009', '$2y$10$mt7Yit47LFUh78VkjedX6ObqcxAh4x7joDCqiZlLUjUe/t32HqF66', 'Muhammad fikri', 'Opickchocolatos009@gmail.com', '6285337501468', '4ki50ki52ki54ki55ki56ki57ki105ki106ka', 106, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:20:38', '2021-03-03 15:23:43', NULL);
INSERT INTO `member` VALUES (115, 'QueenRich3', '$2y$10$xtcG1BNWW7.VbLZc/cVJtOITfuKVSxksi96AwJg65Od7cCxDcGU.a', 'Nona Berlian Ratu', 'lu.ckybestrich@gmail.com', '6282144235990', '5ka15ka16ki112ki113ki', 113, 0, 6, 5000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:24:48', '2021-03-03 16:06:33', NULL);
INSERT INTO `member` VALUES (116, 'Duran', '$2y$10$z/s9AXeYFpN4eg0qShcNh.ckRw44oVCMiCa/n9w2E8sP9PvdF.WqS', 'Nona Berlian Ratu', 'luc.kybestrich@gmail.com', '6282144235990', '5ka15ka16ki112ki113ka', 113, 1, 6, 5000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:34:21', '2021-03-03 16:34:15', NULL);
INSERT INTO `member` VALUES (117, 'master01', '$2y$10$98X0NFbrVIPlHbLTrV6NVuvq1Ni2GwmCtkV6A884VQ0HL9GkKYqou', 'Hendro Sutrisno', 'm.otor.hendro@gmail.com', '6281907075000', '5ka15ka16ka19ki', 19, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:49:50', '2021-03-03 17:04:31', NULL);
INSERT INTO `member` VALUES (118, 'master2', '$2y$10$bSfKivheoVqNTahVVWiZ/OPZVYBWXSnBNCUW.ipFFXIvSLMBSOvJm', 'Hendro Sutrisno', 'mo.tor.hendro@gmail.com', '6281907075000', '5ka15ka16ka19ka', 19, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 15:58:58', '2021-03-03 17:05:16', NULL);
INSERT INTO `member` VALUES (119, 'PRUDENCE', '$2y$10$F4fHMAZUph4YDvErm3XQwOcxMXHulZMoaDNQj0qdLVRmjadtxvPHe', 'Prudence Nadia Pattiselanno', 'fgxpressindonesia@gmail.com', '6282144235990', '5ka15ka16ki112ki113ki115ki', 115, 0, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:04:25', '2021-03-03 16:06:33', NULL);
INSERT INTO `member` VALUES (120, 'Yegar', '$2y$10$JJsIv5iT534UqjIc8f0HM.RpwSwfCB58oy0/We0E.11oEStSoZzT2', 'Yegar Robert Syahaduta Wilson', 'f.gxpressindonesia@gmail.com', '6282144235990', '5ka15ka16ki112ki113ki115ka', 115, 1, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:09:31', '2021-03-03 16:11:18', NULL);
INSERT INTO `member` VALUES (121, 'Renya', '$2y$10$kNgSTOeyNPm8DfdxjVi60.RDVNdloL82umpwkANRb8Q4BDAHM8/QW', 'EMI RENSIANA KOPA ULU', 'emerents83@gmail.com', '6282317427661', '5ka15ka16ka19ki117ki', 117, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:15:21', '2021-03-03 17:09:31', NULL);
INSERT INTO `member` VALUES (122, 'Renyasukses ', '$2y$10$rH5OUAzYTuZkFESPuuWbI.waTFZ7uU6QNlqOKCeH3vtQfWdFcltEy', 'EMI RENSIANA KOPA ULU', 'e.merents83@gmail.com', '62082317427661', '5ka15ka16ka19ki117ki121ki', 121, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:18:59', '2021-03-03 16:20:29', NULL);
INSERT INTO `member` VALUES (123, 'Renyasukses01', '$2y$10$J2BoUbzFYIkOjEcub6./DOHFg6jHEnnQC1eyHtHwWHAovRNlCQaPq', 'EMI RENSIANA KOPA ULU', 'em.erents83@gmail.com', '6282317427661', '5ka15ka16ka19ki117ki121ka', 121, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:20:53', '2021-03-03 16:27:30', NULL);
INSERT INTO `member` VALUES (124, 'Yanto', '$2y$10$GiZ.dU65NcpWpL4nw9tL8OLvIxFNAYflsoh1VCZa5zxtvzkPt5jnu', 'Zeyb Yoyantho Manafe', 'yantho.manafe@gmail.com', '6281339007050', '5ka15ka16ka19ki117ki121ka123ki', 123, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:26:19', '2021-03-03 16:58:20', NULL);
INSERT INTO `member` VALUES (125, 'Yantosukses', '$2y$10$fpdig8kW2xElhiM0URj2B.oGh7ao5EFWigr4bYlq8m3.tcLvbFB5K', 'Zeyb Yoyantho Manafe', 'y.antho.manafe@gmail.com', '6281339007050', '5ka15ka16ka19ki117ki121ka123ki124ki', 124, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:28:54', '2021-03-03 16:43:26', NULL);
INSERT INTO `member` VALUES (126, 'Yantosukses01', '$2y$10$BAHQqzNUzM9m9DvyFSL8D.suwW7eDznwXvHYsN2zb2NsZWEu4h4tu', 'Zeyb Yoyantho Manafe', 'ya.ntho.manafe@gmail.com', '6281339007050', '5ka15ka16ka19ki117ki121ka123ki124ka', 124, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:30:38', '2021-03-03 16:31:44', NULL);
INSERT INTO `member` VALUES (127, 'Fadilla', '$2y$10$keTV4yEKGBin9ollexNbTO8ZxydFYUhDG0SOOIV6RUHywNrGZC5Vu', 'Fadilla Gina Pattiselanno', 'fg.xpressindonesia@gmail.com', '6282144235990', '5ka15ka16ki112ki113ka116ki', 116, 0, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:32:59', '2021-03-03 16:34:15', NULL);
INSERT INTO `member` VALUES (128, 'Chicka', '$2y$10$2t1WO.EsG13GYrxtr/kWPOaM412jbelddvFb6YseLCqpNp9solTLq', 'Chickateta Janelle Wilson', 'fgx.pressindonesia@gmail.com', '6282144235990', '5ka15ka16ki112ki113ka116ka', 116, 1, 5, 2000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:36:26', '2021-03-03 16:37:59', NULL);
INSERT INTO `member` VALUES (129, 'Palugada', '$2y$10$.9tql4PRh/pTscl3VPY1l.Tb6UYXB9mH6/0UmRGK1GsZ2KNWQ7uTO', 'I Ketut Arantika', 'iketutarantikabali@gmail.com', '6282236421591', '5ka15ka16ka19ka118ka', 118, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:43:12', '2021-03-03 23:29:45', NULL);
INSERT INTO `member` VALUES (130, 'alias', '$2y$10$x928Gp8khimzp7pPkgTAL./tVC0MzBJ6PaPGz74hOIJjup0RD4BGe', 'alias', 'al.iassebatik@gmail.com', '6282353468257', '5ki14ka', 14, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 16:51:19', '2021-03-03 16:53:16', NULL);
INSERT INTO `member` VALUES (131, NULL, NULL, 'i wayan suardana', 'upixbase180@gmail.com', '6281338778051', '5ki14ki', 14, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 17:10:14', '2021-03-03 17:10:14', NULL);
INSERT INTO `member` VALUES (132, 'Pang5', '$2y$10$pn7K7XMR6OZvEBXJaTCf8.i7bQE56JXJ0xZY.eQMfP/ryXhZenzPy', 'MIRWAN', 'mirwanbone@gmail.com', '6285213731988', '5ki14ki39ki', 39, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 19:35:59', '2021-03-03 20:36:39', NULL);
INSERT INTO `member` VALUES (133, 'Pang501', '$2y$10$lagpw0Txh8PxNCj2e2G0Kuy7LtevzsT8PvXVtcpSbhim6RA/b4ivy', 'MIRWAN', 'm.irwanbone@gmail.com', '6285213731988', '5ki14ki39ki132ki', 132, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 19:43:57', '2021-03-03 20:37:57', NULL);
INSERT INTO `member` VALUES (134, 'Ultrakaya77', '$2y$10$t/LDe8aoPkl3SdA1WBPnzOEw1mBeUI4kEjWfYoP761VQJ8CPp3LW2', 'AIWAN ARIEF', 'mercusuar511@gmail.com', '62895803579961', '5ki14ki39ki132ki133ka', 133, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 19:53:11', '2021-03-03 20:23:55', NULL);
INSERT INTO `member` VALUES (135, 'Pang502', '$2y$10$3VfAwUIgCUvL4dSUUXPE8OsdSTr9vLRchmgp8wsCl78Pyo6gNWqu6', 'Mirwan', 'powerbetece@gmail.com', '6285399361188', '5ki14ki39ki132ki133ki', 133, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:14:21', '2021-03-03 20:34:36', NULL);
INSERT INTO `member` VALUES (136, 'Ultrakaya007', '$2y$10$mM5QG8EfMO99Ww0bw3C7q.lXLnA3Q73nIHJ.TSLYc2g0MZgcvzOCO', 'Aiwan Arief', 'm.ercusuar511@gmail.com', '62895803579961', '5ki14ki39ki132ki133ka134ki', 134, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:16:49', '2021-03-03 20:23:55', NULL);
INSERT INTO `member` VALUES (137, 'Ultrakaya077', '$2y$10$aj2gyC9IIrvBYxRdnF2JleHukpJUat4XYZdECHD0WXbamjLg7NlXK', 'Aiwan Arief', 'me.rcusuar511@gmail.com', '62895803579961', '5ki14ki39ki132ki133ka134ka', 134, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:18:24', '2021-03-03 20:26:01', NULL);
INSERT INTO `member` VALUES (138, 'P4ng5', '$2y$10$yPWLcZZtUONWH5/qBzQOS.fSej93xuL1js0tqeAs8OnMbrGZeoXZy', 'Mirwan', 'pow.erbetece@gmail.com', '6285399361188', '5ki14ki39ki132ki133ki135ki', 135, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:32:36', '2021-03-03 20:34:36', NULL);
INSERT INTO `member` VALUES (139, '45', '$2y$10$FqQpG1LLFGpfBTbstpWPTueSQRhRVfFJo9uGRMR9.w9rsiXnKyl1W', 'Mirwan', 'powe.rbetece@gmail.com', '6285399361188', '5ki14ki39ki132ki133ki135ka', 135, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:40:00', '2021-03-03 20:44:38', NULL);
INSERT INTO `member` VALUES (140, 'digitalentrepreneur', '$2y$10$MSnw3gYF/gRqbqaGHr3Puu2XCuykaAcO4cGpsPL6kCrkwqZLFC3GS', 'ASIS SUANDI', 'asis.suandi26@gmail.com', '6282353961249', '5ki14ki39ka', 39, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:42:42', '2021-03-03 21:11:23', NULL);
INSERT INTO `member` VALUES (141, 'ternakdollar01', '$2y$10$3enoruhqxyxKXw1yonKcC.LdFthyY9uheJ/dfPUBWhTq27etW7wWe', ' ASIS SUANDI', 'a.sis.suandi26@gmail.com', '6282353961249', '5ki14ki39ka140ki', 140, 0, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:50:07', '2021-03-03 20:53:49', NULL);
INSERT INTO `member` VALUES (142, 'ternakdollar02', '$2y$10$/014.1uxhOVSN3.ZaTdVae3NlaOFg7Tg8IyoTKqau9jc6eAUMZGsq', 'ASIS SUANDI', 'as.is.suandi26@gmail.com', '6282353961249', '5ki14ki39ka140ka', 140, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:52:37', '2021-03-03 21:03:30', NULL);
INSERT INTO `member` VALUES (143, 'Sebatik12', '$2y$10$OynLKl9CZZ3m9Uplz.bPgeSyDNXe.GkCcDIw7u3pLw2QYF0drng2u', 'Alias', 'alia.ssebatik@gmail.com', '6282353468257', '5ki14ki39ka140ka142ka', 142, 1, 1, 100.00, 65, NULL, 1, NULL, NULL, '2021-03-03 20:59:03', '2021-03-03 21:09:35', NULL);
INSERT INTO `member` VALUES (144, 'Mr.willis', '$2y$10$aIiVsrHdcot9hboXGSsfaezSgjgZBsq8Kp/LwMyj2gBj29YOZNaDq', 'karmila wilis', 'karmilawilis@gmail.com', '6282353372702', '5ki14ki39ka140ka142ka143ka', 143, 1, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-03 21:04:40', '2021-03-03 23:59:27', NULL);
INSERT INTO `member` VALUES (145, 'Garuda01', '$2y$10$/aFhtCrnVUS9e7gSNbRAQODRj3sWsOtHLJwlizovN18b.m0eJoEsa', 'karmila wilis', 'k.armilawilis@gmail.com', '6282353372702', '5ki14ki39ka140ka142ka143ka144ki', 144, 0, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 21:12:36', '2021-03-03 21:17:46', NULL);
INSERT INTO `member` VALUES (146, 'Garuda02', '$2y$10$1JF9HmLp8bZAPQMGfghon.WM7FpPjReu9nlgJyPnsAvYFApZmDXvW', 'karmila wilis', 'ka.rmilawilis@gmail.com', '6282353372702', '5ki14ki39ka140ka142ka143ka144ka', 144, 1, 3, 500.00, 65, NULL, 1, NULL, NULL, '2021-03-03 21:14:36', '2021-03-03 21:19:02', NULL);
INSERT INTO `member` VALUES (147, 'Bhdn01', '$2y$10$bKNONWU1.3LvwGWGy1xjD.sjLcULn75tCER3DloyAwIYzqbc.bn5i', 'Hamdan, M.Pd.I.', 'hamdanbhdn@yahoo.com', '6281933015577', '43ki46ki', 46, 0, 2, 200.00, 65, NULL, 1, NULL, NULL, '2021-03-03 23:52:45', '2021-03-04 00:02:54', NULL);
INSERT INTO `member` VALUES (148, NULL, NULL, 'Nurasiah', 'huminiji543@gmail.com', '62085389530111', '5ka15ka16ka19ki', 19, 0, 4, 1000.00, 65, NULL, 1, NULL, NULL, '2021-03-04 00:03:51', '2021-03-04 00:03:51', NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_01_26_221915_create_coinpayment_transactions_table', 1);
INSERT INTO `migrations` VALUES (5, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_11_30_030150_create_coinpayment_transaction_items_table', 1);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `model_id` bigint(20) NOT NULL,
  PRIMARY KEY (`permission_id`, `model_type`, `model_id`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_type`) USING BTREE,
  INDEX `izin_pengguna_fk`(`model_id`) USING BTREE,
  CONSTRAINT `model_has_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `model_has_permissions_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `model_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`, `model_type`, `model_id`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_type`) USING BTREE,
  INDEX `level_pengguna_fk`(`model_id`) USING BTREE,
  CONSTRAINT `model_has_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `model_has_roles_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 1);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payment_method
-- ----------------------------
DROP TABLE IF EXISTS `payment_method`;
CREATE TABLE `payment_method`  (
  `payment_method_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT ' ',
  `payment_method_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `payment_method_abbrevation` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `payment_method_price` decimal(60, 10) NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `guard_name` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_unique`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate`  (
  `rate_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rate_price` decimal(65, 2) NOT NULL,
  `rate_currency` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NOT NULL,
  PRIMARY KEY (`rate_id`) USING BTREE,
  INDEX `pengguna_id`(`user_id`) USING BTREE,
  CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rate
-- ----------------------------
INSERT INTO `rate` VALUES (1, 12.50, 'USD', 1, '2021-03-01 00:00:00.000000', '2021-03-01 00:00:00.000000');

-- ----------------------------
-- Table structure for rating
-- ----------------------------
DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating`  (
  `rating_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rating_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rating_min_turnover` decimal(65, 2) NOT NULL,
  `rating_reward` decimal(65, 2) NOT NULL,
  `rating_order` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`rating_id`) USING BTREE,
  UNIQUE INDEX `rating_order`(`rating_order`) USING BTREE,
  INDEX `pengguna_id`(`user_id`) USING BTREE,
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rating
-- ----------------------------
INSERT INTO `rating` VALUES (1, 'Bronze', 10000.00, 350.00, 1, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `rating` VALUES (2, 'Silver', 100000.00, 3500.00, 2, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `rating` VALUES (3, 'Gold', 350000.00, 10000.00, 3, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `rating` VALUES (4, 'Platinum', 3500000.00, 35000.00, 4, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);

-- ----------------------------
-- Table structure for referral
-- ----------------------------
DROP TABLE IF EXISTS `referral`;
CREATE TABLE `referral`  (
  `referral_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `referral_token` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`referral_id`) USING BTREE,
  UNIQUE INDEX `referal_ibfk_1`(`member_id`) USING BTREE,
  UNIQUE INDEX `referal_token`(`referral_token`) USING BTREE,
  CONSTRAINT `referral_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of referral
-- ----------------------------
INSERT INTO `referral` VALUES (1, 'ccbaKh2nQwFS6kdhyKgPlRHyxZj5erdvAtCovmff1', 1, '2021-03-01 10:14:27', '2021-03-01 10:24:15', '2021-03-01 10:24:15');
INSERT INTO `referral` VALUES (3, '3gLmZPxEG85DJohqReCLiYMRLWL1wWJZocsbSoC53', 3, '2021-03-01 13:17:55', '2021-03-01 13:23:50', '2021-03-01 13:23:50');
INSERT INTO `referral` VALUES (4, 'zYan9krUccgQo5jZ7WZe6USLGGfzobuUN6F5Lz0b4', 4, '2021-03-01 13:31:38', '2021-03-01 13:33:42', '2021-03-01 13:33:42');
INSERT INTO `referral` VALUES (5, 'o3Qk4pD2NWg1K6PiiCpeDqHrKWvZ2NRJeBwSj6Bi5', 5, '2021-03-01 14:28:02', '2021-03-01 14:30:04', '2021-03-01 14:30:04');
INSERT INTO `referral` VALUES (6, 'rqGSQR4dAcOYAwOvJX852DkKuFrHTyfW1MGJu0gC6', 6, '2021-03-01 14:39:37', '2021-03-01 14:43:46', '2021-03-01 14:43:46');
INSERT INTO `referral` VALUES (7, 'IEmrPMEp1ROo2DfFRK5bh1NoduJzZUuqG9wxKxVU7', 7, '2021-03-01 15:13:33', '2021-03-01 15:15:13', '2021-03-01 15:15:13');
INSERT INTO `referral` VALUES (8, 'PrmluGJRRkskMNW0EWqfc5zGcDIEbrQspcHOSS2Z8', 8, '2021-03-01 15:20:37', '2021-03-01 22:24:56', '2021-03-01 22:24:56');
INSERT INTO `referral` VALUES (9, '7honwUcNCdWJSm0o3PwOQWhP3HbgWrMZrJJtpHHT9', 9, '2021-03-01 23:45:13', '2021-03-03 01:25:32', '2021-03-03 01:25:32');
INSERT INTO `referral` VALUES (12, '99pU1rGtjgQ4LdCVn6d2T6yllEhLQBUN9LtpXpkP12', 12, '2021-03-02 06:40:44', '2021-03-02 07:01:42', '2021-03-02 07:01:42');
INSERT INTO `referral` VALUES (13, '4LxAxn0HYsjgk6IDHIKb2qfgh1HgMd3PtMXLUd0L13', 13, '2021-03-02 07:05:17', '2021-03-02 07:06:57', '2021-03-02 07:06:57');
INSERT INTO `referral` VALUES (14, 'PAYGon3SIqgxi88Z65pcjmCij3O2XghYdg04L74M14', 14, '2021-03-02 07:12:43', '2021-03-02 07:14:20', '2021-03-02 07:14:20');
INSERT INTO `referral` VALUES (15, 'VL6QGdT77SVBupfaJpScX9cKge1ldiMZf7vowQA915', 15, '2021-03-02 07:16:56', '2021-03-02 07:17:34', '2021-03-02 07:17:34');
INSERT INTO `referral` VALUES (16, 'Rb3SpZpw7QjjU4DdLynmqJtWzOQNhE2111LwAleI16', 16, '2021-03-02 07:23:27', '2021-03-02 07:24:20', '2021-03-02 07:24:20');
INSERT INTO `referral` VALUES (17, '731JMCasOKnjwM4kcWmJQ8BFz7eQmjhEBQcTo90d17', 17, '2021-03-02 07:35:09', '2021-03-02 07:38:05', '2021-03-02 07:38:05');
INSERT INTO `referral` VALUES (18, 'DuBoOSVDXvNCwnTiJfjggke3vx47MeAM2vzmX71b18', 18, '2021-03-02 07:35:43', '2021-03-02 07:37:00', '2021-03-02 07:37:00');
INSERT INTO `referral` VALUES (19, 'X8Z0crxQD2z0LwcYBFIEvkG2jjsK1jsQlB0QUbXQ19', 19, '2021-03-02 07:38:47', '2021-03-02 07:41:37', '2021-03-02 07:41:37');
INSERT INTO `referral` VALUES (20, 'tAPcR1yBKY6BUCar2026aD5ngQfHDa18tQe5heUS20', 20, '2021-03-02 07:44:05', '2021-03-02 07:48:03', '2021-03-02 07:48:03');
INSERT INTO `referral` VALUES (21, 'HYhuKmnSvU7jvUii2M9WDuNiKP7I5cgyIl10KVOM21', 21, '2021-03-02 07:48:59', '2021-03-02 07:50:28', '2021-03-02 07:50:28');
INSERT INTO `referral` VALUES (22, 'Qlk2QrFp4aB7wJjDFxAauWV83dvwfHgiEgwRyOBH22', 22, '2021-03-02 07:54:16', '2021-03-02 07:55:12', '2021-03-02 07:55:12');
INSERT INTO `referral` VALUES (24, 'cUTp0euRZffgumhbHA6TuVeW0TIMsvH6oxQ7ATfx24', 24, '2021-03-02 10:21:22', '2021-03-02 10:24:58', '2021-03-02 10:24:58');
INSERT INTO `referral` VALUES (25, 'f1CEhdFhCVTtv6GgBkHQPgUyTxwe3m6yKtIzJpHJ25', 25, '2021-03-02 10:52:13', '2021-03-02 10:56:45', '2021-03-02 10:56:45');
INSERT INTO `referral` VALUES (26, 'OW7Lko4qiWiyw4rMuItXziRcOVxDOEpeeGgq7Beu26', 26, '2021-03-02 11:12:32', '2021-03-02 11:15:24', '2021-03-02 11:15:24');
INSERT INTO `referral` VALUES (27, 'KloiVi3zWy5jYyiEoTQ29nzXD3cyYf3MLFsxwGGm27', 27, '2021-03-02 11:35:07', '2021-03-02 11:36:56', '2021-03-02 11:36:56');
INSERT INTO `referral` VALUES (28, 'y7BWfSCbXt4zUUcC1Zw0gjJuwyfUsGVNWpHBLIjI28', 28, '2021-03-02 11:42:21', '2021-03-02 11:46:08', '2021-03-02 11:46:08');
INSERT INTO `referral` VALUES (29, 'G4dhCdNSwHaXQglfm7VNEIS1XYMJRt84AkRV7Rl629', 29, '2021-03-02 11:57:12', '2021-03-02 12:04:25', '2021-03-02 12:04:25');
INSERT INTO `referral` VALUES (30, '1RhyNH1jheS991AcgEE3kinCdyeitxNcbggdG4vG30', 30, '2021-03-02 12:00:28', '2021-03-02 12:02:45', '2021-03-02 12:02:45');
INSERT INTO `referral` VALUES (31, 'HyWTAHkKNh6i1iEmP2HGcWNoYxaSIh3Deu30HLFs31', 31, '2021-03-02 12:40:44', '2021-03-02 12:42:32', '2021-03-02 12:42:32');
INSERT INTO `referral` VALUES (32, 'mpBAw0yDsE3F5S8WLLvJ3gkAayig7rChuJSwqncY32', 32, '2021-03-02 12:52:25', '2021-03-02 12:53:55', '2021-03-02 12:53:55');
INSERT INTO `referral` VALUES (33, 'NSMWnfBQ6w7A8JH8DuoAFqmsQulNdw8u2izCElKp33', 33, '2021-03-02 13:59:57', '2021-03-02 14:05:27', '2021-03-02 14:05:27');
INSERT INTO `referral` VALUES (34, 'nsW4GnnyPga4bUnw68hPvJ5s1PHFoUklUnOk5IOo34', 34, '2021-03-02 14:18:18', '2021-03-02 14:21:34', '2021-03-02 14:21:34');
INSERT INTO `referral` VALUES (35, 'LE8MxrXvWk5tI8EWaQ8sRGJfdNZ85u6ftxMPJ6Iq35', 35, '2021-03-02 15:04:28', '2021-03-02 15:05:37', '2021-03-02 15:05:37');
INSERT INTO `referral` VALUES (36, 'QFNSiYf5ujTtqJIKjGBp4q2imWBC5ECuDCQ6OUGQ36', 36, '2021-03-02 15:19:28', '2021-03-02 15:21:41', '2021-03-02 15:21:41');
INSERT INTO `referral` VALUES (37, 'g5OIrJr1lF2de02I1jS061n9RnSjy0wBta2lV8Ej37', 37, '2021-03-02 15:41:44', '2021-03-02 15:43:58', '2021-03-02 15:43:58');
INSERT INTO `referral` VALUES (38, '39qBeQkxlXNo2SQRO255cYOlRXqgZz3ri8qcZNik38', 38, '2021-03-02 15:48:18', '2021-03-02 15:49:09', '2021-03-02 15:49:09');
INSERT INTO `referral` VALUES (39, 'fsmnpIEnWPlHkwn0vzFNNuEdA4inJjwLJ57TFxUs39', 39, '2021-03-02 16:39:32', '2021-03-02 16:41:23', '2021-03-02 16:41:23');
INSERT INTO `referral` VALUES (40, 'g1EtY04k0BRMw27pSDAM05rb5ZquAGsePu5aoCIi40', 40, '2021-03-02 18:19:10', '2021-03-02 18:21:39', '2021-03-02 18:21:39');
INSERT INTO `referral` VALUES (41, 'diQC3p2O74hzxQwyC3uKDxeyhOdeMw7rSbvsfAV741', 41, '2021-03-02 18:28:34', '2021-03-02 18:29:55', '2021-03-02 18:29:55');
INSERT INTO `referral` VALUES (42, 'lq5FTnpJ7kmakBW51r263JOWW57A6qXz1jbmAry942', 42, '2021-03-02 19:56:24', '2021-03-02 19:58:25', '2021-03-02 19:58:25');
INSERT INTO `referral` VALUES (43, 'VtX6wnax8ZLKMHeUzxQm3YONaVjs1K352d2ALQO743', 43, '2021-03-02 22:45:18', '2021-03-02 22:47:33', '2021-03-02 22:47:33');
INSERT INTO `referral` VALUES (44, 'QMhg0YpLCCoYQOowdAwB2r3rBVmUB4NyEYTvVYPo44', 44, '2021-03-02 22:53:33', '2021-03-02 22:53:33', NULL);
INSERT INTO `referral` VALUES (45, 'QSo9dG1wgwxTLPDJmhIlSDZVp8wmw32dSfk03YXS45', 45, '2021-03-02 22:57:38', '2021-03-03 00:57:09', '2021-03-03 00:57:09');
INSERT INTO `referral` VALUES (46, 'lvuCWtCg4dsIa9aSHkXsISRPDW50NjcKFJJnlHnA46', 46, '2021-03-02 23:07:08', '2021-03-02 23:08:47', '2021-03-02 23:08:47');
INSERT INTO `referral` VALUES (47, 'phMszrThWzn3SfB3BM9TxHapd6kxiWX8dtxoBhPl47', 47, '2021-03-02 23:14:32', '2021-03-02 23:17:12', '2021-03-02 23:17:12');
INSERT INTO `referral` VALUES (48, 'pWqXSLSNh1M4fdLQ2tXx6BmwOZRNmR39PJQeJUit48', 48, '2021-03-02 23:29:54', '2021-03-03 01:01:15', '2021-03-03 01:01:15');
INSERT INTO `referral` VALUES (49, 'a789xcDTgWursZBed6RJ3krlZO7RLQGy7on0wCkz49', 49, '2021-03-02 23:38:50', '2021-03-02 23:38:50', NULL);
INSERT INTO `referral` VALUES (50, 'h9oNkZUAdQ0s0HjATHN22prQMYeBOUSWJEmLEuKP50', 50, '2021-03-02 23:58:34', '2021-03-03 00:03:40', '2021-03-03 00:03:40');
INSERT INTO `referral` VALUES (51, 'kt0EvV132MZUmbAoxBNwGV1Lic8XWo0As97YdarY51', 51, '2021-03-03 00:06:17', '2021-03-03 00:09:51', '2021-03-03 00:09:51');
INSERT INTO `referral` VALUES (52, 'IGLIwzc74Bf143OZNXMRRE6zjQJtKWMXNkKYonsn52', 52, '2021-03-03 00:24:22', '2021-03-03 00:32:57', '2021-03-03 00:32:57');
INSERT INTO `referral` VALUES (53, 'JrtOR75U9dq5j0CPyQF12MfsKWdBobtpYfVSOrBa53', 53, '2021-03-03 01:17:35', '2021-03-03 01:57:45', '2021-03-03 01:57:45');
INSERT INTO `referral` VALUES (54, '80Ufgb2vlc6XVgqWaOcFkUlo0EVPmYUJ4krMoPAC54', 54, '2021-03-03 01:46:56', '2021-03-03 01:50:07', '2021-03-03 01:50:07');
INSERT INTO `referral` VALUES (55, 'zy8ePWZQoHKyqoUDaJB7eF7oeiGSwbDJqGKQmBkY55', 55, '2021-03-03 02:05:38', '2021-03-03 02:08:06', '2021-03-03 02:08:06');
INSERT INTO `referral` VALUES (56, 'ZjnakEqUTOycJxywsHN1B6UgKZgRFGvuNN8HULhA56', 56, '2021-03-03 02:11:35', '2021-03-03 02:12:32', '2021-03-03 02:12:32');
INSERT INTO `referral` VALUES (57, 'uWCfwgFdyPvtOENQsGlYen02ccFMBcVuDOtrUHGv57', 57, '2021-03-03 02:55:25', '2021-03-03 10:49:21', '2021-03-03 10:49:21');
INSERT INTO `referral` VALUES (58, 'CXRAcHd5lXUzVo9AGg3bFOL3N2JWZiDLM9IvToxb58', 58, '2021-03-03 04:56:43', '2021-03-03 07:53:58', '2021-03-03 07:53:58');
INSERT INTO `referral` VALUES (59, 'q7qd0gkm55u8J0vjQUYGFiveQ2Ttsvd6HlbF3H9W59', 59, '2021-03-03 05:09:15', '2021-03-03 05:09:15', NULL);
INSERT INTO `referral` VALUES (60, 'KFCVJpJd6XODTIAjRlvBjFjbOOv7Dya1cGARhui860', 60, '2021-03-03 05:29:53', '2021-03-03 05:32:02', '2021-03-03 05:32:02');
INSERT INTO `referral` VALUES (61, 'MTc5i6gmI5xHmtROQla5A8JMCokAb1dE2lynsRNQ61', 61, '2021-03-03 07:34:15', '2021-03-03 07:37:44', '2021-03-03 07:37:44');
INSERT INTO `referral` VALUES (62, 'PZ7foj6OVwlNfr3mrG3KpD0OOmbWrwzkeLnIK9jr62', 62, '2021-03-03 08:03:19', '2021-03-03 08:04:32', '2021-03-03 08:04:32');
INSERT INTO `referral` VALUES (63, 'rBmwIqSJvJ1CJI19KXo0jceMf7pjSY0KXC1GgC1T63', 63, '2021-03-03 08:06:59', '2021-03-03 08:08:54', '2021-03-03 08:08:54');
INSERT INTO `referral` VALUES (64, 'iashP3z7xvq5XonZZcDYduQzfX8YN4WJvJWevGtB64', 64, '2021-03-03 08:12:04', '2021-03-03 08:13:42', '2021-03-03 08:13:42');
INSERT INTO `referral` VALUES (65, 'DqJw5QSUAtbI0rOYMnUYcX2PVekI7SgOg4CjOCfR65', 65, '2021-03-03 08:17:08', '2021-03-03 08:25:05', '2021-03-03 08:25:05');
INSERT INTO `referral` VALUES (66, 'aWjlTLicailj6RSObJ4uvT1cHAXnUq0nulqSwNJZ66', 66, '2021-03-03 08:26:34', '2021-03-03 08:28:56', '2021-03-03 08:28:56');
INSERT INTO `referral` VALUES (67, 'gcuzSI03sCWcK3pNCPE2vQtasDqyfXtmijTRJBAf67', 67, '2021-03-03 09:34:42', '2021-03-03 09:39:26', '2021-03-03 09:39:26');
INSERT INTO `referral` VALUES (68, 'dsByy6u3q1177BsJke6O2kjahSkw5BvHOd0jywzL68', 68, '2021-03-03 09:42:56', '2021-03-03 09:45:40', '2021-03-03 09:45:40');
INSERT INTO `referral` VALUES (69, '8oxtu0Oz1dX8v4pZUEfWo2e13LEpPEMc5kfi9Tai69', 69, '2021-03-03 09:59:11', '2021-03-03 10:04:09', '2021-03-03 10:04:09');
INSERT INTO `referral` VALUES (70, 'lhlrTw9O3t90HfG5IpepEpFTWxhJ5vP0xOLnhzTW70', 70, '2021-03-03 10:00:43', '2021-03-03 10:06:00', '2021-03-03 10:06:00');
INSERT INTO `referral` VALUES (71, '5jZsCHZuIEdHENerANdPwX1BbgbszlRWU13KaMG271', 71, '2021-03-03 10:30:43', '2021-03-03 10:32:54', '2021-03-03 10:32:54');
INSERT INTO `referral` VALUES (72, 'ZbWOXZJeD6hbpWUMKBE57c0Kspa5Fyq91sV4x3BO72', 72, '2021-03-03 10:43:25', '2021-03-03 10:46:33', '2021-03-03 10:46:33');
INSERT INTO `referral` VALUES (73, 'oNtwRZ0a8zmtKXceR60f4Nuus9uEdGxYOjhWexBx73', 73, '2021-03-03 10:52:32', '2021-03-03 10:52:32', NULL);
INSERT INTO `referral` VALUES (74, 'Pj0odrM2DOZmWY2y5qI6V54SbWH5kf97qdGb4jgD74', 74, '2021-03-03 11:06:18', '2021-03-03 11:09:33', '2021-03-03 11:09:33');
INSERT INTO `referral` VALUES (75, 'tbWdYVMFNW8KmnqPyxnlUgpFEG0hdRF2G6vnrg7t75', 75, '2021-03-03 11:17:03', '2021-03-03 11:17:03', NULL);
INSERT INTO `referral` VALUES (76, 'ACGF9AdI1FhfK2TwtkkksZYldGinXVIGMyQgmumg76', 76, '2021-03-03 11:23:02', '2021-03-03 11:29:16', '2021-03-03 11:29:16');
INSERT INTO `referral` VALUES (77, 'Nhp4yCuSCmxobKrAdayy2Thrr1OKRgPaowjCVwfl77', 77, '2021-03-03 11:28:24', '2021-03-03 11:28:24', NULL);
INSERT INTO `referral` VALUES (78, 'W0MEsT8zF41aiDHd8nFlD4EAO5v9ye09cck2wGNk78', 78, '2021-03-03 11:41:25', '2021-03-03 11:45:41', '2021-03-03 11:45:41');
INSERT INTO `referral` VALUES (79, 'LYt20jYDDknMVLd4tsBmchgadUf6Sjlv4YAjxefn79', 79, '2021-03-03 11:42:11', '2021-03-03 11:45:10', '2021-03-03 11:45:10');
INSERT INTO `referral` VALUES (80, 'tOVvH7uWXWZuppa99iTPFxvtptBi0c7FouAmcGEG80', 80, '2021-03-03 11:42:50', '2021-03-03 11:44:40', '2021-03-03 11:44:40');
INSERT INTO `referral` VALUES (81, 'MSmVyMQoKIlxOMcMU66FImwT0e9DwzRpM5zmyi3t81', 81, '2021-03-03 11:55:02', '2021-03-03 11:57:38', '2021-03-03 11:57:38');
INSERT INTO `referral` VALUES (82, 'ue6FM5Ht9b4gqtV0pyP0L0eXWcMvGTeovYRB87OC82', 82, '2021-03-03 11:58:10', '2021-03-03 12:03:06', '2021-03-03 12:03:06');
INSERT INTO `referral` VALUES (83, 'sQoADmThHHQu92pC27hbSqv7XNxkXHIabquevJID83', 83, '2021-03-03 12:11:46', '2021-03-03 12:15:05', '2021-03-03 12:15:05');
INSERT INTO `referral` VALUES (84, 'uKurwo9UyVvC6MP2qw2fx3U0rbktwTkVCHyDRFTh84', 84, '2021-03-03 12:21:21', '2021-03-03 12:22:41', '2021-03-03 12:22:41');
INSERT INTO `referral` VALUES (85, '7W9sGQoDZu5S17YJQY4sFOlmp8uTfG2rd9L1eonJ85', 85, '2021-03-03 12:27:02', '2021-03-03 12:30:23', '2021-03-03 12:30:23');
INSERT INTO `referral` VALUES (86, 'reh6EirFo7KfqRMZEErthso5vhAbzZgQe6dja8dd86', 86, '2021-03-03 12:32:56', '2021-03-03 12:34:46', '2021-03-03 12:34:46');
INSERT INTO `referral` VALUES (87, 'rNyN1xBLK2YfdxcrAd3UsTLmZamFpaAqkU94cwmu87', 87, '2021-03-03 12:33:08', '2021-03-03 12:38:11', '2021-03-03 12:38:11');
INSERT INTO `referral` VALUES (88, 'UMzt9HGWFYI4cDcvcBBbeMts9tF27oKDhAt3OJjn88', 88, '2021-03-03 12:33:09', '2021-03-03 12:35:22', '2021-03-03 12:35:22');
INSERT INTO `referral` VALUES (89, 'RhNDN9jWZqhl0V3Sdm4rj0nyqkmMuP4TW7MkCZeu89', 89, '2021-03-03 12:38:38', '2021-03-03 12:40:06', '2021-03-03 12:40:06');
INSERT INTO `referral` VALUES (90, 'tqaTFK8elPfv8EIUslpSJXDNNCTmJmpo5jXvMAEb90', 90, '2021-03-03 12:42:26', '2021-03-03 12:43:53', '2021-03-03 12:43:53');
INSERT INTO `referral` VALUES (91, 'l2eOjhuwdg9YRRwP7GCUHg0xTzcoy5vYwd5F5oz291', 91, '2021-03-03 12:45:23', '2021-03-03 12:48:50', '2021-03-03 12:48:50');
INSERT INTO `referral` VALUES (92, 'CTFnBV36qdY9SmbzdErRtmHolL4FMkQMgjel9UOV92', 92, '2021-03-03 12:53:13', '2021-03-03 12:57:16', '2021-03-03 12:57:16');
INSERT INTO `referral` VALUES (93, 'uqv7N3wL4hE2oC5lTMameViEbmdIEe51PQLLICBP93', 93, '2021-03-03 12:56:36', '2021-03-03 12:59:54', '2021-03-03 12:59:54');
INSERT INTO `referral` VALUES (94, 'OmGQPponA9IuIQ1HBQEPGpcpS6k81KlWhZHYky8494', 94, '2021-03-03 13:05:06', '2021-03-03 13:15:37', '2021-03-03 13:15:37');
INSERT INTO `referral` VALUES (95, 'Wby0TSRLnGfWeVE5SwGglYmiKbkiwyV8b8biB84M95', 95, '2021-03-03 13:09:08', '2021-03-03 13:11:16', '2021-03-03 13:11:16');
INSERT INTO `referral` VALUES (96, 'GpoufgnX3hiscAswmqKhkGMEtkXwJPoBhzpR574296', 96, '2021-03-03 13:14:23', '2021-03-03 13:16:33', '2021-03-03 13:16:33');
INSERT INTO `referral` VALUES (97, '9pcECiOss4zBbB94Al2unAOn28Pf28kUwu1GJ3Iz97', 97, '2021-03-03 13:17:30', '2021-03-03 13:22:29', '2021-03-03 13:22:29');
INSERT INTO `referral` VALUES (98, 'xdkM9JT6evj0YtPL8TjMKBRcvx2sAOpWRIk4kamX98', 98, '2021-03-03 13:23:19', '2021-03-03 13:37:02', '2021-03-03 13:37:02');
INSERT INTO `referral` VALUES (99, 'Lkm8WWYDKRFdAUdeztujzSQgiD0Rd3W9VsGpR9fC99', 99, '2021-03-03 13:26:38', '2021-03-03 13:31:59', '2021-03-03 13:31:59');
INSERT INTO `referral` VALUES (100, 'e5qRo8JLRZdvGn3WfZCHDfcx5sHqf50LHQuydMIG100', 100, '2021-03-03 13:38:49', '2021-03-03 13:43:26', '2021-03-03 13:43:26');
INSERT INTO `referral` VALUES (101, '75gA0IlOlP3WeoShZ00BkNNhq1FHWNS2P43NIYco101', 101, '2021-03-03 13:42:52', '2021-03-03 13:46:17', '2021-03-03 13:46:17');
INSERT INTO `referral` VALUES (102, 'hDDr1Mbi36MLnXj9c6FrUd8MChRtaOCnA8ruXUV4102', 102, '2021-03-03 13:49:12', '2021-03-03 13:53:49', '2021-03-03 13:53:49');
INSERT INTO `referral` VALUES (103, 'Bome7Y8o940b1IgEYTxZkrzG79WUH9HrajzAdSWI103', 103, '2021-03-03 13:53:59', '2021-03-03 14:08:47', '2021-03-03 14:08:47');
INSERT INTO `referral` VALUES (104, '8g9ogldXY8VKiHFvS4H9b1byxfDCoQBBienvRgYW104', 104, '2021-03-03 14:00:39', '2021-03-03 14:06:34', '2021-03-03 14:06:34');
INSERT INTO `referral` VALUES (105, 'mDJIY36LgUkTVgLpXRlmcXfU76zuapvdzXvkjTkV105', 105, '2021-03-03 14:03:00', '2021-03-03 14:06:18', '2021-03-03 14:06:18');
INSERT INTO `referral` VALUES (106, 'k4dedufFt8i30rfTLAdYoh7XypI4loZyz9TeArZO106', 106, '2021-03-03 14:12:40', '2021-03-03 14:19:00', '2021-03-03 14:19:00');
INSERT INTO `referral` VALUES (107, 'xapWRMoqfeoQVWmWZY01H7sQJhFYXtUkcYCoht6l107', 107, '2021-03-03 14:22:19', '2021-03-03 14:26:30', '2021-03-03 14:26:30');
INSERT INTO `referral` VALUES (108, 'Qjea0VTNFazWtgXT1VwdZXKHgfqk37Tdiwc3Jds0108', 108, '2021-03-03 14:24:05', '2021-03-03 14:26:50', '2021-03-03 14:26:50');
INSERT INTO `referral` VALUES (109, '0crIvazu7CYBSq84zH0tlzpMsPEjUh2Cq4qAuxnC109', 109, '2021-03-03 14:28:56', '2021-03-03 14:30:53', '2021-03-03 14:30:53');
INSERT INTO `referral` VALUES (110, 'x9EsLbDjFmjeCQISobsclRP7kn3HE0cN2JzcujBF110', 110, '2021-03-03 14:37:25', '2021-03-03 14:39:48', '2021-03-03 14:39:48');
INSERT INTO `referral` VALUES (111, '2EiQWPpWB6cBJJOCiLGELMA5auJuxeGUwXT82gNY111', 111, '2021-03-03 14:39:29', '2021-03-03 14:45:43', '2021-03-03 14:45:43');
INSERT INTO `referral` VALUES (112, 'V7AuZIdFEUTg6Ioat5WhXDXEPP11YeMBxJYRLvLS112', 112, '2021-03-03 15:09:22', '2021-03-03 15:17:17', '2021-03-03 15:17:17');
INSERT INTO `referral` VALUES (113, 'oYxb3M1Hjq7dzX42zNnnjhk70KMhcIf16WUPo7lJ113', 113, '2021-03-03 15:19:22', '2021-03-03 15:22:11', '2021-03-03 15:22:11');
INSERT INTO `referral` VALUES (114, 'roruX5oW9f04bDH2wxXwaXn8TlylxVLONAI8kPWl114', 114, '2021-03-03 15:20:38', '2021-03-03 15:23:43', '2021-03-03 15:23:43');
INSERT INTO `referral` VALUES (115, 'EQR2JY3QuYYZwbJ0Ct0GLCeVNjuuqnbVAwp9Cfpi115', 115, '2021-03-03 15:24:48', '2021-03-03 15:25:47', '2021-03-03 15:25:47');
INSERT INTO `referral` VALUES (116, '4V4RCK9n2Dg8kB5idUM5ewhkFYXX2BKY0TCKXFja116', 116, '2021-03-03 15:34:21', '2021-03-03 15:36:08', '2021-03-03 15:36:08');
INSERT INTO `referral` VALUES (117, 'EjJdAjLU8XFYylY36XBWgX7WG7WQ0IfmcFy8mbh6117', 117, '2021-03-03 15:49:50', '2021-03-03 15:56:26', '2021-03-03 15:56:26');
INSERT INTO `referral` VALUES (118, 'SjX6KvwIBrRQ2DL27O9bqMYiYd6n4VJFLp90f0Iw118', 118, '2021-03-03 15:58:58', '2021-03-03 16:01:38', '2021-03-03 16:01:38');
INSERT INTO `referral` VALUES (119, 'UAognuiozjrM6v0KQGtyTvitRhZDj1espaDLwqCW119', 119, '2021-03-03 16:04:25', '2021-03-03 16:06:33', '2021-03-03 16:06:33');
INSERT INTO `referral` VALUES (120, 'BMDy3cpsi9staIRMYQige1bCykGTSrWk2h2QwHLr120', 120, '2021-03-03 16:09:31', '2021-03-03 16:11:18', '2021-03-03 16:11:18');
INSERT INTO `referral` VALUES (121, 'y3QGw0UqPSJsJ8HRogrICNVHM5nqTlgEx9Wc7svi121', 121, '2021-03-03 16:15:21', '2021-03-03 16:17:18', '2021-03-03 16:17:18');
INSERT INTO `referral` VALUES (122, '9vPncXLjJK4R2wh0OSkcSLUd888Js2BhDFv1kWJI122', 122, '2021-03-03 16:18:59', '2021-03-03 16:20:29', '2021-03-03 16:20:29');
INSERT INTO `referral` VALUES (123, 'M9anUD9pMQbS9Y7R0jo8LDg8M04dBCw84SRAQeeQ123', 123, '2021-03-03 16:20:53', '2021-03-03 16:22:24', '2021-03-03 16:22:24');
INSERT INTO `referral` VALUES (124, 'LIrr4nRNwnoPrsrgjBbLqk0wP15IOCqA1roNwyxC124', 124, '2021-03-03 16:26:19', '2021-03-03 16:27:30', '2021-03-03 16:27:30');
INSERT INTO `referral` VALUES (125, 'ivT9kVjuOSekBVuYaWW6god2XCiNahgtntarFEGW125', 125, '2021-03-03 16:28:54', '2021-03-03 16:29:42', '2021-03-03 16:29:42');
INSERT INTO `referral` VALUES (126, '4yBwZ4Q7ljXqwEWN06PQjOBaldL9qx1ivB7obqUR126', 126, '2021-03-03 16:30:38', '2021-03-03 16:31:43', '2021-03-03 16:31:43');
INSERT INTO `referral` VALUES (127, 'rSNcKwYVjYQTHEZklW0YqFv031PgdKQN0xah8aci127', 127, '2021-03-03 16:32:59', '2021-03-03 16:34:15', '2021-03-03 16:34:15');
INSERT INTO `referral` VALUES (128, 'DJ5YbOTNUyhNGvzPOMFQKdTso2NYrLcHCbBUzTTo128', 128, '2021-03-03 16:36:26', '2021-03-03 16:37:59', '2021-03-03 16:37:59');
INSERT INTO `referral` VALUES (129, 'ciBdPDNT4F4R5SPrpRK8yeKE4ikfoBRIqQBbsfX5129', 129, '2021-03-03 16:43:12', '2021-03-03 16:45:44', '2021-03-03 16:45:44');
INSERT INTO `referral` VALUES (130, 'c5JSSYlSKPUKHn5BOOsFvRzOvMWjWlhrGgWHTJCs130', 130, '2021-03-03 16:51:19', '2021-03-03 16:53:16', '2021-03-03 16:53:16');
INSERT INTO `referral` VALUES (131, 'qBQZhqNI47TCwf8I7ZeOUd6dQQRrzETSxLF2NqGf131', 131, '2021-03-03 17:10:14', '2021-03-03 17:10:14', NULL);
INSERT INTO `referral` VALUES (132, 'Z2AyidI7SJUKjoaYjxaQdAbTNB2ONYF7lnE9NZES132', 132, '2021-03-03 19:35:59', '2021-03-03 19:39:08', '2021-03-03 19:39:08');
INSERT INTO `referral` VALUES (133, 'Ho7p77iB3aUiS1v4KxqRa2djzPxom6RRJb2OQWGe133', 133, '2021-03-03 19:43:57', '2021-03-03 19:45:58', '2021-03-03 19:45:58');
INSERT INTO `referral` VALUES (134, 'eERjJAeQNB8Q4KV3Prk6zVtc4tKluzIqXGeVVZWr134', 134, '2021-03-03 19:53:11', '2021-03-03 20:05:07', '2021-03-03 20:05:07');
INSERT INTO `referral` VALUES (135, 'keHvXG6LTp6YR9EYehw2P1ehYF6QGjfuDeF7isyp135', 135, '2021-03-03 20:14:21', '2021-03-03 20:17:27', '2021-03-03 20:17:27');
INSERT INTO `referral` VALUES (136, 'G0CuoUSQ6CfSU06jNQLFqGAPeB2bXPXnwSwKPfbm136', 136, '2021-03-03 20:16:49', '2021-03-03 20:23:55', '2021-03-03 20:23:55');
INSERT INTO `referral` VALUES (137, '4P26jpMzjkqXli015shXQvYTGWhGRoMsx6npV6w2137', 137, '2021-03-03 20:18:24', '2021-03-03 20:26:01', '2021-03-03 20:26:01');
INSERT INTO `referral` VALUES (138, 'Dk6IiwMtkxCqUzqaGIbQv8jmQdDVtkJo1N7ZjUyr138', 138, '2021-03-03 20:32:36', '2021-03-03 20:34:36', '2021-03-03 20:34:36');
INSERT INTO `referral` VALUES (139, 'n6pPTKxg38MH0W0EG51AQ6GDQWwwuJ7bs5Z3sBuH139', 139, '2021-03-03 20:40:00', '2021-03-03 20:44:38', '2021-03-03 20:44:38');
INSERT INTO `referral` VALUES (140, '01DmEJqzMZzS5rn3LqJfdRPUwEfps6X2CUBGQjHC140', 140, '2021-03-03 20:42:42', '2021-03-03 20:46:51', '2021-03-03 20:46:51');
INSERT INTO `referral` VALUES (141, 'VoBzouks9U7vPE1SXBq9NVFqmlu93lP9tHyKO9qQ141', 141, '2021-03-03 20:50:07', '2021-03-03 20:53:49', '2021-03-03 20:53:49');
INSERT INTO `referral` VALUES (142, 'IZvyZ4OcVPKsf1x67MzpF03RiefSX0yBZHbZflpc142', 142, '2021-03-03 20:52:37', '2021-03-03 20:55:12', '2021-03-03 20:55:12');
INSERT INTO `referral` VALUES (143, 'hVR0imkKYJg6r4qPQabrLsevVldQE2f7k1jVxeXC143', 143, '2021-03-03 20:59:03', '2021-03-03 21:02:13', '2021-03-03 21:02:13');
INSERT INTO `referral` VALUES (144, 'Lfbsl3IF4zlCX6UQdcu08Wk9gLbN3Op9Kv5a08p0144', 144, '2021-03-03 21:04:40', '2021-03-03 21:09:35', '2021-03-03 21:09:35');
INSERT INTO `referral` VALUES (145, 'uBFTaM39dRFgfUuzADdTrz0xJUjTiy3s6K5batZc145', 145, '2021-03-03 21:12:36', '2021-03-03 21:17:46', '2021-03-03 21:17:46');
INSERT INTO `referral` VALUES (146, '9UIipCo7twK6RoIzbiMtmqwlwBZ5xKMny39mXb9N146', 146, '2021-03-03 21:14:36', '2021-03-03 21:19:02', '2021-03-03 21:19:02');
INSERT INTO `referral` VALUES (147, 'cpGMCOBxYYDWcmfXrQl45M1C1TxDkWO3Y3dqWURi147', 147, '2021-03-03 23:52:45', '2021-03-04 00:02:53', '2021-03-04 00:02:53');
INSERT INTO `referral` VALUES (148, 'eUnrnWXe1FF0gjqrW2TrpHOvTGwKzTm2K7v8cSRl148', 148, '2021-03-04 00:03:51', '2021-03-04 00:03:51', NULL);

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `role_has_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `guard_name` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_unique`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'super-admin', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');
INSERT INTO `roles` VALUES (2, 'user', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');
INSERT INTO `roles` VALUES (3, 'guest', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES ('01wkDsRcK1-202103031145411614771941680', 'Member activation on behalf of Leadersaok', '2021-03-03 11:45:41', '2021-03-03 11:45:41');
INSERT INTO `transaction` VALUES ('0aK4yyVJTi-202103030417181614788238124', 'Member activation on behalf of Renya', '2021-03-03 16:17:18', '2021-03-03 16:17:18');
INSERT INTO `transaction` VALUES ('0VJ0QBbOr1-202103020221341614694894641', 'Member activation on behalf of SM_Team08', '2021-03-02 14:21:34', '2021-03-02 14:21:34');
INSERT INTO `transaction` VALUES ('123123123123', 'Member registration on behalf of NURUL WATHANI', '2021-03-02 07:35:43', '2021-03-02 07:35:43');
INSERT INTO `transaction` VALUES ('1Lw779fndf-202103030116331614777393084', 'Member activation on behalf of NURDIN198601', '2021-03-03 13:16:33', '2021-03-03 13:16:33');
INSERT INTO `transaction` VALUES ('1NVRvFM2P5-202103021202451614686565108', 'Member activation on behalf of ArniLbc', '2021-03-02 12:02:45', '2021-03-02 12:02:45');
INSERT INTO `transaction` VALUES ('1wsr2qVumu-202103011024151614594255421', 'Member activation on behalf of andifajarlah@gmail.com', '2021-03-01 10:24:15', '2021-03-01 10:24:15');
INSERT INTO `transaction` VALUES ('32aXJX2cvy-202103031203061614772986213', 'Member activation on behalf of sudaesallomboki', '2021-03-03 12:03:06', '2021-03-03 12:03:06');
INSERT INTO `transaction` VALUES ('3hsmbu1gdX-202103030206181614780378670', 'Member activation on behalf of Puspita01', '2021-03-03 14:06:18', '2021-03-03 14:06:18');
INSERT INTO `transaction` VALUES ('3LV2crS86W-202103020343581614699838988', 'Member activation on behalf of Taoke_02', '2021-03-02 15:43:58', '2021-03-02 15:43:58');
INSERT INTO `transaction` VALUES ('4P3OBo2AHu-202103030532021614749522503', 'Member activation on behalf of toyadirich', '2021-03-03 05:32:02', '2021-03-03 05:32:02');
INSERT INTO `transaction` VALUES ('53q1Elv7iD-202103030739081614800348280', 'Member activation on behalf of Pang5', '2021-03-03 19:39:08', '2021-03-03 19:39:08');
INSERT INTO `transaction` VALUES ('5FgKdey2Mx-202103030230531614781853380', 'Member activation on behalf of Muhar1986', '2021-03-03 14:30:53', '2021-03-03 14:30:53');
INSERT INTO `transaction` VALUES ('6CB9BV3o4H-202103030401381614787298930', 'Member activation on behalf of master2', '2021-03-03 16:01:38', '2021-03-03 16:01:38');
INSERT INTO `transaction` VALUES ('6sgW7jKgk9-202103030817271614802647559', 'Member activation on behalf of Pang502', '2021-03-03 20:17:27', '2021-03-03 20:17:27');
INSERT INTO `transaction` VALUES ('7bg1iTDDoY-202103020758251614715105361', 'Member activation on behalf of mzwfam', '2021-03-02 19:58:25', '2021-03-02 19:58:25');
INSERT INTO `transaction` VALUES ('7KTkIjDnnQ-202103031257091614733029647', 'Member activation on behalf of GUNTURTKER1', '2021-03-03 00:57:09', '2021-03-03 00:57:09');
INSERT INTO `transaction` VALUES ('7W6a13zMnS-202103030208471614780527147', 'Member activation on behalf of MYUNUS03', '2021-03-03 14:08:47', '2021-03-03 14:08:47');
INSERT INTO `transaction` VALUES ('8Ewupp7JoH-202103030356261614786986291', 'Member activation on behalf of master01', '2021-03-03 15:56:26', '2021-03-03 15:56:26');
INSERT INTO `transaction` VALUES ('8h0EDagpeV-202103030919021614806342689', 'Member activation on behalf of Garuda02', '2021-03-03 21:19:02', '2021-03-03 21:19:02');
INSERT INTO `transaction` VALUES ('A8smWVhzMR-202103031032541614767574786', 'Member activation on behalf of WAHYURICH', '2021-03-03 10:32:54', '2021-03-03 10:32:54');
INSERT INTO `transaction` VALUES ('aHFf9gFzgN-202103021117121614727032799', 'Member activation on behalf of sugihmotah02', '2021-03-02 23:17:12', '2021-03-02 23:17:12');
INSERT INTO `transaction` VALUES ('Ai751shtle-202103031203401614729820624', 'Member activation on behalf of Andra88', '2021-03-03 00:03:40', '2021-03-03 00:03:40');
INSERT INTO `transaction` VALUES ('BeakYLcRCF-202103030422241614788544946', 'Member activation on behalf of Renyasukses01', '2021-03-03 16:22:24', '2021-03-03 16:22:24');
INSERT INTO `transaction` VALUES ('By9sdp53uc-202103021024581614680698165', 'Member activation on behalf of HHT CENTER', '2021-03-02 10:24:58', '2021-03-02 10:24:58');
INSERT INTO `transaction` VALUES ('byNUl7P3Ln-202103030445441614789944561', 'Member activation on behalf of Palugada', '2021-03-03 16:45:44', '2021-03-03 16:45:44');
INSERT INTO `transaction` VALUES ('byT3oMMeYX-202103030737441614757064325', 'Member activation on behalf of ARGANTA1', '2021-03-03 07:37:44', '2021-03-03 07:37:44');
INSERT INTO `transaction` VALUES ('ca1KWl4zZZ-202103030902131614805333022', 'Member activation on behalf of Sebatik12', '2021-03-03 21:02:13', '2021-03-03 21:02:13');
INSERT INTO `transaction` VALUES ('cH6RxIaHMk-202103010133421614605622293', 'Member activation on behalf of Excellent', '2021-03-01 13:33:42', '2021-03-01 13:33:42');
INSERT INTO `transaction` VALUES ('cv74J43sLG-202103020706571614668817853', 'Member activation on behalf of Team01', '2021-03-02 07:06:57', '2021-03-02 07:06:57');
INSERT INTO `transaction` VALUES ('dgKWplSL75-202103030317171614784637893', 'Member activation on behalf of QueenRich', '2021-03-03 15:17:17', '2021-03-03 15:17:17');
INSERT INTO `transaction` VALUES ('dgvPY4eEv9-202103031004091614765849124', 'Member activation on behalf of smteam$', '2021-03-03 10:04:09', '2021-03-03 10:04:09');
INSERT INTO `transaction` VALUES ('DH5DfG9c4V-202103030823551614803035155', 'Member activation on behalf of Ultrakaya007', '2021-03-03 20:23:55', '2021-03-03 20:23:55');
INSERT INTO `transaction` VALUES ('DhdQnqQrEV-202103030429421614788982583', 'Member activation on behalf of Yantosukses', '2021-03-03 16:29:42', '2021-03-03 16:29:42');
INSERT INTO `transaction` VALUES ('DiBknMbbRw-202103030219001614781140857', 'Member activation on behalf of RINJANI007', '2021-03-03 14:19:00', '2021-03-03 14:19:00');
INSERT INTO `transaction` VALUES ('e5YNpvfXh6-202103030157451614736665355', 'Member activation on behalf of DOAIBU', '2021-03-03 01:57:45', '2021-03-03 01:57:45');
INSERT INTO `transaction` VALUES ('E9CorrW9dJ-202103030153491614779629147', 'Member activation on behalf of JAWARASASAK02', '2021-03-03 13:53:49', '2021-03-03 13:53:49');
INSERT INTO `transaction` VALUES ('eGllBy52BC-202103030212321614737552899', 'Member activation on behalf of DatuSelaparang', '2021-03-03 02:12:32', '2021-03-03 02:12:32');
INSERT INTO `transaction` VALUES ('eM0uTjcGsZ-202103030434151614789255220', 'Member activation on behalf of Fadilla', '2021-03-03 16:34:15', '2021-03-03 16:34:15');
INSERT INTO `transaction` VALUES ('EyreYd7M7W-202103020629551614709795671', 'Member activation on behalf of UMAR', '2021-03-02 18:29:55', '2021-03-02 18:29:55');
INSERT INTO `transaction` VALUES ('F0jn8OzaoX-202103030122291614777749513', 'Member activation on behalf of MAJID02', '2021-03-03 13:22:29', '2021-03-03 13:22:29');
INSERT INTO `transaction` VALUES ('fCYhcxdGHI-202103021253551614689635676', 'Member activation on behalf of JENDRAL3', '2021-03-02 12:53:55', '2021-03-02 12:53:55');
INSERT INTO `transaction` VALUES ('fGMgWP2VJa-202103030137021614778622187', 'Member activation on behalf of JAWARASASAK01', '2021-03-03 13:37:02', '2021-03-03 13:37:02');
INSERT INTO `transaction` VALUES ('fiOJpX0ICG-202103020714201614669260342', 'Member activation on behalf of PapaOnline2', '2021-03-02 07:14:20', '2021-03-02 07:14:20');
INSERT INTO `transaction` VALUES ('G19StjYAPE-202103030853491614804829662', 'Member activation on behalf of ternakdollar01', '2021-03-03 20:53:49', '2021-03-03 20:53:49');
INSERT INTO `transaction` VALUES ('g3ny1DwN51-202103030226301614781590154', 'Member activation on behalf of Zalila2006', '2021-03-03 14:26:30', '2021-03-03 14:26:30');
INSERT INTO `transaction` VALUES ('G3RYirSQza-202103030323431614785023561', 'Member activation on behalf of RINJANI009', '2021-03-03 15:23:43', '2021-03-03 15:23:43');
INSERT INTO `transaction` VALUES ('G5uzYFNoEP-202103030808541614758934682', 'Member activation on behalf of ALWANUL01', '2021-03-03 08:08:54', '2021-03-03 08:08:54');
INSERT INTO `transaction` VALUES ('GXCtYQat9Y-202103030828561614760136881', 'Member activation on behalf of ALWANUL03', '2021-03-03 08:28:56', '2021-03-03 08:28:56');
INSERT INTO `transaction` VALUES ('h47TakEjZ7-202103030226501614781610838', 'Member activation on behalf of PRABU BAKE 007', '2021-03-03 14:26:50', '2021-03-03 14:26:50');
INSERT INTO `transaction` VALUES ('HdkaenddoU-202103030411181614787878472', 'Member activation on behalf of Yegar', '2021-03-03 16:11:18', '2021-03-03 16:11:18');
INSERT INTO `transaction` VALUES ('hG9BrWHxNz-202103021047331614725253817', 'Member activation on behalf of sugihmotah01', '2021-03-02 22:47:33', '2021-03-02 22:47:33');
INSERT INTO `transaction` VALUES ('hmvNozMDD4-202103030427301614788850178', 'Member activation on behalf of Yanto', '2021-03-03 16:27:30', '2021-03-03 16:27:30');
INSERT INTO `transaction` VALUES ('HP56bUPvnd-202103030131591614778319726', 'Member activation on behalf of MYUNUS01', '2021-03-03 13:31:59', '2021-03-03 13:31:59');
INSERT INTO `transaction` VALUES ('hwguSLdHTC-202103031230231614774623950', 'Member activation on behalf of Leadersaok02', '2021-03-03 12:30:23', '2021-03-03 12:30:23');
INSERT INTO `transaction` VALUES ('I5PXRHQl7o-202103031248501614775730599', 'Member activation on behalf of NURDIN1986', '2021-03-03 12:48:50', '2021-03-03 12:48:50');
INSERT INTO `transaction` VALUES ('iBUqYFEIzv-202103030844381614804278023', 'Member activation on behalf of 45', '2021-03-03 20:44:38', '2021-03-03 20:44:38');
INSERT INTO `transaction` VALUES ('iQlQ8RpmZE-202103020717341614669454256', 'Member activation on behalf of PapaOnline3', '2021-03-02 07:17:34', '2021-03-02 07:17:34');
INSERT INTO `transaction` VALUES ('IthsrC75I5-202103021204251614686665327', 'Member activation on behalf of HWSLOMBOK', '2021-03-02 12:04:25', '2021-03-02 12:04:25');
INSERT INTO `transaction` VALUES ('IYAVHY4T5w-202103030325471614785147173', 'Member activation on behalf of QueenRich3', '2021-03-03 15:25:47', '2021-03-03 15:25:47');
INSERT INTO `transaction` VALUES ('IzG0u1fxn3-202103030945401614764740957', 'Member activation on behalf of Chikofam_b', '2021-03-03 09:45:40', '2021-03-03 09:45:40');
INSERT INTO `transaction` VALUES ('J9ITVQM9Re-202103031144401614771880629', 'Member activation on behalf of Haqqi2021', '2021-03-03 11:44:40', '2021-03-03 11:44:40');
INSERT INTO `transaction` VALUES ('jRNKBTAaY1-202103020349091614700149421', 'Member activation on behalf of Taoke_03', '2021-03-02 15:49:09', '2021-03-02 15:49:09');
INSERT INTO `transaction` VALUES ('jUkaAx3z1a-202103030206341614780394145', 'Member activation on behalf of Ihsan1997', '2021-03-03 14:06:34', '2021-03-03 14:06:34');
INSERT INTO `transaction` VALUES ('kiIp4u3nm5-202103010243461614609826362', 'Member activation on behalf of GAJAHMADA', '2021-03-01 14:43:46', '2021-03-01 14:43:46');
INSERT INTO `transaction` VALUES ('KkDxkAkEmh-202103020305371614697537829', 'Member activation on behalf of SM_Team06', '2021-03-02 15:05:37', '2021-03-02 15:05:37');
INSERT INTO `transaction` VALUES ('KOvw2Jrl4o-202103030813421614759222611', 'Member activation on behalf of ALWANUL02', '2021-03-03 08:13:42', '2021-03-03 08:13:42');
INSERT INTO `transaction` VALUES ('LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020741481614670908152', 'Buy 1 PIN1 by Team01', '2021-03-02 07:41:48', '2021-03-02 07:41:48');
INSERT INTO `transaction` VALUES ('LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020754161614671656124', 'Member registration on behalf of Fitriana junisa by Team01', '2021-03-02 07:54:16', '2021-03-02 07:54:16');
INSERT INTO `transaction` VALUES ('LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021134191614684859703', 'Buy 1 PIN by Team01', '2021-03-02 11:34:19', '2021-03-02 11:34:19');
INSERT INTO `transaction` VALUES ('LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021135071614684907123', 'Member registration on behalf of yusrilhamdani.yh@gmail.com by Team01', '2021-03-02 11:35:07', '2021-03-02 11:35:07');
INSERT INTO `transaction` VALUES ('LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020747231614671243399', 'Buy 1 PIN by Super01', '2021-03-02 07:47:23', '2021-03-02 07:47:23');
INSERT INTO `transaction` VALUES ('LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020748591614671339365', 'Member registration on behalf of Rayyan by Super01', '2021-03-02 07:48:59', '2021-03-02 07:48:59');
INSERT INTO `transaction` VALUES ('LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021049251614682165833', 'Buy 1 PIN by Super01', '2021-03-02 10:49:25', '2021-03-02 10:49:25');
INSERT INTO `transaction` VALUES ('LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021052131614682333923', 'Member registration on behalf of muhammadmw1983@gmail.com by Super01', '2021-03-02 10:52:13', '2021-03-02 10:52:13');
INSERT INTO `transaction` VALUES ('LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021231341614688294146', 'Buy 2 PINs by JENDRAL', '2021-03-02 12:31:34', '2021-03-02 12:31:34');
INSERT INTO `transaction` VALUES ('LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021240441614688844400', 'Member registration on behalf of yusrilhy212@gmail.com by JENDRAL', '2021-03-02 12:40:44', '2021-03-02 12:40:44');
INSERT INTO `transaction` VALUES ('LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021252251614689545147', 'Member registration on behalf of dimashiporia@gmail.com by JENDRAL', '2021-03-02 12:52:25', '2021-03-02 12:52:25');
INSERT INTO `transaction` VALUES ('LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103020818201614673100792', 'Buy 1 PIN by Team02', '2021-03-02 08:18:20', '2021-03-02 08:18:20');
INSERT INTO `transaction` VALUES ('LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021021221614680482844', 'Member registration on behalf of hhtcenter1@gmail.com by Team02', '2021-03-02 10:21:22', '2021-03-02 10:21:22');
INSERT INTO `transaction` VALUES ('LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021140551614685255520', 'Buy 1 PIN by Team02', '2021-03-02 11:40:55', '2021-03-02 11:40:55');
INSERT INTO `transaction` VALUES ('LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021142211614685341982', 'Member registration on behalf of hamidagung433@gmail.com by Team02', '2021-03-02 11:42:21', '2021-03-02 11:42:21');
INSERT INTO `transaction` VALUES ('Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030957261614765446225', 'Buy 2 PINs by Chikofam_a', '2021-03-03 09:57:26', '2021-03-03 09:57:26');
INSERT INTO `transaction` VALUES ('Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030959111614765551485', 'Member registration on behalf of smteam012021@gmail.com by Chikofam_a', '2021-03-03 09:59:11', '2021-03-03 09:59:11');
INSERT INTO `transaction` VALUES ('Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103031000431614765643266', 'Member registration on behalf of smteam022021@gmail.com by Chikofam_a', '2021-03-03 10:00:43', '2021-03-03 10:00:43');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021154311614729271611', 'Buy 2 PINs by Excellent', '2021-03-02 23:54:31', '2021-03-02 23:54:31');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021158341614729514564', 'Member registration on behalf of bbemailku80@gmail.com by Excellent', '2021-03-02 23:58:34', '2021-03-02 23:58:34');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030146561614736016953', 'Member registration on behalf of bongor1976@gmail.com by Excellent', '2021-03-03 01:46:56', '2021-03-03 01:46:56');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030156331614779793010', 'Buy 1 PIN by Excellent', '2021-03-03 13:56:33', '2021-03-03 13:56:33');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030201011614736861715', 'Buy 2 PINs by Excellent', '2021-03-03 02:01:01', '2021-03-03 02:01:01');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030203001614780180453', 'Member registration on behalf of lenipuspitadewi97@gmail.com by Excellent', '2021-03-03 14:03:00', '2021-03-03 14:03:00');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030205381614737138166', 'Member registration on behalf of lerylesmana9@gmail.com by Excellent', '2021-03-03 02:05:38', '2021-03-03 02:05:38');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030211351614737495733', 'Member registration on behalf of soldierwinter782@gmail.com by Excellent', '2021-03-03 02:11:35', '2021-03-03 02:11:35');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030212401614780760780', 'Member registration on behalf of Opickchocolatos007@gmail.com by Excellent', '2021-03-03 14:12:40', '2021-03-03 14:12:40');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030224051614781445270', 'Member registration on behalf of Bangfikri007@gmail.com by Excellent', '2021-03-03 14:24:05', '2021-03-03 14:24:05');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030226251614781585938', 'Buy 1 PIN by Excellent', '2021-03-03 14:26:25', '2021-03-03 14:26:25');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030237251614782245494', 'Member registration on behalf of lerylesmana10@gmail.com by Excellent', '2021-03-03 14:37:25', '2021-03-03 14:37:25');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030239291614782369498', 'Member registration on behalf of Opickchocolatos008@gmail.com by Excellent', '2021-03-03 14:39:29', '2021-03-03 14:39:29');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030251231614739883728', 'Buy 4 PINs by Excellent', '2021-03-03 02:51:23', '2021-03-03 02:51:23');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030255251614740125824', 'Member registration on behalf of lilikindrawati182@gmail.com by Excellent', '2021-03-03 02:55:25', '2021-03-03 02:55:25');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030313331614784413864', 'Buy 1 PIN by Excellent', '2021-03-03 15:13:33', '2021-03-03 15:13:33');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030320381614784838919', 'Member registration on behalf of Opickchocolatos009@gmail.com by Excellent', '2021-03-03 15:20:38', '2021-03-03 15:20:38');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030328381614785318146', 'Buy 11 PINs by Excellent', '2021-03-03 15:28:38', '2021-03-03 15:28:38');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031206171614729977779', 'Member registration on behalf of bbemailku81@gmail.com by Excellent', '2021-03-03 00:06:17', '2021-03-03 00:06:17');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031220041614730804801', 'Buy 2 PINs by Excellent', '2021-03-03 00:20:04', '2021-03-03 00:20:04');
INSERT INTO `transaction` VALUES ('Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031224221614731062429', 'Member registration on behalf of hibarisatria@gmail.com by Excellent', '2021-03-03 00:24:22', '2021-03-03 00:24:22');
INSERT INTO `transaction` VALUES ('Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031219011614773941214', 'Buy 1 PIN by Taoke_03', '2021-03-03 12:19:01', '2021-03-03 12:19:01');
INSERT INTO `transaction` VALUES ('Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031221211614774081442', 'Member registration on behalf of datudahe1983@gmail.com by Taoke_03', '2021-03-03 12:21:21', '2021-03-03 12:21:21');
INSERT INTO `transaction` VALUES ('LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031207071614773227758', 'Buy 2 PINs by Leadersaok', '2021-03-03 12:07:07', '2021-03-03 12:07:07');
INSERT INTO `transaction` VALUES ('LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031211461614773506132', 'Member registration on behalf of sul121751@gmail.com by Leadersaok', '2021-03-03 12:11:46', '2021-03-03 12:11:46');
INSERT INTO `transaction` VALUES ('LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031227021614774422648', 'Member registration on behalf of sulh8315@gmail.com by Leadersaok', '2021-03-03 12:27:02', '2021-03-03 12:27:02');
INSERT INTO `transaction` VALUES ('Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021103431614726223871', 'Buy 6 PINs by sugihmotah01', '2021-03-02 23:03:43', '2021-03-02 23:03:43');
INSERT INTO `transaction` VALUES ('Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021107081614726428584', 'Member registration on behalf of dayock1982@gmail.com by sugihmotah01', '2021-03-02 23:07:08', '2021-03-02 23:07:08');
INSERT INTO `transaction` VALUES ('Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021114321614726872706', 'Member registration on behalf of lukmanulhakim974@gmail.com by sugihmotah01', '2021-03-02 23:14:32', '2021-03-02 23:14:32');
INSERT INTO `transaction` VALUES ('Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031150271614815427575', 'Buy 2 PINs by sugihmotah01', '2021-03-03 23:50:27', '2021-03-03 23:50:27');
INSERT INTO `transaction` VALUES ('Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031152451614815565087', 'Member registration on behalf of hamdanbhdn@yahoo.com by sugihmotah01', '2021-03-03 23:52:45', '2021-03-03 23:52:45');
INSERT INTO `transaction` VALUES ('LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103010942201614634940463', 'Buy 2 PINs by andifajarlah@gmail.com', '2021-03-01 21:42:20', '2021-03-01 21:42:20');
INSERT INTO `transaction` VALUES ('LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103020728551614670135184', 'Buy 1 PIN1 by andifajarlah@gmail.com', '2021-03-02 07:28:55', '2021-03-02 07:28:55');
INSERT INTO `transaction` VALUES ('Lh76GuMR5N-202103020441231614703283219', 'Member activation on behalf of Johana', '2021-03-02 16:41:23', '2021-03-02 16:41:23');
INSERT INTO `transaction` VALUES ('lIlCJW4qFv-202103030111161614777076998', 'Member activation on behalf of ALWANUL04', '2021-03-03 13:11:16', '2021-03-03 13:11:16');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103020825351614673535525', 'Buy 2 PINs by GUNTURTKER', '2021-03-02 08:25:35', '2021-03-02 08:25:35');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021053331614725613201', 'Member registration on behalf of salehlalu596@gmail.com by GUNTURTKER', '2021-03-02 22:53:33', '2021-03-02 22:53:33');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021057381614725858665', 'Member registration on behalf of lalumuhammadsaleh181@gmail.com by GUNTURTKER', '2021-03-02 22:57:38', '2021-03-02 22:57:38');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021116081614726968602', 'Buy 2 PINs by GUNTURTKER', '2021-03-02 23:16:08', '2021-03-02 23:16:08');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021129541614727794388', 'Member registration on behalf of salehraden098@gmail.com by GUNTURTKER', '2021-03-02 23:29:54', '2021-03-02 23:29:54');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021138501614728330612', 'Member registration on behalf of tkerguntur098@gmail.com by GUNTURTKER', '2021-03-02 23:38:50', '2021-03-02 23:38:50');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030104081614776648542', 'Buy 5 PINs by GUNTURTKER', '2021-03-03 13:04:08', '2021-03-03 13:04:08');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030109081614776948091', 'Member registration on behalf of baiqsahuri50@gmail.com by GUNTURTKER', '2021-03-03 13:09:08', '2021-03-03 13:09:08');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030114231614777263873', 'Member registration on behalf of muhammadnizar3334@gmail.com by GUNTURTKER', '2021-03-03 13:14:23', '2021-03-03 13:14:23');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030117301614777450702', 'Member registration on behalf of halil123haji@gmail.com by GUNTURTKER', '2021-03-03 13:17:30', '2021-03-03 13:17:30');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030123191614777799811', 'Member registration on behalf of hjmurgasih@gmail.com by GUNTURTKER', '2021-03-03 13:23:19', '2021-03-03 13:23:19');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030126381614777998699', 'Member registration on behalf of myunusyuan@gmail.com by GUNTURTKER', '2021-03-03 13:26:38', '2021-03-03 13:26:38');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030135211614778521844', 'Buy 5 PINs by GUNTURTKER', '2021-03-03 13:35:21', '2021-03-03 13:35:21');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030138491614778729215', 'Member registration on behalf of yunusyuan01@gmail.com by GUNTURTKER', '2021-03-03 13:38:49', '2021-03-03 13:38:49');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030142521614778972743', 'Member registration on behalf of lalupanjipparawangsa@gmail.com by GUNTURTKER', '2021-03-03 13:42:52', '2021-03-03 13:42:52');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030149121614779352653', 'Member registration on behalf of satryasasak@gmail.com by GUNTURTKER', '2021-03-03 13:49:12', '2021-03-03 13:49:12');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030153591614779639509', 'Member registration on behalf of myunusyuan02@gmail.com by GUNTURTKER', '2021-03-03 13:53:59', '2021-03-03 13:53:59');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030334201614742460962', 'Buy 2 PINs by GUNTURTKER', '2021-03-03 03:34:20', '2021-03-03 03:34:20');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030456431614747403089', 'Member registration on behalf of alwanulhamdi76@gmail.com by GUNTURTKER', '2021-03-03 04:56:43', '2021-03-03 04:56:43');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030509151614748155000', 'Member registration on behalf of dinn44554@gmail.com by GUNTURTKER', '2021-03-03 05:09:15', '2021-03-03 05:09:15');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030731401614756700674', 'Buy 1 PIN by GUNTURTKER', '2021-03-03 07:31:40', '2021-03-03 07:31:40');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030734151614756855950', 'Member registration on behalf of lamtanuss@gmail.com by GUNTURTKER', '2021-03-03 07:34:15', '2021-03-03 07:34:15');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030757471614758267410', 'Buy 5 PINs by GUNTURTKER', '2021-03-03 07:57:47', '2021-03-03 07:57:47');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030803191614758599404', 'Member registration on behalf of lamtanusimam@gmail.com by GUNTURTKER', '2021-03-03 08:03:19', '2021-03-03 08:03:19');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030806591614758819884', 'Member registration on behalf of albytsaqib20@gmail.com by GUNTURTKER', '2021-03-03 08:06:59', '2021-03-03 08:06:59');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030812041614759124189', 'Member registration on behalf of hamdilalu76@gmail.com by GUNTURTKER', '2021-03-03 08:12:04', '2021-03-03 08:12:04');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030817081614759428583', 'Member registration on behalf of samsulrina31@gmail.com by GUNTURTKER', '2021-03-03 08:17:08', '2021-03-03 08:17:08');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030826341614759994755', 'Member registration on behalf of hannabaiq76@gmail.com by GUNTURTKER', '2021-03-03 08:26:34', '2021-03-03 08:26:34');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030923171614763397679', 'Buy 5 PINs by GUNTURTKER', '2021-03-03 09:23:17', '2021-03-03 09:23:17');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031233091614774789782', 'Member registration on behalf of revaazahra85@gmail.com by GUNTURTKER', '2021-03-03 12:33:09', '2021-03-03 12:33:09');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031238381614775118636', 'Member registration on behalf of erwinefendi4445@gmail.com by GUNTURTKER', '2021-03-03 12:38:38', '2021-03-03 12:38:38');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031242261614775346494', 'Member registration on behalf of wiendy780@gmail.com by GUNTURTKER', '2021-03-03 12:42:26', '2021-03-03 12:42:26');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031245231614775523841', 'Member registration on behalf of dinn45544@gmail.com by GUNTURTKER', '2021-03-03 12:45:23', '2021-03-03 12:45:23');
INSERT INTO `transaction` VALUES ('LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031256361614776196930', 'Member registration on behalf of laluabdulmajid120876@gmail.com by GUNTURTKER', '2021-03-03 12:56:36', '2021-03-03 12:56:36');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020710361614669036878', 'Buy 50 PINs by PapaOnline', '2021-03-02 07:10:36', '2021-03-02 07:10:36');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020712431614669163964', 'Member registration on behalf of alias by PapaOnline', '2021-03-02 07:12:43', '2021-03-02 07:12:43');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020716561614669416045', 'Member registration on behalf of alias by PapaOnline', '2021-03-02 07:16:56', '2021-03-02 07:16:56');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020723271614669807943', 'Member registration on behalf of Hendro Sutrisno by PapaOnline', '2021-03-02 07:23:27', '2021-03-02 07:23:27');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020738471614670727570', 'Member registration on behalf of Hendro Sutrisno by PapaOnline', '2021-03-02 07:38:47', '2021-03-02 07:38:47');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030309221614784162695', 'Member registration on behalf of luckybestrich@gmail.com by PapaOnline', '2021-03-03 15:09:22', '2021-03-03 15:09:22');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030319221614784762947', 'Member registration on behalf of l.uckybestrich@gmail.com by PapaOnline', '2021-03-03 15:19:22', '2021-03-03 15:19:22');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030324481614785088140', 'Member registration on behalf of lu.ckybestrich@gmail.com by PapaOnline', '2021-03-03 15:24:48', '2021-03-03 15:24:48');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030334211614785661159', 'Member registration on behalf of luc.kybestrich@gmail.com by PapaOnline', '2021-03-03 15:34:21', '2021-03-03 15:34:21');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030349501614786590393', 'Member registration on behalf of m.otor.hendro@gmail.com by PapaOnline', '2021-03-03 15:49:50', '2021-03-03 15:49:50');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030358581614787138801', 'Member registration on behalf of mo.tor.hendro@gmail.com by PapaOnline', '2021-03-03 15:58:58', '2021-03-03 15:58:58');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030404251614787465396', 'Member registration on behalf of fgxpressindonesia@gmail.com by PapaOnline', '2021-03-03 16:04:25', '2021-03-03 16:04:25');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030409311614787771122', 'Member registration on behalf of f.gxpressindonesia@gmail.com by PapaOnline', '2021-03-03 16:09:31', '2021-03-03 16:09:31');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030415211614788121069', 'Member registration on behalf of emerents83@gmail.com by PapaOnline', '2021-03-03 16:15:21', '2021-03-03 16:15:21');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030418591614788339096', 'Member registration on behalf of e.merents83@gmail.com by PapaOnline', '2021-03-03 16:18:59', '2021-03-03 16:18:59');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030420531614788453044', 'Member registration on behalf of em.erents83@gmail.com by PapaOnline', '2021-03-03 16:20:53', '2021-03-03 16:20:53');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030423001614788580043', 'Buy 50 PINs by PapaOnline', '2021-03-03 16:23:00', '2021-03-03 16:23:00');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030426191614788779239', 'Member registration on behalf of yantho.manafe@gmail.com by PapaOnline', '2021-03-03 16:26:19', '2021-03-03 16:26:19');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030428541614788934082', 'Member registration on behalf of y.antho.manafe@gmail.com by PapaOnline', '2021-03-03 16:28:54', '2021-03-03 16:28:54');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030430381614789038317', 'Member registration on behalf of ya.ntho.manafe@gmail.com by PapaOnline', '2021-03-03 16:30:38', '2021-03-03 16:30:38');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030432591614789179733', 'Member registration on behalf of fg.xpressindonesia@gmail.com by PapaOnline', '2021-03-03 16:32:59', '2021-03-03 16:32:59');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030436261614789386279', 'Member registration on behalf of fgx.pressindonesia@gmail.com by PapaOnline', '2021-03-03 16:36:26', '2021-03-03 16:36:26');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030443121614789792717', 'Member registration on behalf of iketutarantikabali@gmail.com by PapaOnline', '2021-03-03 16:43:12', '2021-03-03 16:43:12');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030451191614790279751', 'Member registration on behalf of al.iassebatik@gmail.com by PapaOnline', '2021-03-03 16:51:19', '2021-03-03 16:51:19');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030510141614791414180', 'Member registration on behalf of upixbase180@gmail.com by PapaOnline', '2021-03-03 17:10:14', '2021-03-03 17:10:14');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030735591614800159838', 'Member registration on behalf of mirwanbone@gmail.com by PapaOnline', '2021-03-03 19:35:59', '2021-03-03 19:35:59');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030743571614800637269', 'Member registration on behalf of m.irwanbone@gmail.com by PapaOnline', '2021-03-03 19:43:57', '2021-03-03 19:43:57');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030753111614801191607', 'Member registration on behalf of mercusuar511@gmail.com by PapaOnline', '2021-03-03 19:53:11', '2021-03-03 19:53:11');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030814211614802461377', 'Member registration on behalf of powerbetece@gmail.com by PapaOnline', '2021-03-03 20:14:21', '2021-03-03 20:14:21');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030816491614802609050', 'Member registration on behalf of m.ercusuar511@gmail.com by PapaOnline', '2021-03-03 20:16:49', '2021-03-03 20:16:49');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030818241614802704125', 'Member registration on behalf of me.rcusuar511@gmail.com by PapaOnline', '2021-03-03 20:18:24', '2021-03-03 20:18:24');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030832361614803556924', 'Member registration on behalf of pow.erbetece@gmail.com by PapaOnline', '2021-03-03 20:32:36', '2021-03-03 20:32:36');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030840001614804000718', 'Member registration on behalf of powe.rbetece@gmail.com by PapaOnline', '2021-03-03 20:40:00', '2021-03-03 20:40:00');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030842421614804162694', 'Member registration on behalf of asis.suandi26@gmail.com by PapaOnline', '2021-03-03 20:42:42', '2021-03-03 20:42:42');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030850071614804607767', 'Member registration on behalf of a.sis.suandi26@gmail.com by PapaOnline', '2021-03-03 20:50:07', '2021-03-03 20:50:07');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030852371614804757028', 'Member registration on behalf of as.is.suandi26@gmail.com by PapaOnline', '2021-03-03 20:52:37', '2021-03-03 20:52:37');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030859031614805143554', 'Member registration on behalf of alia.ssebatik@gmail.com by PapaOnline', '2021-03-03 20:59:03', '2021-03-03 20:59:03');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030904401614805480663', 'Member registration on behalf of karmilawilis@gmail.com by PapaOnline', '2021-03-03 21:04:40', '2021-03-03 21:04:40');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030912361614805956664', 'Member registration on behalf of k.armilawilis@gmail.com by PapaOnline', '2021-03-03 21:12:36', '2021-03-03 21:12:36');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030914361614806076601', 'Member registration on behalf of ka.rmilawilis@gmail.com by PapaOnline', '2021-03-03 21:14:36', '2021-03-03 21:14:36');
INSERT INTO `transaction` VALUES ('LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103041203511614816231694', 'Member registration on behalf of huminiji543@gmail.com by PapaOnline', '2021-03-04 00:03:51', '2021-03-04 00:03:51');
INSERT INTO `transaction` VALUES ('LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030158531614779933910', 'Buy 1 PIN by Rinjanilombok', '2021-03-03 13:58:53', '2021-03-03 13:58:53');
INSERT INTO `transaction` VALUES ('LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030200391614780039840', 'Member registration on behalf of misjaruddin73@gmail.com by Rinjanilombok', '2021-03-03 14:00:39', '2021-03-03 14:00:39');
INSERT INTO `transaction` VALUES ('LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031140191614771619644', 'Buy 2 PINs by Rinjanilombok', '2021-03-03 11:40:19', '2021-03-03 11:40:19');
INSERT INTO `transaction` VALUES ('LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031142501614771770070', 'Member registration on behalf of hazanalhaqqidarojat@gmail.com by Rinjanilombok', '2021-03-03 11:42:50', '2021-03-03 11:42:50');
INSERT INTO `transaction` VALUES ('LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031155021614772502592', 'Member registration on behalf of aripianhazami@gmail.com by Rinjanilombok', '2021-03-03 11:55:02', '2021-03-03 11:55:02');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020610131614708613998', 'Buy 2 PINs by MUHAMMAD', '2021-03-02 18:10:13', '2021-03-02 18:10:13');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020619101614709150835', 'Member registration on behalf of djamallulailhamzah@gmail.com by MUHAMMAD', '2021-03-02 18:19:10', '2021-03-02 18:19:10');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020628341614709714821', 'Member registration on behalf of asmanjaya016@gmail.com by MUHAMMAD', '2021-03-02 18:28:34', '2021-03-02 18:28:34');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031028561614767336824', 'Buy 1 PIN by MUHAMMAD', '2021-03-03 10:28:56', '2021-03-03 10:28:56');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031030431614767443270', 'Member registration on behalf of wahyurich2019@gmail.com by MUHAMMAD', '2021-03-03 10:30:43', '2021-03-03 10:30:43');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031040461614768046633', 'Buy 3 PINs by MUHAMMAD', '2021-03-03 10:40:46', '2021-03-03 10:40:46');
INSERT INTO `transaction` VALUES ('LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031043251614768205885', 'Member registration on behalf of hamzahlbc1@gmail.com by MUHAMMAD', '2021-03-03 10:43:25', '2021-03-03 10:43:25');
INSERT INTO `transaction` VALUES ('LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020155051614693305549', 'Buy 1 PIN by SM01202102', '2021-03-02 13:55:05', '2021-03-02 13:55:05');
INSERT INTO `transaction` VALUES ('LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020159571614693597222', 'Member registration on behalf of mzw032021@gmail.com by SM01202102', '2021-03-02 13:59:57', '2021-03-02 13:59:57');
INSERT INTO `transaction` VALUES ('LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020753101614714790174', 'Buy 1 PIN by SM01202102', '2021-03-02 19:53:10', '2021-03-02 19:53:10');
INSERT INTO `transaction` VALUES ('LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020756241614714984144', 'Member registration on behalf of mzw042021@gmail.com by SM01202102', '2021-03-02 19:56:24', '2021-03-02 19:56:24');
INSERT INTO `transaction` VALUES ('LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031229401614774580157', 'Buy 1 PIN by datudahe', '2021-03-03 12:29:40', '2021-03-03 12:29:40');
INSERT INTO `transaction` VALUES ('LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031232561614774776681', 'Member registration on behalf of dreamtofuture.76@gmail.com by datudahe', '2021-03-03 12:32:56', '2021-03-03 12:32:56');
INSERT INTO `transaction` VALUES ('lmme4bJUOx-202103030150071614736207459', 'Member activation on behalf of Andilove02', '2021-03-03 01:50:07', '2021-03-03 01:50:07');
INSERT INTO `transaction` VALUES ('LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030219261614781166239', 'Buy 2 PINs by Ihsan1997', '2021-03-03 14:19:26', '2021-03-03 14:19:26');
INSERT INTO `transaction` VALUES ('LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030222191614781339817', 'Member registration on behalf of muaddah77@gmail.com by Ihsan1997', '2021-03-03 14:22:19', '2021-03-03 14:22:19');
INSERT INTO `transaction` VALUES ('LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030228561614781736405', 'Member registration on behalf of muharuddin968@gmail.com by Ihsan1997', '2021-03-03 14:28:56', '2021-03-03 14:28:56');
INSERT INTO `transaction` VALUES ('LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031230251614774625351', 'Buy 2 PINs by smteam#', '2021-03-03 12:30:25', '2021-03-03 12:30:25');
INSERT INTO `transaction` VALUES ('LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031233081614774788609', 'Member registration on behalf of putrawanzaini123@gmail.com by smteam#', '2021-03-03 12:33:08', '2021-03-03 12:33:08');
INSERT INTO `transaction` VALUES ('LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030931591614763919051', 'Buy 2 PINs by SM_Team08', '2021-03-03 09:31:59', '2021-03-03 09:31:59');
INSERT INTO `transaction` VALUES ('LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030934421614764082453', 'Member registration on behalf of mzw012021@gmail.com by SM_Team08', '2021-03-03 09:34:42', '2021-03-03 09:34:42');
INSERT INTO `transaction` VALUES ('LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030942561614764576764', 'Member registration on behalf of mzw022021@gmail.com by SM_Team08', '2021-03-03 09:42:56', '2021-03-03 09:42:56');
INSERT INTO `transaction` VALUES ('LPdEHbnY6v-202103031234461614774886522', 'Member activation on behalf of Kaloskaya', '2021-03-03 12:34:46', '2021-03-03 12:34:46');
INSERT INTO `transaction` VALUES ('LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020136351614692195119', 'Buy 5 PINs by SemutMerah', '2021-03-02 13:36:35', '2021-03-02 13:36:35');
INSERT INTO `transaction` VALUES ('LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020218181614694698421', 'Member registration on behalf of smteam052021@gmail.com by SemutMerah', '2021-03-02 14:18:18', '2021-03-02 14:18:18');
INSERT INTO `transaction` VALUES ('LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020639151614667155052', 'Buy 2 PINs by SemutMerah', '2021-03-02 06:39:15', '2021-03-02 06:39:15');
INSERT INTO `transaction` VALUES ('LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020735431614670543094', 'Member registration on behalf of Zainul wasti by SemutMerah', '2021-03-02 07:35:43', '2021-03-02 07:35:43');
INSERT INTO `transaction` VALUES ('LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103021112321614683552533', 'Member registration on behalf of sm01202102@gmail.com by SemutMerah', '2021-03-02 11:12:32', '2021-03-02 11:12:32');
INSERT INTO `transaction` VALUES ('LqQqLqNlCY-202103020724201614669860761', 'Member activation on behalf of qilara', '2021-03-02 07:24:20', '2021-03-02 07:24:20');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103010359301614614370946', 'Buy 2 PINs by GAJAHMADA', '2021-03-01 15:59:30', '2021-03-01 15:59:30');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020735091614670509541', 'Member registration on behalf of I Wayan Gina by GAJAHMADA', '2021-03-02 07:35:09', '2021-03-02 07:35:09');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020744051614671045065', 'Member registration on behalf of I Wayan Gina by GAJAHMADA', '2021-03-02 07:44:05', '2021-03-02 07:44:05');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030110461614733846803', 'Buy 1 PIN by GAJAHMADA', '2021-03-03 01:10:46', '2021-03-03 01:10:46');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030117351614734255387', 'Member registration on behalf of mintojaya1405@gmail.com by GAJAHMADA', '2021-03-03 01:17:35', '2021-03-03 01:17:35');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030527291614749249916', 'Buy 1 PIN by GAJAHMADA', '2021-03-03 05:27:29', '2021-03-03 05:27:29');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030529531614749393920', 'Member registration on behalf of toyadi2017@gmail.com by GAJAHMADA', '2021-03-03 05:29:53', '2021-03-03 05:29:53');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030534171614749657857', 'Buy 1 PIN by GAJAHMADA', '2021-03-03 05:34:17', '2021-03-03 05:34:17');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031052321614768752855', 'Member registration on behalf of sutaantara14@gmail.com by GAJAHMADA', '2021-03-03 10:52:32', '2021-03-03 10:52:32');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031111511614769911732', 'Buy 1 PIN by GAJAHMADA', '2021-03-03 11:11:51', '2021-03-03 11:11:51');
INSERT INTO `transaction` VALUES ('LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031128241614770904025', 'Member registration on behalf of gedeekapuja@gmail.com by GAJAHMADA', '2021-03-03 11:28:24', '2021-03-03 11:28:24');
INSERT INTO `transaction` VALUES ('LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031114291614770069895', 'Buy 2 PINs by smteam$', '2021-03-03 11:14:29', '2021-03-03 11:14:29');
INSERT INTO `transaction` VALUES ('LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031117031614770223762', 'Member registration on behalf of sulham027@gmailcom by smteam$', '2021-03-03 11:17:03', '2021-03-03 11:17:03');
INSERT INTO `transaction` VALUES ('LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031123021614770582117', 'Member registration on behalf of saggafzianzian@gmail.com by smteam$', '2021-03-03 11:23:02', '2021-03-03 11:23:02');
INSERT INTO `transaction` VALUES ('LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031139171614771557705', 'Buy 1 PIN by smteam$', '2021-03-03 11:39:17', '2021-03-03 11:39:17');
INSERT INTO `transaction` VALUES ('LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031141251614771685356', 'Member registration on behalf of sulham027@gmail.com by smteam$', '2021-03-03 11:41:25', '2021-03-03 11:41:25');
INSERT INTO `transaction` VALUES ('LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103030105061614776706007', 'Member registration on behalf of nihazaini4@gmail.com by LBC_SMzaini', '2021-03-03 13:05:06', '2021-03-03 13:05:06');
INSERT INTO `transaction` VALUES ('LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031250211614775821683', 'Buy 2 PINs by LBC_SMzaini', '2021-03-03 12:50:21', '2021-03-03 12:50:21');
INSERT INTO `transaction` VALUES ('LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031253131614775993046', 'Member registration on behalf of putrizaskiya9@gmail.com by LBC_SMzaini', '2021-03-03 12:53:13', '2021-03-03 12:53:13');
INSERT INTO `transaction` VALUES ('LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031103001614769380684', 'Buy 3 PINs by HAMZAH01', '2021-03-03 11:03:00', '2021-03-03 11:03:00');
INSERT INTO `transaction` VALUES ('LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031106181614769578786', 'Member registration on behalf of hamzahlbc2@gmail.com by HAMZAH01', '2021-03-03 11:06:18', '2021-03-03 11:06:18');
INSERT INTO `transaction` VALUES ('LvyUz9byFK-202103030826011614803161363', 'Member activation on behalf of Ultrakaya077', '2021-03-03 20:26:01', '2021-03-03 20:26:01');
INSERT INTO `transaction` VALUES ('LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021155391614686139568', 'Buy 2 PINs by Super02', '2021-03-02 11:55:39', '2021-03-02 11:55:39');
INSERT INTO `transaction` VALUES ('LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021157121614686232309', 'Member registration on behalf of hwsoundlombok@gmail.com by Super02', '2021-03-02 11:57:12', '2021-03-02 11:57:12');
INSERT INTO `transaction` VALUES ('LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021200281614686428904', 'Member registration on behalf of arnimariani70@gmail.com by Super02', '2021-03-02 12:00:28', '2021-03-02 12:00:28');
INSERT INTO `transaction` VALUES ('LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020300241614697224268', 'Buy 1 PIN by mzwfam03', '2021-03-02 15:00:24', '2021-03-02 15:00:24');
INSERT INTO `transaction` VALUES ('LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020304281614697468050', 'Member registration on behalf of smteam062021@gmail.com by mzwfam03', '2021-03-02 15:04:28', '2021-03-02 15:04:28');
INSERT INTO `transaction` VALUES ('LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020317521614698272273', 'Buy 1 PIN by SM_Team06', '2021-03-02 15:17:52', '2021-03-02 15:17:52');
INSERT INTO `transaction` VALUES ('LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020319281614698368001', 'Member registration on behalf of asroriazam@gmail.com by SM_Team06', '2021-03-02 15:19:28', '2021-03-02 15:19:28');
INSERT INTO `transaction` VALUES ('LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031156071614772567928', 'Buy 1 PIN by SM_Team06', '2021-03-03 11:56:07', '2021-03-03 11:56:07');
INSERT INTO `transaction` VALUES ('LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031158101614772690626', 'Member registration on behalf of abdurrahmanassudaes9@gmail.com by SM_Team06', '2021-03-03 11:58:10', '2021-03-03 11:58:10');
INSERT INTO `transaction` VALUES ('LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020355561614700556599', 'Buy 2 PINs by PapaOnline2', '2021-03-02 15:55:56', '2021-03-02 15:55:56');
INSERT INTO `transaction` VALUES ('LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020439321614703172660', 'Member registration on behalf of a.liassebatik@gmail.com by PapaOnline2', '2021-03-02 16:39:32', '2021-03-02 16:39:32');
INSERT INTO `transaction` VALUES ('LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020339581614699598012', 'Buy 2 PINs by Taoke_01', '2021-03-02 15:39:58', '2021-03-02 15:39:58');
INSERT INTO `transaction` VALUES ('LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020341441614699704331', 'Member registration on behalf of dhiaanisara@gmail.com by Taoke_01', '2021-03-02 15:41:44', '2021-03-02 15:41:44');
INSERT INTO `transaction` VALUES ('LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020348181614700098644', 'Member registration on behalf of nathaniaasror@gmail.com by Taoke_01', '2021-03-02 15:48:18', '2021-03-02 15:48:18');
INSERT INTO `transaction` VALUES ('LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031135281614771328153', 'Buy 1 PIN by Taoke_01', '2021-03-03 11:35:28', '2021-03-03 11:35:28');
INSERT INTO `transaction` VALUES ('LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031142111614771731219', 'Member registration on behalf of hafiz.ibam7@gmail.com by Taoke_01', '2021-03-03 11:42:11', '2021-03-03 11:42:11');
INSERT INTO `transaction` VALUES ('LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020634051614666845210', 'Buy 2 PINs by SuperTeam', '2021-03-02 06:34:05', '2021-03-02 06:34:05');
INSERT INTO `transaction` VALUES ('LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020640441614667244693', 'Member registration on behalf of Anwar by SuperTeam', '2021-03-02 06:40:44', '2021-03-02 06:40:44');
INSERT INTO `transaction` VALUES ('LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020705171614668717929', 'Member registration on behalf of Asmini by SuperTeam', '2021-03-02 07:05:17', '2021-03-02 07:05:17');
INSERT INTO `transaction` VALUES ('mbPyWodMov-202103030917461614806266603', 'Member activation on behalf of Garuda01', '2021-03-03 21:17:46', '2021-03-03 21:17:46');
INSERT INTO `transaction` VALUES ('mgZYF7hWVh-202103030406331614787593410', 'Member activation on behalf of PRUDENCE', '2021-03-03 16:06:33', '2021-03-03 16:06:33');
INSERT INTO `transaction` VALUES ('MOviqBzN63-202103030939261614764366005', 'Member activation on behalf of Chikofam_a', '2021-03-03 09:39:26', '2021-03-03 09:39:26');
INSERT INTO `transaction` VALUES ('MsUUhetzG9-202103020755121614671712854', 'Member activation on behalf of Team02', '2021-03-02 07:55:12', '2021-03-02 07:55:12');
INSERT INTO `transaction` VALUES ('MUKKVHawIS-202103030143261614779006820', 'Member activation on behalf of MYUNUS02', '2021-03-03 13:43:26', '2021-03-03 13:43:26');
INSERT INTO `transaction` VALUES ('mZNy0PcgYW-202103031129161614770956424', 'Member activation on behalf of Rinjanilombok', '2021-03-03 11:29:16', '2021-03-03 11:29:16');
INSERT INTO `transaction` VALUES ('nEmx8iP4zm-202103020621391614709299556', 'Member activation on behalf of ABU BAKAR', '2021-03-02 18:21:39', '2021-03-02 18:21:39');
INSERT INTO `transaction` VALUES ('Nj6k5ntXBQ-202103020737001614670620489', 'Member activation on behalf of SM01202101', '2021-03-02 07:37:00', '2021-03-02 07:37:00');
INSERT INTO `transaction` VALUES ('nLCYpLUWU6-202103031209511614730191211', 'Member activation on behalf of Excellent88', '2021-03-03 00:09:51', '2021-03-03 00:09:51');
INSERT INTO `transaction` VALUES ('nPv9svd0MC-202103030745581614800758694', 'Member activation on behalf of Pang501', '2021-03-03 19:45:58', '2021-03-03 19:45:58');
INSERT INTO `transaction` VALUES ('NTozjJJ54o-202103031257161614776236577', 'Member activation on behalf of Lbcsmputriz', '2021-03-03 12:57:16', '2021-03-03 12:57:16');
INSERT INTO `transaction` VALUES ('nym3eIzD4L-202103031243531614775433828', 'Member activation on behalf of ERWIN33', '2021-03-03 12:43:53', '2021-03-03 12:43:53');
INSERT INTO `transaction` VALUES ('o9SrEZQ0cn-202103031049211614768561280', 'Member activation on behalf of Lilik01', '2021-03-03 10:49:21', '2021-03-03 10:49:21');
INSERT INTO `transaction` VALUES ('OOqsgwLSc8-202103031046331614768393996', 'Member activation on behalf of HAMZAH01', '2021-03-03 10:46:33', '2021-03-03 10:46:33');
INSERT INTO `transaction` VALUES ('p7J2oQuOBm-202103021108471614726527872', 'Member activation on behalf of dayock1', '2021-03-02 23:08:47', '2021-03-02 23:08:47');
INSERT INTO `transaction` VALUES ('PEbwxsXKPS-202103021115241614683724114', 'Member activation on behalf of SM01202102', '2021-03-02 11:15:24', '2021-03-02 11:15:24');
INSERT INTO `transaction` VALUES ('PlVTZE0NYR-202103020321411614698501100', 'Member activation on behalf of Taoke_01', '2021-03-02 15:21:41', '2021-03-02 15:21:41');
INSERT INTO `transaction` VALUES ('pnRzbYWicA-202103020738051614670685892', 'Member activation on behalf of GAJAHMADA01', '2021-03-02 07:38:05', '2021-03-02 07:38:05');
INSERT INTO `transaction` VALUES ('PqiSot6Fp7-202103010315131614611713549', 'Member activation on behalf of SemutMerah', '2021-03-01 15:15:13', '2021-03-01 15:15:13');
INSERT INTO `transaction` VALUES ('q7WFdbTerW-202103030825051614759905847', 'Member activation on behalf of SAMSUL881', '2021-03-03 08:25:05', '2021-03-03 08:25:05');
INSERT INTO `transaction` VALUES ('QdRylL8Nfk-202103031109331614769773016', 'Member activation on behalf of HAMZAH02', '2021-03-03 11:09:33', '2021-03-03 11:09:33');
INSERT INTO `transaction` VALUES ('qRTMLAGuGV-202103030846511614804411086', 'Member activation on behalf of digitalentrepreneur', '2021-03-03 20:46:51', '2021-03-03 20:46:51');
INSERT INTO `transaction` VALUES ('QrUwsBp21x-202103031235221614774922175', 'Member activation on behalf of ERWIN11', '2021-03-03 12:35:22', '2021-03-03 12:35:22');
INSERT INTO `transaction` VALUES ('qT4bnGZiYS-202103021242321614688952917', 'Member activation on behalf of JENDRAL2', '2021-03-02 12:42:32', '2021-03-02 12:42:32');
INSERT INTO `transaction` VALUES ('r6rak3u7ji-202103030431431614789103863', 'Member activation on behalf of Yantosukses01', '2021-03-03 16:31:43', '2021-03-03 16:31:43');
INSERT INTO `transaction` VALUES ('rCq6GnFxWo-202103030804321614758672680', 'Member activation on behalf of ARGANTA2', '2021-03-03 08:04:32', '2021-03-03 08:04:32');
INSERT INTO `transaction` VALUES ('rhmZB9dz87-202103030146171614779177462', 'Member activation on behalf of MAJID03', '2021-03-03 13:46:17', '2021-03-03 13:46:17');
INSERT INTO `transaction` VALUES ('rYIa0Q8mvx-202103030336081614785768969', 'Member activation on behalf of Duran', '2021-03-03 15:36:08', '2021-03-03 15:36:08');
INSERT INTO `transaction` VALUES ('RYo0RNNciU-202103020701421614668502759', 'Member activation on behalf of Super01', '2021-03-02 07:01:42', '2021-03-02 07:01:42');
INSERT INTO `transaction` VALUES ('shxxo3mXq4-202103031145101614771910639', 'Member activation on behalf of Hafizib7', '2021-03-03 11:45:10', '2021-03-03 11:45:10');
INSERT INTO `transaction` VALUES ('SoWEnUXkzV-202103030834361614803676410', 'Member activation on behalf of P4ng5', '2021-03-03 20:34:36', '2021-03-03 20:34:36');
INSERT INTO `transaction` VALUES ('SqvDIDKrZo-202103031240061614775206268', 'Member activation on behalf of ERWIN22', '2021-03-03 12:40:06', '2021-03-03 12:40:06');
INSERT INTO `transaction` VALUES ('SSbPDBElu5-202103041202531614816173987', 'Member activation on behalf of Bhdn01', '2021-03-04 00:02:53', '2021-03-04 00:02:53');
INSERT INTO `transaction` VALUES ('tgj1ZvBfJu-202103020741371614670897051', 'Member activation on behalf of master', '2021-03-02 07:41:37', '2021-03-02 07:41:37');
INSERT INTO `transaction` VALUES ('tOYA5LrkjF-202103031238111614775091639', 'Member activation on behalf of LBC_SMzaini', '2021-03-03 12:38:11', '2021-03-03 12:38:11');
INSERT INTO `transaction` VALUES ('tp1nJIRIqs-202103031232571614731577430', 'Member activation on behalf of hibarisatria', '2021-03-03 00:32:57', '2021-03-03 00:32:57');
INSERT INTO `transaction` VALUES ('tVyBadtVgD-202103030909351614805775473', 'Member activation on behalf of Mr.willis', '2021-03-03 21:09:35', '2021-03-03 21:09:35');
INSERT INTO `transaction` VALUES ('Ue0FjLEjzD-202103020750281614671428627', 'Member activation on behalf of Super02', '2021-03-02 07:50:28', '2021-03-02 07:50:28');
INSERT INTO `transaction` VALUES ('uJVKJzFFEH-202103010123501614605030294', 'Member activation on behalf of SuperTeam', '2021-03-01 13:23:50', '2021-03-01 13:23:50');
INSERT INTO `transaction` VALUES ('uvNUeIR5xy-202103021056451614682605767', 'Member activation on behalf of MUHAMMAD', '2021-03-02 10:56:45', '2021-03-02 10:56:45');
INSERT INTO `transaction` VALUES ('uWOJQcFvfq-202103031215051614773705940', 'Member activation on behalf of Leadersaok01', '2021-03-03 12:15:05', '2021-03-03 12:15:05');
INSERT INTO `transaction` VALUES ('UyMMCF34Iz-202103030322111614784931787', 'Member activation on behalf of QueenRich2', '2021-03-03 15:22:11', '2021-03-03 15:22:11');
INSERT INTO `transaction` VALUES ('VaCX3feqZv-202103030855121614804912315', 'Member activation on behalf of ternakdollar02', '2021-03-03 20:55:12', '2021-03-03 20:55:12');
INSERT INTO `transaction` VALUES ('VD1EqpFKoR-202103030208061614737286131', 'Member activation on behalf of DatuPejanggik', '2021-03-03 02:08:06', '2021-03-03 02:08:06');
INSERT INTO `transaction` VALUES ('vD4APwAIgS-202103030239481614782388679', 'Member activation on behalf of DatuBayan', '2021-03-03 14:39:48', '2021-03-03 14:39:48');
INSERT INTO `transaction` VALUES ('vd9ntkCzmC-202103020748031614671283849', 'Member activation on behalf of GAJAHMADA02', '2021-03-02 07:48:03', '2021-03-02 07:48:03');
INSERT INTO `transaction` VALUES ('VoSfKgWWmY-202103030125321614734732503', 'Member activation on behalf of Antmaster01', '2021-03-03 01:25:32', '2021-03-03 01:25:32');
INSERT INTO `transaction` VALUES ('w5H9CkPtTW-202103030805071614801907618', 'Member activation on behalf of Ultrakaya77', '2021-03-03 20:05:07', '2021-03-03 20:05:07');
INSERT INTO `transaction` VALUES ('Wd5bMHycTs-202103030115371614777337202', 'Member activation on behalf of lbcsmniha', '2021-03-03 13:15:37', '2021-03-03 13:15:37');
INSERT INTO `transaction` VALUES ('wJZV33wyYs-202103011024561614637496830', 'Member activation on behalf of GUNTURTKER', '2021-03-01 22:24:56', '2021-03-01 22:24:56');
INSERT INTO `transaction` VALUES ('wxSOkTAdbA-202103031006001614765960402', 'Member activation on behalf of smteam#', '2021-03-03 10:06:00', '2021-03-03 10:06:00');
INSERT INTO `transaction` VALUES ('WxVgF4P56C-202103030245431614782743544', 'Member activation on behalf of RADEN PANJI TILAR', '2021-03-03 14:45:43', '2021-03-03 14:45:43');
INSERT INTO `transaction` VALUES ('X2nZh1obJ6-202103030753581614758038672', 'Member activation on behalf of BEGER1', '2021-03-03 07:53:58', '2021-03-03 07:53:58');
INSERT INTO `transaction` VALUES ('x628uXLZLB-202103030437591614789479554', 'Member activation on behalf of Chicka', '2021-03-03 16:37:59', '2021-03-03 16:37:59');
INSERT INTO `transaction` VALUES ('xa6DrWpghO-202103030420291614788429335', 'Member activation on behalf of Renyasukses ', '2021-03-03 16:20:29', '2021-03-03 16:20:29');
INSERT INTO `transaction` VALUES ('xhCJ0uaiNX-202103031259541614776394579', 'Member activation on behalf of MAJID01', '2021-03-03 12:59:54', '2021-03-03 12:59:54');
INSERT INTO `transaction` VALUES ('XOcG8PB4tV-202103031222411614774161405', 'Member activation on behalf of datudahe', '2021-03-03 12:22:41', '2021-03-03 12:22:41');
INSERT INTO `transaction` VALUES ('xs2I7l7vJX-202103030101151614733275567', 'Member activation on behalf of FIRMANJUNDI', '2021-03-03 01:01:15', '2021-03-03 01:01:15');
INSERT INTO `transaction` VALUES ('XvaGqNJuCa-202103020205271614693927797', 'Member activation on behalf of mzwfam03', '2021-03-02 14:05:27', '2021-03-02 14:05:27');
INSERT INTO `transaction` VALUES ('Y1Q8fF6Pii-202103021136561614685016614', 'Member activation on behalf of JENDRAL', '2021-03-02 11:36:56', '2021-03-02 11:36:56');
INSERT INTO `transaction` VALUES ('ygQHsvHWDs-202103010230041614609004980', 'Member activation on behalf of PapaOnline', '2021-03-01 14:30:04', '2021-03-01 14:30:04');
INSERT INTO `transaction` VALUES ('yU6g8ErvqH-202103021146081614685568303', 'Member activation on behalf of Agung01', '2021-03-02 11:46:08', '2021-03-02 11:46:08');
INSERT INTO `transaction` VALUES ('zhsovKACRh-202103030453161614790396009', 'Member activation on behalf of alias', '2021-03-03 16:53:16', '2021-03-03 16:53:16');
INSERT INTO `transaction` VALUES ('ZmIgfZ5vHT-202103031157381614772658590', 'Member activation on behalf of Aripianhazami', '2021-03-03 11:57:38', '2021-03-03 11:57:38');

-- ----------------------------
-- Table structure for transaction_exchange
-- ----------------------------
DROP TABLE IF EXISTS `transaction_exchange`;
CREATE TABLE `transaction_exchange`  (
  `transaction_exchange_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_exchange_amount` decimal(65, 30) NOT NULL,
  `rate_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_exchange_id`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE,
  INDEX `kurs_id`(`rate_id`) USING BTREE,
  INDEX `transaction_id`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_exchange_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transaction_exchange_ibfk_2` FOREIGN KEY (`rate_id`) REFERENCES `rate` (`rate_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transaction_exchange_ibfk_3` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_extension
-- ----------------------------
DROP TABLE IF EXISTS `transaction_extension`;
CREATE TABLE `transaction_extension`  (
  `member_id` bigint(20) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  INDEX `reinvest_pengguna_id_fkey`(`member_id`) USING BTREE,
  INDEX `reinvest_ibfk_1`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_extension_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transaction_extension_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_income
-- ----------------------------
DROP TABLE IF EXISTS `transaction_income`;
CREATE TABLE `transaction_income`  (
  `transaction_income_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_income_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_income_amount` decimal(65, 2) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  INDEX `pendapatan_ibfk_1`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_income_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction_income
-- ----------------------------
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by GAJAHMADA', 'Pin', 6.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103010359301614614370946', '2021-03-01 15:59:30', '2021-03-01 15:59:30');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by andifajarlah@gmail.com', 'Pin', 6.00, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103010942201614634940463', '2021-03-01 21:42:20', '2021-03-01 21:42:20');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by SuperTeam', 'Pin', 6.00, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020634051614666845210', '2021-03-02 06:34:05', '2021-03-02 06:34:05');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by SemutMerah', 'Pin', 6.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020639151614667155052', '2021-03-02 06:39:15', '2021-03-02 06:39:15');
INSERT INTO `transaction_income` VALUES ('Buy 50 PINs by PapaOnline', 'Pin', 150.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020710361614669036878', '2021-03-02 07:10:36', '2021-03-02 07:10:36');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN1 by andifajarlah@gmail.com', 'Pin', 3.00, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103020728551614670135184', '2021-03-02 07:28:55', '2021-03-02 07:28:55');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN1 by Team01', 'Pin', 3.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020741481614670908152', '2021-03-02 07:41:48', '2021-03-02 07:41:48');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Super01', 'Pin', 3.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020747231614671243399', '2021-03-02 07:47:23', '2021-03-02 07:47:23');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Team02', 'Pin', 3.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103020818201614673100792', '2021-03-02 08:18:20', '2021-03-02 08:18:20');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by GUNTURTKER', 'Pin', 6.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103020825351614673535525', '2021-03-02 08:25:35', '2021-03-02 08:25:35');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Super01', 'Pin', 3.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021049251614682165833', '2021-03-02 10:49:25', '2021-03-02 10:49:25');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Team01', 'Pin', 3.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021134191614684859703', '2021-03-02 11:34:19', '2021-03-02 11:34:19');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Team02', 'Pin', 3.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021140551614685255520', '2021-03-02 11:40:55', '2021-03-02 11:40:55');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Super02', 'Pin', 6.00, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021155391614686139568', '2021-03-02 11:55:39', '2021-03-02 11:55:39');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by JENDRAL', 'Pin', 6.00, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021231341614688294146', '2021-03-02 12:31:34', '2021-03-02 12:31:34');
INSERT INTO `transaction_income` VALUES ('Buy 5 PINs by SemutMerah', 'Pin', 15.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020136351614692195119', '2021-03-02 13:36:35', '2021-03-02 13:36:35');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by SM01202102', 'Pin', 3.00, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020155051614693305549', '2021-03-02 13:55:05', '2021-03-02 13:55:05');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by mzwfam03', 'Pin', 3.00, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020300241614697224268', '2021-03-02 15:00:24', '2021-03-02 15:00:24');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by SM_Team06', 'Pin', 3.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020317521614698272273', '2021-03-02 15:17:52', '2021-03-02 15:17:52');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Taoke_01', 'Pin', 6.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020339581614699598012', '2021-03-02 15:39:58', '2021-03-02 15:39:58');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by PapaOnline2', 'Pin', 6.00, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020355561614700556599', '2021-03-02 15:55:56', '2021-03-02 15:55:56');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by MUHAMMAD', 'Pin', 6.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020610131614708613998', '2021-03-02 18:10:14', '2021-03-02 18:10:14');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by SM01202102', 'Pin', 3.00, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020753101614714790174', '2021-03-02 19:53:10', '2021-03-02 19:53:10');
INSERT INTO `transaction_income` VALUES ('Buy 6 PINs by sugihmotah01', 'Pin', 18.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021103431614726223871', '2021-03-02 23:03:43', '2021-03-02 23:03:43');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by GUNTURTKER', 'Pin', 6.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021116081614726968602', '2021-03-02 23:16:08', '2021-03-02 23:16:08');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Excellent', 'Pin', 6.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021154311614729271611', '2021-03-02 23:54:31', '2021-03-02 23:54:31');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Excellent', 'Pin', 6.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031220041614730804801', '2021-03-03 00:20:04', '2021-03-03 00:20:04');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by GAJAHMADA', 'Pin', 3.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030110461614733846803', '2021-03-03 01:10:46', '2021-03-03 01:10:46');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Excellent', 'Pin', 6.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030201011614736861715', '2021-03-03 02:01:01', '2021-03-03 02:01:01');
INSERT INTO `transaction_income` VALUES ('Buy 4 PINs by Excellent', 'Pin', 12.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030251231614739883728', '2021-03-03 02:51:23', '2021-03-03 02:51:23');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by GUNTURTKER', 'Pin', 6.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030334201614742460962', '2021-03-03 03:34:20', '2021-03-03 03:34:20');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by GAJAHMADA', 'Pin', 3.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030527291614749249916', '2021-03-03 05:27:29', '2021-03-03 05:27:29');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by GAJAHMADA', 'Pin', 3.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030534171614749657857', '2021-03-03 05:34:17', '2021-03-03 05:34:17');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by GUNTURTKER', 'Pin', 3.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030731401614756700674', '2021-03-03 07:31:40', '2021-03-03 07:31:40');
INSERT INTO `transaction_income` VALUES ('Buy 5 PINs by GUNTURTKER', 'Pin', 15.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030757471614758267410', '2021-03-03 07:57:47', '2021-03-03 07:57:47');
INSERT INTO `transaction_income` VALUES ('Buy 5 PINs by GUNTURTKER', 'Pin', 15.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030923171614763397679', '2021-03-03 09:23:17', '2021-03-03 09:23:17');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by SM_Team08', 'Pin', 6.00, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030931591614763919051', '2021-03-03 09:31:59', '2021-03-03 09:31:59');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Chikofam_a', 'Pin', 6.00, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030957261614765446225', '2021-03-03 09:57:26', '2021-03-03 09:57:26');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by MUHAMMAD', 'Pin', 3.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031028561614767336824', '2021-03-03 10:28:56', '2021-03-03 10:28:56');
INSERT INTO `transaction_income` VALUES ('Buy 3 PINs by MUHAMMAD', 'Pin', 9.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031040461614768046633', '2021-03-03 10:40:46', '2021-03-03 10:40:46');
INSERT INTO `transaction_income` VALUES ('Buy 3 PINs by HAMZAH01', 'Pin', 9.00, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031103001614769380684', '2021-03-03 11:03:00', '2021-03-03 11:03:00');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by GAJAHMADA', 'Pin', 3.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031111511614769911732', '2021-03-03 11:11:51', '2021-03-03 11:11:51');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by smteam$', 'Pin', 6.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031114291614770069895', '2021-03-03 11:14:29', '2021-03-03 11:14:29');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Taoke_01', 'Pin', 3.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031135281614771328153', '2021-03-03 11:35:28', '2021-03-03 11:35:28');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by smteam$', 'Pin', 3.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031139171614771557705', '2021-03-03 11:39:17', '2021-03-03 11:39:17');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Rinjanilombok', 'Pin', 6.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031140191614771619644', '2021-03-03 11:40:19', '2021-03-03 11:40:19');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by SM_Team06', 'Pin', 3.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031156071614772567928', '2021-03-03 11:56:07', '2021-03-03 11:56:07');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Leadersaok', 'Pin', 6.00, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031207071614773227758', '2021-03-03 12:07:07', '2021-03-03 12:07:07');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Taoke_03', 'Pin', 3.00, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031219011614773941214', '2021-03-03 12:19:01', '2021-03-03 12:19:01');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by datudahe', 'Pin', 3.00, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031229401614774580157', '2021-03-03 12:29:40', '2021-03-03 12:29:40');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by smteam#', 'Pin', 6.00, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031230251614774625351', '2021-03-03 12:30:25', '2021-03-03 12:30:25');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by LBC_SMzaini', 'Pin', 6.00, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031250211614775821683', '2021-03-03 12:50:21', '2021-03-03 12:50:21');
INSERT INTO `transaction_income` VALUES ('Buy 5 PINs by GUNTURTKER', 'Pin', 15.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030104081614776648542', '2021-03-03 13:04:08', '2021-03-03 13:04:08');
INSERT INTO `transaction_income` VALUES ('Buy 5 PINs by GUNTURTKER', 'Pin', 15.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030135211614778521844', '2021-03-03 13:35:21', '2021-03-03 13:35:21');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Excellent', 'Pin', 3.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030156331614779793010', '2021-03-03 13:56:33', '2021-03-03 13:56:33');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Rinjanilombok', 'Pin', 3.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030158531614779933910', '2021-03-03 13:58:53', '2021-03-03 13:58:53');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by Ihsan1997', 'Pin', 6.00, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030219261614781166239', '2021-03-03 14:19:26', '2021-03-03 14:19:26');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Excellent', 'Pin', 3.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030226251614781585938', '2021-03-03 14:26:25', '2021-03-03 14:26:25');
INSERT INTO `transaction_income` VALUES ('Buy 1 PIN by Excellent', 'Pin', 3.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030313331614784413864', '2021-03-03 15:13:33', '2021-03-03 15:13:33');
INSERT INTO `transaction_income` VALUES ('Buy 11 PINs by Excellent', 'Pin', 33.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030328381614785318146', '2021-03-03 15:28:38', '2021-03-03 15:28:38');
INSERT INTO `transaction_income` VALUES ('Buy 50 PINs by PapaOnline', 'Pin', 150.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030423001614788580043', '2021-03-03 16:23:00', '2021-03-03 16:23:00');
INSERT INTO `transaction_income` VALUES ('Buy 2 PINs by sugihmotah01', 'Pin', 6.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031150271614815427575', '2021-03-03 23:50:27', '2021-03-03 23:50:27');

-- ----------------------------
-- Table structure for transaction_payment
-- ----------------------------
DROP TABLE IF EXISTS `transaction_payment`;
CREATE TABLE `transaction_payment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `from_currency` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `entered_amount` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `to_currency` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `amount` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gateway_id` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gateway_url` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_pin
-- ----------------------------
DROP TABLE IF EXISTS `transaction_pin`;
CREATE TABLE `transaction_pin`  (
  `transaction_pin_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_pin_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_pin_amount` int(11) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_pin_id`) USING BTREE,
  INDEX `pin_pengguna_id_fkey`(`member_id`) USING BTREE,
  INDEX `pin_ibfk_1`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_pin_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_pin_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction_pin
-- ----------------------------
INSERT INTO `transaction_pin` VALUES (1, 'Buy 1 PIN1', 1, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020741481614670908152', 13, '2021-03-02 07:41:48', '2021-03-02 07:41:48', NULL);
INSERT INTO `transaction_pin` VALUES (2, 'Member registration on behalf of Fitriana junisa', -1, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020754161614671656124', 13, '2021-03-02 07:54:16', '2021-03-02 07:54:16', NULL);
INSERT INTO `transaction_pin` VALUES (3, 'Buy 1 PIN', 1, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021134191614684859703', 13, '2021-03-02 11:34:19', '2021-03-02 11:34:19', NULL);
INSERT INTO `transaction_pin` VALUES (4, 'Member registration on behalf of yusrilhamdani.yh@gmail.com', -1, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021135071614684907123', 13, '2021-03-02 11:35:07', '2021-03-02 11:35:07', NULL);
INSERT INTO `transaction_pin` VALUES (5, 'Buy 1 PIN', 1, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020747231614671243399', 12, '2021-03-02 07:47:23', '2021-03-02 07:47:23', NULL);
INSERT INTO `transaction_pin` VALUES (6, 'Member registration on behalf of Rayyan', -1, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020748591614671339365', 12, '2021-03-02 07:48:59', '2021-03-02 07:48:59', NULL);
INSERT INTO `transaction_pin` VALUES (7, 'Buy 1 PIN', 1, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021049251614682165833', 12, '2021-03-02 10:49:25', '2021-03-02 10:49:25', NULL);
INSERT INTO `transaction_pin` VALUES (8, 'Member registration on behalf of muhammadmw1983@gmail.com', -1, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021052131614682333923', 12, '2021-03-02 10:52:13', '2021-03-02 10:52:13', NULL);
INSERT INTO `transaction_pin` VALUES (9, 'Buy 2 PINs', 2, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021231341614688294146', 27, '2021-03-02 12:31:34', '2021-03-02 12:31:34', NULL);
INSERT INTO `transaction_pin` VALUES (10, 'Member registration on behalf of yusrilhy212@gmail.com', -1, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021240441614688844400', 27, '2021-03-02 12:40:44', '2021-03-02 12:40:44', NULL);
INSERT INTO `transaction_pin` VALUES (11, 'Member registration on behalf of dimashiporia@gmail.com', -1, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021252251614689545147', 27, '2021-03-02 12:52:25', '2021-03-02 12:52:25', NULL);
INSERT INTO `transaction_pin` VALUES (12, 'Buy 1 PIN', 1, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103020818201614673100792', 22, '2021-03-02 08:18:20', '2021-03-02 08:18:20', NULL);
INSERT INTO `transaction_pin` VALUES (13, 'Member registration on behalf of hhtcenter1@gmail.com', -1, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021021221614680482844', 22, '2021-03-02 10:21:22', '2021-03-02 10:21:22', NULL);
INSERT INTO `transaction_pin` VALUES (14, 'Buy 1 PIN', 1, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021140551614685255520', 22, '2021-03-02 11:40:55', '2021-03-02 11:40:55', NULL);
INSERT INTO `transaction_pin` VALUES (15, 'Member registration on behalf of hamidagung433@gmail.com', -1, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021142211614685341982', 22, '2021-03-02 11:42:21', '2021-03-02 11:42:21', NULL);
INSERT INTO `transaction_pin` VALUES (16, 'Buy 2 PINs', 2, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021154311614729271611', 4, '2021-03-02 23:54:31', '2021-03-02 23:54:31', NULL);
INSERT INTO `transaction_pin` VALUES (17, 'Member registration on behalf of bbemailku80@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021158341614729514564', 4, '2021-03-02 23:58:34', '2021-03-02 23:58:34', NULL);
INSERT INTO `transaction_pin` VALUES (18, 'Member registration on behalf of bongor1976@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030146561614736016953', 4, '2021-03-03 01:46:56', '2021-03-03 01:46:56', NULL);
INSERT INTO `transaction_pin` VALUES (19, 'Buy 2 PINs', 2, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030201011614736861715', 4, '2021-03-03 02:01:01', '2021-03-03 02:01:01', NULL);
INSERT INTO `transaction_pin` VALUES (20, 'Member registration on behalf of lerylesmana9@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030205381614737138166', 4, '2021-03-03 02:05:38', '2021-03-03 02:05:38', NULL);
INSERT INTO `transaction_pin` VALUES (21, 'Member registration on behalf of soldierwinter782@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030211351614737495733', 4, '2021-03-03 02:11:35', '2021-03-03 02:11:35', NULL);
INSERT INTO `transaction_pin` VALUES (22, 'Buy 4 PINs', 4, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030251231614739883728', 4, '2021-03-03 02:51:23', '2021-03-03 02:51:23', NULL);
INSERT INTO `transaction_pin` VALUES (23, 'Member registration on behalf of lilikindrawati182@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030255251614740125824', 4, '2021-03-03 02:55:25', '2021-03-03 02:55:25', NULL);
INSERT INTO `transaction_pin` VALUES (24, 'Member registration on behalf of bbemailku81@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031206171614729977779', 4, '2021-03-03 00:06:17', '2021-03-03 00:06:17', NULL);
INSERT INTO `transaction_pin` VALUES (25, 'Buy 2 PINs', 2, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031220041614730804801', 4, '2021-03-03 00:20:04', '2021-03-03 00:20:04', NULL);
INSERT INTO `transaction_pin` VALUES (26, 'Member registration on behalf of hibarisatria@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031224221614731062429', 4, '2021-03-03 00:24:22', '2021-03-03 00:24:22', NULL);
INSERT INTO `transaction_pin` VALUES (27, 'Buy 6 PINs', 6, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021103431614726223871', 43, '2021-03-02 23:03:43', '2021-03-02 23:03:43', NULL);
INSERT INTO `transaction_pin` VALUES (28, 'Member registration on behalf of dayock1982@gmail.com', -3, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021107081614726428584', 43, '2021-03-02 23:07:08', '2021-03-02 23:07:08', NULL);
INSERT INTO `transaction_pin` VALUES (29, 'Member registration on behalf of lukmanulhakim974@gmail.com', -3, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021114321614726872706', 43, '2021-03-02 23:14:32', '2021-03-02 23:14:32', NULL);
INSERT INTO `transaction_pin` VALUES (30, 'Buy 2 PINs', 2, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103010942201614634940463', 1, '2021-03-01 21:42:20', '2021-03-01 21:42:20', NULL);
INSERT INTO `transaction_pin` VALUES (31, 'Buy 1 PIN1', 1, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103020728551614670135184', 1, '2021-03-02 07:28:55', '2021-03-02 07:28:55', NULL);
INSERT INTO `transaction_pin` VALUES (32, 'Buy 2 PINs', 2, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103020825351614673535525', 8, '2021-03-02 08:25:35', '2021-03-02 08:25:35', NULL);
INSERT INTO `transaction_pin` VALUES (33, 'Member registration on behalf of salehlalu596@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021053331614725613201', 8, '2021-03-02 22:53:33', '2021-03-02 22:53:33', NULL);
INSERT INTO `transaction_pin` VALUES (34, 'Member registration on behalf of lalumuhammadsaleh181@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021057381614725858665', 8, '2021-03-02 22:57:38', '2021-03-02 22:57:38', NULL);
INSERT INTO `transaction_pin` VALUES (35, 'Buy 2 PINs', 2, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021116081614726968602', 8, '2021-03-02 23:16:08', '2021-03-02 23:16:08', NULL);
INSERT INTO `transaction_pin` VALUES (36, 'Member registration on behalf of salehraden098@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021129541614727794388', 8, '2021-03-02 23:29:54', '2021-03-02 23:29:54', NULL);
INSERT INTO `transaction_pin` VALUES (37, 'Member registration on behalf of tkerguntur098@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021138501614728330612', 8, '2021-03-02 23:38:50', '2021-03-02 23:38:50', NULL);
INSERT INTO `transaction_pin` VALUES (38, 'Buy 2 PINs', 2, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030334201614742460962', 8, '2021-03-03 03:34:20', '2021-03-03 03:34:20', NULL);
INSERT INTO `transaction_pin` VALUES (39, 'Buy 50 PINs', 50, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020710361614669036878', 5, '2021-03-02 07:10:36', '2021-03-02 07:10:36', NULL);
INSERT INTO `transaction_pin` VALUES (40, 'Member registration on behalf of alias', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020712431614669163964', 5, '2021-03-02 07:12:43', '2021-03-02 07:12:43', NULL);
INSERT INTO `transaction_pin` VALUES (41, 'Member registration on behalf of alias', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020716561614669416045', 5, '2021-03-02 07:16:56', '2021-03-02 07:16:56', NULL);
INSERT INTO `transaction_pin` VALUES (42, 'Member registration on behalf of Hendro Sutrisno', -5, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020723271614669807943', 5, '2021-03-02 07:23:27', '2021-03-02 07:23:27', NULL);
INSERT INTO `transaction_pin` VALUES (43, 'Member registration on behalf of Hendro Sutrisno', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020738471614670727570', 5, '2021-03-02 07:38:47', '2021-03-02 07:38:47', NULL);
INSERT INTO `transaction_pin` VALUES (44, 'Buy 2 PINs', 2, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020610131614708613998', 25, '2021-03-02 18:10:13', '2021-03-02 18:10:13', NULL);
INSERT INTO `transaction_pin` VALUES (45, 'Member registration on behalf of djamallulailhamzah@gmail.com', -1, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020619101614709150835', 25, '2021-03-02 18:19:10', '2021-03-02 18:19:10', NULL);
INSERT INTO `transaction_pin` VALUES (46, 'Member registration on behalf of asmanjaya016@gmail.com', -1, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020628341614709714821', 25, '2021-03-02 18:28:34', '2021-03-02 18:28:34', NULL);
INSERT INTO `transaction_pin` VALUES (47, 'Buy 1 PIN', 1, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020155051614693305549', 26, '2021-03-02 13:55:05', '2021-03-02 13:55:05', NULL);
INSERT INTO `transaction_pin` VALUES (48, 'Member registration on behalf of mzw032021@gmail.com', -1, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020159571614693597222', 26, '2021-03-02 13:59:57', '2021-03-02 13:59:57', NULL);
INSERT INTO `transaction_pin` VALUES (49, 'Buy 1 PIN', 1, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020753101614714790174', 26, '2021-03-02 19:53:10', '2021-03-02 19:53:10', NULL);
INSERT INTO `transaction_pin` VALUES (50, 'Member registration on behalf of mzw042021@gmail.com', -1, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020756241614714984144', 26, '2021-03-02 19:56:24', '2021-03-02 19:56:24', NULL);
INSERT INTO `transaction_pin` VALUES (51, 'Buy 5 PINs', 5, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020136351614692195119', 7, '2021-03-02 13:36:35', '2021-03-02 13:36:35', NULL);
INSERT INTO `transaction_pin` VALUES (52, 'Member registration on behalf of smteam052021@gmail.com', -1, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020218181614694698421', 7, '2021-03-02 14:18:18', '2021-03-02 14:18:18', NULL);
INSERT INTO `transaction_pin` VALUES (53, 'Buy 2 PINs', 2, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020639151614667155052', 7, '2021-03-02 06:39:15', '2021-03-02 06:39:15', NULL);
INSERT INTO `transaction_pin` VALUES (54, 'Member registration on behalf of Zainul wasti', -1, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020735431614670543094', 7, '2021-03-02 07:35:43', '2021-03-02 07:35:43', NULL);
INSERT INTO `transaction_pin` VALUES (55, 'Member registration on behalf of sm01202102@gmail.com', -1, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103021112321614683552533', 7, '2021-03-02 11:12:32', '2021-03-02 11:12:32', NULL);
INSERT INTO `transaction_pin` VALUES (56, 'Buy 2 PINs', 2, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103010359301614614370946', 6, '2021-03-01 15:59:30', '2021-03-01 15:59:30', NULL);
INSERT INTO `transaction_pin` VALUES (57, 'Member registration on behalf of I Wayan Gina', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020735091614670509541', 6, '2021-03-02 07:35:09', '2021-03-02 07:35:09', NULL);
INSERT INTO `transaction_pin` VALUES (58, 'Member registration on behalf of I Wayan Gina', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020744051614671045065', 6, '2021-03-02 07:44:05', '2021-03-02 07:44:05', NULL);
INSERT INTO `transaction_pin` VALUES (59, 'Buy 1 PIN', 1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030110461614733846803', 6, '2021-03-03 01:10:46', '2021-03-03 01:10:46', NULL);
INSERT INTO `transaction_pin` VALUES (60, 'Member registration on behalf of mintojaya1405@gmail.com', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030117351614734255387', 6, '2021-03-03 01:17:35', '2021-03-03 01:17:35', NULL);
INSERT INTO `transaction_pin` VALUES (61, 'Buy 2 PINs', 2, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021155391614686139568', 21, '2021-03-02 11:55:39', '2021-03-02 11:55:39', NULL);
INSERT INTO `transaction_pin` VALUES (62, 'Member registration on behalf of hwsoundlombok@gmail.com', -1, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021157121614686232309', 21, '2021-03-02 11:57:12', '2021-03-02 11:57:12', NULL);
INSERT INTO `transaction_pin` VALUES (63, 'Member registration on behalf of arnimariani70@gmail.com', -1, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021200281614686428904', 21, '2021-03-02 12:00:28', '2021-03-02 12:00:28', NULL);
INSERT INTO `transaction_pin` VALUES (64, 'Buy 1 PIN', 1, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020300241614697224268', 33, '2021-03-02 15:00:24', '2021-03-02 15:00:24', NULL);
INSERT INTO `transaction_pin` VALUES (65, 'Member registration on behalf of smteam062021@gmail.com', -1, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020304281614697468050', 33, '2021-03-02 15:04:28', '2021-03-02 15:04:28', NULL);
INSERT INTO `transaction_pin` VALUES (66, 'Buy 1 PIN', 1, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020317521614698272273', 35, '2021-03-02 15:17:52', '2021-03-02 15:17:52', NULL);
INSERT INTO `transaction_pin` VALUES (67, 'Member registration on behalf of asroriazam@gmail.com', -1, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020319281614698368001', 35, '2021-03-02 15:19:28', '2021-03-02 15:19:28', NULL);
INSERT INTO `transaction_pin` VALUES (68, 'Buy 2 PINs', 2, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020355561614700556599', 14, '2021-03-02 15:55:56', '2021-03-02 15:55:56', NULL);
INSERT INTO `transaction_pin` VALUES (69, 'Member registration on behalf of a.liassebatik@gmail.com', -1, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020439321614703172660', 14, '2021-03-02 16:39:32', '2021-03-02 16:39:32', NULL);
INSERT INTO `transaction_pin` VALUES (70, 'Buy 2 PINs', 2, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020339581614699598012', 36, '2021-03-02 15:39:58', '2021-03-02 15:39:58', NULL);
INSERT INTO `transaction_pin` VALUES (71, 'Member registration on behalf of dhiaanisara@gmail.com', -1, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020341441614699704331', 36, '2021-03-02 15:41:44', '2021-03-02 15:41:44', NULL);
INSERT INTO `transaction_pin` VALUES (72, 'Member registration on behalf of nathaniaasror@gmail.com', -1, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020348181614700098644', 36, '2021-03-02 15:48:18', '2021-03-02 15:48:18', NULL);
INSERT INTO `transaction_pin` VALUES (73, 'Buy 2 PINs', 2, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020634051614666845210', 3, '2021-03-02 06:34:05', '2021-03-02 06:34:05', NULL);
INSERT INTO `transaction_pin` VALUES (74, 'Member registration on behalf of Anwar', -1, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020640441614667244693', 3, '2021-03-02 06:40:44', '2021-03-02 06:40:44', NULL);
INSERT INTO `transaction_pin` VALUES (75, 'Member registration on behalf of Asmini', -1, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020705171614668717929', 3, '2021-03-02 07:05:17', '2021-03-02 07:05:17', NULL);
INSERT INTO `transaction_pin` VALUES (76, 'Member registration on behalf of alwanulhamdi76@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030456431614747403089', 8, '2021-03-03 04:56:43', '2021-03-03 04:56:43', NULL);
INSERT INTO `transaction_pin` VALUES (77, 'Member registration on behalf of dinn44554@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030509151614748155000', 8, '2021-03-03 05:09:15', '2021-03-03 05:09:15', NULL);
INSERT INTO `transaction_pin` VALUES (78, 'Buy 1 PIN', 1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030527291614749249916', 6, '2021-03-03 05:27:29', '2021-03-03 05:27:29', NULL);
INSERT INTO `transaction_pin` VALUES (79, 'Member registration on behalf of toyadi2017@gmail.com', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030529531614749393920', 6, '2021-03-03 05:29:53', '2021-03-03 05:29:53', NULL);
INSERT INTO `transaction_pin` VALUES (80, 'Buy 1 PIN', 1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030534171614749657857', 6, '2021-03-03 05:34:17', '2021-03-03 05:34:17', NULL);
INSERT INTO `transaction_pin` VALUES (81, 'Buy 1 PIN', 1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030731401614756700674', 8, '2021-03-03 07:31:40', '2021-03-03 07:31:40', NULL);
INSERT INTO `transaction_pin` VALUES (82, 'Member registration on behalf of lamtanuss@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030734151614756855950', 8, '2021-03-03 07:34:15', '2021-03-03 07:34:15', NULL);
INSERT INTO `transaction_pin` VALUES (83, 'Buy 5 PINs', 5, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030757471614758267410', 8, '2021-03-03 07:57:47', '2021-03-03 07:57:47', NULL);
INSERT INTO `transaction_pin` VALUES (84, 'Member registration on behalf of lamtanusimam@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030803191614758599404', 8, '2021-03-03 08:03:19', '2021-03-03 08:03:19', NULL);
INSERT INTO `transaction_pin` VALUES (85, 'Member registration on behalf of albytsaqib20@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030806591614758819884', 8, '2021-03-03 08:06:59', '2021-03-03 08:06:59', NULL);
INSERT INTO `transaction_pin` VALUES (86, 'Member registration on behalf of hamdilalu76@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030812041614759124189', 8, '2021-03-03 08:12:04', '2021-03-03 08:12:04', NULL);
INSERT INTO `transaction_pin` VALUES (87, 'Member registration on behalf of samsulrina31@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030817081614759428583', 8, '2021-03-03 08:17:08', '2021-03-03 08:17:08', NULL);
INSERT INTO `transaction_pin` VALUES (88, 'Member registration on behalf of hannabaiq76@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030826341614759994755', 8, '2021-03-03 08:26:34', '2021-03-03 08:26:34', NULL);
INSERT INTO `transaction_pin` VALUES (89, 'Buy 5 PINs', 5, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030923171614763397679', 8, '2021-03-03 09:23:17', '2021-03-03 09:23:17', NULL);
INSERT INTO `transaction_pin` VALUES (90, 'Buy 2 PINs', 2, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030931591614763919051', 34, '2021-03-03 09:31:59', '2021-03-03 09:31:59', NULL);
INSERT INTO `transaction_pin` VALUES (91, 'Member registration on behalf of mzw012021@gmail.com', -1, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030934421614764082453', 34, '2021-03-03 09:34:42', '2021-03-03 09:34:42', NULL);
INSERT INTO `transaction_pin` VALUES (92, 'Member registration on behalf of mzw022021@gmail.com', -1, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030942561614764576764', 34, '2021-03-03 09:42:56', '2021-03-03 09:42:56', NULL);
INSERT INTO `transaction_pin` VALUES (93, 'Buy 2 PINs', 2, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030957261614765446225', 67, '2021-03-03 09:57:26', '2021-03-03 09:57:26', NULL);
INSERT INTO `transaction_pin` VALUES (94, 'Member registration on behalf of smteam012021@gmail.com', -1, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030959111614765551485', 67, '2021-03-03 09:59:11', '2021-03-03 09:59:11', NULL);
INSERT INTO `transaction_pin` VALUES (95, 'Member registration on behalf of smteam022021@gmail.com', -1, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103031000431614765643266', 67, '2021-03-03 10:00:43', '2021-03-03 10:00:43', NULL);
INSERT INTO `transaction_pin` VALUES (96, 'Buy 1 PIN', 1, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031028561614767336824', 25, '2021-03-03 10:28:56', '2021-03-03 10:28:56', NULL);
INSERT INTO `transaction_pin` VALUES (97, 'Member registration on behalf of wahyurich2019@gmail.com', -1, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031030431614767443270', 25, '2021-03-03 10:30:43', '2021-03-03 10:30:43', NULL);
INSERT INTO `transaction_pin` VALUES (98, 'Buy 3 PINs', 3, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031040461614768046633', 25, '2021-03-03 10:40:46', '2021-03-03 10:40:46', NULL);
INSERT INTO `transaction_pin` VALUES (99, 'Member registration on behalf of hamzahlbc1@gmail.com', -3, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031043251614768205885', 25, '2021-03-03 10:43:25', '2021-03-03 10:43:25', NULL);
INSERT INTO `transaction_pin` VALUES (100, 'Member registration on behalf of sutaantara14@gmail.com', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031052321614768752855', 6, '2021-03-03 10:52:32', '2021-03-03 10:52:32', NULL);
INSERT INTO `transaction_pin` VALUES (101, 'Buy 3 PINs', 3, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031103001614769380684', 72, '2021-03-03 11:03:00', '2021-03-03 11:03:00', NULL);
INSERT INTO `transaction_pin` VALUES (102, 'Member registration on behalf of hamzahlbc2@gmail.com', -3, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031106181614769578786', 72, '2021-03-03 11:06:18', '2021-03-03 11:06:18', NULL);
INSERT INTO `transaction_pin` VALUES (103, 'Buy 1 PIN', 1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031111511614769911732', 6, '2021-03-03 11:11:51', '2021-03-03 11:11:51', NULL);
INSERT INTO `transaction_pin` VALUES (104, 'Buy 2 PINs', 2, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031114291614770069895', 69, '2021-03-03 11:14:29', '2021-03-03 11:14:29', NULL);
INSERT INTO `transaction_pin` VALUES (105, 'Member registration on behalf of sulham027@gmailcom', -1, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031117031614770223762', 69, '2021-03-03 11:17:03', '2021-03-03 11:17:03', NULL);
INSERT INTO `transaction_pin` VALUES (106, 'Member registration on behalf of saggafzianzian@gmail.com', -1, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031123021614770582117', 69, '2021-03-03 11:23:02', '2021-03-03 11:23:02', NULL);
INSERT INTO `transaction_pin` VALUES (107, 'Member registration on behalf of gedeekapuja@gmail.com', -1, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031128241614770904025', 6, '2021-03-03 11:28:24', '2021-03-03 11:28:24', NULL);
INSERT INTO `transaction_pin` VALUES (108, 'Buy 1 PIN', 1, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031135281614771328153', 36, '2021-03-03 11:35:28', '2021-03-03 11:35:28', NULL);
INSERT INTO `transaction_pin` VALUES (109, 'Buy 1 PIN', 1, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031139171614771557705', 69, '2021-03-03 11:39:17', '2021-03-03 11:39:17', NULL);
INSERT INTO `transaction_pin` VALUES (110, 'Buy 2 PINs', 2, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031140191614771619644', 76, '2021-03-03 11:40:19', '2021-03-03 11:40:19', NULL);
INSERT INTO `transaction_pin` VALUES (111, 'Member registration on behalf of sulham027@gmail.com', -1, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031141251614771685356', 69, '2021-03-03 11:41:25', '2021-03-03 11:41:25', NULL);
INSERT INTO `transaction_pin` VALUES (112, 'Member registration on behalf of hafiz.ibam7@gmail.com', -1, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031142111614771731219', 36, '2021-03-03 11:42:11', '2021-03-03 11:42:11', NULL);
INSERT INTO `transaction_pin` VALUES (113, 'Member registration on behalf of hazanalhaqqidarojat@gmail.com', -1, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031142501614771770070', 76, '2021-03-03 11:42:50', '2021-03-03 11:42:50', NULL);
INSERT INTO `transaction_pin` VALUES (114, 'Member registration on behalf of aripianhazami@gmail.com', -1, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031155021614772502592', 76, '2021-03-03 11:55:02', '2021-03-03 11:55:02', NULL);
INSERT INTO `transaction_pin` VALUES (115, 'Buy 1 PIN', 1, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031156071614772567928', 35, '2021-03-03 11:56:07', '2021-03-03 11:56:07', NULL);
INSERT INTO `transaction_pin` VALUES (116, 'Member registration on behalf of abdurrahmanassudaes9@gmail.com', -1, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031158101614772690626', 35, '2021-03-03 11:58:10', '2021-03-03 11:58:10', NULL);
INSERT INTO `transaction_pin` VALUES (117, 'Buy 2 PINs', 2, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031207071614773227758', 78, '2021-03-03 12:07:07', '2021-03-03 12:07:07', NULL);
INSERT INTO `transaction_pin` VALUES (118, 'Member registration on behalf of sul121751@gmail.com', -1, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031211461614773506132', 78, '2021-03-03 12:11:46', '2021-03-03 12:11:46', NULL);
INSERT INTO `transaction_pin` VALUES (119, 'Buy 1 PIN', 1, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031219011614773941214', 38, '2021-03-03 12:19:01', '2021-03-03 12:19:01', NULL);
INSERT INTO `transaction_pin` VALUES (120, 'Member registration on behalf of datudahe1983@gmail.com', -1, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031221211614774081442', 38, '2021-03-03 12:21:21', '2021-03-03 12:21:21', NULL);
INSERT INTO `transaction_pin` VALUES (121, 'Member registration on behalf of sulh8315@gmail.com', -1, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031227021614774422648', 78, '2021-03-03 12:27:02', '2021-03-03 12:27:02', NULL);
INSERT INTO `transaction_pin` VALUES (122, 'Buy 1 PIN', 1, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031229401614774580157', 84, '2021-03-03 12:29:40', '2021-03-03 12:29:40', NULL);
INSERT INTO `transaction_pin` VALUES (123, 'Buy 2 PINs', 2, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031230251614774625351', 70, '2021-03-03 12:30:25', '2021-03-03 12:30:25', NULL);
INSERT INTO `transaction_pin` VALUES (124, 'Member registration on behalf of dreamtofuture.76@gmail.com', -1, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031232561614774776681', 84, '2021-03-03 12:32:56', '2021-03-03 12:32:56', NULL);
INSERT INTO `transaction_pin` VALUES (125, 'Member registration on behalf of putrawanzaini123@gmail.com', -1, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031233081614774788609', 70, '2021-03-03 12:33:08', '2021-03-03 12:33:08', NULL);
INSERT INTO `transaction_pin` VALUES (126, 'Member registration on behalf of revaazahra85@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031233091614774789782', 8, '2021-03-03 12:33:09', '2021-03-03 12:33:09', NULL);
INSERT INTO `transaction_pin` VALUES (127, 'Member registration on behalf of erwinefendi4445@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031238381614775118636', 8, '2021-03-03 12:38:38', '2021-03-03 12:38:38', NULL);
INSERT INTO `transaction_pin` VALUES (128, 'Member registration on behalf of wiendy780@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031242261614775346494', 8, '2021-03-03 12:42:26', '2021-03-03 12:42:26', NULL);
INSERT INTO `transaction_pin` VALUES (129, 'Member registration on behalf of dinn45544@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031245231614775523841', 8, '2021-03-03 12:45:23', '2021-03-03 12:45:23', NULL);
INSERT INTO `transaction_pin` VALUES (130, 'Buy 2 PINs', 2, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031250211614775821683', 87, '2021-03-03 12:50:21', '2021-03-03 12:50:21', NULL);
INSERT INTO `transaction_pin` VALUES (131, 'Member registration on behalf of putrizaskiya9@gmail.com', -1, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031253131614775993046', 87, '2021-03-03 12:53:13', '2021-03-03 12:53:13', NULL);
INSERT INTO `transaction_pin` VALUES (132, 'Member registration on behalf of laluabdulmajid120876@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031256361614776196930', 8, '2021-03-03 12:56:36', '2021-03-03 12:56:36', NULL);
INSERT INTO `transaction_pin` VALUES (133, 'Buy 5 PINs', 5, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030104081614776648542', 8, '2021-03-03 13:04:08', '2021-03-03 13:04:08', NULL);
INSERT INTO `transaction_pin` VALUES (134, 'Member registration on behalf of nihazaini4@gmail.com', -1, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103030105061614776706007', 87, '2021-03-03 13:05:06', '2021-03-03 13:05:06', NULL);
INSERT INTO `transaction_pin` VALUES (135, 'Member registration on behalf of baiqsahuri50@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030109081614776948091', 8, '2021-03-03 13:09:08', '2021-03-03 13:09:08', NULL);
INSERT INTO `transaction_pin` VALUES (136, 'Member registration on behalf of muhammadnizar3334@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030114231614777263873', 8, '2021-03-03 13:14:23', '2021-03-03 13:14:23', NULL);
INSERT INTO `transaction_pin` VALUES (137, 'Member registration on behalf of halil123haji@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030117301614777450702', 8, '2021-03-03 13:17:30', '2021-03-03 13:17:30', NULL);
INSERT INTO `transaction_pin` VALUES (138, 'Member registration on behalf of hjmurgasih@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030123191614777799811', 8, '2021-03-03 13:23:19', '2021-03-03 13:23:19', NULL);
INSERT INTO `transaction_pin` VALUES (139, 'Member registration on behalf of myunusyuan@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030126381614777998699', 8, '2021-03-03 13:26:38', '2021-03-03 13:26:38', NULL);
INSERT INTO `transaction_pin` VALUES (140, 'Buy 5 PINs', 5, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030135211614778521844', 8, '2021-03-03 13:35:21', '2021-03-03 13:35:21', NULL);
INSERT INTO `transaction_pin` VALUES (141, 'Member registration on behalf of yunusyuan01@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030138491614778729215', 8, '2021-03-03 13:38:49', '2021-03-03 13:38:49', NULL);
INSERT INTO `transaction_pin` VALUES (142, 'Member registration on behalf of lalupanjipparawangsa@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030142521614778972743', 8, '2021-03-03 13:42:52', '2021-03-03 13:42:52', NULL);
INSERT INTO `transaction_pin` VALUES (143, 'Member registration on behalf of satryasasak@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030149121614779352653', 8, '2021-03-03 13:49:12', '2021-03-03 13:49:12', NULL);
INSERT INTO `transaction_pin` VALUES (144, 'Member registration on behalf of myunusyuan02@gmail.com', -1, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030153591614779639509', 8, '2021-03-03 13:53:59', '2021-03-03 13:53:59', NULL);
INSERT INTO `transaction_pin` VALUES (145, 'Buy 1 PIN', 1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030156331614779793010', 4, '2021-03-03 13:56:33', '2021-03-03 13:56:33', NULL);
INSERT INTO `transaction_pin` VALUES (146, 'Buy 1 PIN', 1, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030158531614779933910', 76, '2021-03-03 13:58:53', '2021-03-03 13:58:53', NULL);
INSERT INTO `transaction_pin` VALUES (147, 'Member registration on behalf of misjaruddin73@gmail.com', -1, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030200391614780039840', 76, '2021-03-03 14:00:39', '2021-03-03 14:00:39', NULL);
INSERT INTO `transaction_pin` VALUES (148, 'Member registration on behalf of lenipuspitadewi97@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030203001614780180453', 4, '2021-03-03 14:03:00', '2021-03-03 14:03:00', NULL);
INSERT INTO `transaction_pin` VALUES (149, 'Member registration on behalf of Opickchocolatos007@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030212401614780760780', 4, '2021-03-03 14:12:40', '2021-03-03 14:12:40', NULL);
INSERT INTO `transaction_pin` VALUES (150, 'Buy 2 PINs', 2, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030219261614781166239', 104, '2021-03-03 14:19:26', '2021-03-03 14:19:26', NULL);
INSERT INTO `transaction_pin` VALUES (151, 'Member registration on behalf of muaddah77@gmail.com', -1, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030222191614781339817', 104, '2021-03-03 14:22:19', '2021-03-03 14:22:19', NULL);
INSERT INTO `transaction_pin` VALUES (152, 'Member registration on behalf of Bangfikri007@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030224051614781445270', 4, '2021-03-03 14:24:05', '2021-03-03 14:24:05', NULL);
INSERT INTO `transaction_pin` VALUES (153, 'Buy 1 PIN', 1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030226251614781585938', 4, '2021-03-03 14:26:25', '2021-03-03 14:26:25', NULL);
INSERT INTO `transaction_pin` VALUES (154, 'Member registration on behalf of muharuddin968@gmail.com', -1, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030228561614781736405', 104, '2021-03-03 14:28:56', '2021-03-03 14:28:56', NULL);
INSERT INTO `transaction_pin` VALUES (155, 'Member registration on behalf of lerylesmana10@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030237251614782245494', 4, '2021-03-03 14:37:25', '2021-03-03 14:37:25', NULL);
INSERT INTO `transaction_pin` VALUES (156, 'Member registration on behalf of Opickchocolatos008@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030239291614782369498', 4, '2021-03-03 14:39:29', '2021-03-03 14:39:29', NULL);
INSERT INTO `transaction_pin` VALUES (157, 'Member registration on behalf of luckybestrich@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030309221614784162695', 5, '2021-03-03 15:09:22', '2021-03-03 15:09:22', NULL);
INSERT INTO `transaction_pin` VALUES (158, 'Buy 1 PIN', 1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030313331614784413864', 4, '2021-03-03 15:13:33', '2021-03-03 15:13:33', NULL);
INSERT INTO `transaction_pin` VALUES (159, 'Member registration on behalf of l.uckybestrich@gmail.com', -5, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030319221614784762947', 5, '2021-03-03 15:19:22', '2021-03-03 15:19:22', NULL);
INSERT INTO `transaction_pin` VALUES (160, 'Member registration on behalf of Opickchocolatos009@gmail.com', -1, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030320381614784838919', 4, '2021-03-03 15:20:38', '2021-03-03 15:20:38', NULL);
INSERT INTO `transaction_pin` VALUES (161, 'Member registration on behalf of lu.ckybestrich@gmail.com', -5, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030324481614785088140', 5, '2021-03-03 15:24:48', '2021-03-03 15:24:48', NULL);
INSERT INTO `transaction_pin` VALUES (162, 'Buy 11 PINs', 11, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030328381614785318146', 4, '2021-03-03 15:28:38', '2021-03-03 15:28:38', NULL);
INSERT INTO `transaction_pin` VALUES (163, 'Member registration on behalf of luc.kybestrich@gmail.com', -5, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030334211614785661159', 5, '2021-03-03 15:34:21', '2021-03-03 15:34:21', NULL);
INSERT INTO `transaction_pin` VALUES (164, 'Member registration on behalf of m.otor.hendro@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030349501614786590393', 5, '2021-03-03 15:49:50', '2021-03-03 15:49:50', NULL);
INSERT INTO `transaction_pin` VALUES (165, 'Member registration on behalf of mo.tor.hendro@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030358581614787138801', 5, '2021-03-03 15:58:58', '2021-03-03 15:58:58', NULL);
INSERT INTO `transaction_pin` VALUES (166, 'Member registration on behalf of fgxpressindonesia@gmail.com', -3, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030404251614787465396', 5, '2021-03-03 16:04:25', '2021-03-03 16:04:25', NULL);
INSERT INTO `transaction_pin` VALUES (167, 'Member registration on behalf of f.gxpressindonesia@gmail.com', -3, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030409311614787771122', 5, '2021-03-03 16:09:31', '2021-03-03 16:09:31', NULL);
INSERT INTO `transaction_pin` VALUES (168, 'Member registration on behalf of emerents83@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030415211614788121069', 5, '2021-03-03 16:15:21', '2021-03-03 16:15:21', NULL);
INSERT INTO `transaction_pin` VALUES (169, 'Member registration on behalf of e.merents83@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030418591614788339096', 5, '2021-03-03 16:18:59', '2021-03-03 16:18:59', NULL);
INSERT INTO `transaction_pin` VALUES (170, 'Member registration on behalf of em.erents83@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030420531614788453044', 5, '2021-03-03 16:20:53', '2021-03-03 16:20:53', NULL);
INSERT INTO `transaction_pin` VALUES (171, 'Buy 50 PINs', 50, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030423001614788580043', 5, '2021-03-03 16:23:00', '2021-03-03 16:23:00', NULL);
INSERT INTO `transaction_pin` VALUES (172, 'Member registration on behalf of yantho.manafe@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030426191614788779239', 5, '2021-03-03 16:26:19', '2021-03-03 16:26:19', NULL);
INSERT INTO `transaction_pin` VALUES (173, 'Member registration on behalf of y.antho.manafe@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030428541614788934082', 5, '2021-03-03 16:28:54', '2021-03-03 16:28:54', NULL);
INSERT INTO `transaction_pin` VALUES (174, 'Member registration on behalf of ya.ntho.manafe@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030430381614789038317', 5, '2021-03-03 16:30:38', '2021-03-03 16:30:38', NULL);
INSERT INTO `transaction_pin` VALUES (175, 'Member registration on behalf of fg.xpressindonesia@gmail.com', -3, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030432591614789179733', 5, '2021-03-03 16:32:59', '2021-03-03 16:32:59', NULL);
INSERT INTO `transaction_pin` VALUES (176, 'Member registration on behalf of fgx.pressindonesia@gmail.com', -3, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030436261614789386279', 5, '2021-03-03 16:36:26', '2021-03-03 16:36:26', NULL);
INSERT INTO `transaction_pin` VALUES (177, 'Member registration on behalf of iketutarantikabali@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030443121614789792717', 5, '2021-03-03 16:43:12', '2021-03-03 16:43:12', NULL);
INSERT INTO `transaction_pin` VALUES (178, 'Member registration on behalf of al.iassebatik@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030451191614790279751', 5, '2021-03-03 16:51:19', '2021-03-03 16:51:19', NULL);
INSERT INTO `transaction_pin` VALUES (179, 'Member registration on behalf of upixbase180@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030510141614791414180', 5, '2021-03-03 17:10:14', '2021-03-03 17:10:14', NULL);
INSERT INTO `transaction_pin` VALUES (180, 'Member registration on behalf of mirwanbone@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030735591614800159838', 5, '2021-03-03 19:35:59', '2021-03-03 19:35:59', NULL);
INSERT INTO `transaction_pin` VALUES (181, 'Member registration on behalf of m.irwanbone@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030743571614800637269', 5, '2021-03-03 19:43:57', '2021-03-03 19:43:57', NULL);
INSERT INTO `transaction_pin` VALUES (182, 'Member registration on behalf of mercusuar511@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030753111614801191607', 5, '2021-03-03 19:53:11', '2021-03-03 19:53:11', NULL);
INSERT INTO `transaction_pin` VALUES (183, 'Member registration on behalf of powerbetece@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030814211614802461377', 5, '2021-03-03 20:14:21', '2021-03-03 20:14:21', NULL);
INSERT INTO `transaction_pin` VALUES (184, 'Member registration on behalf of m.ercusuar511@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030816491614802609050', 5, '2021-03-03 20:16:49', '2021-03-03 20:16:49', NULL);
INSERT INTO `transaction_pin` VALUES (185, 'Member registration on behalf of me.rcusuar511@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030818241614802704125', 5, '2021-03-03 20:18:24', '2021-03-03 20:18:24', NULL);
INSERT INTO `transaction_pin` VALUES (186, 'Member registration on behalf of pow.erbetece@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030832361614803556924', 5, '2021-03-03 20:32:36', '2021-03-03 20:32:36', NULL);
INSERT INTO `transaction_pin` VALUES (187, 'Member registration on behalf of powe.rbetece@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030840001614804000718', 5, '2021-03-03 20:40:00', '2021-03-03 20:40:00', NULL);
INSERT INTO `transaction_pin` VALUES (188, 'Member registration on behalf of asis.suandi26@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030842421614804162694', 5, '2021-03-03 20:42:42', '2021-03-03 20:42:42', NULL);
INSERT INTO `transaction_pin` VALUES (189, 'Member registration on behalf of a.sis.suandi26@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030850071614804607767', 5, '2021-03-03 20:50:07', '2021-03-03 20:50:07', NULL);
INSERT INTO `transaction_pin` VALUES (190, 'Member registration on behalf of as.is.suandi26@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030852371614804757028', 5, '2021-03-03 20:52:37', '2021-03-03 20:52:37', NULL);
INSERT INTO `transaction_pin` VALUES (191, 'Member registration on behalf of alia.ssebatik@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030859031614805143554', 5, '2021-03-03 20:59:03', '2021-03-03 20:59:03', NULL);
INSERT INTO `transaction_pin` VALUES (192, 'Member registration on behalf of karmilawilis@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030904401614805480663', 5, '2021-03-03 21:04:40', '2021-03-03 21:04:40', NULL);
INSERT INTO `transaction_pin` VALUES (193, 'Member registration on behalf of k.armilawilis@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030912361614805956664', 5, '2021-03-03 21:12:36', '2021-03-03 21:12:36', NULL);
INSERT INTO `transaction_pin` VALUES (194, 'Member registration on behalf of ka.rmilawilis@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030914361614806076601', 5, '2021-03-03 21:14:36', '2021-03-03 21:14:36', NULL);
INSERT INTO `transaction_pin` VALUES (195, 'Buy 2 PINs', 2, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031150271614815427575', 43, '2021-03-03 23:50:27', '2021-03-03 23:50:27', NULL);
INSERT INTO `transaction_pin` VALUES (196, 'Member registration on behalf of hamdanbhdn@yahoo.com', -1, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031152451614815565087', 43, '2021-03-03 23:52:45', '2021-03-03 23:52:45', NULL);
INSERT INTO `transaction_pin` VALUES (197, 'Member registration on behalf of huminiji543@gmail.com', -1, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103041203511614816231694', 5, '2021-03-04 00:03:51', '2021-03-04 00:03:51', NULL);

-- ----------------------------
-- Table structure for transaction_reward
-- ----------------------------
DROP TABLE IF EXISTS `transaction_reward`;
CREATE TABLE `transaction_reward`  (
  `transaction_reward_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_reward_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_reward_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_reward_amount` decimal(65, 2) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_reward_id`) USING BTREE,
  INDEX `bagi_hasil_pengguna_id_fkey`(`member_id`) USING BTREE,
  INDEX `transaksi_id`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_reward_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_reward_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 257 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction_reward
-- ----------------------------
INSERT INTO `transaction_reward` VALUES (1, 'Member registration on behalf of Anwar', 'Referral', 100.00, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020640441614667244693', 3, '2021-03-02 06:40:44', '2021-03-02 06:40:44', NULL);
INSERT INTO `transaction_reward` VALUES (2, 'Member registration on behalf of Asmini', 'Referral', 100.00, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020705171614668717929', 3, '2021-03-02 07:05:17', '2021-03-02 07:05:17', NULL);
INSERT INTO `transaction_reward` VALUES (3, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'cv74J43sLG-202103020706571614668817853', 3, '2021-03-02 07:06:57', '2021-03-02 07:06:57', NULL);
INSERT INTO `transaction_reward` VALUES (4, 'Member registration on behalf of alias', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020712431614669163964', 5, '2021-03-02 07:12:43', '2021-03-02 07:12:43', NULL);
INSERT INTO `transaction_reward` VALUES (5, 'Member registration on behalf of alias', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020716561614669416045', 5, '2021-03-02 07:16:56', '2021-03-02 07:16:56', NULL);
INSERT INTO `transaction_reward` VALUES (6, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'iQlQ8RpmZE-202103020717341614669454256', 5, '2021-03-02 07:17:34', '2021-03-02 07:17:34', NULL);
INSERT INTO `transaction_reward` VALUES (7, 'Member registration on behalf of Hendro Sutrisno', 'Referral', 500.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020723271614669807943', 14, '2021-03-02 07:23:27', '2021-03-02 07:23:27', NULL);
INSERT INTO `transaction_reward` VALUES (8, 'Member registration on behalf of I Wayan Gina', 'Referral', 100.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020735091614670509541', 6, '2021-03-02 07:35:09', '2021-03-02 07:35:09', NULL);
INSERT INTO `transaction_reward` VALUES (9, 'Member registration on behalf of Zainul wasti', 'Referral', 50.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020735431614670543094', 7, '2021-03-02 07:35:43', '2021-03-02 07:35:43', NULL);
INSERT INTO `transaction_reward` VALUES (10, 'Member registration on behalf of Hendro Sutrisno', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020738471614670727570', 15, '2021-03-02 07:38:47', '2021-03-02 07:38:47', NULL);
INSERT INTO `transaction_reward` VALUES (11, 'Member registration on behalf of I Wayan Gina', 'Referral', 100.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103020744051614671045065', 6, '2021-03-02 07:44:05', '2021-03-02 07:44:05', NULL);
INSERT INTO `transaction_reward` VALUES (12, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'vd9ntkCzmC-202103020748031614671283849', 6, '2021-03-02 07:48:03', '2021-03-02 07:48:03', NULL);
INSERT INTO `transaction_reward` VALUES (13, 'Member registration on behalf of Rayyan', 'Referral', 100.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020748591614671339365', 12, '2021-03-02 07:48:59', '2021-03-02 07:48:59', NULL);
INSERT INTO `transaction_reward` VALUES (14, 'Member registration on behalf of Fitriana junisa', 'Referral', 100.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020754161614671656124', 13, '2021-03-02 07:54:16', '2021-03-02 07:54:16', NULL);
INSERT INTO `transaction_reward` VALUES (15, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'MsUUhetzG9-202103020755121614671712854', 3, '2021-03-02 07:55:12', '2021-03-02 07:55:12', NULL);
INSERT INTO `transaction_reward` VALUES (16, 'Member registration on behalf of hhtcenter1@gmail.com', 'Referral', 100.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021021221614680482844', 22, '2021-03-02 10:21:22', '2021-03-02 10:21:22', NULL);
INSERT INTO `transaction_reward` VALUES (17, 'Member registration on behalf of muhammadmw1983@gmail.com', 'Referral', 100.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021052131614682333923', 12, '2021-03-02 10:52:13', '2021-03-02 10:52:13', NULL);
INSERT INTO `transaction_reward` VALUES (18, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'uvNUeIR5xy-202103021056451614682605767', 12, '2021-03-02 10:56:45', '2021-03-02 10:56:45', NULL);
INSERT INTO `transaction_reward` VALUES (19, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'uvNUeIR5xy-202103021056451614682605767', 3, '2021-03-02 10:56:45', '2021-03-02 10:56:45', NULL);
INSERT INTO `transaction_reward` VALUES (20, 'Member registration on behalf of sm01202102@gmail.com', 'Referral', 50.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103021112321614683552533', 7, '2021-03-02 11:12:32', '2021-03-02 11:12:32', NULL);
INSERT INTO `transaction_reward` VALUES (21, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'PEbwxsXKPS-202103021115241614683724114', 7, '2021-03-02 11:15:24', '2021-03-02 11:15:24', NULL);
INSERT INTO `transaction_reward` VALUES (22, 'Member registration on behalf of yusrilhamdani.yh@gmail.com', 'Referral', 100.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021135071614684907123', 13, '2021-03-02 11:35:07', '2021-03-02 11:35:07', NULL);
INSERT INTO `transaction_reward` VALUES (23, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'Y1Q8fF6Pii-202103021136561614685016614', 13, '2021-03-02 11:36:56', '2021-03-02 11:36:56', NULL);
INSERT INTO `transaction_reward` VALUES (24, 'Member registration on behalf of hamidagung433@gmail.com', 'Referral', 100.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021142211614685341982', 22, '2021-03-02 11:42:21', '2021-03-02 11:42:21', NULL);
INSERT INTO `transaction_reward` VALUES (25, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'yU6g8ErvqH-202103021146081614685568303', 22, '2021-03-02 11:46:08', '2021-03-02 11:46:08', NULL);
INSERT INTO `transaction_reward` VALUES (26, 'Member registration on behalf of hwsoundlombok@gmail.com', 'Referral', 50.00, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021157121614686232309', 21, '2021-03-02 11:57:12', '2021-03-02 11:57:12', NULL);
INSERT INTO `transaction_reward` VALUES (27, 'Member registration on behalf of arnimariani70@gmail.com', 'Referral', 100.00, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021200281614686428904', 21, '2021-03-02 12:00:28', '2021-03-02 12:00:28', NULL);
INSERT INTO `transaction_reward` VALUES (28, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, '1NVRvFM2P5-202103021202451614686565108', 3, '2021-03-02 12:02:45', '2021-03-02 12:02:45', NULL);
INSERT INTO `transaction_reward` VALUES (29, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'IthsrC75I5-202103021204251614686665327', 21, '2021-03-02 12:04:25', '2021-03-02 12:04:25', NULL);
INSERT INTO `transaction_reward` VALUES (30, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'IthsrC75I5-202103021204251614686665327', 3, '2021-03-02 12:04:25', '2021-03-02 12:04:25', NULL);
INSERT INTO `transaction_reward` VALUES (31, 'Member registration on behalf of NURUL WATHANI', 'Referral', 100.00, '123123123123', 16, '2021-03-02 07:35:43', '2021-03-02 07:35:43', NULL);
INSERT INTO `transaction_reward` VALUES (32, 'Member registration on behalf of yusrilhy212@gmail.com', 'Referral', 100.00, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021240441614688844400', 27, '2021-03-02 12:40:44', '2021-03-02 12:40:44', NULL);
INSERT INTO `transaction_reward` VALUES (33, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'qT4bnGZiYS-202103021242321614688952917', 13, '2021-03-02 12:42:32', '2021-03-02 12:42:32', NULL);
INSERT INTO `transaction_reward` VALUES (34, 'Member registration on behalf of dimashiporia@gmail.com', 'Referral', 100.00, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021252251614689545147', 27, '2021-03-02 12:52:25', '2021-03-02 12:52:25', NULL);
INSERT INTO `transaction_reward` VALUES (35, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'fCYhcxdGHI-202103021253551614689635676', 27, '2021-03-02 12:53:55', '2021-03-02 12:53:55', NULL);
INSERT INTO `transaction_reward` VALUES (36, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'fCYhcxdGHI-202103021253551614689635676', 13, '2021-03-02 12:53:55', '2021-03-02 12:53:55', NULL);
INSERT INTO `transaction_reward` VALUES (37, 'Member registration on behalf of mzw032021@gmail.com', 'Referral', 50.00, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020159571614693597222', 26, '2021-03-02 13:59:57', '2021-03-02 13:59:57', NULL);
INSERT INTO `transaction_reward` VALUES (38, 'Member registration on behalf of smteam052021@gmail.com', 'Referral', 50.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020218181614694698421', 7, '2021-03-02 14:18:18', '2021-03-02 14:18:18', NULL);
INSERT INTO `transaction_reward` VALUES (39, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, '0VJ0QBbOr1-202103020221341614694894641', 7, '2021-03-02 14:21:34', '2021-03-02 14:21:34', NULL);
INSERT INTO `transaction_reward` VALUES (40, 'Member registration on behalf of smteam062021@gmail.com', 'Referral', 50.00, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020304281614697468050', 33, '2021-03-02 15:04:28', '2021-03-02 15:04:28', NULL);
INSERT INTO `transaction_reward` VALUES (41, 'Member registration on behalf of asroriazam@gmail.com', 'Referral', 50.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020319281614698368001', 35, '2021-03-02 15:19:28', '2021-03-02 15:19:28', NULL);
INSERT INTO `transaction_reward` VALUES (42, 'Member registration on behalf of dhiaanisara@gmail.com', 'Referral', 50.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020341441614699704331', 36, '2021-03-02 15:41:44', '2021-03-02 15:41:44', NULL);
INSERT INTO `transaction_reward` VALUES (43, 'Member registration on behalf of nathaniaasror@gmail.com', 'Referral', 50.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020348181614700098644', 36, '2021-03-02 15:48:18', '2021-03-02 15:48:18', NULL);
INSERT INTO `transaction_reward` VALUES (44, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'jRNKBTAaY1-202103020349091614700149421', 36, '2021-03-02 15:49:09', '2021-03-02 15:49:09', NULL);
INSERT INTO `transaction_reward` VALUES (45, 'Member registration on behalf of a.liassebatik@gmail.com', 'Referral', 50.00, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020439321614703172660', 14, '2021-03-02 16:39:32', '2021-03-02 16:39:32', NULL);
INSERT INTO `transaction_reward` VALUES (46, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'Lh76GuMR5N-202103020441231614703283219', 5, '2021-03-02 16:41:23', '2021-03-02 16:41:23', NULL);
INSERT INTO `transaction_reward` VALUES (47, 'Member registration on behalf of djamallulailhamzah@gmail.com', 'Referral', 100.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020619101614709150835', 25, '2021-03-02 18:19:10', '2021-03-02 18:19:10', NULL);
INSERT INTO `transaction_reward` VALUES (48, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'nEmx8iP4zm-202103020621391614709299556', 12, '2021-03-02 18:21:39', '2021-03-02 18:21:39', NULL);
INSERT INTO `transaction_reward` VALUES (49, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'nEmx8iP4zm-202103020621391614709299556', 3, '2021-03-02 18:21:39', '2021-03-02 18:21:39', NULL);
INSERT INTO `transaction_reward` VALUES (50, 'Member registration on behalf of asmanjaya016@gmail.com', 'Referral', 100.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020628341614709714821', 25, '2021-03-02 18:28:34', '2021-03-02 18:28:34', NULL);
INSERT INTO `transaction_reward` VALUES (51, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'EyreYd7M7W-202103020629551614709795671', 25, '2021-03-02 18:29:55', '2021-03-02 18:29:55', NULL);
INSERT INTO `transaction_reward` VALUES (52, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 25.00, 'EyreYd7M7W-202103020629551614709795671', 12, '2021-03-02 18:29:55', '2021-03-02 18:29:55', NULL);
INSERT INTO `transaction_reward` VALUES (53, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'EyreYd7M7W-202103020629551614709795671', 3, '2021-03-02 18:29:55', '2021-03-02 18:29:55', NULL);
INSERT INTO `transaction_reward` VALUES (54, 'Member registration on behalf of mzw042021@gmail.com', 'Referral', 50.00, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020756241614714984144', 26, '2021-03-02 19:56:24', '2021-03-02 19:56:24', NULL);
INSERT INTO `transaction_reward` VALUES (55, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '7bg1iTDDoY-202103020758251614715105361', 26, '2021-03-02 19:58:25', '2021-03-02 19:58:25', NULL);
INSERT INTO `transaction_reward` VALUES (56, 'Member registration on behalf of salehlalu596@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021053331614725613201', 8, '2021-03-02 22:53:33', '2021-03-02 22:53:33', NULL);
INSERT INTO `transaction_reward` VALUES (57, 'Member registration on behalf of lalumuhammadsaleh181@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021057381614725858665', 8, '2021-03-02 22:57:38', '2021-03-02 22:57:38', NULL);
INSERT INTO `transaction_reward` VALUES (58, 'Member registration on behalf of dayock1982@gmail.com', 'Referral', 200.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021107081614726428584', 43, '2021-03-02 23:07:08', '2021-03-02 23:07:08', NULL);
INSERT INTO `transaction_reward` VALUES (59, 'Member registration on behalf of lukmanulhakim974@gmail.com', 'Referral', 200.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021114321614726872706', 43, '2021-03-02 23:14:32', '2021-03-02 23:14:32', NULL);
INSERT INTO `transaction_reward` VALUES (60, 'Turnonver growth  5% of 2,000.00 right side registration', 'Turnover Growth', 100.00, 'aHFf9gFzgN-202103021117121614727032799', 43, '2021-03-02 23:17:12', '2021-03-02 23:17:12', NULL);
INSERT INTO `transaction_reward` VALUES (61, 'Member registration on behalf of salehraden098@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021129541614727794388', 8, '2021-03-02 23:29:54', '2021-03-02 23:29:54', NULL);
INSERT INTO `transaction_reward` VALUES (62, 'Member registration on behalf of tkerguntur098@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021138501614728330612', 8, '2021-03-02 23:38:50', '2021-03-02 23:38:50', NULL);
INSERT INTO `transaction_reward` VALUES (63, 'Member registration on behalf of bbemailku80@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021158341614729514564', 4, '2021-03-02 23:58:34', '2021-03-02 23:58:34', NULL);
INSERT INTO `transaction_reward` VALUES (64, 'Member registration on behalf of bbemailku81@gmail.com', 'Referral', 50.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031206171614729977779', 4, '2021-03-03 00:06:17', '2021-03-03 00:06:17', NULL);
INSERT INTO `transaction_reward` VALUES (65, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'nLCYpLUWU6-202103031209511614730191211', 4, '2021-03-03 00:09:51', '2021-03-03 00:09:51', NULL);
INSERT INTO `transaction_reward` VALUES (66, 'Member registration on behalf of hibarisatria@gmail.com', 'Referral', 50.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031224221614731062429', 50, '2021-03-03 00:24:22', '2021-03-03 00:24:22', NULL);
INSERT INTO `transaction_reward` VALUES (67, 'Turnonver growth  5% of 200.00 left side registration', 'Turnover Growth', 10.00, 'xs2I7l7vJX-202103030101151614733275567', 8, '2021-03-03 01:01:15', '2021-03-03 01:01:15', NULL);
INSERT INTO `transaction_reward` VALUES (68, 'Member registration on behalf of mintojaya1405@gmail.com', 'Referral', 50.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030117351614734255387', 17, '2021-03-03 01:17:35', '2021-03-03 01:17:35', NULL);
INSERT INTO `transaction_reward` VALUES (69, 'Member registration on behalf of bongor1976@gmail.com', 'Referral', 50.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030146561614736016953', 52, '2021-03-03 01:46:56', '2021-03-03 01:46:56', NULL);
INSERT INTO `transaction_reward` VALUES (70, 'Member registration on behalf of lerylesmana9@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030205381614737138166', 54, '2021-03-03 02:05:38', '2021-03-03 02:05:38', NULL);
INSERT INTO `transaction_reward` VALUES (71, 'Member registration on behalf of soldierwinter782@gmail.com', 'Referral', 20.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030211351614737495733', 55, '2021-03-03 02:11:35', '2021-03-03 02:11:35', NULL);
INSERT INTO `transaction_reward` VALUES (72, 'Member registration on behalf of lilikindrawati182@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030255251614740125824', 56, '2021-03-03 02:55:25', '2021-03-03 02:55:25', NULL);
INSERT INTO `transaction_reward` VALUES (73, 'Member registration on behalf of alwanulhamdi76@gmail.com', 'Referral', 100.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030456431614747403089', 8, '2021-03-03 04:56:43', '2021-03-03 04:56:43', NULL);
INSERT INTO `transaction_reward` VALUES (74, 'Member registration on behalf of dinn44554@gmail.com', 'Referral', 100.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030509151614748155000', 8, '2021-03-03 05:09:15', '2021-03-03 05:09:15', NULL);
INSERT INTO `transaction_reward` VALUES (75, 'Member registration on behalf of toyadi2017@gmail.com', 'Referral', 10.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030529531614749393920', 20, '2021-03-03 05:29:53', '2021-03-03 05:29:53', NULL);
INSERT INTO `transaction_reward` VALUES (76, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, '4P3OBo2AHu-202103030532021614749522503', 6, '2021-03-03 05:32:02', '2021-03-03 05:32:02', NULL);
INSERT INTO `transaction_reward` VALUES (77, 'Member registration on behalf of lamtanuss@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030734151614756855950', 8, '2021-03-03 07:34:15', '2021-03-03 07:34:15', NULL);
INSERT INTO `transaction_reward` VALUES (78, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 15.00, 'byT3oMMeYX-202103030737441614757064325', 8, '2021-03-03 07:37:44', '2021-03-03 07:37:44', NULL);
INSERT INTO `transaction_reward` VALUES (79, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 10.00, 'X2nZh1obJ6-202103030753581614758038672', 8, '2021-03-03 07:53:58', '2021-03-03 07:53:58', NULL);
INSERT INTO `transaction_reward` VALUES (80, 'Member registration on behalf of lamtanusimam@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030803191614758599404', 61, '2021-03-03 08:03:19', '2021-03-03 08:03:19', NULL);
INSERT INTO `transaction_reward` VALUES (81, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'rCq6GnFxWo-202103030804321614758672680', 8, '2021-03-03 08:04:32', '2021-03-03 08:04:32', NULL);
INSERT INTO `transaction_reward` VALUES (82, 'Member registration on behalf of albytsaqib20@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030806591614758819884', 58, '2021-03-03 08:06:59', '2021-03-03 08:06:59', NULL);
INSERT INTO `transaction_reward` VALUES (83, 'Member registration on behalf of hamdilalu76@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030812041614759124189', 58, '2021-03-03 08:12:04', '2021-03-03 08:12:04', NULL);
INSERT INTO `transaction_reward` VALUES (84, 'Turnonver growth  5% of 200.00 left side registration', 'Turnover Growth', 10.00, 'KOvw2Jrl4o-202103030813421614759222611', 58, '2021-03-03 08:13:42', '2021-03-03 08:13:42', NULL);
INSERT INTO `transaction_reward` VALUES (85, 'Member registration on behalf of samsulrina31@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030817081614759428583', 61, '2021-03-03 08:17:08', '2021-03-03 08:17:08', NULL);
INSERT INTO `transaction_reward` VALUES (86, 'Turnonver growth  5% of 200.00 right side registration', 'Turnover Growth', 10.00, 'q7WFdbTerW-202103030825051614759905847', 61, '2021-03-03 08:25:05', '2021-03-03 08:25:05', NULL);
INSERT INTO `transaction_reward` VALUES (87, 'Turnonver growth  5% of 200.00 left side registration', 'Turnover Growth', 10.00, 'q7WFdbTerW-202103030825051614759905847', 8, '2021-03-03 08:25:05', '2021-03-03 08:25:05', NULL);
INSERT INTO `transaction_reward` VALUES (88, 'Member registration on behalf of hannabaiq76@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030826341614759994755', 58, '2021-03-03 08:26:34', '2021-03-03 08:26:34', NULL);
INSERT INTO `transaction_reward` VALUES (89, 'Member registration on behalf of mzw012021@gmail.com', 'Referral', 50.00, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030934421614764082453', 34, '2021-03-03 09:34:42', '2021-03-03 09:34:42', NULL);
INSERT INTO `transaction_reward` VALUES (90, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'MOviqBzN63-202103030939261614764366005', 7, '2021-03-03 09:39:26', '2021-03-03 09:39:26', NULL);
INSERT INTO `transaction_reward` VALUES (91, 'Member registration on behalf of mzw022021@gmail.com', 'Referral', 50.00, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030942561614764576764', 34, '2021-03-03 09:42:56', '2021-03-03 09:42:56', NULL);
INSERT INTO `transaction_reward` VALUES (92, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'IzG0u1fxn3-202103030945401614764740957', 34, '2021-03-03 09:45:40', '2021-03-03 09:45:40', NULL);
INSERT INTO `transaction_reward` VALUES (93, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'IzG0u1fxn3-202103030945401614764740957', 7, '2021-03-03 09:45:40', '2021-03-03 09:45:40', NULL);
INSERT INTO `transaction_reward` VALUES (94, 'Member registration on behalf of smteam012021@gmail.com', 'Referral', 50.00, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030959111614765551485', 67, '2021-03-03 09:59:11', '2021-03-03 09:59:11', NULL);
INSERT INTO `transaction_reward` VALUES (95, 'Member registration on behalf of smteam022021@gmail.com', 'Referral', 50.00, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103031000431614765643266', 67, '2021-03-03 10:00:43', '2021-03-03 10:00:43', NULL);
INSERT INTO `transaction_reward` VALUES (96, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'dgvPY4eEv9-202103031004091614765849124', 7, '2021-03-03 10:04:09', '2021-03-03 10:04:09', NULL);
INSERT INTO `transaction_reward` VALUES (97, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'wxSOkTAdbA-202103031006001614765960402', 67, '2021-03-03 10:06:00', '2021-03-03 10:06:00', NULL);
INSERT INTO `transaction_reward` VALUES (98, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'wxSOkTAdbA-202103031006001614765960402', 7, '2021-03-03 10:06:00', '2021-03-03 10:06:00', NULL);
INSERT INTO `transaction_reward` VALUES (99, 'Member registration on behalf of wahyurich2019@gmail.com', 'Referral', 100.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031030431614767443270', 40, '2021-03-03 10:30:43', '2021-03-03 10:30:43', NULL);
INSERT INTO `transaction_reward` VALUES (100, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 25.00, 'A8smWVhzMR-202103031032541614767574786', 3, '2021-03-03 10:32:54', '2021-03-03 10:32:54', NULL);
INSERT INTO `transaction_reward` VALUES (101, 'Member registration on behalf of hamzahlbc1@gmail.com', 'Referral', 200.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031043251614768205885', 41, '2021-03-03 10:43:25', '2021-03-03 10:43:25', NULL);
INSERT INTO `transaction_reward` VALUES (102, 'Turnonver growth  5% of 2,000.00 left side registration', 'Turnover Growth', 50.00, 'OOqsgwLSc8-202103031046331614768393996', 25, '2021-03-03 10:46:34', '2021-03-03 10:46:34', NULL);
INSERT INTO `transaction_reward` VALUES (103, 'Member registration on behalf of sutaantara14@gmail.com', 'Referral', 10.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031052321614768752855', 60, '2021-03-03 10:52:32', '2021-03-03 10:52:32', NULL);
INSERT INTO `transaction_reward` VALUES (104, 'Member registration on behalf of hamzahlbc2@gmail.com', 'Referral', 200.00, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031106181614769578786', 72, '2021-03-03 11:06:18', '2021-03-03 11:06:18', NULL);
INSERT INTO `transaction_reward` VALUES (105, 'Member registration on behalf of sulham027@gmailcom', 'Referral', 100.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031117031614770223762', 69, '2021-03-03 11:17:03', '2021-03-03 11:17:03', NULL);
INSERT INTO `transaction_reward` VALUES (106, 'Member registration on behalf of saggafzianzian@gmail.com', 'Referral', 100.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031123021614770582117', 69, '2021-03-03 11:23:02', '2021-03-03 11:23:02', NULL);
INSERT INTO `transaction_reward` VALUES (107, 'Member registration on behalf of gedeekapuja@gmail.com', 'Referral', 100.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031128241614770904025', 17, '2021-03-03 11:28:24', '2021-03-03 11:28:24', NULL);
INSERT INTO `transaction_reward` VALUES (108, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 25.00, 'mZNy0PcgYW-202103031129161614770956424', 7, '2021-03-03 11:29:16', '2021-03-03 11:29:16', NULL);
INSERT INTO `transaction_reward` VALUES (109, 'Member registration on behalf of sulham027@gmail.com', 'Referral', 100.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031141251614771685356', 69, '2021-03-03 11:41:25', '2021-03-03 11:41:25', NULL);
INSERT INTO `transaction_reward` VALUES (110, 'Member registration on behalf of hafiz.ibam7@gmail.com', 'Referral', 50.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031142111614771731219', 36, '2021-03-03 11:42:11', '2021-03-03 11:42:11', NULL);
INSERT INTO `transaction_reward` VALUES (111, 'Member registration on behalf of hazanalhaqqidarojat@gmail.com', 'Referral', 20.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031142501614771770070', 76, '2021-03-03 11:42:50', '2021-03-03 11:42:50', NULL);
INSERT INTO `transaction_reward` VALUES (112, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'shxxo3mXq4-202103031145101614771910639', 7, '2021-03-03 11:45:10', '2021-03-03 11:45:10', NULL);
INSERT INTO `transaction_reward` VALUES (113, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, '01wkDsRcK1-202103031145411614771941680', 69, '2021-03-03 11:45:41', '2021-03-03 11:45:41', NULL);
INSERT INTO `transaction_reward` VALUES (114, 'Member registration on behalf of aripianhazami@gmail.com', 'Referral', 20.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031155021614772502592', 76, '2021-03-03 11:55:02', '2021-03-03 11:55:02', NULL);
INSERT INTO `transaction_reward` VALUES (115, 'Turnonver growth  5% of 200.00 right side registration', 'Turnover Growth', 10.00, 'ZmIgfZ5vHT-202103031157381614772658590', 76, '2021-03-03 11:57:38', '2021-03-03 11:57:38', NULL);
INSERT INTO `transaction_reward` VALUES (116, 'Member registration on behalf of abdurrahmanassudaes9@gmail.com', 'Referral', 100.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031158101614772690626', 35, '2021-03-03 11:58:10', '2021-03-03 11:58:10', NULL);
INSERT INTO `transaction_reward` VALUES (117, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, '32aXJX2cvy-202103031203061614772986213', 35, '2021-03-03 12:03:06', '2021-03-03 12:03:06', NULL);
INSERT INTO `transaction_reward` VALUES (118, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, '32aXJX2cvy-202103031203061614772986213', 7, '2021-03-03 12:03:06', '2021-03-03 12:03:06', NULL);
INSERT INTO `transaction_reward` VALUES (119, 'Member registration on behalf of sul121751@gmail.com', 'Referral', 50.00, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031211461614773506132', 78, '2021-03-03 12:11:46', '2021-03-03 12:11:46', NULL);
INSERT INTO `transaction_reward` VALUES (120, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 20.00, 'uWOJQcFvfq-202103031215051614773705940', 69, '2021-03-03 12:15:05', '2021-03-03 12:15:05', NULL);
INSERT INTO `transaction_reward` VALUES (121, 'Member registration on behalf of datudahe1983@gmail.com', 'Referral', 50.00, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031221211614774081442', 38, '2021-03-03 12:21:21', '2021-03-03 12:21:21', NULL);
INSERT INTO `transaction_reward` VALUES (122, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'XOcG8PB4tV-202103031222411614774161405', 36, '2021-03-03 12:22:41', '2021-03-03 12:22:41', NULL);
INSERT INTO `transaction_reward` VALUES (123, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'XOcG8PB4tV-202103031222411614774161405', 7, '2021-03-03 12:22:41', '2021-03-03 12:22:41', NULL);
INSERT INTO `transaction_reward` VALUES (124, 'Member registration on behalf of sulh8315@gmail.com', 'Referral', 50.00, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031227021614774422648', 78, '2021-03-03 12:27:02', '2021-03-03 12:27:02', NULL);
INSERT INTO `transaction_reward` VALUES (125, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'hwguSLdHTC-202103031230231614774623950', 78, '2021-03-03 12:30:23', '2021-03-03 12:30:23', NULL);
INSERT INTO `transaction_reward` VALUES (126, 'Member registration on behalf of dreamtofuture.76@gmail.com', 'Referral', 50.00, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031232561614774776681', 84, '2021-03-03 12:32:56', '2021-03-03 12:32:56', NULL);
INSERT INTO `transaction_reward` VALUES (127, 'Member registration on behalf of putrawanzaini123@gmail.com', 'Referral', 100.00, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031233081614774788609', 70, '2021-03-03 12:33:08', '2021-03-03 12:33:08', NULL);
INSERT INTO `transaction_reward` VALUES (128, 'Member registration on behalf of revaazahra85@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031233091614774789782', 45, '2021-03-03 12:33:09', '2021-03-03 12:33:09', NULL);
INSERT INTO `transaction_reward` VALUES (129, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'LPdEHbnY6v-202103031234461614774886522', 7, '2021-03-03 12:34:46', '2021-03-03 12:34:46', NULL);
INSERT INTO `transaction_reward` VALUES (130, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'tOYA5LrkjF-202103031238111614775091639', 67, '2021-03-03 12:38:11', '2021-03-03 12:38:11', NULL);
INSERT INTO `transaction_reward` VALUES (131, 'Member registration on behalf of erwinefendi4445@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031238381614775118636', 88, '2021-03-03 12:38:38', '2021-03-03 12:38:38', NULL);
INSERT INTO `transaction_reward` VALUES (132, 'Member registration on behalf of wiendy780@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031242261614775346494', 88, '2021-03-03 12:42:26', '2021-03-03 12:42:26', NULL);
INSERT INTO `transaction_reward` VALUES (133, 'Turnonver growth  5% of 200.00 left side registration', 'Turnover Growth', 10.00, 'nym3eIzD4L-202103031243531614775433828', 88, '2021-03-03 12:43:53', '2021-03-03 12:43:53', NULL);
INSERT INTO `transaction_reward` VALUES (134, 'Member registration on behalf of dinn45544@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031245231614775523841', 48, '2021-03-03 12:45:23', '2021-03-03 12:45:23', NULL);
INSERT INTO `transaction_reward` VALUES (135, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'I5PXRHQl7o-202103031248501614775730599', 8, '2021-03-03 12:48:50', '2021-03-03 12:48:50', NULL);
INSERT INTO `transaction_reward` VALUES (136, 'Member registration on behalf of putrizaskiya9@gmail.com', 'Referral', 100.00, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031253131614775993046', 87, '2021-03-03 12:53:13', '2021-03-03 12:53:13', NULL);
INSERT INTO `transaction_reward` VALUES (137, 'Member registration on behalf of laluabdulmajid120876@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103031256361614776196930', 66, '2021-03-03 12:56:36', '2021-03-03 12:56:36', NULL);
INSERT INTO `transaction_reward` VALUES (138, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'NTozjJJ54o-202103031257161614776236577', 67, '2021-03-03 12:57:16', '2021-03-03 12:57:16', NULL);
INSERT INTO `transaction_reward` VALUES (139, 'Member registration on behalf of nihazaini4@gmail.com', 'Referral', 100.00, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103030105061614776706007', 87, '2021-03-03 13:05:06', '2021-03-03 13:05:06', NULL);
INSERT INTO `transaction_reward` VALUES (140, 'Member registration on behalf of baiqsahuri50@gmail.com', 'Referral', 20.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030109081614776948091', 58, '2021-03-03 13:09:08', '2021-03-03 13:09:08', NULL);
INSERT INTO `transaction_reward` VALUES (141, 'Turnonver growth  5% of 200.00 left side registration', 'Turnover Growth', 10.00, 'lIlCJW4qFv-202103030111161614777076998', 58, '2021-03-03 13:11:17', '2021-03-03 13:11:17', NULL);
INSERT INTO `transaction_reward` VALUES (142, 'Member registration on behalf of muhammadnizar3334@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030114231614777263873', 91, '2021-03-03 13:14:23', '2021-03-03 13:14:23', NULL);
INSERT INTO `transaction_reward` VALUES (143, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'Wd5bMHycTs-202103030115371614777337202', 87, '2021-03-03 13:15:37', '2021-03-03 13:15:37', NULL);
INSERT INTO `transaction_reward` VALUES (144, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'Wd5bMHycTs-202103030115371614777337202', 67, '2021-03-03 13:15:37', '2021-03-03 13:15:37', NULL);
INSERT INTO `transaction_reward` VALUES (145, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, '1Lw779fndf-202103030116331614777393084', 8, '2021-03-03 13:16:33', '2021-03-03 13:16:33', NULL);
INSERT INTO `transaction_reward` VALUES (146, 'Member registration on behalf of halil123haji@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030117301614777450702', 93, '2021-03-03 13:17:30', '2021-03-03 13:17:30', NULL);
INSERT INTO `transaction_reward` VALUES (147, 'Member registration on behalf of hjmurgasih@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030123191614777799811', 96, '2021-03-03 13:23:19', '2021-03-03 13:23:19', NULL);
INSERT INTO `transaction_reward` VALUES (148, 'Member registration on behalf of myunusyuan@gmail.com', 'Referral', 100.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030126381614777998699', 95, '2021-03-03 13:26:38', '2021-03-03 13:26:38', NULL);
INSERT INTO `transaction_reward` VALUES (149, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 10.00, 'HP56bUPvnd-202103030131591614778319726', 58, '2021-03-03 13:31:59', '2021-03-03 13:31:59', NULL);
INSERT INTO `transaction_reward` VALUES (150, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'fGMgWP2VJa-202103030137021614778622187', 8, '2021-03-03 13:37:02', '2021-03-03 13:37:02', NULL);
INSERT INTO `transaction_reward` VALUES (151, 'Member registration on behalf of yunusyuan01@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030138491614778729215', 99, '2021-03-03 13:38:49', '2021-03-03 13:38:49', NULL);
INSERT INTO `transaction_reward` VALUES (152, 'Member registration on behalf of lalupanjipparawangsa@gmail.com', 'Referral', 50.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030142521614778972743', 93, '2021-03-03 13:42:52', '2021-03-03 13:42:52', NULL);
INSERT INTO `transaction_reward` VALUES (153, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 5.00, 'rhmZB9dz87-202103030146171614779177462', 93, '2021-03-03 13:46:17', '2021-03-03 13:46:17', NULL);
INSERT INTO `transaction_reward` VALUES (154, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'rhmZB9dz87-202103030146171614779177462', 58, '2021-03-03 13:46:17', '2021-03-03 13:46:17', NULL);
INSERT INTO `transaction_reward` VALUES (155, 'Member registration on behalf of satryasasak@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030149121614779352653', 98, '2021-03-03 13:49:12', '2021-03-03 13:49:12', NULL);
INSERT INTO `transaction_reward` VALUES (156, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'E9CorrW9dJ-202103030153491614779629147', 8, '2021-03-03 13:53:49', '2021-03-03 13:53:49', NULL);
INSERT INTO `transaction_reward` VALUES (157, 'Member registration on behalf of myunusyuan02@gmail.com', 'Referral', 10.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030153591614779639509', 99, '2021-03-03 13:53:59', '2021-03-03 13:53:59', NULL);
INSERT INTO `transaction_reward` VALUES (158, 'Member registration on behalf of misjaruddin73@gmail.com', 'Referral', 100.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030200391614780039840', 76, '2021-03-03 14:00:39', '2021-03-03 14:00:39', NULL);
INSERT INTO `transaction_reward` VALUES (159, 'Member registration on behalf of lenipuspitadewi97@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030203001614780180453', 57, '2021-03-03 14:03:00', '2021-03-03 14:03:00', NULL);
INSERT INTO `transaction_reward` VALUES (160, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 30.00, 'jUkaAx3z1a-202103030206341614780394145', 69, '2021-03-03 14:06:34', '2021-03-03 14:06:34', NULL);
INSERT INTO `transaction_reward` VALUES (161, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, '7W6a13zMnS-202103030208471614780527147', 99, '2021-03-03 14:08:47', '2021-03-03 14:08:47', NULL);
INSERT INTO `transaction_reward` VALUES (162, 'Member registration on behalf of Opickchocolatos007@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030212401614780760780', 105, '2021-03-03 14:12:40', '2021-03-03 14:12:40', NULL);
INSERT INTO `transaction_reward` VALUES (163, 'Member registration on behalf of muaddah77@gmail.com', 'Referral', 50.00, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030222191614781339817', 104, '2021-03-03 14:22:19', '2021-03-03 14:22:19', NULL);
INSERT INTO `transaction_reward` VALUES (164, 'Member registration on behalf of Bangfikri007@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030224051614781445270', 106, '2021-03-03 14:24:05', '2021-03-03 14:24:05', NULL);
INSERT INTO `transaction_reward` VALUES (165, 'Member registration on behalf of muharuddin968@gmail.com', 'Referral', 50.00, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030228561614781736405', 104, '2021-03-03 14:28:56', '2021-03-03 14:28:56', NULL);
INSERT INTO `transaction_reward` VALUES (166, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '5FgKdey2Mx-202103030230531614781853380', 104, '2021-03-03 14:30:53', '2021-03-03 14:30:53', NULL);
INSERT INTO `transaction_reward` VALUES (167, 'Member registration on behalf of lerylesmana10@gmail.com', 'Referral', 20.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030237251614782245494', 55, '2021-03-03 14:37:25', '2021-03-03 14:37:25', NULL);
INSERT INTO `transaction_reward` VALUES (168, 'Member registration on behalf of Opickchocolatos008@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030239291614782369498', 106, '2021-03-03 14:39:29', '2021-03-03 14:39:29', NULL);
INSERT INTO `transaction_reward` VALUES (169, 'Member registration on behalf of luckybestrich@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030309221614784162695', 16, '2021-03-03 15:09:22', '2021-03-03 15:09:22', NULL);
INSERT INTO `transaction_reward` VALUES (170, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'dgKWplSL75-202103030317171614784637893', 16, '2021-03-03 15:17:17', '2021-03-03 15:17:17', NULL);
INSERT INTO `transaction_reward` VALUES (171, 'Member registration on behalf of l.uckybestrich@gmail.com', 'Referral', 500.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030319221614784762947', 112, '2021-03-03 15:19:22', '2021-03-03 15:19:22', NULL);
INSERT INTO `transaction_reward` VALUES (172, 'Member registration on behalf of Opickchocolatos009@gmail.com', 'Referral', 100.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030320381614784838919', 106, '2021-03-03 15:20:38', '2021-03-03 15:20:38', NULL);
INSERT INTO `transaction_reward` VALUES (173, 'Turnonver growth  5% of 5,000.00 left side registration', 'Turnover Growth', 25.00, 'UyMMCF34Iz-202103030322111614784931787', 16, '2021-03-03 15:22:11', '2021-03-03 15:22:11', NULL);
INSERT INTO `transaction_reward` VALUES (174, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'G3RYirSQza-202103030323431614785023561', 106, '2021-03-03 15:23:43', '2021-03-03 15:23:43', NULL);
INSERT INTO `transaction_reward` VALUES (175, 'Member registration on behalf of lu.ckybestrich@gmail.com', 'Referral', 500.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030324481614785088140', 113, '2021-03-03 15:24:48', '2021-03-03 15:24:48', NULL);
INSERT INTO `transaction_reward` VALUES (176, 'Member registration on behalf of luc.kybestrich@gmail.com', 'Referral', 500.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030334211614785661159', 113, '2021-03-03 15:34:21', '2021-03-03 15:34:21', NULL);
INSERT INTO `transaction_reward` VALUES (177, 'Turnonver growth  5% of 5,000.00 right side registration', 'Turnover Growth', 250.00, 'rYIa0Q8mvx-202103030336081614785768969', 113, '2021-03-03 15:36:09', '2021-03-03 15:36:09', NULL);
INSERT INTO `transaction_reward` VALUES (178, 'Member registration on behalf of m.otor.hendro@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030349501614786590393', 19, '2021-03-03 15:49:50', '2021-03-03 15:49:50', NULL);
INSERT INTO `transaction_reward` VALUES (179, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '8Ewupp7JoH-202103030356261614786986291', 16, '2021-03-03 15:56:26', '2021-03-03 15:56:26', NULL);
INSERT INTO `transaction_reward` VALUES (180, 'Member registration on behalf of mo.tor.hendro@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030358581614787138801', 19, '2021-03-03 15:58:58', '2021-03-03 15:58:58', NULL);
INSERT INTO `transaction_reward` VALUES (181, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '6CB9BV3o4H-202103030401381614787298930', 19, '2021-03-03 16:01:38', '2021-03-03 16:01:38', NULL);
INSERT INTO `transaction_reward` VALUES (182, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '6CB9BV3o4H-202103030401381614787298930', 16, '2021-03-03 16:01:38', '2021-03-03 16:01:38', NULL);
INSERT INTO `transaction_reward` VALUES (183, 'Member registration on behalf of fgxpressindonesia@gmail.com', 'Referral', 200.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030404251614787465396', 115, '2021-03-03 16:04:25', '2021-03-03 16:04:25', NULL);
INSERT INTO `transaction_reward` VALUES (184, 'Member registration on behalf of f.gxpressindonesia@gmail.com', 'Referral', 200.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030409311614787771122', 115, '2021-03-03 16:09:31', '2021-03-03 16:09:31', NULL);
INSERT INTO `transaction_reward` VALUES (185, 'Turnonver growth  5% of 2,000.00 right side registration', 'Turnover Growth', 100.00, 'HdkaenddoU-202103030411181614787878472', 115, '2021-03-03 16:11:18', '2021-03-03 16:11:18', NULL);
INSERT INTO `transaction_reward` VALUES (186, 'Member registration on behalf of emerents83@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030415211614788121069', 117, '2021-03-03 16:15:21', '2021-03-03 16:15:21', NULL);
INSERT INTO `transaction_reward` VALUES (187, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, '0aK4yyVJTi-202103030417181614788238124', 16, '2021-03-03 16:17:18', '2021-03-03 16:17:18', NULL);
INSERT INTO `transaction_reward` VALUES (188, 'Member registration on behalf of e.merents83@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030418591614788339096', 121, '2021-03-03 16:18:59', '2021-03-03 16:18:59', NULL);
INSERT INTO `transaction_reward` VALUES (189, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'xa6DrWpghO-202103030420291614788429335', 16, '2021-03-03 16:20:29', '2021-03-03 16:20:29', NULL);
INSERT INTO `transaction_reward` VALUES (190, 'Member registration on behalf of em.erents83@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030420531614788453044', 121, '2021-03-03 16:20:53', '2021-03-03 16:20:53', NULL);
INSERT INTO `transaction_reward` VALUES (191, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'BeakYLcRCF-202103030422241614788544946', 121, '2021-03-03 16:22:24', '2021-03-03 16:22:24', NULL);
INSERT INTO `transaction_reward` VALUES (192, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'BeakYLcRCF-202103030422241614788544946', 16, '2021-03-03 16:22:24', '2021-03-03 16:22:24', NULL);
INSERT INTO `transaction_reward` VALUES (193, 'Member registration on behalf of yantho.manafe@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030426191614788779239', 123, '2021-03-03 16:26:19', '2021-03-03 16:26:19', NULL);
INSERT INTO `transaction_reward` VALUES (194, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'hmvNozMDD4-202103030427301614788850178', 16, '2021-03-03 16:27:30', '2021-03-03 16:27:30', NULL);
INSERT INTO `transaction_reward` VALUES (195, 'Member registration on behalf of y.antho.manafe@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030428541614788934082', 124, '2021-03-03 16:28:54', '2021-03-03 16:28:54', NULL);
INSERT INTO `transaction_reward` VALUES (196, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'DhdQnqQrEV-202103030429421614788982583', 16, '2021-03-03 16:29:42', '2021-03-03 16:29:42', NULL);
INSERT INTO `transaction_reward` VALUES (197, 'Member registration on behalf of ya.ntho.manafe@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030430381614789038317', 124, '2021-03-03 16:30:38', '2021-03-03 16:30:38', NULL);
INSERT INTO `transaction_reward` VALUES (198, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'r6rak3u7ji-202103030431431614789103863', 124, '2021-03-03 16:31:43', '2021-03-03 16:31:43', NULL);
INSERT INTO `transaction_reward` VALUES (199, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'r6rak3u7ji-202103030431431614789103863', 16, '2021-03-03 16:31:43', '2021-03-03 16:31:43', NULL);
INSERT INTO `transaction_reward` VALUES (200, 'Member registration on behalf of fg.xpressindonesia@gmail.com', 'Referral', 200.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030432591614789179733', 116, '2021-03-03 16:32:59', '2021-03-03 16:32:59', NULL);
INSERT INTO `transaction_reward` VALUES (201, 'Turnonver growth  5% of 2,000.00 right side registration', 'Turnover Growth', 100.00, 'eM0uTjcGsZ-202103030434151614789255220', 113, '2021-03-03 16:34:15', '2021-03-03 16:34:15', NULL);
INSERT INTO `transaction_reward` VALUES (202, 'Member registration on behalf of fgx.pressindonesia@gmail.com', 'Referral', 200.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030436261614789386279', 116, '2021-03-03 16:36:26', '2021-03-03 16:36:26', NULL);
INSERT INTO `transaction_reward` VALUES (203, 'Turnonver growth  5% of 2,000.00 right side registration', 'Turnover Growth', 100.00, 'x628uXLZLB-202103030437591614789479554', 116, '2021-03-03 16:37:59', '2021-03-03 16:37:59', NULL);
INSERT INTO `transaction_reward` VALUES (204, 'Turnonver growth  5% of 2,000.00 right side registration', 'Turnover Growth', 100.00, 'x628uXLZLB-202103030437591614789479554', 113, '2021-03-03 16:37:59', '2021-03-03 16:37:59', NULL);
INSERT INTO `transaction_reward` VALUES (205, 'Member registration on behalf of iketutarantikabali@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030443121614789792717', 118, '2021-03-03 16:43:12', '2021-03-03 16:43:12', NULL);
INSERT INTO `transaction_reward` VALUES (206, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'byNUl7P3Ln-202103030445441614789944561', 19, '2021-03-03 16:45:44', '2021-03-03 16:45:44', NULL);
INSERT INTO `transaction_reward` VALUES (207, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'byNUl7P3Ln-202103030445441614789944561', 16, '2021-03-03 16:45:44', '2021-03-03 16:45:44', NULL);
INSERT INTO `transaction_reward` VALUES (208, 'Member registration on behalf of al.iassebatik@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030451191614790279751', 14, '2021-03-03 16:51:19', '2021-03-03 16:51:19', NULL);
INSERT INTO `transaction_reward` VALUES (209, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, 'zhsovKACRh-202103030453161614790396009', 14, '2021-03-03 16:53:16', '2021-03-03 16:53:16', NULL);
INSERT INTO `transaction_reward` VALUES (210, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'zhsovKACRh-202103030453161614790396009', 5, '2021-03-03 16:53:16', '2021-03-03 16:53:16', NULL);
INSERT INTO `transaction_reward` VALUES (211, 'Member registration on behalf of upixbase180@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030510141614791414180', 14, '2021-03-03 17:10:14', '2021-03-03 17:10:14', NULL);
INSERT INTO `transaction_reward` VALUES (212, 'Member registration on behalf of mirwanbone@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030735591614800159838', 39, '2021-03-03 19:35:59', '2021-03-03 19:35:59', NULL);
INSERT INTO `transaction_reward` VALUES (213, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, '53q1Elv7iD-202103030739081614800348280', 5, '2021-03-03 19:39:08', '2021-03-03 19:39:08', NULL);
INSERT INTO `transaction_reward` VALUES (214, 'Member registration on behalf of m.irwanbone@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030743571614800637269', 132, '2021-03-03 19:43:57', '2021-03-03 19:43:57', NULL);
INSERT INTO `transaction_reward` VALUES (215, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'nPv9svd0MC-202103030745581614800758694', 5, '2021-03-03 19:45:58', '2021-03-03 19:45:58', NULL);
INSERT INTO `transaction_reward` VALUES (216, 'Member registration on behalf of mercusuar511@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030753111614801191607', 133, '2021-03-03 19:53:11', '2021-03-03 19:53:11', NULL);
INSERT INTO `transaction_reward` VALUES (217, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'w5H9CkPtTW-202103030805071614801907618', 5, '2021-03-03 20:05:07', '2021-03-03 20:05:07', NULL);
INSERT INTO `transaction_reward` VALUES (218, 'Member registration on behalf of powerbetece@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030814211614802461377', 133, '2021-03-03 20:14:21', '2021-03-03 20:14:21', NULL);
INSERT INTO `transaction_reward` VALUES (219, 'Member registration on behalf of m.ercusuar511@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030816491614802609050', 134, '2021-03-03 20:16:49', '2021-03-03 20:16:49', NULL);
INSERT INTO `transaction_reward` VALUES (220, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, '6sgW7jKgk9-202103030817271614802647559', 133, '2021-03-03 20:17:27', '2021-03-03 20:17:27', NULL);
INSERT INTO `transaction_reward` VALUES (221, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, '6sgW7jKgk9-202103030817271614802647559', 5, '2021-03-03 20:17:27', '2021-03-03 20:17:27', NULL);
INSERT INTO `transaction_reward` VALUES (222, 'Member registration on behalf of me.rcusuar511@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030818241614802704125', 134, '2021-03-03 20:18:24', '2021-03-03 20:18:24', NULL);
INSERT INTO `transaction_reward` VALUES (223, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'DH5DfG9c4V-202103030823551614803035155', 5, '2021-03-03 20:23:55', '2021-03-03 20:23:55', NULL);
INSERT INTO `transaction_reward` VALUES (224, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'LvyUz9byFK-202103030826011614803161363', 134, '2021-03-03 20:26:01', '2021-03-03 20:26:01', NULL);
INSERT INTO `transaction_reward` VALUES (225, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'LvyUz9byFK-202103030826011614803161363', 5, '2021-03-03 20:26:01', '2021-03-03 20:26:01', NULL);
INSERT INTO `transaction_reward` VALUES (226, 'Member registration on behalf of pow.erbetece@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030832361614803556924', 135, '2021-03-03 20:32:36', '2021-03-03 20:32:36', NULL);
INSERT INTO `transaction_reward` VALUES (227, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'SoWEnUXkzV-202103030834361614803676410', 133, '2021-03-03 20:34:36', '2021-03-03 20:34:36', NULL);
INSERT INTO `transaction_reward` VALUES (228, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'SoWEnUXkzV-202103030834361614803676410', 5, '2021-03-03 20:34:36', '2021-03-03 20:34:36', NULL);
INSERT INTO `transaction_reward` VALUES (229, 'Member registration on behalf of powe.rbetece@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030840001614804000718', 135, '2021-03-03 20:40:00', '2021-03-03 20:40:00', NULL);
INSERT INTO `transaction_reward` VALUES (230, 'Member registration on behalf of asis.suandi26@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030842421614804162694', 39, '2021-03-03 20:42:42', '2021-03-03 20:42:42', NULL);
INSERT INTO `transaction_reward` VALUES (231, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'iBUqYFEIzv-202103030844381614804278023', 135, '2021-03-03 20:44:38', '2021-03-03 20:44:38', NULL);
INSERT INTO `transaction_reward` VALUES (232, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'iBUqYFEIzv-202103030844381614804278023', 133, '2021-03-03 20:44:38', '2021-03-03 20:44:38', NULL);
INSERT INTO `transaction_reward` VALUES (233, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'iBUqYFEIzv-202103030844381614804278023', 5, '2021-03-03 20:44:38', '2021-03-03 20:44:38', NULL);
INSERT INTO `transaction_reward` VALUES (234, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'qRTMLAGuGV-202103030846511614804411086', 39, '2021-03-03 20:46:51', '2021-03-03 20:46:51', NULL);
INSERT INTO `transaction_reward` VALUES (235, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'qRTMLAGuGV-202103030846511614804411086', 5, '2021-03-03 20:46:51', '2021-03-03 20:46:51', NULL);
INSERT INTO `transaction_reward` VALUES (236, 'Member registration on behalf of a.sis.suandi26@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030850071614804607767', 140, '2021-03-03 20:50:07', '2021-03-03 20:50:07', NULL);
INSERT INTO `transaction_reward` VALUES (237, 'Member registration on behalf of as.is.suandi26@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030852371614804757028', 140, '2021-03-03 20:52:37', '2021-03-03 20:52:37', NULL);
INSERT INTO `transaction_reward` VALUES (238, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'G19StjYAPE-202103030853491614804829662', 39, '2021-03-03 20:53:49', '2021-03-03 20:53:49', NULL);
INSERT INTO `transaction_reward` VALUES (239, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'G19StjYAPE-202103030853491614804829662', 5, '2021-03-03 20:53:49', '2021-03-03 20:53:49', NULL);
INSERT INTO `transaction_reward` VALUES (240, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'VaCX3feqZv-202103030855121614804912315', 140, '2021-03-03 20:55:12', '2021-03-03 20:55:12', NULL);
INSERT INTO `transaction_reward` VALUES (241, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'VaCX3feqZv-202103030855121614804912315', 39, '2021-03-03 20:55:12', '2021-03-03 20:55:12', NULL);
INSERT INTO `transaction_reward` VALUES (242, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'VaCX3feqZv-202103030855121614804912315', 5, '2021-03-03 20:55:12', '2021-03-03 20:55:12', NULL);
INSERT INTO `transaction_reward` VALUES (243, 'Member registration on behalf of alia.ssebatik@gmail.com', 'Referral', 10.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030859031614805143554', 142, '2021-03-03 20:59:03', '2021-03-03 20:59:03', NULL);
INSERT INTO `transaction_reward` VALUES (244, 'Turnonver growth  5% of 100.00 right side registration', 'Turnover Growth', 5.00, 'ca1KWl4zZZ-202103030902131614805333022', 39, '2021-03-03 21:02:13', '2021-03-03 21:02:13', NULL);
INSERT INTO `transaction_reward` VALUES (245, 'Turnonver growth  5% of 100.00 left side registration', 'Turnover Growth', 5.00, 'ca1KWl4zZZ-202103030902131614805333022', 5, '2021-03-03 21:02:13', '2021-03-03 21:02:13', NULL);
INSERT INTO `transaction_reward` VALUES (246, 'Member registration on behalf of karmilawilis@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030904401614805480663', 143, '2021-03-03 21:04:40', '2021-03-03 21:04:40', NULL);
INSERT INTO `transaction_reward` VALUES (247, 'Turnonver growth  5% of 1,000.00 right side registration', 'Turnover Growth', 50.00, 'tVyBadtVgD-202103030909351614805775473', 39, '2021-03-03 21:09:35', '2021-03-03 21:09:35', NULL);
INSERT INTO `transaction_reward` VALUES (248, 'Turnonver growth  5% of 1,000.00 left side registration', 'Turnover Growth', 50.00, 'tVyBadtVgD-202103030909351614805775473', 5, '2021-03-03 21:09:35', '2021-03-03 21:09:35', NULL);
INSERT INTO `transaction_reward` VALUES (249, 'Member registration on behalf of k.armilawilis@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030912361614805956664', 144, '2021-03-03 21:12:36', '2021-03-03 21:12:36', NULL);
INSERT INTO `transaction_reward` VALUES (250, 'Member registration on behalf of ka.rmilawilis@gmail.com', 'Referral', 50.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030914361614806076601', 144, '2021-03-03 21:14:36', '2021-03-03 21:14:36', NULL);
INSERT INTO `transaction_reward` VALUES (251, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 10.00, 'mbPyWodMov-202103030917461614806266603', 39, '2021-03-03 21:17:46', '2021-03-03 21:17:46', NULL);
INSERT INTO `transaction_reward` VALUES (252, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, 'mbPyWodMov-202103030917461614806266603', 5, '2021-03-03 21:17:46', '2021-03-03 21:17:46', NULL);
INSERT INTO `transaction_reward` VALUES (253, 'Turnonver growth  5% of 500.00 right side registration', 'Turnover Growth', 25.00, '8h0EDagpeV-202103030919021614806342689', 144, '2021-03-03 21:19:02', '2021-03-03 21:19:02', NULL);
INSERT INTO `transaction_reward` VALUES (254, 'Turnonver growth  5% of 500.00 left side registration', 'Turnover Growth', 25.00, '8h0EDagpeV-202103030919021614806342689', 5, '2021-03-03 21:19:02', '2021-03-03 21:19:02', NULL);
INSERT INTO `transaction_reward` VALUES (255, 'Member registration on behalf of hamdanbhdn@yahoo.com', 'Referral', 20.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031152451614815565087', 46, '2021-03-03 23:52:45', '2021-03-03 23:52:45', NULL);
INSERT INTO `transaction_reward` VALUES (256, 'Member registration on behalf of huminiji543@gmail.com', 'Referral', 100.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103041203511614816231694', 19, '2021-03-04 00:03:51', '2021-03-04 00:03:51', NULL);

-- ----------------------------
-- Table structure for transaction_reward_pin
-- ----------------------------
DROP TABLE IF EXISTS `transaction_reward_pin`;
CREATE TABLE `transaction_reward_pin`  (
  `transaction_reward_pin_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_reward_pin_information` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `transaction_reward_pin_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `transaction_reward_pin_amount` decimal(65, 2) NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_reward_pin_id`) USING BTREE,
  INDEX `bonus_pin_pengguna_id_fkey`(`member_id`) USING BTREE,
  INDEX `bonus_pin_ibfk_1`(`transaction_id`) USING BTREE,
  CONSTRAINT `transaction_reward_pin_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_reward_pin_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transaction_reward_pin
-- ----------------------------
INSERT INTO `transaction_reward_pin` VALUES (1, 'Buy 2 PINs by GAJAHMADA', NULL, 14.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103010359301614614370946', 6, '2021-03-01 15:59:30', '2021-03-01 15:59:30', NULL);
INSERT INTO `transaction_reward_pin` VALUES (2, 'Buy 2 PINs by andifajarlah@gmail.com', NULL, 14.00, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103010942201614634940463', 1, '2021-03-01 21:42:20', '2021-03-01 21:42:20', NULL);
INSERT INTO `transaction_reward_pin` VALUES (3, 'Buy 2 PINs by SuperTeam', NULL, 14.00, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3202103020634051614666845210', 3, '2021-03-02 06:34:05', '2021-03-02 06:34:05', NULL);
INSERT INTO `transaction_reward_pin` VALUES (4, 'Buy 2 PINs by SemutMerah', NULL, 14.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020639151614667155052', 7, '2021-03-02 06:39:15', '2021-03-02 06:39:15', NULL);
INSERT INTO `transaction_reward_pin` VALUES (5, 'Buy 50 PINs by PapaOnline', NULL, 350.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103020710361614669036878', 5, '2021-03-02 07:10:36', '2021-03-02 07:10:36', NULL);
INSERT INTO `transaction_reward_pin` VALUES (6, 'Buy 1 PIN1 by andifajarlah@gmail.com', NULL, 7.00, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o202103020728551614670135184', 1, '2021-03-02 07:28:55', '2021-03-02 07:28:55', NULL);
INSERT INTO `transaction_reward_pin` VALUES (7, 'Buy 1 PIN1 by Team01', NULL, 7.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103020741481614670908152', 3, '2021-03-02 07:41:48', '2021-03-02 07:41:48', NULL);
INSERT INTO `transaction_reward_pin` VALUES (8, 'Buy 1 PIN by Super01', NULL, 7.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103020747231614671243399', 3, '2021-03-02 07:47:23', '2021-03-02 07:47:23', NULL);
INSERT INTO `transaction_reward_pin` VALUES (10, 'Buy 1 PIN by Team02', NULL, 7.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103020818201614673100792', 3, '2021-03-02 08:18:20', '2021-03-02 08:18:20', NULL);
INSERT INTO `transaction_reward_pin` VALUES (11, 'Buy 2 PINs by GUNTURTKER', NULL, 14.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103020825351614673535525', 8, '2021-03-02 08:25:35', '2021-03-02 08:25:35', NULL);
INSERT INTO `transaction_reward_pin` VALUES (13, 'Buy 1 PIN by Super01', NULL, 7.00, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ202103021049251614682165833', 3, '2021-03-02 10:49:25', '2021-03-02 10:49:25', NULL);
INSERT INTO `transaction_reward_pin` VALUES (15, 'Buy 1 PIN by Team01', NULL, 7.00, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf202103021134191614684859703', 3, '2021-03-02 11:34:19', '2021-03-02 11:34:19', NULL);
INSERT INTO `transaction_reward_pin` VALUES (17, 'Buy 1 PIN by Team02', NULL, 7.00, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX202103021140551614685255520', 3, '2021-03-02 11:40:55', '2021-03-02 11:40:55', NULL);
INSERT INTO `transaction_reward_pin` VALUES (19, 'Buy 2 PINs by Super02', NULL, 14.00, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH202103021155391614686139568', 3, '2021-03-02 11:55:39', '2021-03-02 11:55:39', NULL);
INSERT INTO `transaction_reward_pin` VALUES (21, 'Buy 2 PINs by JENDRAL', NULL, 14.00, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe202103021231341614688294146', 3, '2021-03-02 12:31:34', '2021-03-02 12:31:34', NULL);
INSERT INTO `transaction_reward_pin` VALUES (22, 'Buy 5 PINs by SemutMerah', NULL, 35.00, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE202103020136351614692195119', 7, '2021-03-02 13:36:35', '2021-03-02 13:36:35', NULL);
INSERT INTO `transaction_reward_pin` VALUES (23, 'Buy 1 PIN by SM01202102', NULL, 3.50, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020155051614693305549', 7, '2021-03-02 13:55:05', '2021-03-02 13:55:05', NULL);
INSERT INTO `transaction_reward_pin` VALUES (24, 'Buy 1 PIN by SM01202102', NULL, 3.50, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020155051614693305549', 7, '2021-03-02 13:55:05', '2021-03-02 13:55:05', NULL);
INSERT INTO `transaction_reward_pin` VALUES (26, 'Buy 1 PIN by mzwfam03', NULL, 7.00, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx202103020300241614697224268', 7, '2021-03-02 15:00:24', '2021-03-02 15:00:24', NULL);
INSERT INTO `transaction_reward_pin` VALUES (28, 'Buy 1 PIN by SM_Team06', NULL, 7.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103020317521614698272273', 7, '2021-03-02 15:17:52', '2021-03-02 15:17:52', NULL);
INSERT INTO `transaction_reward_pin` VALUES (30, 'Buy 2 PINs by Taoke_01', NULL, 14.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103020339581614699598012', 7, '2021-03-02 15:39:58', '2021-03-02 15:39:58', NULL);
INSERT INTO `transaction_reward_pin` VALUES (32, 'Buy 2 PINs by PapaOnline2', NULL, 14.00, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J202103020355561614700556599', 5, '2021-03-02 15:55:56', '2021-03-02 15:55:56', NULL);
INSERT INTO `transaction_reward_pin` VALUES (34, 'Buy 2 PINs by MUHAMMAD', NULL, 14.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103020610131614708613998', 3, '2021-03-02 18:10:14', '2021-03-02 18:10:14', NULL);
INSERT INTO `transaction_reward_pin` VALUES (36, 'Buy 1 PIN by SM01202102', NULL, 7.00, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc202103020753101614714790174', 7, '2021-03-02 19:53:10', '2021-03-02 19:53:10', NULL);
INSERT INTO `transaction_reward_pin` VALUES (37, 'Buy 6 PINs by sugihmotah01', NULL, 42.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103021103431614726223871', 43, '2021-03-02 23:03:43', '2021-03-02 23:03:43', NULL);
INSERT INTO `transaction_reward_pin` VALUES (38, 'Buy 2 PINs by GUNTURTKER', NULL, 14.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103021116081614726968602', 8, '2021-03-02 23:16:08', '2021-03-02 23:16:08', NULL);
INSERT INTO `transaction_reward_pin` VALUES (39, 'Buy 2 PINs by Excellent', NULL, 14.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103021154311614729271611', 4, '2021-03-02 23:54:31', '2021-03-02 23:54:31', NULL);
INSERT INTO `transaction_reward_pin` VALUES (40, 'Buy 2 PINs by Excellent', NULL, 14.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103031220041614730804801', 4, '2021-03-03 00:20:04', '2021-03-03 00:20:04', NULL);
INSERT INTO `transaction_reward_pin` VALUES (41, 'Buy 1 PIN by GAJAHMADA', NULL, 7.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030110461614733846803', 6, '2021-03-03 01:10:46', '2021-03-03 01:10:46', NULL);
INSERT INTO `transaction_reward_pin` VALUES (42, 'Buy 2 PINs by Excellent', NULL, 14.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030201011614736861715', 4, '2021-03-03 02:01:01', '2021-03-03 02:01:01', NULL);
INSERT INTO `transaction_reward_pin` VALUES (43, 'Buy 4 PINs by Excellent', NULL, 28.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030251231614739883728', 4, '2021-03-03 02:51:23', '2021-03-03 02:51:23', NULL);
INSERT INTO `transaction_reward_pin` VALUES (44, 'Buy 2 PINs by GUNTURTKER', NULL, 14.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030334201614742460962', 8, '2021-03-03 03:34:20', '2021-03-03 03:34:20', NULL);
INSERT INTO `transaction_reward_pin` VALUES (45, 'Buy 1 PIN by GAJAHMADA', NULL, 7.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030527291614749249916', 6, '2021-03-03 05:27:29', '2021-03-03 05:27:29', NULL);
INSERT INTO `transaction_reward_pin` VALUES (46, 'Buy 1 PIN by GAJAHMADA', NULL, 7.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103030534171614749657857', 6, '2021-03-03 05:34:17', '2021-03-03 05:34:17', NULL);
INSERT INTO `transaction_reward_pin` VALUES (47, 'Buy 1 PIN by GUNTURTKER', NULL, 7.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030731401614756700674', 8, '2021-03-03 07:31:40', '2021-03-03 07:31:40', NULL);
INSERT INTO `transaction_reward_pin` VALUES (48, 'Buy 5 PINs by GUNTURTKER', NULL, 35.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030757471614758267410', 8, '2021-03-03 07:57:47', '2021-03-03 07:57:47', NULL);
INSERT INTO `transaction_reward_pin` VALUES (49, 'Buy 5 PINs by GUNTURTKER', NULL, 35.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030923171614763397679', 8, '2021-03-03 09:23:17', '2021-03-03 09:23:17', NULL);
INSERT INTO `transaction_reward_pin` VALUES (50, 'Buy 2 PINs by SM_Team08', NULL, 7.00, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030931591614763919051', 7, '2021-03-03 09:31:59', '2021-03-03 09:31:59', NULL);
INSERT INTO `transaction_reward_pin` VALUES (51, 'Buy 2 PINs by SM_Team08', NULL, 7.00, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7202103030931591614763919051', 7, '2021-03-03 09:31:59', '2021-03-03 09:31:59', NULL);
INSERT INTO `transaction_reward_pin` VALUES (53, 'Buy 2 PINs by Chikofam_a', NULL, 14.00, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9202103030957261614765446225', 7, '2021-03-03 09:57:26', '2021-03-03 09:57:26', NULL);
INSERT INTO `transaction_reward_pin` VALUES (55, 'Buy 1 PIN by MUHAMMAD', NULL, 7.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031028561614767336824', 3, '2021-03-03 10:28:56', '2021-03-03 10:28:56', NULL);
INSERT INTO `transaction_reward_pin` VALUES (57, 'Buy 3 PINs by MUHAMMAD', NULL, 21.00, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM202103031040461614768046633', 3, '2021-03-03 10:40:46', '2021-03-03 10:40:46', NULL);
INSERT INTO `transaction_reward_pin` VALUES (59, 'Buy 3 PINs by HAMZAH01', NULL, 21.00, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT202103031103001614769380684', 3, '2021-03-03 11:03:00', '2021-03-03 11:03:00', NULL);
INSERT INTO `transaction_reward_pin` VALUES (60, 'Buy 1 PIN by GAJAHMADA', NULL, 7.00, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS202103031111511614769911732', 6, '2021-03-03 11:11:51', '2021-03-03 11:11:51', NULL);
INSERT INTO `transaction_reward_pin` VALUES (62, 'Buy 2 PINs by smteam$', NULL, 14.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031114291614770069895', 7, '2021-03-03 11:14:29', '2021-03-03 11:14:29', NULL);
INSERT INTO `transaction_reward_pin` VALUES (64, 'Buy 1 PIN by Taoke_01', NULL, 7.00, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax202103031135281614771328153', 7, '2021-03-03 11:35:28', '2021-03-03 11:35:28', NULL);
INSERT INTO `transaction_reward_pin` VALUES (66, 'Buy 1 PIN by smteam$', NULL, 7.00, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M202103031139171614771557705', 7, '2021-03-03 11:39:17', '2021-03-03 11:39:17', NULL);
INSERT INTO `transaction_reward_pin` VALUES (68, 'Buy 2 PINs by Rinjanilombok', NULL, 14.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103031140191614771619644', 7, '2021-03-03 11:40:19', '2021-03-03 11:40:19', NULL);
INSERT INTO `transaction_reward_pin` VALUES (70, 'Buy 1 PIN by SM_Team06', NULL, 7.00, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx202103031156071614772567928', 7, '2021-03-03 11:56:07', '2021-03-03 11:56:07', NULL);
INSERT INTO `transaction_reward_pin` VALUES (72, 'Buy 2 PINs by Leadersaok', NULL, 14.00, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U202103031207071614773227758', 7, '2021-03-03 12:07:07', '2021-03-03 12:07:07', NULL);
INSERT INTO `transaction_reward_pin` VALUES (74, 'Buy 1 PIN by Taoke_03', NULL, 7.00, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa202103031219011614773941214', 7, '2021-03-03 12:19:01', '2021-03-03 12:19:01', NULL);
INSERT INTO `transaction_reward_pin` VALUES (76, 'Buy 1 PIN by datudahe', NULL, 7.00, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU202103031229401614774580157', 7, '2021-03-03 12:29:40', '2021-03-03 12:29:40', NULL);
INSERT INTO `transaction_reward_pin` VALUES (78, 'Buy 2 PINs by smteam#', NULL, 14.00, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp202103031230251614774625351', 7, '2021-03-03 12:30:25', '2021-03-03 12:30:25', NULL);
INSERT INTO `transaction_reward_pin` VALUES (80, 'Buy 2 PINs by LBC_SMzaini', NULL, 14.00, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa202103031250211614775821683', 7, '2021-03-03 12:50:21', '2021-03-03 12:50:21', NULL);
INSERT INTO `transaction_reward_pin` VALUES (81, 'Buy 5 PINs by GUNTURTKER', NULL, 35.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030104081614776648542', 8, '2021-03-03 13:04:08', '2021-03-03 13:04:08', NULL);
INSERT INTO `transaction_reward_pin` VALUES (82, 'Buy 5 PINs by GUNTURTKER', NULL, 35.00, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz202103030135211614778521844', 8, '2021-03-03 13:35:21', '2021-03-03 13:35:21', NULL);
INSERT INTO `transaction_reward_pin` VALUES (83, 'Buy 1 PIN by Excellent', NULL, 7.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030156331614779793010', 4, '2021-03-03 13:56:33', '2021-03-03 13:56:33', NULL);
INSERT INTO `transaction_reward_pin` VALUES (85, 'Buy 1 PIN by Rinjanilombok', NULL, 7.00, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq202103030158531614779933910', 7, '2021-03-03 13:58:53', '2021-03-03 13:58:53', NULL);
INSERT INTO `transaction_reward_pin` VALUES (87, 'Buy 2 PINs by Ihsan1997', NULL, 14.00, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT202103030219261614781166239', 7, '2021-03-03 14:19:26', '2021-03-03 14:19:26', NULL);
INSERT INTO `transaction_reward_pin` VALUES (88, 'Buy 1 PIN by Excellent', NULL, 7.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030226251614781585938', 4, '2021-03-03 14:26:25', '2021-03-03 14:26:25', NULL);
INSERT INTO `transaction_reward_pin` VALUES (89, 'Buy 1 PIN by Excellent', NULL, 7.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030313331614784413864', 4, '2021-03-03 15:13:33', '2021-03-03 15:13:33', NULL);
INSERT INTO `transaction_reward_pin` VALUES (90, 'Buy 11 PINs by Excellent', NULL, 77.00, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r202103030328381614785318146', 4, '2021-03-03 15:28:38', '2021-03-03 15:28:38', NULL);
INSERT INTO `transaction_reward_pin` VALUES (91, 'Buy 50 PINs by PapaOnline', NULL, 350.00, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq202103030423001614788580043', 5, '2021-03-03 16:23:00', '2021-03-03 16:23:00', NULL);
INSERT INTO `transaction_reward_pin` VALUES (92, 'Buy 2 PINs by sugihmotah01', NULL, 14.00, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3202103031150271614815427575', 43, '2021-03-03 23:50:27', '2021-03-03 23:50:27', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_nick` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_password` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_photo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `user_wallet` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `remember_token` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `pengguna_uid`(`user_nick`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'administrator', '$2y$10$zmh8Q8LInBS1p3eYvYhIQeLMzDIWObcZtAf5UCNCJ9VoDRsL2SN4q', 'Administrator', NULL, 'LKuDTamd3pcLYv96LavWtMQHAZqvXFZCKV', NULL, '2021-01-14 00:00:00', '2021-03-03 23:03:27', NULL);

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet`  (
  `wallet_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wallet_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `main` tinyint(1) NOT NULL DEFAULT 1,
  `member_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`wallet_id`) USING BTREE,
  UNIQUE INDEX `wallet_wallet_kode_idx`(`wallet_address`) USING BTREE,
  INDEX `wallet_ibfk_1`(`member_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet
-- ----------------------------
INSERT INTO `wallet` VALUES (5, 'LgC2aTGMnzK8346Yek5CLYTZMqqErAmG2o', 1, 1, '2021-03-01 10:24:15', '2021-03-01 10:24:15', NULL);
INSERT INTO `wallet` VALUES (6, 'LZopbUVfTGB25Au9qTDXATf8RQWKTzTgG3', 1, 3, '2021-03-01 13:23:50', '2021-03-01 13:23:50', NULL);
INSERT INTO `wallet` VALUES (7, 'Ld4vDctx6kKfSfxNXHS3LdFJcZw3QEgt9r', 1, 4, '2021-03-01 13:33:42', '2021-03-01 13:33:42', NULL);
INSERT INTO `wallet` VALUES (8, 'LKM2CwHXfr9DMG9u6UVBGQi7yPbUsdiptq', 1, 5, '2021-03-01 14:30:04', '2021-03-01 14:30:04', NULL);
INSERT INTO `wallet` VALUES (9, 'LRT32GhF8zU1mUmigGhkGdMwzWB3S9EErS', 1, 6, '2021-03-01 14:43:46', '2021-03-01 14:43:46', NULL);
INSERT INTO `wallet` VALUES (10, 'LPg6nL9E5JJvmQKs4Umu1eAkCgQHSZZtdE', 1, 7, '2021-03-01 15:15:13', '2021-03-01 15:15:13', NULL);
INSERT INTO `wallet` VALUES (11, 'LiUsE4KiMYVVb9P9V3Fjh3wVqp6Lg6Uudz', 1, 8, '2021-03-01 22:24:56', '2021-03-01 22:24:56', NULL);
INSERT INTO `wallet` VALUES (12, 'LbxwFuyhgp5ZekWKnAYhBJutyqzSfwJdyZ', 1, 12, '2021-03-02 07:01:42', '2021-03-02 07:01:42', NULL);
INSERT INTO `wallet` VALUES (13, 'LbiGwgCCKqQ28zaxD8XBnFE4GJuL26vXhf', 1, 13, '2021-03-02 07:06:57', '2021-03-02 07:06:57', NULL);
INSERT INTO `wallet` VALUES (14, 'LZ8TTybYwEuLJr8XUeXStDHkwsyDZMh78J', 1, 14, '2021-03-02 07:14:20', '2021-03-02 07:14:20', NULL);
INSERT INTO `wallet` VALUES (15, 'LNt4zZLyFw277F2GRqze8WuMCo177Exi6H', 1, 15, '2021-03-02 07:17:34', '2021-03-02 07:17:34', NULL);
INSERT INTO `wallet` VALUES (16, 'LSAEVXL7v31jZfpznF2Pwuo5axb1Cpf7b5', 1, 16, '2021-03-02 07:24:20', '2021-03-02 07:24:20', NULL);
INSERT INTO `wallet` VALUES (17, 'LT5NHNA6DiEsVSgYXKVgiizsJDCigDdcuU', 1, 18, '2021-03-02 07:37:00', '2021-03-02 07:37:00', NULL);
INSERT INTO `wallet` VALUES (18, 'LiCocwv5VguxXW76PU3s2R9fG9NEBpmc3N', 1, 17, '2021-03-02 07:38:05', '2021-03-02 07:38:05', NULL);
INSERT INTO `wallet` VALUES (19, 'LSpVPa9YFvomU1YD9aP8gnmqvnmJc2qFgW', 1, 19, '2021-03-02 07:41:37', '2021-03-02 07:41:37', NULL);
INSERT INTO `wallet` VALUES (20, 'LbdHxyepuhs9RG1T3AMmt8wxDLUJeJtSzY', 1, 20, '2021-03-02 07:48:03', '2021-03-02 07:48:03', NULL);
INSERT INTO `wallet` VALUES (21, 'LXdFdSMJRR1JCCShJEqpPAB76oZvsSoprH', 1, 21, '2021-03-02 07:50:28', '2021-03-02 07:50:28', NULL);
INSERT INTO `wallet` VALUES (22, 'LcPyodtbasnKpDnzR25ZkxsooLVsrPi6SX', 1, 22, '2021-03-02 07:55:12', '2021-03-02 07:55:12', NULL);
INSERT INTO `wallet` VALUES (23, 'LZAePnxTXTF9QzPK8MdLR5J8c8wi5J5Ekc', 1, 24, '2021-03-02 10:24:58', '2021-03-02 10:24:58', NULL);
INSERT INTO `wallet` VALUES (24, 'LL7YGtiTEzAFnGS4mZmS7LjxD6WN3HXNSM', 1, 25, '2021-03-02 10:56:45', '2021-03-02 10:56:45', NULL);
INSERT INTO `wallet` VALUES (25, 'LLb92Q63wTMejnPvcBvrXYAEpNDKJf6DPc', 1, 26, '2021-03-02 11:15:24', '2021-03-02 11:15:24', NULL);
INSERT INTO `wallet` VALUES (26, 'LcNXV3akXw2zn9YpEmvXGrTxvHw9HvgYfe', 1, 27, '2021-03-02 11:36:56', '2021-03-02 11:36:56', NULL);
INSERT INTO `wallet` VALUES (27, 'LbbUidbpJyjFPGM55RC4KAReouce2qwBng', 1, 28, '2021-03-02 11:46:08', '2021-03-02 11:46:08', NULL);
INSERT INTO `wallet` VALUES (28, 'Li1qPKGcH8MbZLrHtNq2Lg4EcSQJPdHpNQ', 1, 30, '2021-03-02 12:02:45', '2021-03-02 12:02:45', NULL);
INSERT INTO `wallet` VALUES (29, 'LcSBzyFSbtsEAv1KoiZeUtWeudt3BxVecW', 1, 29, '2021-03-02 12:04:25', '2021-03-02 12:04:25', NULL);
INSERT INTO `wallet` VALUES (30, 'LNuY5m2CAnQKaMfNsB3jPKxJRbsEf6SGe3', 1, 31, '2021-03-02 12:42:32', '2021-03-02 12:42:32', NULL);
INSERT INTO `wallet` VALUES (31, 'LgvVVXGwfnTv4VC6cqpw2wb7uXgpgkBzuA', 1, 32, '2021-03-02 12:53:55', '2021-03-02 12:53:55', NULL);
INSERT INTO `wallet` VALUES (32, 'LXSETreKycM2GuxdYHqVGaxN1Bi9ubCrzx', 1, 33, '2021-03-02 14:05:27', '2021-03-02 14:05:27', NULL);
INSERT INTO `wallet` VALUES (33, 'LP1uDoFryaCH2E52mvDJHBVoAbiVNYswc7', 1, 34, '2021-03-02 14:21:34', '2021-03-02 14:21:34', NULL);
INSERT INTO `wallet` VALUES (34, 'LYDY2RHDWKjQX7JmnN38zNUFv9UyJrYcxx', 1, 35, '2021-03-02 15:05:37', '2021-03-02 15:05:37', NULL);
INSERT INTO `wallet` VALUES (35, 'LZixkF6XJcTeumkbdrdMwDWbBqSrcFh9Ax', 1, 36, '2021-03-02 15:21:41', '2021-03-02 15:21:41', NULL);
INSERT INTO `wallet` VALUES (36, 'Lh1mwg4KEWsjGPoyuY44b3QVMwRKgHH49q', 1, 37, '2021-03-02 15:43:58', '2021-03-02 15:43:58', NULL);
INSERT INTO `wallet` VALUES (37, 'Ldi2KqndFMhM3efjNdWw9SXjuYrrFUvtoa', 1, 38, '2021-03-02 15:49:09', '2021-03-02 15:49:09', NULL);
INSERT INTO `wallet` VALUES (38, 'LKkrXskcp6WPZbyWtNPpGVBfLQ2tk6QJw7', 1, 39, '2021-03-02 16:41:23', '2021-03-02 16:41:23', NULL);
INSERT INTO `wallet` VALUES (39, 'LMJj4wPjQPMQ2Ud4v5Qs8ewwbk6FQzK6qK', 1, 40, '2021-03-02 18:21:39', '2021-03-02 18:21:39', NULL);
INSERT INTO `wallet` VALUES (40, 'LfyZn5EGdRR5dwV3M9srh1RYpNx77UCJ5B', 1, 41, '2021-03-02 18:29:55', '2021-03-02 18:29:55', NULL);
INSERT INTO `wallet` VALUES (41, 'LNHWATCJKv21L7Nd7tb3FoseGBk5AVoGsy', 1, 42, '2021-03-02 19:58:25', '2021-03-02 19:58:25', NULL);
INSERT INTO `wallet` VALUES (42, 'Lez4EB4tXTv2myKBj8m17U5D645dCU6vi3', 1, 43, '2021-03-02 22:47:33', '2021-03-02 22:47:33', NULL);
INSERT INTO `wallet` VALUES (43, 'LayDXGA2vrMRZUoicw8oRvBjZf181Qp2xE', 1, 46, '2021-03-02 23:08:47', '2021-03-02 23:08:47', NULL);
INSERT INTO `wallet` VALUES (44, 'LSjA6UG2SnwNgbrFeHZZd2MJF86fnJbc3g', 1, 47, '2021-03-02 23:17:12', '2021-03-02 23:17:12', NULL);
INSERT INTO `wallet` VALUES (45, 'LREtdHg2Lz4mAoDN2q3bQW41FDDJvN7THn', 1, 50, '2021-03-03 00:03:40', '2021-03-03 00:03:40', NULL);
INSERT INTO `wallet` VALUES (46, 'LYQVME81jgq8qxoKxuySazy8sJiuU7p14Q', 1, 51, '2021-03-03 00:09:51', '2021-03-03 00:09:51', NULL);
INSERT INTO `wallet` VALUES (47, 'LPpU56gRA3N9Li3wLkFj9m2MDT7iLHEY4L', 1, 52, '2021-03-03 00:32:57', '2021-03-03 00:32:57', NULL);
INSERT INTO `wallet` VALUES (48, 'LYdPBmdxXAyLWW84JmCgN6FYWLwhf5A7EB', 1, 45, '2021-03-03 00:57:09', '2021-03-03 00:57:09', NULL);
INSERT INTO `wallet` VALUES (49, 'LZNrbNA38iMRbLpJk6vMfpFEmfS5GvS9Mv', 1, 48, '2021-03-03 01:01:15', '2021-03-03 01:01:15', NULL);
INSERT INTO `wallet` VALUES (50, 'LY9f4w9bhzJEx6TnhDduJa5XY2mZUSg4ad', 1, 9, '2021-03-03 01:25:32', '2021-03-03 01:25:32', NULL);
INSERT INTO `wallet` VALUES (51, 'LZyW8KSjipcrR7pJfcZ1ZyK6SCgYpE2y2Q', 1, 54, '2021-03-03 01:50:07', '2021-03-03 01:50:07', NULL);
INSERT INTO `wallet` VALUES (52, 'LVCb1Rm1afhLTaHt1tvEPyWeENCFvDpHsS', 1, 53, '2021-03-03 01:57:45', '2021-03-03 01:57:45', NULL);
INSERT INTO `wallet` VALUES (53, 'LVy55Pfr3tyopCcXs84tkLdMkGDcxjKWg4', 1, 55, '2021-03-03 02:08:06', '2021-03-03 02:08:06', NULL);
INSERT INTO `wallet` VALUES (54, 'LWHx5Z1i3atWkWnU6LveeUrcCjgY2u1Xig', 1, 56, '2021-03-03 02:12:32', '2021-03-03 02:12:32', NULL);
INSERT INTO `wallet` VALUES (55, 'LNPKsjUmm1sD3nYaAWX7GtVtRHuWurN4Vx', 1, 60, '2021-03-03 05:32:02', '2021-03-03 05:32:02', NULL);
INSERT INTO `wallet` VALUES (56, 'LW2PQXr2wVbWxBJyTjqDWvKgyBJrUSKKY7', 1, 61, '2021-03-03 07:37:44', '2021-03-03 07:37:44', NULL);
INSERT INTO `wallet` VALUES (57, 'LQ7yryg5L5HA3TkniYuE5fZn41Khqairqz', 1, 58, '2021-03-03 07:53:58', '2021-03-03 07:53:58', NULL);
INSERT INTO `wallet` VALUES (58, 'LfaWe4AkVcjDHXQoykP8WSbKCXTL3kgp2j', 1, 62, '2021-03-03 08:04:32', '2021-03-03 08:04:32', NULL);
INSERT INTO `wallet` VALUES (59, 'LNLsbjRxizGvABTbxK9f8Crx6peQRo4xkt', 1, 63, '2021-03-03 08:08:54', '2021-03-03 08:08:54', NULL);
INSERT INTO `wallet` VALUES (60, 'Ld9hsQdDCtJDc7SJ4MGHWxZRC6sNijnaxU', 1, 64, '2021-03-03 08:13:42', '2021-03-03 08:13:42', NULL);
INSERT INTO `wallet` VALUES (61, 'LeQotzqWSB62hNcNk7qDsCLzWT3qLUtviy', 1, 65, '2021-03-03 08:25:05', '2021-03-03 08:25:05', NULL);
INSERT INTO `wallet` VALUES (62, 'Lag1xoyWJcSbXoRG4V6QYHx2uoMpRUtjE9', 1, 66, '2021-03-03 08:28:56', '2021-03-03 08:28:56', NULL);
INSERT INTO `wallet` VALUES (63, 'Ld33ppYQrwqUE15gnXTLHdz9VqipaLTpY9', 1, 67, '2021-03-03 09:39:26', '2021-03-03 09:39:26', NULL);
INSERT INTO `wallet` VALUES (64, 'LYoz1PtaH6t5Ro42eJeYRTAFtpjFbCWFWk', 1, 68, '2021-03-03 09:45:40', '2021-03-03 09:45:40', NULL);
INSERT INTO `wallet` VALUES (65, 'LTk2NPsX8g87XtKK1zPnfiwTbPuxisrZ2M', 1, 69, '2021-03-03 10:04:09', '2021-03-03 10:04:09', NULL);
INSERT INTO `wallet` VALUES (66, 'LNNLp6x358fT2FnHQMmgJBqH11XdRNcAqp', 1, 70, '2021-03-03 10:06:00', '2021-03-03 10:06:00', NULL);
INSERT INTO `wallet` VALUES (67, 'LKUQztSbkHzXFXgb1SKxut56Ze1kBSVGw1', 1, 71, '2021-03-03 10:32:54', '2021-03-03 10:32:54', NULL);
INSERT INTO `wallet` VALUES (68, 'LUFmGttBKkhFRwepo6UmEGpzcC2YEdKLTT', 1, 72, '2021-03-03 10:46:33', '2021-03-03 10:46:33', NULL);
INSERT INTO `wallet` VALUES (69, 'LS5Tj3Pe9FJtXyLwFRFuZw2R7UcDrmrwVr', 1, 57, '2021-03-03 10:49:21', '2021-03-03 10:49:21', NULL);
INSERT INTO `wallet` VALUES (70, 'LV6w7wnnLUqL4nmSmukvQ6ftCGLdFvMuwo', 1, 74, '2021-03-03 11:09:33', '2021-03-03 11:09:33', NULL);
INSERT INTO `wallet` VALUES (71, 'LKNeS1rKPLxMP6Ds6GCMtDiLu797xmtWhq', 1, 76, '2021-03-03 11:29:16', '2021-03-03 11:29:16', NULL);
INSERT INTO `wallet` VALUES (72, 'LddCpLJgGmGJCnt4pZYcBiLN1FR4PE6ByV', 1, 80, '2021-03-03 11:44:40', '2021-03-03 11:44:40', NULL);
INSERT INTO `wallet` VALUES (73, 'LgiMWQgqPg4SwwBd3PduNqJJ8SAkNaqGRQ', 1, 79, '2021-03-03 11:45:10', '2021-03-03 11:45:10', NULL);
INSERT INTO `wallet` VALUES (74, 'LdohLK3nrjSQwMDMEgESwfjYj3Hkm2Ba7U', 1, 78, '2021-03-03 11:45:41', '2021-03-03 11:45:41', NULL);
INSERT INTO `wallet` VALUES (75, 'LZhff2kJtbDyFipWnY6X8M6e5RYhpEyKQG', 1, 81, '2021-03-03 11:57:38', '2021-03-03 11:57:38', NULL);
INSERT INTO `wallet` VALUES (76, 'LdtD6VQBoPDHKXKBDh9VqifuJVuQajEDua', 1, 82, '2021-03-03 12:03:06', '2021-03-03 12:03:06', NULL);
INSERT INTO `wallet` VALUES (77, 'LSpSZ67ZR6mThhieYjBY16MMmsr6KAP7Pb', 1, 83, '2021-03-03 12:15:05', '2021-03-03 12:15:05', NULL);
INSERT INTO `wallet` VALUES (78, 'LLRUFBs79xnPDn5sgs1PRewDQUdMLP3nzU', 1, 84, '2021-03-03 12:22:41', '2021-03-03 12:22:41', NULL);
INSERT INTO `wallet` VALUES (79, 'LNwgKAJxvwKfeY9QSpH6a7kuA1xMyvdnRZ', 1, 85, '2021-03-03 12:30:23', '2021-03-03 12:30:23', NULL);
INSERT INTO `wallet` VALUES (80, 'LZjoUKaKJwpGnLjrHEiTQPjVgsphKtqXM5', 1, 86, '2021-03-03 12:34:46', '2021-03-03 12:34:46', NULL);
INSERT INTO `wallet` VALUES (81, 'LYsHTuuvujAY51UvoCbqjeH1JqSWKuCkfb', 1, 88, '2021-03-03 12:35:22', '2021-03-03 12:35:22', NULL);
INSERT INTO `wallet` VALUES (82, 'LTzePTd2ME4fnd8oWtTowreyt6RETazFGa', 1, 87, '2021-03-03 12:38:11', '2021-03-03 12:38:11', NULL);
INSERT INTO `wallet` VALUES (83, 'LdWUyVhxAG5FnFkyXPXhjXEbTMrxtcjZ5j', 1, 89, '2021-03-03 12:40:06', '2021-03-03 12:40:06', NULL);
INSERT INTO `wallet` VALUES (84, 'LZFVduwYmwHh4J3Cn3de6Qc3USvpu1MKu4', 1, 90, '2021-03-03 12:43:53', '2021-03-03 12:43:53', NULL);
INSERT INTO `wallet` VALUES (85, 'LgUiEKk9eWwLrwCErWD1a9tKNngsNXLirZ', 1, 91, '2021-03-03 12:48:50', '2021-03-03 12:48:50', NULL);
INSERT INTO `wallet` VALUES (86, 'LU2V9XUTRnq6iTU5ynGoYjNfRrZZHQQKuB', 1, 92, '2021-03-03 12:57:16', '2021-03-03 12:57:16', NULL);
INSERT INTO `wallet` VALUES (87, 'LNU2AM2mqFs2pZLWbv7gwMchfcyjUMq5Yy', 1, 93, '2021-03-03 12:59:54', '2021-03-03 12:59:54', NULL);
INSERT INTO `wallet` VALUES (88, 'LSvfyjzN3uLT4VGwM3VZsBEoiwtzz9bRyp', 1, 95, '2021-03-03 13:11:16', '2021-03-03 13:11:16', NULL);
INSERT INTO `wallet` VALUES (89, 'Li4sBotNWbgPqcucx5B3QBfbT77ZxtYNZN', 1, 94, '2021-03-03 13:15:37', '2021-03-03 13:15:37', NULL);
INSERT INTO `wallet` VALUES (90, 'LU6sBv7Xx8bhc8yW5fsUYzEittBSs4UCai', 1, 96, '2021-03-03 13:16:33', '2021-03-03 13:16:33', NULL);
INSERT INTO `wallet` VALUES (91, 'LcScXR2Tnrmj3RYBtUjFNp1CCBdPr8M1k3', 1, 97, '2021-03-03 13:22:29', '2021-03-03 13:22:29', NULL);
INSERT INTO `wallet` VALUES (92, 'LPdUwzvjW6FhutV7WRWcq1quV73WbUhHRp', 1, 99, '2021-03-03 13:31:59', '2021-03-03 13:31:59', NULL);
INSERT INTO `wallet` VALUES (93, 'LT4DAezXvZjFSUgA3LonWPWHifL2EwHy79', 1, 98, '2021-03-03 13:37:02', '2021-03-03 13:37:02', NULL);
INSERT INTO `wallet` VALUES (94, 'LXygFPXmbAgR93K6eAmXNea4F9dJqHL1UQ', 1, 100, '2021-03-03 13:43:26', '2021-03-03 13:43:26', NULL);
INSERT INTO `wallet` VALUES (95, 'Lhv11LuvGerHsEudw6nk7FKJ53tU52X81X', 1, 101, '2021-03-03 13:46:17', '2021-03-03 13:46:17', NULL);
INSERT INTO `wallet` VALUES (96, 'LTGSGa6f55ZdmdPzPRZphpopanP8e8E3ZZ', 1, 102, '2021-03-03 13:53:49', '2021-03-03 13:53:49', NULL);
INSERT INTO `wallet` VALUES (97, 'LYvqpCXqsmBarUtMjGJFVanefjiZR5nDJf', 1, 105, '2021-03-03 14:06:18', '2021-03-03 14:06:18', NULL);
INSERT INTO `wallet` VALUES (98, 'LNkKo5fqvzVwasMZDSyVYX2WSH58JRtnDT', 1, 104, '2021-03-03 14:06:34', '2021-03-03 14:06:34', NULL);
INSERT INTO `wallet` VALUES (99, 'LT1691u1Sgsf3jgPKbvsC5xRgtnwpUiAk1', 1, 103, '2021-03-03 14:08:47', '2021-03-03 14:08:47', NULL);
INSERT INTO `wallet` VALUES (100, 'LgxnnbB86GfmRPKuj5w4SeUhctKJfPJm9n', 1, 106, '2021-03-03 14:19:00', '2021-03-03 14:19:00', NULL);
INSERT INTO `wallet` VALUES (101, 'Lemju7ArviwmeQmVfKhNtoTpqdFsroFsuc', 1, 107, '2021-03-03 14:26:30', '2021-03-03 14:26:30', NULL);
INSERT INTO `wallet` VALUES (102, 'Lcqzw1v7RpYwxkJqsEdnKKLeN9rGzgzNqn', 1, 108, '2021-03-03 14:26:50', '2021-03-03 14:26:50', NULL);
INSERT INTO `wallet` VALUES (103, 'LUHUUZNBX2CRZaEtCGyW6bgHxsTsW8Lvut', 1, 109, '2021-03-03 14:30:53', '2021-03-03 14:30:53', NULL);
INSERT INTO `wallet` VALUES (104, 'LPQfohU9Vknt71me8H3PFAvb61CWfXrZzN', 1, 110, '2021-03-03 14:39:48', '2021-03-03 14:39:48', NULL);
INSERT INTO `wallet` VALUES (105, 'LUYeoUiZhHi1xaZJuCitWmuDVJQvbsyjkH', 1, 111, '2021-03-03 14:45:43', '2021-03-03 14:45:43', NULL);
INSERT INTO `wallet` VALUES (106, 'LhsAXPaw5ACNG6vesQ5u5tAJjRpDRJT8cM', 1, 112, '2021-03-03 15:17:17', '2021-03-03 15:17:17', NULL);
INSERT INTO `wallet` VALUES (107, 'LhJMZXMZNyZXY1pzr7eq1nnSjvaRVP5188', 1, 113, '2021-03-03 15:22:11', '2021-03-03 15:22:11', NULL);
INSERT INTO `wallet` VALUES (108, 'Lh8TtydRbJKDpYuqyAqfGqCRTjA1wiSV18', 1, 114, '2021-03-03 15:23:43', '2021-03-03 15:23:43', NULL);
INSERT INTO `wallet` VALUES (109, 'LMStwTjYwJtLYhR7iUAieoHd5qaC5XejSk', 1, 115, '2021-03-03 15:25:47', '2021-03-03 15:25:47', NULL);
INSERT INTO `wallet` VALUES (110, 'LQMZ2Yx2UvqiVKGGnSB9hbKQxTSjCpKzEL', 1, 116, '2021-03-03 15:36:08', '2021-03-03 15:36:08', NULL);
INSERT INTO `wallet` VALUES (111, 'LNJFUkGr7JMDn2bJ958LakbJEcfnGLF21o', 1, 117, '2021-03-03 15:56:26', '2021-03-03 15:56:26', NULL);
INSERT INTO `wallet` VALUES (112, 'LXdHb3fZAJyGLZ1d56G9QHj97wiLmrx7Kd', 1, 118, '2021-03-03 16:01:38', '2021-03-03 16:01:38', NULL);
INSERT INTO `wallet` VALUES (113, 'LhpDT4FDU5qn3778DX1PKzyFEdSCN8kEB2', 1, 119, '2021-03-03 16:06:33', '2021-03-03 16:06:33', NULL);
INSERT INTO `wallet` VALUES (114, 'LgxHKR5SeRmuPfFzFe8QcjuzHWUAfkbG2R', 1, 120, '2021-03-03 16:11:18', '2021-03-03 16:11:18', NULL);
INSERT INTO `wallet` VALUES (115, 'LT8BfYefgBJ2nba8eyepf6uBWNPLbmuAjM', 1, 121, '2021-03-03 16:17:18', '2021-03-03 16:17:18', NULL);
INSERT INTO `wallet` VALUES (116, 'LScr2uXTm6Y9ogH2r58hdxsofQYzHeaRhx', 1, 122, '2021-03-03 16:20:29', '2021-03-03 16:20:29', NULL);
INSERT INTO `wallet` VALUES (117, 'LV3s4p8cEph3godatpmNXneJYhuS7eujw6', 1, 123, '2021-03-03 16:22:24', '2021-03-03 16:22:24', NULL);
INSERT INTO `wallet` VALUES (118, 'LhrKyNSegRKXPCu4T5R51YsyJZP8drTvhF', 1, 124, '2021-03-03 16:27:30', '2021-03-03 16:27:30', NULL);
INSERT INTO `wallet` VALUES (119, 'LVjBGfsAuv3MyBhafcqz3XhM22WFWLPeV3', 1, 125, '2021-03-03 16:29:42', '2021-03-03 16:29:42', NULL);
INSERT INTO `wallet` VALUES (120, 'LWXtZgE3FKn3SJsPRShYHkq2QpvQ7mjbsX', 1, 126, '2021-03-03 16:31:43', '2021-03-03 16:31:43', NULL);
INSERT INTO `wallet` VALUES (121, 'LZZqNPfcLRiDenzzPo9K8apPHiCHc6NCuW', 1, 127, '2021-03-03 16:34:15', '2021-03-03 16:34:15', NULL);
INSERT INTO `wallet` VALUES (122, 'LMoeLaDK9tB4KZt5frRbFNxWzvrrz4ULh8', 1, 128, '2021-03-03 16:37:59', '2021-03-03 16:37:59', NULL);
INSERT INTO `wallet` VALUES (123, 'LXEg8AWh19dd43WW4gCAfFeJyoDGD7rN13', 1, 129, '2021-03-03 16:45:44', '2021-03-03 16:45:44', NULL);
INSERT INTO `wallet` VALUES (124, 'LYA5bBBGqfw4syuJynj6feUQxaya6KUx8b', 1, 130, '2021-03-03 16:53:16', '2021-03-03 16:53:16', NULL);
INSERT INTO `wallet` VALUES (125, 'LXjAXUGmgixt6hFieMZXWXCB7DDDek8EfE', 1, 132, '2021-03-03 19:39:08', '2021-03-03 19:39:08', NULL);
INSERT INTO `wallet` VALUES (126, 'LYnFJNo9C55bgJqmy44Qnn7efNFRFhWkWE', 1, 133, '2021-03-03 19:45:58', '2021-03-03 19:45:58', NULL);
INSERT INTO `wallet` VALUES (127, 'LT5sVxaVf7qTQcEoXLYcvekaMURpjV5D8z', 1, 134, '2021-03-03 20:05:07', '2021-03-03 20:05:07', NULL);
INSERT INTO `wallet` VALUES (128, 'LaLXgXh35xbxesJM6ACpdgfA3bPVzdT2B3', 1, 135, '2021-03-03 20:17:27', '2021-03-03 20:17:27', NULL);
INSERT INTO `wallet` VALUES (129, 'LTqCYsescjZx3LNQ1QiWA5gu46HYcivE92', 1, 136, '2021-03-03 20:23:55', '2021-03-03 20:23:55', NULL);
INSERT INTO `wallet` VALUES (130, 'LM7WVveH38aJFjh6FJyMsyhbMmKVqmwNLA', 1, 137, '2021-03-03 20:26:01', '2021-03-03 20:26:01', NULL);
INSERT INTO `wallet` VALUES (131, 'LSZQQJgGUESGX67QH18AYvThREpzzYkVWF', 1, 138, '2021-03-03 20:34:36', '2021-03-03 20:34:36', NULL);
INSERT INTO `wallet` VALUES (132, 'LUUZEsqTQvgx6KFqLRevBPXEp696i2KyT8', 1, 139, '2021-03-03 20:44:38', '2021-03-03 20:44:38', NULL);
INSERT INTO `wallet` VALUES (133, 'LS8fxqYQKYdPq2Z5WTz6gDTKifYJ8JmWjS', 1, 140, '2021-03-03 20:46:51', '2021-03-03 20:46:51', NULL);
INSERT INTO `wallet` VALUES (134, 'LXDU1v1F9bNkeR3uTt395T1FRM8GBzbc72', 1, 141, '2021-03-03 20:53:49', '2021-03-03 20:53:49', NULL);
INSERT INTO `wallet` VALUES (135, 'Lctw2iChnxrouoBQcjFkLa3vF8F1Ffie4r', 1, 142, '2021-03-03 20:55:12', '2021-03-03 20:55:12', NULL);
INSERT INTO `wallet` VALUES (136, 'Ld4DgRu5f2hfkpNgNyxfBio2Nu5wAguC94', 1, 143, '2021-03-03 21:02:13', '2021-03-03 21:02:13', NULL);
INSERT INTO `wallet` VALUES (137, 'LgBDPaaQgyPU4BsQRgLi7cHoT59jXYSxWG', 1, 144, '2021-03-03 21:09:35', '2021-03-03 21:09:35', NULL);
INSERT INTO `wallet` VALUES (138, 'Lb2CZ3fxQGnHsxdgoDf6Ek7SQjCQXSpw6C', 1, 145, '2021-03-03 21:17:46', '2021-03-03 21:17:46', NULL);
INSERT INTO `wallet` VALUES (139, 'LRKBGYZo71ZRQ4UCcKr8svQuqVKURRTjvn', 1, 146, '2021-03-03 21:19:02', '2021-03-03 21:19:02', NULL);
INSERT INTO `wallet` VALUES (140, 'LUX4EqHgTShLdL6XSsyeUdkqjnuxgYxkF7', 1, 147, '2021-03-04 00:02:53', '2021-03-04 00:02:53', NULL);

SET FOREIGN_KEY_CHECKS = 1;
