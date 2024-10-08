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
CREATE DATABASE IF NOT EXISTS `clinica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clinica`;

-- Volcando estructura para tabla clinica.module
CREATE TABLE IF NOT EXISTS `module` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order` int NOT NULL,
  `link` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.module: ~1 rows (aproximadamente)
DELETE FROM `module`;
INSERT INTO `module` (`id`, `name`, `order`, `link`, `icon`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Pacientes', 1, 'paciente', 'bi bi-person me-2', '2024-10-05 15:11:37', 1, '2024-10-06 17:16:49', 1, NULL, NULL),
	(2, 'Empleados', 1, 'empleado', 'bi bi-person me-2', '2024-10-05 15:11:37', 1, '2024-10-06 17:16:49', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.permission
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `create_operation` int unsigned NOT NULL,
  `update_operation` int unsigned NOT NULL,
  `delete_operation` int unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.permission: ~2 rows (aproximadamente)
DELETE FROM `permission`;
INSERT INTO `permission` (`id`, `role_id`, `module_id`, `create_operation`, `update_operation`, `delete_operation`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 1, 1, 1, 1, 1, '2024-10-06 17:20:19', 1, '2024-10-06 22:05:06', 1, NULL, NULL),
	(2, 1, 2, 1, 1, 1, '2024-10-06 19:50:27', 1, '2024-10-06 20:07:55', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.product
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.session_tokens: ~60 rows (aproximadamente)
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
	(12, 1, 'e1ed0f0b0ee647053029783760091688ed8346b12efeab6ef60c7c1c46665a49', '2024-10-05 15:52:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-05 14:52:16', 1, '2024-10-06 09:07:21', 1, '2024-10-06 09:07:15', 1),
	(13, 2, '6e96d34eb533572146aacfaf147c46a9493366ff11681b309eba4b14afcb2293', '3600-10-05 22:10:10', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:10:10', 2, '2024-10-05 22:10:51', 2, '2024-10-05 00:00:00', 2),
	(14, 2, '9a77f4146f8f527b5ef83f145886743b59259a51dcab389c1387c94eac28e8f9', '3600-10-05 22:10:51', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:10:51', 2, '2024-10-05 22:13:16', 2, '2024-10-05 00:00:00', 2),
	(15, 2, '325501215be43c6f440662951f18d1502f6c92901460d2a92614991c0f22bcff', '3600-10-05 22:13:16', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:13:16', 2, '2024-10-05 22:13:30', 2, '2024-10-05 00:00:00', 2),
	(16, 2, '9d961bdb4e76d8c617cea5f3cf7824cd67474d4265b183060ad0d09f724ee4f6', '3600-10-05 22:13:30', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:13:30', 2, '2024-10-05 22:14:32', 2, '2024-10-05 00:00:00', 2),
	(17, 2, '70acfd5d308dca9dd8a2b44ce0e946b5451920d023570359d59239286880e5ee', '3600-10-05 22:14:32', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:14:32', 2, '2024-10-05 22:16:06', 2, '2024-10-05 00:00:00', 2),
	(18, 2, '03929d1b3efc0c4d94a09aeb4f53710eb435a252925a99d8fbc141710640716c', '3600-10-05 22:16:06', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:16:06', 2, '2024-10-05 22:17:20', 2, '2024-10-05 00:00:00', 2),
	(19, 2, 'aa2732eb1fa940dc96cfc99bd6428e13ccd47e8a7af0227f854fcbb1451bb602', '3600-10-05 22:17:20', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:17:20', 2, '2024-10-05 22:18:29', 2, '2024-10-05 00:00:00', 2),
	(20, 2, '44b26da92b57d5d97c9879e2c2c28c42b10e9b3b2e2d2167dd4140e07c8d9102', '2024-10-05 23:18:29', '::1', 'PostmanRuntime/7.42.0', '2024-10-05 22:18:29', 2, '2024-10-06 08:24:35', 2, '2024-10-06 00:00:00', 2),
	(21, 2, '95601ec1ded79167f11801eca98ff5169945356ed74e3cbf3430f5221a47570a', '2024-10-06 09:24:35', '127.0.0.1', 'Thunder Client (https://www.thunderclient.com)', '2024-10-06 08:24:35', 2, '2024-10-06 09:07:59', 2, '2024-10-06 00:00:00', 2),
	(22, 2, '9cc40fcf55c7ac430a651280da234d59d2fc6ea5dd508cc0f2a481201fda1257', '2024-10-06 10:07:59', '::1', 'PostmanRuntime/7.42.0', '2024-10-06 09:07:59', 2, '2024-10-06 09:20:51', 2, '2024-10-06 00:00:00', 2),
	(23, 2, '6cacb92097c21537395b6bf86674b725abc690168e4fc0cebf05c68a4729caf0', '2024-10-06 10:20:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:20:51', 2, '2024-10-06 09:22:05', 2, '2024-10-06 00:00:00', 2),
	(24, 2, 'dc61f4b316e884bb7a57192bdfddfc2d026cc6535bbde398fde20f7cdfbb923c', '2024-10-06 10:22:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:22:05', 2, '2024-10-06 09:26:39', 2, '2024-10-06 00:00:00', 2),
	(25, 2, '9b5c23204532d1a4955f24028e135323c82bd4d2e5bee19662fc42d8c7d8b9b1', '2024-10-06 10:26:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:26:39', 2, '2024-10-06 09:30:04', 2, '2024-10-06 00:00:00', 2),
	(26, 2, '08bf5b61a1617e8e000ed8fcaa62fb9c2f2bf393690f710c974dd1c1036f86de', '2024-10-06 10:30:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:30:04', 2, '2024-10-06 09:30:42', 2, '2024-10-06 00:00:00', 2),
	(27, 2, '52a25e8035672d6bd993ef2ffd04be7f2b7c814fc0f9c8f5a8b6fbf5125f5af1', '2024-10-06 10:30:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:30:42', 2, '2024-10-06 09:40:57', 2, '2024-10-06 00:00:00', 2),
	(28, 2, 'c0bfabcf0742541bec4530887a302598fb1346ae48dc814ca5d6b93ea47f2ee0', '2024-10-06 10:40:57', '::1', 'PostmanRuntime/7.42.0', '2024-10-06 09:40:57', 2, '2024-10-06 09:47:36', 2, '2024-10-06 00:00:00', 2),
	(29, 2, '86a577205eea92a45388283972355e1f570dbc1efaaa592a82c76d3a6592cf6b', '2024-10-06 10:47:36', '::1', 'PostmanRuntime/7.42.0', '2024-10-06 09:47:36', 2, '2024-10-06 09:49:31', 2, '2024-10-06 00:00:00', 2),
	(30, 2, 'c0487cc3c66ca98900cc66e779abdebad69145dd61c2470fecda836b15763bb9', '2024-10-06 10:49:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:49:31', 2, '2024-10-06 09:49:38', 2, '2024-10-06 00:00:00', 2),
	(31, 2, 'd24c9e9e031c88f4a5252b1c20cdadfd4401d4af60294fee08370b0ab96db778', '2024-10-06 10:49:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:49:38', 2, '2024-10-06 09:50:14', 2, '2024-10-06 00:00:00', 2),
	(32, 2, '507ea838af289909a02b19eaefbd034ec980fff18104dce303f303c133361471', '2024-10-06 10:50:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:50:14', 2, '2024-10-06 09:52:51', 2, '2024-10-06 00:00:00', 2),
	(33, 2, '8dc08090f97d7cbdc5d74472977eb9332fe056dc69efcd49863942f5ce4d7fbd', '2024-10-06 10:52:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:52:51', 2, '2024-10-06 09:52:57', 2, '2024-10-06 00:00:00', 2),
	(34, 2, '3929578e89d40ea6e58d2580ba9ba7a90aed70862462c03b9ec1e970a3daf950', '2024-10-06 10:52:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:52:57', 2, '2024-10-06 09:55:18', 2, '2024-10-06 00:00:00', 2),
	(35, 2, '6f70f3265517c3806f82eeccccd40abaf1e983a00d34dedd2a47ab390a1372cb', '2024-10-06 10:55:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:55:18', 2, '2024-10-06 09:55:39', 2, '2024-10-06 00:00:00', 2),
	(36, 2, 'd9fea5473ff46e06a1499f9a0c7ae29ee340132b87e4449e1039d230e0169145', '2024-10-06 10:55:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:55:39', 2, '2024-10-06 09:58:09', 2, '2024-10-06 00:00:00', 2),
	(37, 2, '0ba421982e4865db9d71faa7b6bd4c1bceda4a1e8c0bc14a20027239d9271564', '2024-10-06 10:58:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:58:09', 2, '2024-10-06 09:59:03', 2, '2024-10-06 00:00:00', 2),
	(38, 2, '25e90e6c40a9abf6c6053a2756f534182936644aa7cd084f5b98f4f70423b75c', '2024-10-06 10:59:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 09:59:03', 2, '2024-10-06 10:20:14', 2, '2024-10-06 00:00:00', 2),
	(39, 2, 'ea3f5a9f03ac6ed8bf222512ba3ba3faff6626f6e0a867a83d33658869fe2da6', '2024-10-06 11:20:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 10:20:14', 2, '2024-10-06 11:21:41', 2, '2024-10-06 00:00:00', 2),
	(40, 2, '095e0570d2910c7d69e12a37702a16c368c5ecf0574ca4a542af5f2ae616f488', '2024-10-06 12:21:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 11:21:41', 2, '2024-10-06 11:39:05', 2, '2024-10-06 00:00:00', 2),
	(41, 2, 'c2426d5ea10d8ff455a1b250ecc2ae9fb2c190d4600e893b7d020e5eed9e480d', '2024-10-06 12:39:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 11:39:05', 2, '2024-10-06 11:41:00', 2, '2024-10-06 00:00:00', 2),
	(42, 2, '29569291b2f79574ddbc77241877a6b9028346c42c73bd981864282934718767', '2024-10-06 13:41:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 11:41:00', 2, '2024-10-06 14:11:03', 2, '2024-10-06 00:00:00', 2),
	(43, 2, 'e83689af0f798aea97e32007fdf52c32a9260f9f405d6becb2b702f224d1456f', '2024-10-06 15:11:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 14:11:03', 2, '2024-10-06 14:28:29', 2, '2024-10-06 00:00:00', 2),
	(44, 2, '4ea5eafeeae168b170b225678d46b9657c4155878778798df912fc27f3c81cda', '2024-10-06 15:28:29', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 14:28:29', 2, '2024-10-06 14:30:40', 2, '2024-10-06 00:00:00', 2),
	(45, 2, '25c00f1a9dbd74be7934035ebe264262c0fc0231de1587f3f09f86e59895e51e', '2024-10-06 12:30:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 14:30:40', 2, '2024-10-06 15:34:41', 2, '2024-10-06 00:00:00', 2),
	(46, 2, '890048b8f3f3c5d452493162439c67f7f4f20de20663a984c262290617ea8cc0', '2024-10-06 15:34:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 15:34:41', 2, '2024-10-06 16:29:47', 2, '2024-10-06 00:00:00', 2),
	(47, 2, 'da1257b98bd894a584ea78a872c465fa161cd711556a3f77d65f2a349613494a', '2024-10-06 22:29:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 16:29:47', 2, '2024-10-06 19:24:11', 2, '2024-10-06 00:00:00', 2),
	(48, 2, '797e73c39c06e531a49a07041027fca3bb17fb80c402fe5ca5402869b1a615ce', '2024-10-06 21:51:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 18:51:38', 2, '2024-10-06 20:16:28', 2, '2024-10-06 00:00:00', 2),
	(49, 2, 'ea04b30bbd31504286b1c21ecb391addbc41eeb259f1bdc9dcacbfe4ef27bb07', '2024-10-06 21:16:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:16:28', 2, '2024-10-06 20:16:35', 2, '2024-10-06 00:00:00', 2),
	(50, 2, 'bcea8643454db6997b3dea2f78220e8c8a54a2d280dd2a69a514fd61a230ad78', '2024-10-06 21:16:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:16:35', 2, '2024-10-06 20:38:43', 2, '2024-10-06 00:00:00', 2),
	(51, 2, '9c949062a8f4bc4f80096bd1a3f5b7e84cac3d9b3251cbd9c44f649b5fedd392', '2024-10-06 21:38:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:38:43', 2, '2024-10-06 20:44:13', 2, '2024-10-06 00:00:00', 2),
	(52, 2, 'a00e191b9472b2161f25c60e7255f2e85ef3bc6a1b356bd771fdceb1c3138708', '2024-10-06 21:44:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:44:13', 2, '2024-10-06 20:45:06', 2, '2024-10-06 00:00:00', 2),
	(53, 2, 'c1faeb69147a536a56f3a4b8c1279bf6a6bceedafc1a89411eac8d0ab0b0744c', '2024-10-06 21:45:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:45:06', 2, '2024-10-06 20:45:38', 2, '2024-10-06 00:00:00', 2),
	(54, 2, '61d454357850e1d35acadeaada8e92a40f4a84ef0ab87b7245414086c27b998e', '2024-10-06 21:45:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:45:38', 2, '2024-10-06 20:45:53', 2, '2024-10-06 00:00:00', 2),
	(55, 2, '8b96cc689e70ed1406b64852dc9f568cfe71b4ae3010098a68f2067f43a7704d', '2024-10-06 21:45:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:45:53', 2, '2024-10-06 20:48:32', 2, '2024-10-06 00:00:00', 2),
	(56, 2, 'e873847d34f9e2a11ce591dc0cf62b6deb3959cd3585133d1ce8782ee68f2d20', '2024-10-06 21:48:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:48:32', 2, '2024-10-06 20:56:03', 2, '2024-10-06 00:00:00', 2),
	(57, 2, 'd1ac9c0da93239ea35c1fbacd17d514156f7677b8354a53f5d380a49b6412e6e', '2024-10-06 21:56:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:56:03', 2, '2024-10-06 20:56:22', 2, '2024-10-06 00:00:00', 2),
	(58, 2, 'bd614281c85a4bbcc9da7164dd33faba3d88b21499132e6cfd5646e94a31407f', '2024-10-06 21:56:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 20:56:22', 2, '2024-10-06 21:53:24', 2, '2024-10-06 21:02:43', 2),
	(59, 2, 'eb1fba9b67d465f9d4f0543a79cab5ce9fb2dc0633ffeef5e2a61f00851b2a3d', '2024-10-06 22:46:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 21:46:05', 2, '2024-10-06 21:53:25', 2, '2024-10-06 21:53:12', 2),
	(60, 2, '085e7dd59129e59cb8be4872f54bff54a66f20e39455f947ca0a710330cbe2a6', '2024-10-06 22:46:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 21:46:05', 2, '2024-10-06 21:53:26', 2, '2024-10-06 21:53:16', 2),
	(61, 2, '25c8a7354378a3e1d39881e2e3ec2932cac0d0fee85d9496bfe5ae673dcf8ea0', '2024-10-06 22:54:55', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 21:54:55', 2, '2024-10-06 21:57:33', 2, '2024-10-06 00:00:00', 2),
	(62, 2, 'e12eaaa7b66bbfee55b25f71d40953827c93d9a121c554f44da8321f1ec1bf4d', '2024-10-06 22:57:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 21:57:33', 2, '2024-10-06 21:57:33', 2, NULL, NULL);

-- Volcando estructura para tabla clinica.user
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
	(2, 1, 'Henry', 'Rodríguez', 'hrodriguez', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-05-23 19:42:32', 1, '2024-10-06 17:19:57', 1, NULL, NULL),
	(3, 2, 'Juan', 'Yat', 'jyat', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-06-01 16:33:38', 1, '2024-10-05 15:01:47', 1, NULL, NULL),
	(4, 2, 'Wilmer', 'Contreras', 'wcontreras', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', '2024-06-01 17:04:25', 1, '2024-10-05 15:01:59', 1, '2024-06-02 01:55:22', 1),
	(5, 1, 'Jonatan', 'Torres', 'jtorrez', '201bce2458f00a54130c695ca8d1658319b32206d495adf175847b57bd4a4151', '2024-06-01 21:51:02', 1, '2024-10-05 15:02:16', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.view
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
