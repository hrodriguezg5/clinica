-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         8.0.33 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para clinica
DROP DATABASE IF EXISTS `clinica`;
CREATE DATABASE IF NOT EXISTS `clinica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clinica`;

-- Volcando estructura para tabla clinica.module
DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.module: ~0 rows (aproximadamente)
DELETE FROM `module`;
INSERT INTO `module` (`id`, `name`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Pacientes', '2024-10-05 15:11:37', 1, '2024-10-05 15:11:37', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.permission
DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `create` int unsigned NOT NULL,
  `update` int unsigned NOT NULL,
  `delete` int unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_permission_role` (`role_id`),
  KEY `fk_permission_module` (`module_id`),
  CONSTRAINT `fk_permission_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_permission_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.permission: ~0 rows (aproximadamente)
DELETE FROM `permission`;

-- Volcando estructura para tabla clinica.product
DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` int unsigned NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.product: ~3 rows (aproximadamente)
DELETE FROM `product`;
INSERT INTO `product` (`id`, `name`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'GPS3G', 1, '2024-05-29 10:37:49', 1, '2024-05-29 10:37:49', 1, NULL, NULL),
	(2, 'GPS4G', 1, '2024-05-29 10:37:58', 1, '2024-05-29 10:37:58', 1, NULL, NULL),
	(3, 'GPS4G Motocicleta', 1, '2024-05-29 10:38:14', 1, '2024-05-29 10:38:14', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.reservation
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` int unsigned NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `product_quantity` int unsigned NOT NULL,
  `reservation_hour_id` int unsigned DEFAULT NULL,
  `reservation_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reservation_product` (`product_id`),
  CONSTRAINT `fk_reservation_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.reservation: ~26 rows (aproximadamente)
DELETE FROM `reservation`;
INSERT INTO `reservation` (`id`, `first_name`, `last_name`, `email`, `phone_number`, `address`, `product_id`, `product_quantity`, `reservation_hour_id`, `reservation_date`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, '2 Calle 1-25 Zona 8, San Miguel Petapa, Guatemala', 1, 1, 1, '2024-05-30', '2024-05-30 18:37:19', 1, '2024-05-30 18:37:19', 1, NULL, NULL),
	(2, 'Henry', 'Rodriguez', 'hrodriguezhenry@gmail.com', 54573864, 'Lote 144 La Linea', 1, 2, 2, '2024-05-31', '2024-05-30 18:49:36', 1, '2024-05-30 18:49:36', 1, NULL, NULL),
	(3, 'Henry', 'Rodriguez', 'hrodriguezhenry@gmail.com', 54573864, 'Lote 144 La Linea', 2, 4, 2, '2024-05-30', '2024-05-30 18:56:15', 1, '2024-05-30 18:56:15', 1, NULL, NULL),
	(4, 'Javier', 'Rodríguez', 'henry@gmail.com', 54573864, '2 Calle 1-25 Zona 8, San Miguel Petapa, Guatemala', 3, 5, 1, '2024-06-01', '2024-05-30 18:57:51', 1, '2024-06-01 23:53:03', 1, '2024-06-01 23:53:03', 1),
	(5, 'Juan', 'Perez', 'jperez@gmail.com', 54573864, '2 Calle 1-25 Zona 8, San Miguel Petapa, Guatemala', 3, 5, 2, '2024-06-01', '2024-05-30 18:58:00', 1, '2024-06-01 23:53:51', 1, '2024-06-01 23:53:51', 1),
	(6, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 3, 5, 1, '2024-06-15', '2024-05-30 18:58:00', 1, '2024-06-02 01:13:10', 1, NULL, NULL),
	(7, 'Carlos', 'Lopez', 'clopez@gmail.com', 87654567, 'San Miguel Petapa, Guatemala', 3, 5, 4, '2024-06-01', '2024-05-30 18:58:00', 1, '2024-06-01 23:57:01', 1, NULL, NULL),
	(8, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, '2 Calle 1-25 Zona 8, San Miguel Petapa, Guatemala', 3, 5, 5, '2024-06-01', '2024-05-30 18:58:00', 1, '2024-05-30 21:45:58', 1, NULL, NULL),
	(9, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 3, 3, 1, '2024-06-02', '2024-06-01 14:48:32', 1, '2024-06-02 01:13:30', 1, '2024-06-02 01:13:30', 1),
	(10, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 2, 3, 2, '2024-06-02', '2024-06-01 14:50:23', 1, '2024-06-02 01:13:34', 1, '2024-06-02 01:13:34', 1),
	(11, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 3, 4, 3, '2024-06-02', '2024-06-01 15:24:56', 1, '2024-06-02 01:51:19', 1, NULL, NULL),
	(12, 'Javier', 'Geronimo', 'hrodriguezhenry@gmail.com', 54573864, 'Lote 144 La Linea', 2, 3, 5, '2024-06-03', '2024-06-01 16:29:19', 1, '2024-06-01 16:29:19', 1, NULL, NULL),
	(13, 'Henry', 'Rodriguez', 'hrodriguezhenrys@gmail.com', 54573864, 'Lote 144 La Linea', 2, 3, 1, '2024-06-03', '2024-06-01 16:34:38', 1, '2024-06-01 16:34:38', 1, NULL, NULL),
	(14, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 3, 3, 1, '2024-06-14', '2024-06-01 16:49:11', 1, '2024-06-01 16:49:11', 1, NULL, NULL),
	(16, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Boca del monte', 3, 5, 5, '2024-06-02', '2024-06-01 20:31:48', 1, '2024-06-02 00:00:44', 1, NULL, NULL),
	(19, 'Henry', 'Rodríguez', 'hrodriguezhenry@gmail.com', 54573864, 'Villa Canales', 2, 1, 4, '2024-06-02', '2024-06-01 21:46:50', 1, '2024-06-02 01:55:26', 1, '2024-06-02 01:55:26', 1),
	(20, 'Carlos', 'Dominguez', 'cdominguez@gmail.com', 2541123, 'Villa Nueva', 2, 1, 1, '2024-06-04', '2024-06-01 21:54:36', 1, '2024-06-01 21:54:36', 1, NULL, NULL),
	(21, 'Juan', 'Perez', 'jperez@gmail.com', 23658456, 'Petapa', 2, 1, 4, '2024-06-04', '2024-06-01 21:55:23', 1, '2024-06-01 21:55:23', 1, NULL, NULL),
	(22, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 1, 1, 1, '2024-09-09', '2024-09-09 10:48:39', 1, '2024-10-03 20:12:19', 1, '2024-10-03 20:12:19', 1),
	(23, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 1, 2, 2, '2024-09-09', '2024-09-09 10:48:52', 1, '2024-09-09 10:48:52', 1, NULL, NULL),
	(24, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 1, 1, 1, '2024-09-16', '2024-09-16 13:48:41', 1, '2024-09-16 13:48:41', 1, NULL, NULL),
	(25, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 2, 2, 1, '2024-09-18', '2024-09-18 13:22:10', 1, '2024-09-18 13:22:10', 1, NULL, NULL),
	(26, 'Juan', 'Morales', 'jmorales@gmail.com', 25233625, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 2, 1, 2, '2024-09-23', '2024-09-23 13:47:56', 1, '2024-09-23 13:49:22', 5, NULL, NULL),
	(27, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 2, 3, 3, '2024-09-24', '2024-09-24 13:28:43', 1, '2024-09-24 13:28:43', 1, NULL, NULL),
	(28, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 2, 3, 2, '2024-09-24', '2024-09-24 13:28:55', 1, '2024-09-24 13:28:55', 1, NULL, NULL),
	(29, 'Henry', 'Rodriguez', 'hrodriguez@tata.com.gt', 54573864, 'Granjas Gerona, 2 Calle 1-25 Zona 8', 1, 3, 4, '2024-09-25', '2024-09-25 13:31:24', 1, '2024-09-25 13:31:24', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.reservation_hour
DROP TABLE IF EXISTS `reservation_hour`;
CREATE TABLE IF NOT EXISTS `reservation_hour` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hour_order` int unsigned DEFAULT '0',
  `active` int unsigned NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int unsigned NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int unsigned NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.reservation_hour: ~5 rows (aproximadamente)
DELETE FROM `reservation_hour`;
INSERT INTO `reservation_hour` (`id`, `name`, `hour_order`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, '10:00am', 1, 1, '2024-05-30 17:29:44', 1, '2024-05-31 13:41:03', 1, NULL, NULL),
	(2, '11:30am', 2, 1, '2024-05-30 17:29:44', 1, '2024-05-31 13:41:04', 1, NULL, NULL),
	(3, '01:00pm', 3, 1, '2024-05-30 17:29:44', 1, '2024-05-31 13:41:04', 1, NULL, NULL),
	(4, '02:30pm', 4, 1, '2024-05-30 17:29:44', 1, '2024-05-31 13:41:05', 1, NULL, NULL),
	(5, '04:00pm', 5, 1, '2024-05-30 17:29:44', 1, '2024-05-31 13:41:07', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.role: ~2 rows (aproximadamente)
DELETE FROM `role`;
INSERT INTO `role` (`id`, `name`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Administrador', '2024-05-21 19:00:41', 1, '2024-06-02 00:59:28', 1, NULL, NULL),
	(2, 'Doctor', '2024-05-23 18:05:01', 1, '2024-10-05 15:11:24', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.session_tokens
DROP TABLE IF EXISTS `session_tokens`;
CREATE TABLE IF NOT EXISTS `session_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `fk_session_tokens_user` (`user_id`),
  CONSTRAINT `fk_session_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.session_tokens: ~9 rows (aproximadamente)
DELETE FROM `session_tokens`;
INSERT INTO `session_tokens` (`id`, `user_id`, `token`, `expires_at`, `ip_address`, `user_agent`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 1, '2757ca582a84bb1e24ed9e46d4a914220a0022a22e5ce2c8c7ee71b755d29687', '2024-09-25 15:07:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-09-25 14:07:01', 1, '2024-10-03 13:36:28', 1, '2024-10-03 00:00:00', 1),
	(2, 1, '4b7db04da486687c978e993c9696d3cd247f072e46e408be8fe1b67a970858f9', '2024-09-26 15:40:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-09-26 14:40:31', 1, '2024-10-03 13:36:28', 1, '2024-10-03 00:00:00', 1),
	(3, 1, '44e8f1406615896e622a0ec8a0e8553e3e06c84959214d8e098e10ba3dab81ea', '2024-09-26 15:40:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-09-26 14:40:33', 1, '2024-10-03 13:36:28', 1, '2024-10-03 00:00:00', 1),
	(4, 1, '11d8f4c7d6e8c81529d2c5c525430aded769f046c8b2e6dd860093c7cff86c7d', '2024-09-26 15:41:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-09-26 14:41:26', 1, '2024-10-03 13:36:28', 1, '2024-10-03 00:00:00', 1),
	(5, 1, 'a03798f29811d923cb42c1fe0df6e19474982f1e55186b969261ae8f26ed9f00', '2024-10-03 14:36:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 13:36:28', 1, '2024-10-03 13:40:11', 1, '2024-10-03 00:00:00', 1),
	(6, 1, 'cb51e00a20905b021b1e4800a06ec35a6100f0b8de216dab39d3711fa7bbed48', '2024-10-03 14:40:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 13:40:11', 1, '2024-10-03 13:52:29', 1, '2024-10-03 00:00:00', 1),
	(7, 1, 'c51ce7b7b2845676f01736e179b3ef18fff42dcb0723419498e825c30ffa95b1', '2024-10-03 14:52:29', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 13:52:29', 1, '2024-10-03 19:18:40', 1, '2024-10-03 00:00:00', 1),
	(8, 1, 'b37cd05da49c3665deb87779ce4c7b70b9b9ab46c972f120109c7e0cb0919b32', '2024-10-03 20:18:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 19:18:40', 1, '2024-10-03 20:21:21', 1, '2024-10-03 00:00:00', 1),
	(9, 1, '1ab8b5447652cc8285f54a16d1b4b58e4488fa45a79864e746ced373043831bb', '2024-10-03 21:21:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 20:21:21', 1, '2024-10-03 20:23:16', 1, '2024-10-03 00:00:00', 1),
	(10, 1, 'd2376b439704a0c5166fbc486d1f5e6e353ebf0c7e04fbc6eb87601b75499eb5', '2024-10-03 21:23:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 20:23:16', 1, '2024-10-03 21:03:23', 1, '2024-10-03 00:00:00', 1),
	(11, 1, '059d90d6bda7375b5436303ce4b449986decabd8373feb514fb57b52a59e3d7c', '2024-10-03 22:03:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-03 21:03:23', 1, '2024-10-05 14:52:16', 1, '2024-10-05 00:00:00', 1),
	(12, 1, 'e1ed0f0b0ee647053029783760091688ed8346b12efeab6ef60c7c1c46665a49', '2024-10-05 15:52:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-05 14:52:16', 1, '2024-10-05 14:52:16', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role` (`role_id`) USING BTREE,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.user: ~5 rows (aproximadamente)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `role_id`, `first_name`, `last_name`, `username`, `password`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 1, 'Administrador', '', 'admin@gpsgt', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-05-21 19:02:10', 1, '2024-06-02 01:54:32', 1, NULL, NULL),
	(2, 2, 'Henry', 'Rodríguez', 'hrodriguez', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-05-23 19:42:32', 1, '2024-10-05 15:01:29', 1, NULL, NULL),
	(3, 2, 'Juan', 'Yat', 'jyat', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-06-01 16:33:38', 1, '2024-10-05 15:01:47', 1, NULL, NULL),
	(4, 2, 'Wilmer', 'Contreras', 'wcontreras', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-06-01 17:04:25', 1, '2024-10-05 15:01:59', 1, '2024-06-02 01:55:22', 1),
	(5, 1, 'Jonatan', 'Torres', 'jtorrez', '201bce2458f00a54130c695ca8d1658319b32206d495adf175847b57bd4a4151', '2024-06-01 21:51:02', 1, '2024-10-05 15:02:16', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.view
DROP TABLE IF EXISTS `view`;
CREATE TABLE IF NOT EXISTS `view` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.view: ~2 rows (aproximadamente)
DELETE FROM `view`;
INSERT INTO `view` (`id`, `name`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'paciente', 1, '2024-05-21 18:59:55', 1, '2024-10-03 19:57:42', 1, NULL, NULL),
	(2, 'usuario', 1, '2024-05-23 18:04:24', 1, '2024-05-23 18:04:24', 1, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
