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

 Date: 31/01/2021 14:19:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for anggota
-- ----------------------------
DROP TABLE IF EXISTS `anggota`;
CREATE TABLE `anggota` (
  `anggota_id` bigint NOT NULL AUTO_INCREMENT,
  `anggota_uid` varchar(255)  DEFAULT NULL,
  `anggota_kata_sandi` varchar(255)  DEFAULT NULL,
  `anggota_nama` varchar(255)  DEFAULT NULL,
  `anggota_email` varchar(255)  NOT NULL,
  `anggota_hp` varchar(255)  DEFAULT NULL,
  `anggota_jaringan` longtext  NOT NULL,
  `anggota_parent` bigint DEFAULT NULL,
  `anggota_posisi` smallint DEFAULT NULL,
  `paket_harga` decimal(65,2) NOT NULL,
  `negara_id` bigint NOT NULL,
  `jatuh_tempo` date DEFAULT NULL,
  `reinvest` int NOT NULL DEFAULT '1',
  `peringkat_id` bigint DEFAULT NULL,
  `remember_token` text ,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`anggota_id`),
  KEY `anggota_paket_id_fkey` (`paket_harga`),
  KEY `anggota_peringkat_id_fkey` (`peringkat_id`),
  CONSTRAINT `anggota_peringkat_id_fkey` FOREIGN KEY (`peringkat_id`) REFERENCES `peringkat` (`peringkat_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=50 ;

-- ----------------------------
-- Table structure for bagi_hasil
-- ----------------------------
DROP TABLE IF EXISTS `bagi_hasil`;
CREATE TABLE `bagi_hasil` (
  `bagi_hasil_id` bigint NOT NULL AUTO_INCREMENT,
  `bagi_hasil_keterangan` text  NOT NULL,
  `bagi_hasil_jenis` varchar(255)  NOT NULL,
  `bagi_hasil_debit` decimal(65,2) NOT NULL,
  `bagi_hasil_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bagi_hasil_id`),
  KEY `bagi_hasil_pengguna_id_fkey` (`anggota_id`),
  KEY `transaksi_id` (`transaksi_id`),
  CONSTRAINT `bagi_hasil_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bagi_hasil_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 ;

-- ----------------------------
-- Table structure for biaya
-- ----------------------------
DROP TABLE IF EXISTS `biaya`;
CREATE TABLE `biaya` (
  `biaya_id` bigint NOT NULL AUTO_INCREMENT,
  `biaya_nama` varchar(255)  DEFAULT NULL,
  `biaya_harga` decimal(65,30) DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`biaya_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `biaya_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for bonus_pin
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pin`;
CREATE TABLE `bonus_pin` (
  `bonus_pin_id` bigint NOT NULL AUTO_INCREMENT,
  `bonus_pin_keterangan` text  NOT NULL,
  `bonus_pin_debit` decimal(65,2) NOT NULL,
  `bonus_pin_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bonus_pin_id`),
  KEY `bonus_pin_pengguna_id_fkey` (`anggota_id`),
  KEY `bonus_pin_ibfk_1` (`transaksi_id`),
  CONSTRAINT `bonus_pin_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bonus_pin_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 ;

-- ----------------------------
-- Table structure for hari_libur
-- ----------------------------
DROP TABLE IF EXISTS `hari_libur`;
CREATE TABLE `hari_libur` (
  `hari_libur_id` bigint NOT NULL AUTO_INCREMENT,
  `hari_libur_tanggal` varchar(255)  NOT NULL,
  `hari_libur_keterangan` text  NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`hari_libur_id`) USING BTREE,
  UNIQUE KEY `hari_besar_hari_besar_tanggal_idx` (`hari_libur_tanggal`) USING BTREE,
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `hari_libur_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 ;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 ;

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
  `kurs_pembayaran_nama` varchar(255)  DEFAULT NULL,
  `kurs_pembayaran_metode` varchar(255)  DEFAULT NULL,
  `kurs_pembayaran_nilai` decimal(60,10) DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kurs_pembayaran_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 ;

-- ----------------------------
-- Records of kurs_pembayaran
-- ----------------------------
BEGIN;
INSERT INTO `kurs_pembayaran` VALUES (1, 'BitCoin', 'BTC', 0.0020000000, 1, '2021-01-30 00:00:00', '2021-01-30 00:00:00', NULL);
INSERT INTO `kurs_pembayaran` VALUES (2, 'Etherium', 'ETH', 0.1000000000, 1, '2021-01-30 00:00:00', '2021-01-30 00:00:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `model_type` varchar(255)  NOT NULL,
  `model_id` bigint NOT NULL,
  PRIMARY KEY (`permission_id`,`model_type`,`model_id`) USING BTREE,
  KEY `model_has_permissions_model_id_model_type_index` (`model_type`) USING BTREE,
  KEY `izin_pengguna_fk` (`model_id`) USING BTREE,
  CONSTRAINT `model_has_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `model_has_permissions_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` int unsigned NOT NULL,
  `model_type` varchar(255)  NOT NULL,
  `model_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`,`model_type`,`model_id`) USING BTREE,
  KEY `model_has_roles_model_id_model_type_index` (`model_type`) USING BTREE,
  KEY `level_pengguna_fk` (`model_id`) USING BTREE,
  CONSTRAINT `model_has_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `model_has_roles_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

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
  `negara_nama` varchar(255)  DEFAULT NULL,
  `negara_kode` varchar(255)  DEFAULT NULL,
  `pengguna_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`negara_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `negara_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 ;

-- ----------------------------
-- Records of negara
-- ----------------------------
BEGIN;
INSERT INTO `negara` VALUES (1, 'Indonesia', '62', 1, NULL, NULL, NULL);
INSERT INTO `negara` VALUES (2, 'Afghanistan', '93', 1, NULL, NULL, NULL);
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
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for paket
-- ----------------------------
DROP TABLE IF EXISTS `paket`;
CREATE TABLE `paket` (
  `paket_id` bigint NOT NULL AUTO_INCREMENT,
  `paket_nama` varchar(255)  NOT NULL,
  `paket_harga` decimal(65,2) NOT NULL,
  `paket_pin` tinyint NOT NULL,
  `paket_min_wd_bagi_hasil` decimal(60,2) DEFAULT NULL,
  `paket_max_wd_bagi_hasil` decimal(60,2) DEFAULT NULL,
  `paket_min_wd_tiket` decimal(60,2) DEFAULT NULL,
  `paket_max_wd_tiket` decimal(60,2) DEFAULT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`paket_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `paket_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 ;

-- ----------------------------
-- Records of paket
-- ----------------------------
BEGIN;
INSERT INTO `paket` VALUES (1, '$ 100', 100.00, 1, 10.00, 100.00, 10.00, 100.00, 1, '2021-01-15 03:09:38', '2021-01-24 12:41:50', NULL);
INSERT INTO `paket` VALUES (2, '$ 200', 200.00, 1, 20.00, 200.00, 10.00, 200.00, 1, '2021-01-15 03:13:35', '2021-01-24 12:41:57', NULL);
INSERT INTO `paket` VALUES (3, '$ 500', 500.00, 1, 50.00, 500.00, 10.00, 500.00, 1, '2021-01-15 03:14:11', '2021-01-24 12:41:58', NULL);
INSERT INTO `paket` VALUES (4, '$ 1000', 1000.00, 1, 100.00, 1000.00, 10.00, 1000.00, 1, '2021-01-15 10:39:09', '2021-01-24 12:41:59', NULL);
INSERT INTO `paket` VALUES (5, '$ 2000', 2000.00, 3, 100.00, 2000.00, 10.00, 1000.00, 1, '2021-01-17 00:30:00', '2021-01-24 12:42:00', NULL);
INSERT INTO `paket` VALUES (6, '$ 5000', 5000.00, 5, 250.00, 5000.00, 10.00, 1000.00, 1, '2021-01-17 00:30:35', '2021-01-24 12:42:01', NULL);
INSERT INTO `paket` VALUES (7, '$ 10000', 10000.00, 9, 500.00, 10000.00, 10.00, 1000.00, 1, '2021-01-24 13:26:44', '2021-01-24 13:26:44', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `from_currency` varchar(500) NOT NULL,
  `entered_amount` varchar(1000) NOT NULL,
  `to_currency` varchar(500) NOT NULL,
  `amount` varchar(50) NOT NULL,
  `gateway_id` varchar(1000) NOT NULL,
  `gateway_url` text NOT NULL,
  `status` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pencapaian
-- ----------------------------
DROP TABLE IF EXISTS `pencapaian`;
CREATE TABLE `pencapaian` (
  `pencapaian_id` bigint NOT NULL AUTO_INCREMENT,
  `peringkat_id` bigint DEFAULT NULL,
  `anggota_id` bigint DEFAULT NULL,
  `proses` text ,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pencapaian_id`),
  KEY `peringkat_id` (`peringkat_id`),
  KEY `anggota_id` (`anggota_id`),
  CONSTRAINT `pencapaian_ibfk_1` FOREIGN KEY (`peringkat_id`) REFERENCES `peringkat` (`peringkat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pencapaian_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

-- ----------------------------
-- Table structure for pendapatan
-- ----------------------------
DROP TABLE IF EXISTS `pendapatan`;
CREATE TABLE `pendapatan` (
  `pendapatan_id` bigint NOT NULL AUTO_INCREMENT,
  `pendapatan_keterangan` text  NOT NULL,
  `pendapatan_jenis` varchar(255)  NOT NULL,
  `pendapatan_jumlah` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`pendapatan_id`),
  KEY `pendapatan_ibfk_1` (`transaksi_id`),
  CONSTRAINT `pendapatan_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 ;

-- ----------------------------
-- Table structure for pengguna
-- ----------------------------
DROP TABLE IF EXISTS `pengguna`;
CREATE TABLE `pengguna` (
  `pengguna_id` bigint NOT NULL AUTO_INCREMENT,
  `pengguna_uid` varchar(255)  NOT NULL,
  `pengguna_kata_sandi` text  NOT NULL,
  `pengguna_nama` text  NOT NULL,
  `pengguna_foto` text ,
  `remember_token` text ,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pengguna_id`),
  UNIQUE KEY `pengguna_uid` (`pengguna_uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of pengguna
-- ----------------------------
BEGIN;
INSERT INTO `pengguna` VALUES (1, 'administrator', '$2y$10$1QwW6dmKaTV6ZQ5C0jhQ0.fWEDdMe0LrVaCJNTiydFBGi7uk4QqAq', 'Administrator', NULL, NULL, '2021-01-14 00:00:00', '2021-01-30 03:46:10', NULL);
COMMIT;

-- ----------------------------
-- Table structure for peringkat
-- ----------------------------
DROP TABLE IF EXISTS `peringkat`;
CREATE TABLE `peringkat` (
  `peringkat_id` bigint NOT NULL AUTO_INCREMENT,
  `peringkat_nama` varchar(255)  NOT NULL,
  `peringkat_omset_min` decimal(65,2) NOT NULL,
  `peringkat_bonus` decimal(65,2) NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`peringkat_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `peringkat_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 ;

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
-- Table structure for permintaan
-- ----------------------------
DROP TABLE IF EXISTS `permintaan`;
CREATE TABLE `permintaan` (
  `permintaan_id` varchar(255)  NOT NULL,
  `permintaan_jenis` varchar(255)  NOT NULL,
  `permintaan_jumlah` decimal(65,2) NOT NULL,
  `anggota_id` bigint NOT NULL,
  `proses` varchar(255)  DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`permintaan_id`),
  KEY `anggota_id` (`anggota_id`),
  CONSTRAINT `permintaan_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191)  NOT NULL,
  `guard_name` varchar(45)  DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `permissions_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for pin
-- ----------------------------
DROP TABLE IF EXISTS `pin`;
CREATE TABLE `pin` (
  `pin_id` bigint NOT NULL AUTO_INCREMENT,
  `pin_keterangan` text  NOT NULL,
  `pin_debit` int NOT NULL,
  `pin_kredit` int NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`pin_id`),
  KEY `pin_pengguna_id_fkey` (`anggota_id`),
  KEY `pin_ibfk_1` (`transaksi_id`),
  CONSTRAINT `pin_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pin_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 ;

-- ----------------------------
-- Table structure for referal
-- ----------------------------
DROP TABLE IF EXISTS `referal`;
CREATE TABLE `referal` (
  `referal_id` bigint NOT NULL AUTO_INCREMENT,
  `referal_token` varchar(300)  DEFAULT NULL,
  `anggota_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`referal_id`),
  UNIQUE KEY `referal_ibfk_1` (`anggota_id`) USING BTREE,
  UNIQUE KEY `referal_token` (`referal_token`),
  CONSTRAINT `referal_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 ;

-- ----------------------------
-- Records of referal
-- ----------------------------
BEGIN;
INSERT INTO `referal` VALUES (6, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for reinvest
-- ----------------------------
DROP TABLE IF EXISTS `reinvest`;
CREATE TABLE `reinvest` (
  `reinvest_id` bigint NOT NULL AUTO_INCREMENT,
  `anggota_id` bigint NOT NULL,
  `transaksi_id` varchar(255)  DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`reinvest_id`),
  KEY `reinvest_pengguna_id_fkey` (`anggota_id`),
  KEY `reinvest_ibfk_1` (`transaksi_id`),
  CONSTRAINT `reinvest_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reinvest_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

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
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191)  NOT NULL,
  `guard_name` varchar(45)  DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roles_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4  ROW_FORMAT=DYNAMIC;

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
  `saldo_keterangan` text  NOT NULL,
  `saldo_debit` decimal(65,2) NOT NULL,
  `saldo_kredit` decimal(65,2) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`saldo_id`),
  KEY `saldo_wallet_id_fkey` (`anggota_id`),
  KEY `saldo_transaksi_id_fkey` (`transaksi_id`),
  CONSTRAINT `saldo_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `saldo_transaksi_id_fkey` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 ;

-- ----------------------------
-- Table structure for transaksi
-- ----------------------------
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE `transaksi` (
  `transaksi_id` varchar(255)  NOT NULL,
  `transaksi_keterangan` text ,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`transaksi_id`)
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `wallet_id` bigint NOT NULL AUTO_INCREMENT,
  `wallet_kode` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `wallet_wallet_kode_idx` (`wallet_kode`) USING BTREE,
  KEY `wallet_ibfk_1` (`anggota_id`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

-- ----------------------------
-- Table structure for withdraw
-- ----------------------------
DROP TABLE IF EXISTS `withdraw`;
CREATE TABLE `withdraw` (
  `withdraw_id` varchar(255)  NOT NULL,
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
) ENGINE=InnoDB ;

SET FOREIGN_KEY_CHECKS = 1;
