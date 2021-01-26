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

 Date: 26/01/2021 17:13:02
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
  `anggota_jaringan` longtext ,
  `anggota_parent` bigint DEFAULT NULL,
  `anggota_parent_posisi` smallint DEFAULT NULL,
  `paket_id` bigint NOT NULL,
  `negara_id` bigint NOT NULL,
  `jatuh_tempo` date DEFAULT NULL,
  `peringkat_id` bigint DEFAULT NULL,
  `remember_token` text ,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`anggota_id`),
  UNIQUE KEY `anggota_email` (`anggota_email`),
  UNIQUE KEY `anggota_hp` (`anggota_hp`),
  UNIQUE KEY `anggota_uid` (`anggota_uid`,`anggota_email`) USING BTREE,
  KEY `anggota_paket_id_fkey` (`paket_id`),
  KEY `anggota_peringkat_id_fkey` (`peringkat_id`),
  CONSTRAINT `anggota_paket_id_fkey` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`paket_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `anggota_peringkat_id_fkey` FOREIGN KEY (`peringkat_id`) REFERENCES `peringkat` (`peringkat_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 ;

-- ----------------------------
-- Records of anggota
-- ----------------------------
BEGIN;
INSERT INTO `anggota` VALUES (1, 'andi', '$2y$10$D0JYxiqw5ZrGuCvwXuTpfeB4CyJF.5Y1uDSKUMSr1GuftL0eRuIRm', 'Andi Fajar Nugraha', 'andifajarlaah@gmail.com', '081803747336', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, '2021-01-19 11:47:34', '2021-01-26 02:37:22', NULL);
INSERT INTO `anggota` VALUES (2, '', '', 'fajar', 'afaj@faj.com', '62123123123123', '1ka', 1, 1, 1, 1, NULL, NULL, NULL, '2021-01-24 10:41:37', '2021-01-24 12:36:29', NULL);
INSERT INTO `anggota` VALUES (7, NULL, NULL, 'Andi Fajar Nugraha', 'andifajarlah@gmail.com', NULL, '1ki', 1, 0, 1, 1, NULL, NULL, NULL, '2021-01-26 04:33:51', '2021-01-26 04:33:51', NULL);
COMMIT;

-- ----------------------------
-- Table structure for bagi_hasil
-- ----------------------------
DROP TABLE IF EXISTS `bagi_hasil`;
CREATE TABLE `bagi_hasil` (
  `bagi_hasil_id` bigint NOT NULL,
  `bagi_hasil_keterangan` text  NOT NULL,
  `bagi_hasil_jenis` varchar(255)  NOT NULL,
  `bagi_hasil_debit` decimal(65,30) NOT NULL,
  `bagi_hasil_kredit` decimal(65,30) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bagi_hasil_id`),
  KEY `bagi_hasil_pengguna_id_fkey` (`anggota_id`),
  KEY `transaksi_id` (`transaksi_id`),
  CONSTRAINT `bagi_hasil_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bagi_hasil_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

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
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for bonus_pin
-- ----------------------------
DROP TABLE IF EXISTS `bonus_pin`;
CREATE TABLE `bonus_pin` (
  `bonus_pin_id` bigint NOT NULL AUTO_INCREMENT,
  `bonus_pin_keterangan` text  NOT NULL,
  `bonus_pin_debit` decimal(65,30) NOT NULL,
  `bonus_pin_kredit` decimal(65,30) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`bonus_pin_id`),
  KEY `bonus_pin_pengguna_id_fkey` (`anggota_id`),
  KEY `bonus_pin_ibfk_1` (`transaksi_id`),
  CONSTRAINT `bonus_pin_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bonus_pin_ibfk_2` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

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
  `kurs_beli` decimal(65,30) NOT NULL,
  `kurs_jual` decimal(65,30) NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`kurs_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `kurs_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

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
  `negara_nama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negara_kode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `paket` VALUES (1, 'paket $1,000', 1000.00, 1, 1, '2021-01-15 03:09:38', '2021-01-24 12:41:50', NULL);
INSERT INTO `paket` VALUES (2, 'tes', 123123123.00, 1, 1, '2021-01-15 03:13:35', '2021-01-24 12:41:57', '2021-01-24 12:41:57');
INSERT INTO `paket` VALUES (3, 'asdfasdf', 2312.00, 1, 1, '2021-01-15 03:14:11', '2021-01-24 12:41:58', '2021-01-24 12:41:58');
INSERT INTO `paket` VALUES (4, '123', 213123123.00, 1, 1, '2021-01-15 10:39:09', '2021-01-24 12:41:59', '2021-01-24 12:41:59');
INSERT INTO `paket` VALUES (5, '123123', 123123123.00, 1, 1, '2021-01-17 00:30:00', '2021-01-24 12:42:00', '2021-01-24 12:42:00');
INSERT INTO `paket` VALUES (6, '12', 22222.00, 1, 1, '2021-01-17 00:30:35', '2021-01-24 12:42:01', '2021-01-24 12:42:01');
INSERT INTO `paket` VALUES (7, '100', 100.00, 2, 1, '2021-01-24 13:26:44', '2021-01-24 13:26:44', NULL);
COMMIT;

-- ----------------------------
-- Table structure for pendapatan
-- ----------------------------
DROP TABLE IF EXISTS `pendapatan`;
CREATE TABLE `pendapatan` (
  `pendapatan_id` bigint NOT NULL AUTO_INCREMENT,
  `pendapatan_keterangan` text  NOT NULL,
  `pendapatan_jenis` varchar(255)  NOT NULL,
  `pendapatan_jumlah` decimal(65,30) NOT NULL,
  `transaksi_id` varchar(255)  NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`pendapatan_id`),
  KEY `pendapatan_ibfk_1` (`transaksi_id`),
  CONSTRAINT `pendapatan_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB ;

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
INSERT INTO `pengguna` VALUES (1, 'administrator', '$2y$10$/n4bWYmgbTZm5rPGRBHYduzI0Lx9qwBTMi1paf6qBHsNjKqQRTt.i', 'Administrator', NULL, NULL, '2021-01-14 00:00:00', '2021-01-24 10:46:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for peringkat
-- ----------------------------
DROP TABLE IF EXISTS `peringkat`;
CREATE TABLE `peringkat` (
  `peringkat_id` bigint NOT NULL AUTO_INCREMENT,
  `peringkat_nama` varchar(255)  NOT NULL,
  `peringkat_omset_min` decimal(65,30) NOT NULL,
  `peringkat_bonus` decimal(65,30) NOT NULL,
  `pengguna_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`peringkat_id`),
  KEY `pengguna_id` (`pengguna_id`),
  CONSTRAINT `peringkat_ibfk_1` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`pengguna_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB ;

-- ----------------------------
-- Table structure for permintaan
-- ----------------------------
DROP TABLE IF EXISTS `permintaan`;
CREATE TABLE `permintaan` (
  `permintaan_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permintaan_jenis` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permintaan_jumlah` decimal(65,2) NOT NULL,
  `anggota_id` bigint NOT NULL,
  `proses` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=12 ;

-- ----------------------------
-- Records of pin
-- ----------------------------
BEGIN;
INSERT INTO `pin` VALUES (1, 'Buy 1 registration ticket', 0, 1, 'I5WjcBjbxLb1uPP-202101241028331611484113034', 1, '2021-01-24 10:28:33', '2021-01-24 10:28:33');
INSERT INTO `pin` VALUES (2, 'Buy 1 registration ticket', 0, 1, 'kjRJFVwG0IwNghY-202101241031111611484271815', 1, '2021-01-24 10:31:11', '2021-01-24 10:31:11');
INSERT INTO `pin` VALUES (3, 'Buy 1 registration ticket', 0, 1, 'XtTlDCxutLkW84LD-202101241031561611484316739', 1, '2021-01-24 10:31:56', '2021-01-24 10:31:56');
INSERT INTO `pin` VALUES (6, 'Member registration on behalf of fajar', 1, 0, 'qktukm1cqH-202101241041371611484897110', 1, '2021-01-24 10:41:37', '2021-01-24 10:41:37');
INSERT INTO `pin` VALUES (7, 'Member registration on behalf of fajar', 1, 0, 'kB4t0AGEtj-202101241042471611484967567', 1, '2021-01-24 10:42:47', '2021-01-24 10:42:47');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 ;

-- ----------------------------
-- Records of referal
-- ----------------------------
BEGIN;
INSERT INTO `referal` VALUES (1, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 1, '2021-01-19 11:54:03', '2021-01-19 07:54:56', '2021-01-19 07:54:56');
INSERT INTO `referal` VALUES (4, 'AGoRNhA9Pxkl5aIsQ2vUPQm9lqfWJnHpxooxDxq32', 2, '2021-01-24 10:41:37', '2021-01-24 12:36:29', '2021-01-24 12:36:29');
INSERT INTO `referal` VALUES (6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `referal` VALUES (10, 'VxdzplCwNrrZOCvC0NI6Isnbr3qoOuGVCzUUsOmT7', 7, '2021-01-26 04:33:51', '2021-01-26 04:33:51', NULL);
COMMIT;

-- ----------------------------
-- Table structure for reinvest
-- ----------------------------
DROP TABLE IF EXISTS `reinvest`;
CREATE TABLE `reinvest` (
  `reinvest_id` bigint NOT NULL AUTO_INCREMENT,
  `kurs_id` bigint NOT NULL,
  `anggota_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`reinvest_id`),
  KEY `reinvest_kurs_id_fkey` (`kurs_id`),
  KEY `reinvest_pengguna_id_fkey` (`anggota_id`),
  CONSTRAINT `reinvest_ibfk_1` FOREIGN KEY (`kurs_id`) REFERENCES `kurs` (`kurs_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
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
) ENGINE=InnoDB AUTO_INCREMENT=24 ;

-- ----------------------------
-- Records of saldo
-- ----------------------------
BEGIN;
INSERT INTO `saldo` VALUES (6, 'tes', 0.00, 100000.00, 'sadfasdf1as 23 234234', 1, '2021-01-23 00:00:00', '2021-01-23 00:00:00');
INSERT INTO `saldo` VALUES (11, 'Buy 1 registration ticket', 10.00, 0.00, 'I5WjcBjbxLb1uPP-202101241028331611484113034', 1, '2021-01-24 10:28:33', '2021-01-24 10:28:33');
INSERT INTO `saldo` VALUES (12, 'Buy 1 registration ticket', 10.00, 0.00, 'kjRJFVwG0IwNghY-202101241031111611484271815', 1, '2021-01-24 10:31:11', '2021-01-24 10:31:11');
INSERT INTO `saldo` VALUES (13, 'Buy 1 registration ticket', 10.00, 0.00, 'XtTlDCxutLkW84LD-202101241031561611484316739', 1, '2021-01-24 10:31:56', '2021-01-24 10:31:56');
INSERT INTO `saldo` VALUES (18, 'Member registration on behalf of fajar', 10000.00, 0.00, 'qktukm1cqH-202101241041371611484897110', 1, '2021-01-24 10:41:37', '2021-01-24 10:41:37');
INSERT INTO `saldo` VALUES (19, 'Member registration on behalf of fajar', 10000.00, 0.00, 'kB4t0AGEtj-202101241042471611484967567', 1, '2021-01-24 10:42:47', '2021-01-24 10:42:47');
COMMIT;

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
-- Records of transaksi
-- ----------------------------
BEGIN;
INSERT INTO `transaksi` VALUES ('I5WjcBjbxLb1uPP-202101241028331611484113034', 'Buy 1 registration ticket  by andi', '2021-01-24 10:28:33', '2021-01-24 10:28:33');
INSERT INTO `transaksi` VALUES ('kB4t0AGEtj-202101241042471611484967567', 'Member registration on behalf of fajar by andi', '2021-01-24 10:42:47', '2021-01-24 10:42:47');
INSERT INTO `transaksi` VALUES ('kjRJFVwG0IwNghY-202101241031111611484271815', 'Buy 1 registration ticket  by andi', '2021-01-24 10:31:11', '2021-01-24 10:31:11');
INSERT INTO `transaksi` VALUES ('qktukm1cqH-202101241041371611484897110', 'Member registration on behalf of fajar by andi', '2021-01-24 10:41:37', '2021-01-24 10:41:37');
INSERT INTO `transaksi` VALUES ('sadfasdf1as 23 234234', 'tes', '2021-01-23 00:00:00', '2021-01-23 00:00:00');
INSERT INTO `transaksi` VALUES ('XtTlDCxutLkW84LD-202101241031561611484316739', 'Buy 1 registration ticket  by andi', '2021-01-24 10:31:56', '2021-01-24 10:31:56');
COMMIT;

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
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`anggota_id`) REFERENCES `anggota` (`anggota_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of wallet
-- ----------------------------
BEGIN;
INSERT INTO `wallet` VALUES (1, 'walet12345', 1, NULL, NULL, NULL);
COMMIT;

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
