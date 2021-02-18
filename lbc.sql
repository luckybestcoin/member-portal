/*
 Navicat Premium Data Transfer

 Source Server         : Local MySQL
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : luckybit

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 18/02/2021 12:09:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for anggota
-- ----------------------------
DROP TABLE IF EXISTS `anggota`;
CREATE TABLE `anggota` (
  `anggota_id` bigint NOT NULL AUTO_INCREMENT,
  `anggota_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anggota_kata_sandi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anggota_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `anggota_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `anggota_hp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anggota_jaringan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_parent` bigint DEFAULT NULL,
  `anggota_posisi` smallint DEFAULT NULL,
  `paket_id` bigint NOT NULL,
  `paket_harga` decimal(65,2) NOT NULL,
  `negara_id` bigint NOT NULL,
  `jatuh_tempo` date DEFAULT NULL,
  `reinvest` int NOT NULL DEFAULT '1',
  `peringkat_id` bigint DEFAULT NULL,
  `remember_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`anggota_id`),
  KEY `anggota_paket_id_fkey` (`paket_harga`),
  KEY `anggota_peringkat_id_fkey` (`peringkat_id`),
  KEY `paket_id` (`paket_id`),
  CONSTRAINT `anggota_ibfk_1` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`paket_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `anggota_peringkat_id_fkey` FOREIGN KEY (`peringkat_id`) REFERENCES `peringkat` (`peringkat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of anggota
-- ----------------------------
BEGIN;
INSERT INTO `anggota` VALUES (50, 'fajar', '$2y$10$7tXd5Ck6ApTgC1fNGPhqOOAOc7ZwAX5aL01buKoHPwM2u2jfk4jjO', 'Andi Fajar Nugraha', 'andifajarlah@gmail.com', '080808080808', '', NULL, NULL, 1, 10000.00, 1, NULL, 1, NULL, NULL, '2021-01-31 00:00:00', '2021-02-17 09:52:17', NULL);
INSERT INTO `anggota` VALUES (51, NULL, NULL, 'tes', 'tes@gmail.com', '081803747336', '50ka', 50, 1, 5, 2000.00, 1, NULL, 1, NULL, NULL, '2021-02-06 03:15:02', '2021-02-06 03:15:02', NULL);
INSERT INTO `anggota` VALUES (52, NULL, NULL, 'tes', 'tesa@gmail.com', '0818037473360', '50ka', 50, 1, 5, 2000.00, 1, NULL, 1, NULL, NULL, '2021-02-06 03:16:17', '2021-02-06 03:16:17', NULL);
COMMIT;

-- ----------------------------
-- Table structure for bagi_hasil
-- ----------------------------
DROP TABLE IF EXISTS `bagi_hasil`;
CREATE TABLE `bagi_hasil` (
  `bagi_hasil_id` bigint NOT NULL AUTO_INCREMENT,
  `bagi_hasil_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bagi_hasil_jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bagi_hasil_debit` decimal(65,2) NOT NULL,
  `bagi_hasil_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bagi_hasil_id`),
  KEY `bagi_hasil_pengguna_id_fkey` (`anggota_id`),
  KEY `transaksi_id` (`transaksi_id`),
  CONSTRAINT `bagi_hasil_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bagi_hasil_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of bagi_hasil
-- ----------------------------
BEGIN;
INSERT INTO `bagi_hasil` VALUES (45, 'Member registration on behalf of tes', 'Referral', 0.00, 200.00, 'oE7Y6jpAUS-202102060315021612581302259', 50, '2021-02-06 03:15:02', '2021-02-06 03:15:02');
INSERT INTO `bagi_hasil` VALUES (46, 'Member registration on behalf of tes', 'Referral', 0.00, 200.00, '4bgxwXCYBa-202102060316171612581377335', 50, '2021-02-06 03:16:17', '2021-02-06 03:16:17');
COMMIT;

-- ----------------------------
-- Table structure for biaya
-- ----------------------------
DROP TABLE IF EXISTS `biaya`;
CREATE TABLE `biaya` (
  `biaya_id` bigint NOT NULL AUTO_INCREMENT,
  `biaya_nama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biaya_harga` decimal(65,30) DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`biaya_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `biaya_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for bonus_pin
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pin`;
CREATE TABLE `bonus_pin` (
  `bonus_pin_id` bigint NOT NULL AUTO_INCREMENT,
  `bonus_pin_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bonus_pin_debit` decimal(65,2) NOT NULL,
  `bonus_pin_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bonus_pin_id`),
  KEY `bonus_pin_pengguna_id_fkey` (`anggota_id`),
  KEY `bonus_pin_ibfk_1` (`transaksi_id`),
  CONSTRAINT `bonus_pin_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bonus_pin_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for hari_libur
-- ----------------------------
DROP TABLE IF EXISTS `hari_libur`;
CREATE TABLE `hari_libur` (
  `hari_libur_id` bigint NOT NULL AUTO_INCREMENT,
  `hari_libur_tanggal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hari_libur_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`hari_libur_id`) USING BTREE,
  UNIQUE KEY `hari_besar_hari_besar_tanggal_idx` (`hari_libur_tanggal`) USING BTREE,
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `hari_libur_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of hari_libur
-- ----------------------------
BEGIN;
INSERT INTO `hari_libur` VALUES (1, '2020-10-12', 'tesa', 1, '2021-01-17 00:42:55', '2021-01-17 00:49:30');
INSERT INTO `hari_libur` VALUES (2, '2020-11-21', 'res', 1, '2021-01-17 00:49:44', '2021-01-17 00:55:45');
COMMIT;

-- ----------------------------
-- Table structure for kurs
-- ----------------------------
DROP TABLE IF EXISTS `kurs`;
CREATE TABLE `kurs` (
  `kurs_id` bigint NOT NULL AUTO_INCREMENT,
  `kurs_beli` decimal(65,2) NOT NULL,
  `kurs_jual` decimal(65,2) NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`kurs_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `kurs_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of kurs
-- ----------------------------
BEGIN;
INSERT INTO `kurs` VALUES (2, 15000.00, 12000.00, 1, '2021-01-30 00:00:00', '2021-01-30 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for kurs_pembayaran
-- ----------------------------
DROP TABLE IF EXISTS `kurs_pembayaran`;
CREATE TABLE `kurs_pembayaran` (
  `kurs_pembayaran_id` bigint NOT NULL AUTO_INCREMENT COMMENT ' ',
  `kurs_pembayaran_nama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kurs_pembayaran_metode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kurs_pembayaran_nilai` decimal(60,10) DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kurs_pembayaran_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of kurs_pembayaran
-- ----------------------------
BEGIN;
INSERT INTO `kurs_pembayaran` VALUES (1, 'BitCoin', 'BTC', 0.0020000000, 1, '2021-01-30 00:00:00', '2021-01-30 00:00:00', NULL);
INSERT INTO `kurs_pembayaran` VALUES (2, 'Etherium', 'ETH', 0.1000000000, 1, '2021-01-30 00:00:00', '2021-01-30 00:00:00', NULL);
INSERT INTO `kurs_pembayaran` VALUES (4, 'Binance', 'BNB', 0.0030000000, 1, NULL, NULL, NULL);
INSERT INTO `kurs_pembayaran` VALUES (5, 'Tron', 'TRX', 0.0003000000, 1, NULL, NULL, NULL);
INSERT INTO `kurs_pembayaran` VALUES (6, 'USD Tether', 'USDT', 1.0000000000, 1, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint NOT NULL,
  PRIMARY KEY (`permission_id`,`model_type`,`model_id`) USING BTREE,
  KEY `model_has_permissions_model_id_model_type_index` (`model_type`) USING BTREE,
  KEY `izin_pengguna_fk` (`model_id`) USING BTREE,
  CONSTRAINT `model_has_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `model_has_permissions_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` int unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`,`model_type`,`model_id`) USING BTREE,
  KEY `model_has_roles_model_id_model_type_index` (`model_type`) USING BTREE,
  KEY `level_pengguna_fk` (`model_id`) USING BTREE,
  CONSTRAINT `model_has_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `model_has_roles_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
BEGIN;
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\Pengguna', 1);
COMMIT;

-- ----------------------------
-- Table structure for negara
-- ----------------------------
DROP TABLE IF EXISTS `negara`;
CREATE TABLE `negara` (
  `negara_id` bigint NOT NULL AUTO_INCREMENT,
  `negara_nama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negara_kode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`negara_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `negara_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of negara
-- ----------------------------
BEGIN;
INSERT INTO `negara` VALUES (1, 'Afganistan', '93', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (2, 'Afrika Selatan', '27', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (3, 'Afrika Tengah', '236', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (4, 'Albania', '355', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (5, 'Algeria', '213', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (6, 'Amerika Serikat', '1', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (7, 'Andorra', '376', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (8, 'Angola', '244', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (9, 'Antigua & Barbuda', '1-268', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (10, 'Arab Saudi', '966', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (11, 'Argentina', '54', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (12, 'Armenia', '374', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (13, 'Australia', '61', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (14, 'Austria', '43', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (15, 'Azerbaijan', '994', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (16, 'Bahama', '1-242', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (17, 'Bahrain', '973', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (18, 'Bangladesh', '880', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (19, 'Barbados', '1-246', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (20, 'Belanda', '31', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (21, 'Belarus', '375', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (22, 'Belgia', '32', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (23, 'Belize', '501', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (24, 'Benin', '229', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (25, 'Bhutan', '975', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (26, 'Bolivia', '591', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (27, 'Bosnia & Herzegovina', '387', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (28, 'Botswana', '267', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (29, 'Brasil', '55', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (30, 'Britania Raya (Inggris)', '44', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (31, 'Brunei Darussalam', '673', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (32, 'Bulgaria', '359', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (33, 'Burkina Faso', '226', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (34, 'Burundi', '257', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (35, 'Ceko', '420', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (36, 'Chad', '235', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (37, 'Chili', '56', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (38, 'China', '86', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (39, 'Denmark', '45', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (40, 'Djibouti', '253', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (41, 'Domikia', '1-767', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (42, 'Ekuador', '593', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (43, 'El Salvador', '503', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (44, 'Eritrea', '291', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (45, 'Estonia', '372', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (46, 'Ethiopia', '251', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (47, 'Fiji', '679', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (48, 'Filipina', '63', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (49, 'Finlandia', '358', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (50, 'Gabon', '241', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (51, 'Gambia', '220', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (52, 'Georgia', '995', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (53, 'Ghana', '233', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (54, 'Grenada', '1-473', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (55, 'Guatemala', '502', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (56, 'Guinea', '224', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (57, 'Guinea Bissau', '245', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (58, 'Guinea Khatulistiwa', '240', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (59, 'Guyana', '592', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (60, 'Haiti', '509', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (61, 'Honduras', '504', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (62, 'Hongaria', '36', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (63, 'Hongkong', '852', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (64, 'India', '91', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (65, 'Indonesia', '62', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (66, 'Irak', '964', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (67, 'Iran', '98', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (68, 'Irlandia', '353', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (69, 'Islandia', '354', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (70, 'Israel', '972', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (71, 'Italia', '39', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (72, 'Jamaika', '1-876', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (73, 'Jepang', '81', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (74, 'Jerman', '49', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (75, 'Jordan', '962', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (76, 'Kamboja', '855', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (77, 'Kamerun', '237', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (78, 'Kanada', '1', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (79, 'Kazakhstan', '7', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (80, 'Kenya', '254', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (81, 'Kirgizstan', '996', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (82, 'Kiribati', '686', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (83, 'Kolombia', '57', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (84, 'Komoro', '269', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (85, 'Republik Kongo', '243', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (86, 'Korea Selatan', '82', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (87, 'Korea Utara', '850', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (88, 'Kosta Rika', '506', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (89, 'Kroasia', '385', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (90, 'Kuba', '53', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (91, 'Kuwait', '965', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (92, 'Laos', '856', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (93, 'Latvia', '371', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (94, 'Lebanon', '961', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (95, 'Lesotho', '266', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (96, 'Liberia', '231', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (97, 'Libya', '218', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (98, 'Liechtenstein', '423', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (99, 'Lituania', '370', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (100, 'Luksemburg', '352', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (101, 'Madagaskar', '261', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (102, 'Makao', '853', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (103, 'Makedonia', '389', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (104, 'Maladewa', '960', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (105, 'Malawi', '265', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (106, 'Malaysia', '60', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (107, 'Mali', '223', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (108, 'Malta', '356', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (109, 'Maroko', '212', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (110, 'Marshall (Kep.)', '692', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (111, 'Mauritania', '222', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (112, 'Mauritius', '230', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (113, 'Meksiko', '52', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (114, 'Mesir', '20', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (115, 'Mikronesia (Kep.)', '691', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (116, 'Moldova', '373', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (117, 'Monako', '377', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (118, 'Mongolia', '976', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (119, 'Montenegro', '382', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (120, 'Mozambik', '258', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (121, 'Myanmar', '95', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (122, 'Namibia', '264', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (123, 'Nauru', '674', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (124, 'Nepal', '977', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (125, 'Niger', '227', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (126, 'Nigeria', '234', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (127, 'Nikaragua', '505', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (128, 'Norwegia', '47', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (129, 'Oman', '968', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (130, 'Pakistan', '92', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (131, 'Palau', '680', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (132, 'Panama', '507', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (133, 'Pantai Gading', '225', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (134, 'Papua Nugini', '675', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (135, 'Paraguay', '595', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (136, 'Perancis', '33', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (137, 'Peru', '51', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (138, 'Polandia', '48', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (139, 'Portugal', '351', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (140, 'Qatar', '974', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (141, 'Rep. Dem. Kongo', '242', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (142, 'Republik Dominika', '1-809; 1-829', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (143, 'Rumania', '40', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (144, 'Rusia', '7', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (145, 'Rwanda', '250', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (146, 'Saint Kitts and Nevis', '1-869', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (147, 'Saint Lucia', '1-758', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (148, 'Saint Vincent & the Grenadines', '1-784', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (149, 'Samoa', '685', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (150, 'San Marino', '378', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (151, 'Sao Tome & Principe', '239', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (152, 'Selandia Baru', '64', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (153, 'Senegal', '221', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (154, 'Serbia', '381', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (155, 'Seychelles', '248', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (156, 'Sierra Leone', '232', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (157, 'Singapura', '65', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (158, 'Siprus', '357', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (159, 'Slovenia', '386', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (160, 'Slowakia', '421', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (161, 'Solomon (Kep.)', '677', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (162, 'Somalia', '252', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (163, 'Spanyol', '34', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (164, 'Sri Lanka', '94', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (165, 'Sudan', '249', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (166, 'Sudan Selatan', '211', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (167, 'Suriah', '963', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (168, 'Suriname', '597', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (169, 'Swaziland', '268', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (170, 'Swedia', '46', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (171, 'Swiss', '41', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (172, 'Tajikistan', '992', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (173, 'Tanjung Verde', '238', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (174, 'Tanzania', '255', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (175, 'Taiwan', '886', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (176, 'Thailand', '66', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (177, 'Timor Leste', '670', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (178, 'Togo', '228', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (179, 'Tonga', '676', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (180, 'Trinidad & Tobago', '1-868', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (181, 'Tunisia', '216', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (182, 'Turki', '90', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (183, 'Turkmenistan', '993', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (184, 'Tuvalu', '688', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (185, 'Uganda', '256', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (186, 'Ukraina', '380', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (187, 'Uni Emirat Arab', '971', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (188, 'Uruguay', '598', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (189, 'Uzbekistan', '998', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (190, 'Vanuatu', '678', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (191, 'Venezuela', '58', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (192, 'Vietnam', '84', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (193, 'Yaman', '967', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (194, 'Yunani', '30', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (195, 'Zambia', '260', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (196, 'Zimbabwe', '263', 1, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for omset_keluar
-- ----------------------------
DROP TABLE IF EXISTS `omset_keluar`;
CREATE TABLE `omset_keluar` (
  `omset_keluar_id` bigint NOT NULL AUTO_INCREMENT,
  `omset_keluar_jumlah` decimal(65,2) NOT NULL,
  `omset_keluar_posisi` tinyint(1) NOT NULL,
  `omset_keluar_anggota` bigint DEFAULT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`omset_keluar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for paket
-- ----------------------------
DROP TABLE IF EXISTS `paket`;
CREATE TABLE `paket` (
  `paket_id` bigint NOT NULL AUTO_INCREMENT,
  `paket_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paket_harga` decimal(65,2) NOT NULL,
  `paket_pin` tinyint NOT NULL,
  `paket_fee_bagi_hasil` decimal(60,2) DEFAULT NULL,
  `paket_min_wd_bagi_hasil` decimal(60,2) DEFAULT NULL,
  `paket_max_wd_bagi_hasil` decimal(60,2) DEFAULT NULL,
  `paket_fee_tiket` decimal(60,2) DEFAULT NULL,
  `paket_min_wd_tiket` decimal(60,2) DEFAULT NULL,
  `paket_max_wd_tiket` decimal(60,2) DEFAULT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`paket_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `paket_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of paket
-- ----------------------------
BEGIN;
INSERT INTO `paket` VALUES (1, 'PREMIUM', 100.00, 1, 2.00, 10.00, 100.00, 3.00, 10.00, 100.00, 1, '2021-01-15 03:09:38', '2021-01-24 12:41:50', NULL);
INSERT INTO `paket` VALUES (2, 'BRONZE', 200.00, 1, 3.00, 20.00, 200.00, 3.00, 10.00, 200.00, 1, '2021-01-15 03:13:35', '2021-01-24 12:41:57', NULL);
INSERT INTO `paket` VALUES (3, 'SILVER', 500.00, 1, 4.00, 50.00, 500.00, 3.00, 10.00, 500.00, 1, '2021-01-15 03:14:11', '2021-01-24 12:41:58', NULL);
INSERT INTO `paket` VALUES (4, 'GOLD', 1000.00, 1, 7.00, 100.00, 1000.00, 3.00, 10.00, 1000.00, 1, '2021-01-15 10:39:09', '2021-01-24 12:41:59', NULL);
INSERT INTO `paket` VALUES (5, 'PLATINUM', 2000.00, 3, 7.00, 100.00, 2000.00, 3.00, 10.00, 1000.00, 1, '2021-01-17 00:30:00', '2021-01-24 12:42:00', NULL);
INSERT INTO `paket` VALUES (6, 'DIAMOND', 5000.00, 5, 7.00, 250.00, 5000.00, 3.00, 10.00, 1000.00, 1, '2021-01-17 00:30:35', '2021-01-24 12:42:01', NULL);
INSERT INTO `paket` VALUES (7, 'CROWN', 10000.00, 9, 7.00, 500.00, 10000.00, 3.00, 10.00, 1000.00, 1, '2021-01-24 13:26:44', '2021-01-24 13:26:44', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_currency` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entered_amount` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_currency` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway_id` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
INSERT INTO `payment` VALUES (2, 'andifajarlah@gmail.com', 'ETH', '10', 'ETH', '10.00000000', 'CPFB1GXSOKSJVSST5AEBDAGLL0', 'https://www.coinpayments.net/index.php?cmd=status&id=CPFB1GXSOKSJVSST5AEBDAGLL0&key=48f1f184cc4a7f1f90f8a690f5dfa826', 'initilaized', '2021-02-03 12:33:56', '2021-02-03 12:33:56');
COMMIT;

-- ----------------------------
-- Table structure for pencapaian
-- ----------------------------
DROP TABLE IF EXISTS `pencapaian`;
CREATE TABLE `pencapaian` (
  `pencapaian_id` bigint NOT NULL AUTO_INCREMENT,
  `peringkat_id` bigint DEFAULT NULL,
  `anggota_id` bigint DEFAULT NULL,
  `proses` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pencapaian_id`),
  KEY `peringkat_id` (`peringkat_id`),
  KEY `anggota_id` (`anggota_id`),
  CONSTRAINT `pencapaian_ibfk_1` FOREIGN KEY (`peringkat_id`) REFERENCES `peringkat` (`peringkat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pencapaian_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for pendapatan
-- ----------------------------
DROP TABLE IF EXISTS `pendapatan`;
CREATE TABLE `pendapatan` (
  `pendapatan_id` bigint NOT NULL AUTO_INCREMENT,
  `pendapatan_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pendapatan_jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pendapatan_jumlah` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`pendapatan_id`),
  KEY `pendapatan_ibfk_1` (`transaksi_id`),
  CONSTRAINT `pendapatan_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for pengguna
-- ----------------------------
DROP TABLE IF EXISTS `pengguna`;
CREATE TABLE `pengguna` (
  `pengguna_id` bigint NOT NULL AUTO_INCREMENT,
  `pengguna_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pengguna_kata_sandi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pengguna_nama` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pengguna_foto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `remember_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pengguna_id`),
  UNIQUE KEY `pengguna_uid` (`pengguna_uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of pengguna
-- ----------------------------
BEGIN;
INSERT INTO `pengguna` VALUES (1, 'administrator', '$2y$10$yjJhDISo1cbZ03jIA/PLFeCa1AhUBrhLI8bs3WeBQea93tEmNm8Ty', 'Administrator', NULL, NULL, '2021-01-14 00:00:00', '2021-02-02 04:45:59', NULL);
COMMIT;

-- ----------------------------
-- Table structure for peringkat
-- ----------------------------
DROP TABLE IF EXISTS `peringkat`;
CREATE TABLE `peringkat` (
  `peringkat_id` bigint NOT NULL AUTO_INCREMENT,
  `peringkat_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `peringkat_omset_min` decimal(65,2) NOT NULL,
  `peringkat_bonus` decimal(65,2) NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`peringkat_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `peringkat_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of peringkat
-- ----------------------------
BEGIN;
INSERT INTO `peringkat` VALUES (1, 'Bronze', 10000.00, 350.00, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `peringkat` VALUES (2, 'Silver', 100000.00, 3500.00, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `peringkat` VALUES (3, 'Gold', 350000.00, 10000.00, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
INSERT INTO `peringkat` VALUES (4, 'Platinum', 3500000.00, 35000.00, 1, '2021-01-27 00:00:00', '2021-01-27 00:00:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `permissions_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for pin
-- ----------------------------
DROP TABLE IF EXISTS `pin`;
CREATE TABLE `pin` (
  `pin_id` bigint NOT NULL AUTO_INCREMENT,
  `pin_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin_debit` int NOT NULL,
  `pin_kredit` int NOT NULL,
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`pin_id`),
  KEY `pin_pengguna_id_fkey` (`anggota_id`),
  KEY `pin_ibfk_1` (`transaksi_id`),
  CONSTRAINT `pin_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pin_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of pin
-- ----------------------------
BEGIN;
INSERT INTO `pin` VALUES (67, 'Member registration on behalf of tes', 3, 0, 'oE7Y6jpAUS-202102060315021612581302259', 50, '2021-02-06 03:15:02', '2021-02-06 03:15:02');
INSERT INTO `pin` VALUES (68, 'Member registration on behalf of tes', 3, 0, '4bgxwXCYBa-202102060316171612581377335', 50, '2021-02-06 03:16:17', '2021-02-06 03:16:17');
COMMIT;

-- ----------------------------
-- Table structure for referal
-- ----------------------------
DROP TABLE IF EXISTS `referal`;
CREATE TABLE `referal` (
  `referal_id` bigint NOT NULL AUTO_INCREMENT,
  `referal_token` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anggota_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`referal_id`),
  UNIQUE KEY `referal_ibfk_1` (`anggota_id`) USING BTREE,
  UNIQUE KEY `referal_token` (`referal_token`),
  CONSTRAINT `referal_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of referal
-- ----------------------------
BEGIN;
INSERT INTO `referal` VALUES (6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `referal` VALUES (45, 'E2hJO9KGNdwinEfEOpGf1AzBjVcsqIeWPXQmuZUB51', 51, '2021-02-06 03:15:02', '2021-02-06 03:15:02', NULL);
INSERT INTO `referal` VALUES (46, 'b5FOZhACreIoY9yY0H2nYuTFlMkXiJY7ZSSIL5Oy52', 52, '2021-02-06 03:16:17', '2021-02-06 03:16:17', NULL);
COMMIT;

-- ----------------------------
-- Table structure for reinvest
-- ----------------------------
DROP TABLE IF EXISTS `reinvest`;
CREATE TABLE `reinvest` (
  `reinvest_id` bigint NOT NULL AUTO_INCREMENT,
  `anggota_id` bigint NOT NULL,
  `transaksi_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`reinvest_id`),
  KEY `reinvest_pengguna_id_fkey` (`anggota_id`),
  KEY `reinvest_ibfk_1` (`transaksi_id`),
  CONSTRAINT `reinvest_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reinvest_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`) USING BTREE,
  KEY `role_has_permissions_role_id_foreign` (`role_id`) USING BTREE,
  CONSTRAINT `role_has_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roles_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (1, 'super-admin', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');
INSERT INTO `roles` VALUES (2, 'user', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');
INSERT INTO `roles` VALUES (3, 'guest', 'web', '2019-04-24 03:38:59', '2019-04-24 03:38:59');
COMMIT;

-- ----------------------------
-- Table structure for saldo
-- ----------------------------
DROP TABLE IF EXISTS `saldo`;
CREATE TABLE `saldo` (
  `saldo_id` bigint NOT NULL AUTO_INCREMENT,
  `saldo_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `saldo_debit` decimal(65,2) NOT NULL,
  `saldo_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`saldo_id`),
  KEY `saldo_wallet_id_fkey` (`anggota_id`),
  KEY `saldo_transaksi_id_fkey` (`transaksi_id`),
  CONSTRAINT `saldo_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `saldo_transaksi_id_fkey` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of saldo
-- ----------------------------
BEGIN;
INSERT INTO `saldo` VALUES (81, 'Member registration on behalf of tes', 2000.00, 0.00, 'oE7Y6jpAUS-202102060315021612581302259', 50, '2021-02-06 03:15:02', '2021-02-06 03:15:02');
INSERT INTO `saldo` VALUES (82, 'Member registration on behalf of tes', 2000.00, 0.00, '4bgxwXCYBa-202102060316171612581377335', 50, '2021-02-06 03:16:17', '2021-02-06 03:16:17');
COMMIT;

-- ----------------------------
-- Table structure for transaksi
-- ----------------------------
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE `transaksi` (
  `transaksi_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaksi_keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`transaksi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of transaksi
-- ----------------------------
BEGIN;
INSERT INTO `transaksi` VALUES ('4bgxwXCYBa-202102060316171612581377335', 'Member registration on behalf of tes by fajar', '2021-02-06 03:16:17', '2021-02-06 03:16:17');
INSERT INTO `transaksi` VALUES ('oE7Y6jpAUS-202102060315021612581302259', 'Member registration on behalf of tes by fajar', '2021-02-06 03:15:02', '2021-02-06 03:15:02');
COMMIT;

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `wallet_id` bigint NOT NULL AUTO_INCREMENT,
  `wallet_kode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `wallet_wallet_kode_idx` (`wallet_kode`) USING BTREE,
  KEY `wallet_ibfk_1` (`anggota_id`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for withdraw
-- ----------------------------
DROP TABLE IF EXISTS `withdraw`;
CREATE TABLE `withdraw` (
  `withdraw_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `withdraw_jumlah` decimal(65,30) NOT NULL,
  `kurs_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`withdraw_id`),
  KEY `wallet_id` (`wallet_id`),
  KEY `kurs_id` (`kurs_id`),
  CONSTRAINT `withdraw_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`wallet_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `withdraw_ibfk_2` FOREIGN KEY (`kurs_id`) REFERENCES `kurs` (`kurs_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
