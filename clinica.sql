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

-- Volcando estructura para tabla clinica.employee
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` int NOT NULL DEFAULT '0',
  `id_position` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id_position` (`id_position`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`id_position`) REFERENCES `position` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.employee: ~5 rows (aproximadamente)
DELETE FROM `employee`;
INSERT INTO `employee` (`id`, `first_name`, `last_name`, `phone`, `email`, `active`, `id_position`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Jose', 'Monroy', '558523', 'joss@gmail.com', 1, 1, '2024-10-13 12:59:38', 1, '2024-10-13 12:59:44', 1, NULL, NULL),
	(2, 'Henry', 'Rodriguez', '526358', 'hrodirguez@gmail.com', 1, 1, '2024-10-13 14:00:43', 1, '2024-10-16 20:52:23', 2, '2024-10-16 20:52:23', 3),
	(3, 'Dennys', 'Hernandez', '558523', 'dhernadez@gmail.com', 1, 1, '2024-10-13 14:28:21', 1, '2024-10-13 14:28:21', 1, NULL, NULL),
	(4, 'Alejandro', 'Barrientos', '43526987', 'abarrientos@gmail.com', 1, 1, '2024-10-13 14:49:13', 1, '2024-10-13 14:49:13', 1, NULL, NULL),
	(5, 'Alejandro', 'Barrientos', '43526987', 'abarrientos@gmail.com', 1, 1, '2024-10-16 20:51:51', 1, '2024-10-16 20:51:51', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.module
DROP TABLE IF EXISTS `module`;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_link` (`link`),
  UNIQUE KEY `unique_order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.module: ~5 rows (aproximadamente)
DELETE FROM `module`;
INSERT INTO `module` (`id`, `name`, `order`, `link`, `icon`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Inicio', 1, 'inicio', 'bi bi-house-door me-2', '2024-10-05 15:11:37', 1, '2024-10-07 21:36:33', 1, NULL, NULL),
	(2, 'Usuarios', 2, 'usuario', 'bi bi-person-gear me-2', '2024-10-05 15:11:37', 1, '2024-10-17 18:47:00', 1, NULL, NULL),
	(3, 'Roles', 3, 'rol', 'bi bi-people me-2', '2024-10-07 21:07:53', 1, '2024-10-17 18:48:06', 1, NULL, NULL),
	(4, 'Pacientes', 4, 'paciente', 'bi bi-file-earmark-person me-2', '2024-10-05 15:11:37', 1, '2024-10-17 18:48:07', 1, NULL, NULL),
	(5, 'Empleados', 5, 'empleado', 'bi bi-person', '2024-10-17 18:43:28', 1, '2024-10-17 18:48:08', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.patient
DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('Masculino','Femenino','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.patient: ~11 rows (aproximadamente)
DELETE FROM `patient`;
INSERT INTO `patient` (`id`, `first_name`, `last_name`, `birth_date`, `gender`, `address`, `phone`, `email`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Juan', 'Pérez', '1985-05-15', 'Masculino', 'Guatemala', '12345678', 'juan.perez@gmail.com', '2024-10-09 21:13:07', 1, '2024-10-12 13:38:57', 4, '2024-10-12 13:38:57', 1),
	(2, 'Pedro', 'Morales', '2022-10-07', 'Masculino', 'Guatemala', '58523698', 'pedro@gmail.com', '2024-10-10 18:07:00', 1, '2024-10-10 18:07:00', 1, NULL, NULL),
	(3, 'Pedro', 'Morales', '2022-10-07', 'Masculino', 'Guatemala', '58523698', 'pedro@gmail.com', '2024-10-10 18:07:30', 1, '2024-10-10 18:07:30', 1, NULL, NULL),
	(4, 'Wilmer', 'Contreras', '2020-08-09', 'Masculino', 'Guatemala', '5856889', 'goeodoellde', '2024-10-10 18:54:13', 1, '2024-10-10 18:54:13', 1, NULL, NULL),
	(5, 'Wilmer', 'Contreras', '2020-08-09', 'Masculino', 'Guatemala', '5856889', 'goeodoellde', '2024-10-10 18:55:16', 1, '2024-10-13 09:09:18', 1, '2024-10-13 09:09:18', 3),
	(6, 'Pedro', 'Morales', '2022-10-07', 'Masculino', 'Guatemala', '58523698', 'pedro@gmail.com', '2024-10-10 19:18:28', 1, '2024-10-12 15:16:02', 1, '2024-10-12 15:16:02', 2),
	(7, 'Juan', 'Morales', '2022-10-07', 'Masculino', 'Guatemala', '58523698', 'pedro@gmail.com', '2024-10-10 19:19:31', 1, '2024-10-10 19:19:31', 1, NULL, NULL),
	(8, 'papa', 'Morales', '2022-10-07', 'Masculino', 'Guatemala', '58523698', 'pedro@gmail.com', '2024-10-10 20:00:43', 1, '2024-10-10 20:00:43', 1, NULL, NULL),
	(9, 'Jonatan', 'Yat', '2024-10-07', 'Masculino', 'Ciudad', '52369878', 'jose@gmail.com', '2024-10-10 20:53:55', 1, '2024-10-10 20:53:55', 1, NULL, NULL),
	(10, 'Jonatan', 'Yat', '2024-10-07', 'Masculino', 'Ciudad', '52369878', 'jose@gmail.com', '2024-10-10 21:00:40', 2, '2024-10-10 21:00:40', 2, NULL, NULL),
	(11, 'dns', 'Hernandez', '1994-06-05', 'Femenino', 'Villa Lobos', '25523', 'prueba@gmail.com', '2024-10-10 21:02:11', 3, '2024-10-10 21:28:59', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.permission
DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `show_operation` int unsigned NOT NULL DEFAULT '0',
  `create_operation` int unsigned NOT NULL DEFAULT '0',
  `update_operation` int unsigned NOT NULL DEFAULT '0',
  `delete_operation` int unsigned NOT NULL DEFAULT '0',
  `cud_operation` int unsigned NOT NULL DEFAULT '1',
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.permission: ~8 rows (aproximadamente)
DELETE FROM `permission`;
INSERT INTO `permission` (`id`, `role_id`, `module_id`, `show_operation`, `create_operation`, `update_operation`, `delete_operation`, `cud_operation`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 1, 1, 1, 0, 0, 0, 0, '2024-10-06 17:20:19', 2, '2024-10-16 22:20:53', 2, NULL, NULL),
	(2, 1, 2, 1, 1, 1, 1, 1, '2024-10-06 19:50:27', 2, '2024-10-16 22:37:42', 2, NULL, NULL),
	(3, 1, 3, 1, 1, 1, 1, 1, '2024-10-11 22:35:47', 2, '2024-10-16 22:01:59', 2, NULL, NULL),
	(4, 1, 4, 1, 0, 0, 0, 1, '2024-10-12 19:31:52', 2, '2024-10-16 22:01:59', 2, NULL, NULL),
	(5, 2, 3, 1, 0, 0, 0, 1, '2024-10-12 21:42:34', 2, '2024-10-13 00:16:51', 2, NULL, NULL),
	(6, 2, 2, 1, 0, 0, 0, 1, '2024-10-12 21:42:34', 2, '2024-10-12 22:02:17', 2, NULL, NULL),
	(7, 2, 4, 1, 1, 0, 0, 1, '2024-10-12 21:42:34', 2, '2024-10-16 19:52:12', 2, NULL, NULL),
	(8, 2, 1, 1, 0, 0, 0, 1, '2024-10-12 21:42:34', 2, '2024-10-12 21:49:59', 2, NULL, NULL);

-- Volcando estructura para tabla clinica.position
DROP TABLE IF EXISTS `position`;
CREATE TABLE IF NOT EXISTS `position` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.position: ~3 rows (aproximadamente)
DELETE FROM `position`;
INSERT INTO `position` (`id`, `name`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Doctor', 1, '2024-10-13 12:58:21', 1, '2024-10-16 19:53:45', 3, NULL, NULL),
	(2, 'Enfermera', 1, '2024-10-16 18:49:33', 2, '2024-10-16 18:49:33', 2, NULL, NULL),
	(3, 'Prueba', 0, '2024-10-16 18:57:31', 2, '2024-10-16 19:18:32', 1, NULL, NULL);

-- Volcando estructura para tabla clinica.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `active` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.role: ~3 rows (aproximadamente)
DELETE FROM `role`;
INSERT INTO `role` (`id`, `name`, `description`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 'Administrador', 'Administrador del sistema', 1, '2024-05-21 19:00:41', 1, '2024-10-16 22:37:51', 2, NULL, NULL),
	(2, 'Doctor', 'Doctores de la clínica', 1, '2024-05-23 18:05:01', 1, '2024-10-17 19:19:35', 1, NULL, NULL),
	(3, 'Doctores', 'Doctor de la cíe', 0, '2024-10-17 19:02:57', 2, '2024-10-17 19:03:02', 2, '2024-10-17 19:03:02', 2);

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
  KEY `fk_session_tokens_user` (`user_id`),
  CONSTRAINT `fk_session_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.session_tokens: ~245 rows (aproximadamente)
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
	(62, 2, 'e12eaaa7b66bbfee55b25f71d40953827c93d9a121c554f44da8321f1ec1bf4d', '2024-10-06 22:57:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-06 21:57:33', 2, '2024-10-07 17:33:45', 2, '2024-10-07 00:00:00', 2),
	(63, 2, '99b9f281feac390f579689ab782d75383599e3a3e4b03d670d1c6f63af7db0e2', '2024-10-07 18:33:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 17:33:45', 2, '2024-10-07 17:33:45', 2, '2024-10-07 00:00:00', 2),
	(64, 2, '448d472194e2447e682e34f894ddc9430eccebc7700333c8f1ff10ea103ef802', '2024-10-07 18:33:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 17:33:45', 2, '2024-10-07 17:34:32', 2, '2024-10-07 00:00:00', 2),
	(65, 2, '789cb28808543ca48a330399ef9f2ffb8ecc4d485fb3f16ed69b4d20934646f5', '2024-10-07 18:34:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 17:34:32', 2, '2024-10-07 17:57:22', 2, '2024-10-07 00:00:00', 2),
	(66, 2, '9ca9f074f1fc22cded116543b9452412b0b3529cfdb6a7bd4008eeba8681c030', '2024-10-07 18:57:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 17:57:22', 2, '2024-10-07 17:59:18', 2, '2024-10-07 00:00:00', 2),
	(67, 2, '2057f8d3bb85282edca757e71ed67bb8e2598dcde131ed95f2301fb6940c58ec', '2024-10-07 18:59:18', '::1', 'PostmanRuntime/7.42.0', '2024-10-07 17:59:18', 2, '2024-10-07 18:35:00', 2, '2024-10-07 00:00:00', 2),
	(68, 2, 'b5d9583ae74c87ea2cb910667a6ebd84ceca14cdd3814e61e21db2283ace4c80', '2024-10-07 19:35:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 18:35:00', 2, '2024-10-07 18:35:44', 2, '2024-10-07 00:00:00', 2),
	(69, 2, '65e31cf13794b0a2fa844f6a1e7b96504ee41ec6fc01a671a223208f8c368675', '2024-10-07 19:35:44', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 18:35:44', 2, '2024-10-07 18:52:59', 2, '2024-10-07 00:00:00', 2),
	(70, 2, '94acd5951041e3475ebfa802bf9a8ebb65d39eaa5cef05e7156558970d922d05', '2024-10-07 19:52:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 18:52:59', 2, '2024-10-07 19:00:36', 2, '2024-10-07 00:00:00', 2),
	(71, 2, 'fe5b32154e8a7ad5aade116fe1b6e1001189d4d54ed1f8d5cc19dd33f8f0c9ad', '2024-10-07 20:00:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 19:00:36', 2, '2024-10-07 19:01:42', 2, '2024-10-07 00:00:00', 2),
	(72, 2, '38348d1253e772b4b9ced8d00c9e214a82fc40206593ef4d2b7afe9ff9c54516', '2024-10-07 20:01:42', '::1', 'PostmanRuntime/7.42.0', '2024-10-07 19:01:42', 2, '2024-10-07 19:13:04', 2, '2024-10-07 00:00:00', 2),
	(73, 2, '9b1708d6392cf2664f70a6ea093497ec0a1afe7eea0c48b0ffca82eddb7a662e', '2024-10-07 20:13:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 19:13:04', 2, '2024-10-07 20:44:41', 2, '2024-10-07 00:00:00', 2),
	(74, 2, '3f4af68ba1caee9ea5b3f88216fb7bedcb0c87123a83b4b05246df7527b19fc7', '2024-10-07 21:44:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:41', 2, '2024-10-07 20:44:42', 2, '2024-10-07 00:00:00', 2),
	(75, 2, 'c78b29efb31d6e0374a9a961471c135e77aaf69b5b810a8a6a6c823b25e26b34', '2024-10-07 21:44:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:42', 2, '2024-10-07 20:44:42', 2, '2024-10-07 00:00:00', 2),
	(76, 2, '8e59ebc758d502241b89a5efc1080f5abb9d5a46bdda25e5dea83604f8db5f26', '2024-10-07 21:44:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:42', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(77, 2, '2e1174ce6917e7e29071c8875f6478faae007c972be5ca6d0235e54b6b41fe8c', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:43', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(78, 2, '8197715bea30334a07eac3702572a61aefc66ff70f2c91c0857db1e88eef4062', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:43', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(79, 2, 'c3747262ff17aaf47d855c74f20ec0090e9ed976af3ac43f3bd2af3e98c361c2', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:43', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(80, 2, 'd186a59240c15d6bd7cfc362f58b2f8cc4ccd4853b800e8599b91f16566c036c', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:43', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(81, 2, '9f4347bf971bdc8bba5de423e279ca1e382451d7330272dc2c91f3943a4d28e4', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:43', 2, '2024-10-07 20:44:43', 2, '2024-10-07 00:00:00', 2),
	(82, 2, '0e1e27fa63e8d657cdb35066ca2d073de34c91e79c94922ba5ae37acdfa4966f', '2024-10-07 21:44:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:44:44', 2, '2024-10-07 20:44:58', 2, '2024-10-07 00:00:00', 2),
	(83, 2, 'd87e1ed856563d3b17a020108184620c60883d8463ec2e182bf241ef9b7a96bb', '2024-10-07 21:44:58', '::1', 'PostmanRuntime/7.42.0', '2024-10-07 20:44:58', 2, '2024-10-07 20:45:00', 2, '2024-10-07 00:00:00', 2),
	(84, 2, '9eded0838a02e20e51ecfb353973065ab383e9c18a41eb0b92a4d9ced60279b6', '2024-10-07 21:45:00', '::1', 'PostmanRuntime/7.42.0', '2024-10-07 20:45:00', 2, '2024-10-07 20:45:52', 2, '2024-10-07 00:00:00', 2),
	(85, 2, '078ff9a5e23f42a51de5d73bf7943192326a3cd432ddd7c13e432f04abfd16ca', '2024-10-07 21:45:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:45:52', 2, '2024-10-07 20:45:53', 2, '2024-10-07 00:00:00', 2),
	(86, 2, 'c4fa207f80249d6c124ecd5c6067be6cd0fd4796174698b0f1fe1606128f02ad', '2024-10-07 21:45:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:45:53', 2, '2024-10-07 20:45:53', 2, '2024-10-07 00:00:00', 2),
	(87, 2, 'c8f0eda6748b81e87ff15a47978d2a59f43586700e4d0b59b90fdc43ba88a757', '2024-10-07 21:45:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:45:53', 2, '2024-10-07 20:45:53', 2, '2024-10-07 00:00:00', 2),
	(88, 2, '0f02f8fce085443cac4e254acb08b933463ed08cbdc5d91807922ce2f93e6515', '2024-10-07 21:45:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:45:53', 2, '2024-10-07 20:46:32', 2, '2024-10-07 00:00:00', 2),
	(89, 2, 'e0961f9e899b9a4786c6aebec3985b004ef363ab3af78812406119ff5c9a0af6', '2024-10-07 21:46:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:46:32', 2, '2024-10-07 20:46:48', 2, '2024-10-07 00:00:00', 2),
	(90, 2, 'fa06a9bb20d2ec2e6627978449a47b16740f9319dc0cb60d084b4f67b43f9b2c', '2024-10-07 21:46:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:46:48', 2, '2024-10-07 20:47:31', 2, '2024-10-07 00:00:00', 2),
	(91, 2, '03b1c611ff5491571cdca125ab71488978f460d17811459faff00f5cf1605c11', '2024-10-07 21:47:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:47:31', 2, '2024-10-07 20:48:01', 2, '2024-10-07 00:00:00', 2),
	(92, 2, '74ba2717759526f71ad5c9fb522b55148fcdd79564ff1cf6021c63bd0dc0a3d8', '2024-10-07 21:48:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:48:01', 2, '2024-10-07 20:48:17', 2, '2024-10-07 00:00:00', 2),
	(93, 2, '66c511313d82d7c9cbd96e3d92a6cca9ef8f279aa942e70b40413bafe3e909f0', '2024-10-07 21:48:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:48:17', 2, '2024-10-07 20:48:27', 2, '2024-10-07 00:00:00', 2),
	(94, 2, 'df024f117f93f456a75c8b449b6d90ad0dd5807d255cb25166005695fd709ffd', '2024-10-07 21:48:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:48:27', 2, '2024-10-07 20:49:47', 2, '2024-10-07 00:00:00', 2),
	(95, 2, '3f41d97743831de998cfb5cdbebd058f7ae86cc53b8e8bbfc1abadad6def842e', '2024-10-07 21:49:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:49:47', 2, '2024-10-07 20:52:59', 2, '2024-10-07 00:00:00', 2),
	(96, 2, '820e9d0edcef9ad18dcfeea0cd316db3604451e6b053580ced8ba4d4d4dac9f0', '2024-10-07 21:52:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:52:59', 2, '2024-10-07 20:53:30', 2, '2024-10-07 00:00:00', 2),
	(97, 2, '966b704ae7c10c859fe1ae93f41dd114e648d920ea603583cf88e4781103e2c5', '2024-10-07 20:53:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:53:30', 2, '2024-10-07 20:54:12', 2, '2024-10-07 00:00:00', 2),
	(98, 2, '669a1b6386b470bc139d2d368f558afe2aaddb85029c13ea44b84d12721e7460', '2024-10-07 21:54:12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:54:12', 2, '2024-10-07 20:58:30', 2, '2024-10-07 00:00:00', 2),
	(99, 2, '16279a6d4a3bb364bcb642b068a52db5abdfcfab121207fce3d9ca7b8e73a897', '2024-10-07 22:58:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 20:58:30', 2, '2024-10-07 22:50:21', 2, '2024-10-07 00:00:00', 2),
	(100, 5, 'abb3bba9d32173109a7e78ea613b544a7ebef12a251234a6f475cd31be4b6594', '2024-10-07 23:50:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 22:50:21', 2, '2024-10-07 22:55:00', 2, '2024-10-07 22:54:52', 2),
	(101, 5, '8feaeddcccaa33144296d3f398abe144f2d8585654ddb46fff1ba4952503f6d7', '2024-10-07 23:55:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 22:55:07', 2, '2024-10-07 23:54:09', 2, '2024-10-07 23:53:57', 1),
	(102, 2, 'c8698d426a1026651d50390cb061eb5e701a844c4b6835f0514ddb1edc739eb8', '2024-10-08 00:53:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-07 23:53:37', 2, '2024-10-07 23:54:24', 2, '2024-10-07 23:54:16', 1),
	(103, 2, 'a04c84af3c27076d236e54121836841258321932f3004a8d4370acca48a68dcc', '2024-10-08 01:30:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:30:49', 2, '2024-10-08 00:53:32', 2, '2024-10-08 00:31:11', 1),
	(104, 2, '18455d5638f9072992c8963df83f17fc747ba9f743e168d7629fb23d537c662c', '2024-10-08 01:34:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:34:35', 2, '2024-10-08 00:53:33', 2, '2024-10-08 00:34:46', 1),
	(105, 2, '017540e17bf97594595816f5fc1c5111cfd61c00171ba6a84bd030a4878ab724', '2024-10-08 01:45:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:45:23', 2, '2024-10-08 00:46:17', 2, '2024-10-08 00:00:00', 2),
	(106, 2, 'a3e69b6d56294732ea93560907c14a8cb93287838672628efef45418dd5471e9', '2024-10-08 01:46:17', '::1', 'PostmanRuntime/7.42.0', '2024-10-08 00:46:17', 2, '2024-10-08 00:49:23', 2, '2024-10-08 00:00:00', 2),
	(107, 5, 'a50311f95466a257b266961e49e88fc136b41d306f91d5689c26c516de01b9ff', '2024-10-08 01:49:23', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:49:23', 2, '2024-10-08 00:53:34', 2, '2024-10-08 00:53:27', 1),
	(108, 2, 'bac95ef20919db5543f69842dc370788748685027f81e509a22802751c7319f8', '2024-10-08 01:53:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:53:16', 2, '2024-10-08 00:53:51', 2, '2024-10-08 00:53:46', 1),
	(109, 2, '37cffa64ba647c3da91601d8a346f93e2a011a8b057ddc0f370fc89d9b6d4ceb', '2024-10-08 01:55:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:55:52', 2, '2024-10-08 00:56:05', 2, '2024-10-08 00:56:02', 1),
	(110, 2, '5eeeeaea5fa9f130a1188f145b707cc2ce53e9a05a61dcde3f2fff9c184b1fb8', '2024-10-08 01:56:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:56:31', 2, '2024-10-08 00:56:43', 2, '2024-10-08 00:56:40', 1),
	(111, 2, '1d4a39ca991cacf081f92a5f254237ffc9235a672d2b33286558b82695644f52', '2024-10-08 01:59:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:59:13', 2, '2024-10-08 00:59:25', 2, '2024-10-08 00:59:23', 1),
	(112, 2, '319e039c803339a385beb216b2c81dc4774f436c9c30823169b8d677ac4ac2d2', '2024-10-08 01:59:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 00:59:57', 2, '2024-10-08 01:00:03', 2, '2024-10-08 01:00:02', 1),
	(113, 2, 'a708e3dede0f16d986c933c762e937c73e4df1b529ef6273b38092a5bb1fa665', '2024-10-08 02:03:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 01:03:38', 2, '2024-10-08 01:08:52', 2, '2024-10-08 00:00:00', 2),
	(114, 2, '63b691c560c520be36e47d00aa2da135523c4bf6c6dd2231773a56379839973f', '2024-10-08 02:08:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 01:08:52', 2, '2024-10-08 01:15:40', 2, '2024-10-08 00:00:00', 2),
	(115, 2, '47eb9ebc35a0b7d0181feb950a63d7a299cad928e11e49f01331b3b426e13daf', '2024-10-08 02:15:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 01:15:40', 2, '2024-10-08 01:15:49', 2, '2024-10-08 01:15:47', 1),
	(116, 5, '9582a52d516cd2854a9542b81708781d7c54519afeafc24b2742357217fbfe2b', '2024-10-08 02:15:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 01:15:59', 2, '2024-10-08 02:14:29', 2, '2024-10-08 02:14:26', 1),
	(117, 2, '83660f9db88bc0cd956142af47411c3386ba105f0191f3243ebc99d58642b6f2', '2024-10-08 02:18:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 01:18:31', 2, '2024-10-08 02:05:27', 2, '2024-10-08 00:00:00', 2),
	(118, 2, '80c3b2edd0196a121fce6929c8af8e348178b561d41835ec33145af5c4526107', '2024-10-08 03:05:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 02:05:41', 2, '2024-10-08 02:05:44', 2, '2024-10-08 00:00:00', 2),
	(119, 2, 'e22f1bfd287a80454abec308dd1019c3c13fc11532c7732a1be4592411158995', '2024-10-08 03:06:19', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 02:06:19', 2, '2024-10-08 02:06:39', 2, '2024-10-08 00:00:00', 2),
	(120, 2, '128c69543de708adb7cb0894b89a5946fc543970d9f83a1faad68678a216e23f', '2024-10-08 03:17:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 02:14:49', 2, '2024-10-08 02:17:29', 2, '2024-10-08 00:00:00', 2),
	(121, 2, 'd92b349a9f83a34375d1f719001eb67b54ede1a75b8efe7c0538e615f1a9db90', '2024-10-08 03:19:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 02:19:31', 2, '2024-10-08 19:10:37', 2, '2024-10-08 00:00:00', 2),
	(122, 2, 'ba683ad6855ef828f367a51d1c8f4f06e1aa42295e6e75ef0f69f62d927e5251', '2024-10-08 20:11:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 19:10:37', 2, '2024-10-08 19:11:26', 2, '2024-10-08 00:00:00', 2),
	(123, 2, 'f81b9f419882aab2aa510ca78d8381e6921fc6bc6f51cf3c1ab1fdeeb2729a66', '2024-10-08 20:52:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 19:11:34', 2, '2024-10-08 20:29:46', 2, '2024-10-08 00:00:00', 2),
	(124, 1, '4bb7ee6c3c81da8932096187fe486b447b414e5149ded17fcab48b4ddced31a5', '2024-10-08 21:03:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-08 20:31:15', 1, '2024-10-09 14:22:11', 1, '2024-10-09 00:00:00', 1),
	(125, 2, '7231ca70447453525aaa8f0e5e60e8aff309cfc4ea3f1c6a093d930773749886', '2024-10-09 12:46:29', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 14:15:09', 2, '2024-10-09 14:29:46', 2, '2024-10-09 00:00:00', 2),
	(126, 1, 'd0580f01d10dd9a7056bc8fd7eb9eca1a8ab47b285b3e4ece13f82bd95f9135d', '2024-10-09 14:59:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 14:22:11', 1, '2024-10-09 14:29:39', 1, '2024-10-09 00:00:00', 1),
	(127, 2, '5b029aa2bb32437615edb6e2588199b3254edb50beacee233105e4ce39e792f4', '2024-10-09 14:02:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 14:29:46', 2, '2024-10-09 14:47:47', 2, '2024-10-09 00:00:00', 2),
	(128, 2, '4bd3d398eef379a1fd35d8dcfd606110f8199ded4ee21ddc24a24571c37fb901', '2024-10-09 15:17:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 14:47:47', 2, '2024-10-09 14:47:51', 2, '2024-10-09 00:00:00', 2),
	(129, 2, '1328ebc5fc9ec503290caded463f1b850654f0507b4c306d9c9d419942bfbb80', '2024-10-09 15:17:54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 14:47:54', 2, '2024-10-09 14:49:57', 2, '2024-10-09 00:00:00', 2),
	(130, 2, '7824e8f57f45735fe6933823917f6df2aac89ac60905d727fd840209e508ed2f', '2024-10-10 20:51:05', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-09 18:32:35', 2, '2024-10-10 21:43:17', 2, '2024-10-10 00:00:00', 2),
	(131, 2, 'e08540211ca6988076289a39894b6e01462c6fe7cb2227396d158e312fff7cdf', '2024-10-10 22:23:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 21:43:17', 2, '2024-10-10 21:53:09', 2, '2024-10-10 00:00:00', 2),
	(132, 2, '920108a04da8b0a8d0c6054f61b399aa1342bfddc94a65bb83b41cf5121920a4', '2024-10-10 23:41:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 23:10:58', 2, '2024-10-10 23:11:12', 2, '2024-10-10 00:00:00', 2),
	(133, 3, '2e70662a30416cecf7b35ec67149890869311910cf14b6a461794d191bd4683e', '2024-10-10 23:41:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 23:11:44', 3, '2024-10-10 23:11:48', 3, '2024-10-10 00:00:00', 3),
	(134, 2, '555711f53aba17e126155fe7b888518f61b5408c87540d21e04eb3f928b88cf4', '2024-10-10 23:42:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 23:12:07', 2, '2024-10-10 23:12:09', 2, '2024-10-10 00:00:00', 2),
	(135, 4, 'feb2c8f7423b428b3fbe3432a1a1148da25563152eacc89ca0f9de446dc3a369', '2024-10-10 23:42:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 23:12:20', 4, '2024-10-11 22:08:03', 4, '2024-10-11 00:00:00', 4),
	(136, 2, 'e3d9787ebd59911ae95d6dcc2a97474e39b709071ec59a88f71ea91f1067cf3f', '2024-10-11 00:42:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-10 23:18:18', 2, '2024-10-11 11:25:25', 2, '2024-10-11 00:00:00', 2),
	(137, 2, 'ec6cf843b3f507c16df97fcab7c2e21c1a71612e9e9779011fee1ff774e621fa', '2024-10-11 11:55:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 11:25:25', 2, '2024-10-11 11:25:28', 2, '2024-10-11 00:00:00', 2),
	(138, 2, 'f497f898297b72c0b93ab898c2fcae7e4f98b706013d03ccf3cca6fb67846fed', '2024-10-11 11:55:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 11:25:35', 2, '2024-10-11 13:25:52', 2, '2024-10-11 00:00:00', 2),
	(139, 2, '32027f6377265fa525a817997e5fe20bd4e51d6490820ea4dc22a279567d739f', '2024-10-11 15:28:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 13:25:52', 2, '2024-10-11 17:14:53', 2, '2024-10-11 00:00:00', 2),
	(140, 1, '9574dee10531ff3218ee19f7ea09b9ea69f3382456a7f1f7d500c16a724b70ca', '2024-10-11 18:02:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 15:38:46', 1, '2024-10-11 20:00:16', 1, '2024-10-11 00:00:00', 1),
	(141, 2, 'f88eab5879fc7dfd329e5038012b5662b33054c38e3b0b8d6c745c6aab76ab76', '2024-10-11 17:44:53', '192.168.1.69', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36', '2024-10-11 17:14:53', 2, '2024-10-11 17:14:54', 2, '2024-10-11 00:00:00', 2),
	(142, 2, 'd2a7d2acd951be6257e8a7797eb3404b100dda682bcacce1b3e289dcae5cf334', '2024-10-11 17:45:05', '192.168.1.69', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36', '2024-10-11 17:14:54', 2, '2024-10-11 21:41:46', 2, '2024-10-11 00:00:00', 2),
	(143, 1, '45b79b323117226b8a4f4b0967face21f82ad0876f025acf62749c28e6ea9c6d', '2024-10-11 21:10:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 20:00:16', 1, '2024-10-11 21:32:28', 1, '2024-10-11 00:00:00', 1),
	(144, 1, '093d66bd31ed229e511a39a4ce9ae2e82c8a21650d19df023787cda8035a19e8', '2024-10-11 22:06:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:32:28', 1, '2024-10-11 21:37:31', 1, '2024-10-11 00:00:00', 1),
	(145, 1, 'c7424a27eaace4a18d80f946611657170d3c7f8498fefa65095fee4825198695', '2024-10-11 22:09:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:37:31', 1, '2024-10-11 21:40:06', 1, '2024-10-11 00:00:00', 1),
	(146, 1, '6a6489254ed62f57011e68d8f76b37b2283913eb6fc6bde9494b6cdddc99b8d2', '2024-10-11 22:10:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:40:06', 1, '2024-10-11 21:40:20', 1, '2024-10-11 00:00:00', 1),
	(147, 1, '9dcfa7e22344c9ef03eeee4a61fe4a1b2e17c4932def9f758fd748062d9aa66d', '2024-10-11 22:10:35', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:40:25', 1, '2024-10-11 21:40:36', 1, '2024-10-11 00:00:00', 1),
	(148, 1, 'fa69546b8d3725aaa265270f49723bd5ccd66db06e3973a7564bc7dfd85086b4', '2024-10-11 22:10:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:40:42', 1, '2024-10-11 21:41:03', 1, '2024-10-11 00:00:00', 1),
	(149, 1, '89d77fd2402ac17b341d4d28acdfd17366ea998ed52b5ea412e616aec522af20', '2024-10-11 22:11:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:41:03', 1, '2024-10-11 21:41:21', 1, '2024-10-11 00:00:00', 1),
	(150, 1, '7adc28397c42ce7941e3e8ea8c975c45815cefe42c9515405db3c1ef6e56ccc9', '2024-10-11 22:11:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:41:21', 1, '2024-10-11 21:41:36', 1, '2024-10-11 00:00:00', 1),
	(151, 1, '18ba896be953e37866c4d25b6841f398b06c1fcbd177ec9b31d8dc677adcab22', '2024-10-11 22:11:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 21:41:36', 1, '2024-10-11 21:41:38', 1, '2024-10-11 00:00:00', 1),
	(152, 2, '77f0e4f842550f1eae181cb42b02bf81b0b5a557a2b379b9bc98f04bf9599927', '2024-10-11 22:11:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 21:41:46', 2, '2024-10-11 21:41:54', 2, '2024-10-11 00:00:00', 2),
	(153, 2, 'b3b32600281affbedd5426711acb2dda0d2b4454c6a18929c57d497a41f5d426', '2024-10-11 22:11:54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 21:41:54', 2, '2024-10-11 21:42:22', 2, '2024-10-11 00:00:00', 2),
	(154, 1, 'da39c254094fd74a1e20a682284ea851bc88719998b56292b00e04a7a3036bad', '2024-10-11 22:12:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 21:42:26', 1, '2024-10-11 21:46:39', 1, '2024-10-11 00:00:00', 1),
	(155, 1, 'e4d6f8ac6b1956169361e0b733be04620c8e8af8c48f22f3a3788a00b9917c2f', '2024-10-11 22:16:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:46:39', 1, '2024-10-11 21:46:45', 1, '2024-10-11 00:00:00', 1),
	(156, 1, '26247fcd0a09789a05510e903775f31a309b87cd8dfa3a3bb27e8a70acc0b5e4', '2024-10-11 22:17:15', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:47:15', 1, '2024-10-11 21:47:24', 1, '2024-10-11 00:00:00', 1),
	(157, 1, 'b201b2b2e0087a470e15a2f5a02d075402fdafc463681d0c949e7320112c145d', '2024-10-11 22:17:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:47:24', 1, '2024-10-11 21:47:45', 1, '2024-10-11 00:00:00', 1),
	(158, 1, '9ba5db39026285142137447243ae2b9c8166b648ee85a658145b867fa39b2053', '2024-10-11 22:18:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:47:45', 1, '2024-10-11 21:48:24', 1, '2024-10-11 00:00:00', 1),
	(159, 1, '2bf5f39376df9a8387ee9bb67f5b9faddd95d3155fd2365995ade1d05b3a8146', '2024-10-11 22:18:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:48:47', 1, '2024-10-11 21:49:56', 1, '2024-10-11 00:00:00', 1),
	(160, 1, '9227d95acb19f5fc6838c59e0a099861d1713e389a0082665c36ae2390347d84', '2024-10-11 22:19:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:49:56', 1, '2024-10-11 21:50:04', 1, '2024-10-11 00:00:00', 1),
	(161, 1, 'e6d853407d380811bbf89acfc26e434b0763103f53328b790512e487e698acfd', '2024-10-11 22:20:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:50:07', 1, '2024-10-11 21:50:25', 1, '2024-10-11 00:00:00', 1),
	(162, 1, 'ffd0ea3feb884c076b8c346e3829d9f39746019accc4e88fecdb7b4b010b10ac', '2024-10-11 22:20:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 21:50:25', 1, '2024-10-11 21:53:46', 1, '2024-10-11 00:00:00', 1),
	(163, 1, '0a26cf971b8ba0eea526067d42e556f538f483c492c12af49edf7f4c3d97b543', '2024-10-11 22:23:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:53:46', 1, '2024-10-11 21:53:55', 1, '2024-10-11 00:00:00', 1),
	(164, 1, '58ea9e159874813528041f9d69a0e4a7ba722fb01f10b3d41d6f574c8cf8556e', '2024-10-11 22:23:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:53:57', 1, '2024-10-11 21:54:04', 1, '2024-10-11 00:00:00', 1),
	(165, 2, '1d62f20c338e15ffd4af5d38f8b27a83a50c5c35b26d5dbf2f8c6e9bce7ea7d6', '2024-10-11 22:25:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:54:13', 2, '2024-10-11 21:55:11', 2, '2024-10-11 00:00:00', 2),
	(166, 1, '462c6eb2d378cc9bb4cfadee6cf694f8b65d45fd60900d4bb47a874e90babd2a', '2024-10-11 22:25:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:55:17', 1, '2024-10-11 21:55:20', 1, '2024-10-11 00:00:00', 1),
	(167, 2, '7fa977722260ec645961299db6bd0b5491f46370304cdc69d85b1c1c439280f7', '2024-10-11 22:28:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:55:31', 2, '2024-10-11 21:58:31', 2, '2024-10-11 00:00:00', 2),
	(168, 1, '5de512d81175640fd5bb161e8192d5eea598878be63f52cad5f2e9f0d1996d3c', '2024-10-11 22:29:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:59:36', 1, '2024-10-11 21:59:40', 1, '2024-10-11 00:00:00', 1),
	(169, 2, '5c7871bd663b0774c22bb1bff64d9d4787f7aeea7d97ce6170244a6a381dd8f2', '2024-10-11 22:29:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 21:59:57', 2, '2024-10-11 22:00:05', 2, '2024-10-11 00:00:00', 2),
	(170, 4, 'bc8ffc8818f141ec1bd4c3cee03f290fcfe725b20db28a2ca72bdd3ad60b5569', '2024-10-11 22:38:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 22:08:03', 4, '2024-10-15 21:42:07', 4, '2024-10-15 00:00:00', 4),
	(171, 2, 'fccf4c1e944de78b74e1da020dda4ab36c2d96f7da3f97998452d57297e8b4f0', '2024-10-11 22:40:16', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 22:10:16', 2, '2024-10-11 22:11:50', 2, '2024-10-11 00:00:00', 2),
	(172, 2, '3925261bdb6fe465f038dd24e3c04c3b8b21ba9b4255309d1b7c1ee15e9a2e88', '2024-10-11 22:41:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 22:11:50', 2, '2024-10-11 22:12:05', 2, '2024-10-11 00:00:00', 2),
	(173, 2, '460ff13c0998469821e9c128bbda503e73a6a35a5108979cedb27bd036cf93e1', '2024-10-11 22:42:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 22:12:09', 2, '2024-10-11 22:13:43', 2, '2024-10-11 00:00:00', 2),
	(174, 2, 'ccd66fb7470795de951321a07c094a3eb722214942b01a72c06ee972ad13477c', '2024-10-11 22:43:43', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 22:13:43', 2, '2024-10-11 22:13:45', 2, '2024-10-11 00:00:00', 2),
	(175, 1, 'f23eaaf60106416f5796e092ad85d9e62156300337d24ffa5f8566ec864bed8c', '2024-10-11 22:44:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 22:14:00', 1, '2024-10-11 22:14:14', 1, '2024-10-11 00:00:00', 1),
	(176, 1, 'f68d88613a425e833272f318b4043a664c185e40f2ccabb669569abf67405614', '2024-10-11 22:44:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 22:14:30', 1, '2024-10-11 22:14:33', 1, '2024-10-11 00:00:00', 1),
	(177, 1, '25582b7826913a404a7ed530e9924b3c9ff60829d87c0a5dd27e0aa2596bc51c', '2024-10-11 23:20:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-11 22:14:36', 1, '2024-10-12 19:00:45', 1, '2024-10-12 00:00:00', 1),
	(178, 2, '379c0bdd33e0419ed5baac733636e873cb4b6780e3b6dfed4a452023aa8aa63d', '2024-10-11 23:54:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 22:35:14', 2, '2024-10-11 23:25:00', 2, '2024-10-11 00:00:00', 2),
	(179, 2, '249eb4780e79577ec31d61712c83e4d12a7d7c7e910f2c3180a6a4c62d221218', '2024-10-11 23:58:42', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:25:09', 2, '2024-10-11 23:29:12', 2, '2024-10-11 00:00:00', 2),
	(180, 2, '2048447c5dd889c41bcddcf53bd0f4e59a6e48b479fbc6b4fbc4620df7a134fb', '2024-10-12 00:02:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:29:12', 2, '2024-10-11 23:33:18', 2, '2024-10-11 00:00:00', 2),
	(181, 2, 'a8cff2a03eee6b9d15f55ede77be16046f025ed1f92d323fa7688fbe22da5275', '2024-10-12 00:04:57', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:33:18', 2, '2024-10-11 23:34:59', 2, '2024-10-11 00:00:00', 2),
	(182, 2, 'f9ab3a722ad851280ef073764f373b21ea17af0c6d4ed307529f666a5d415e73', '2024-10-12 00:05:04', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:35:04', 2, '2024-10-11 23:35:07', 2, '2024-10-11 00:00:00', 2),
	(183, 2, 'e128e644c340729b3556d2c2ceae9be7f9c829a63ac2e41a6beca62dd6587fca', '2024-10-12 00:08:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:37:09', 2, '2024-10-11 23:39:01', 2, '2024-10-11 00:00:00', 2),
	(184, 2, 'c59851f113419534e94ff0f44ac19a81555947d2666842dc39c50cc3f3a8db0e', '2024-10-12 00:36:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-11 23:39:06', 2, '2024-10-12 08:27:20', 2, '2024-10-12 00:00:00', 2),
	(185, 2, 'ce4ec1379fc384ae6de346a450104f4af416261aab93998e293695f86a1b3afc', '2024-10-12 10:01:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 08:27:20', 2, '2024-10-12 09:32:20', 2, '2024-10-12 00:00:00', 2),
	(186, 2, '25efd92d3c730edc52cd371a88600a4374cf48ccd253b77af428acc17cc843f5', '2024-10-12 10:03:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 09:32:20', 2, '2024-10-12 09:37:04', 2, '2024-10-12 00:00:00', 2),
	(187, 2, '39bc930a3cbad75730ea22e4b16f24cd134b463644f323c6a2906e6b68af6de3', '2024-10-12 13:27:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 09:37:04', 2, '2024-10-12 14:14:30', 2, '2024-10-12 00:00:00', 2),
	(188, 2, 'ca41251607775f74132fd7004b94e0700859d7a0aa8bc4b844b845c15243f8fc', '2024-10-12 15:11:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 14:14:30', 2, '2024-10-12 15:31:03', 2, '2024-10-12 00:00:00', 2),
	(189, 2, '0440e2867e1748fffcc065bad2568aec25527a20a66dbda31b41336cf9fd86da', '2024-10-12 18:03:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 15:31:03', 2, '2024-10-12 17:33:25', 2, '2024-10-12 00:00:00', 2),
	(190, 2, 'f771667a371b9934a1f8d6125f4751a04fe510013fc0b36e99413635aa831bad', '2024-10-12 18:03:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0', '2024-10-12 17:33:25', 2, '2024-10-12 17:33:47', 2, '2024-10-12 00:00:00', 2),
	(191, 2, 'fa9cf55ba91a2b2fd9d6e175bdd7a16243ef2fc042c0b7fcf7ca24ea199d7a4f', '2024-10-12 18:43:19', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 17:33:47', 2, '2024-10-12 19:13:35', 2, '2024-10-12 00:00:00', 2),
	(192, 1, '79e2712d299d04140093ef8423eb63bc559ca69af4d9e9cc94f8403afbe0ac88', '2024-10-12 19:30:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 19:00:45', 1, '2024-10-12 19:00:53', 1, '2024-10-12 00:00:00', 1),
	(193, 2, '053ea189c6aae6e6a30a52e9a59ac396f6f0fa901a3b4f31f6d7423708d6432d', '2024-10-12 23:50:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 19:13:35', 2, '2024-10-12 23:25:27', 2, '2024-10-12 00:00:00', 2),
	(194, 2, 'f8eafc041cdfe8dedcd5282488d7a07075df0a4ee7888403995859d5473839be', '2024-10-12 22:54:15', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 23:20:37', 2, '2024-10-12 23:27:53', 2, '2024-10-12 00:00:00', 2),
	(195, 2, '8d3d79b95a9b8c985b050bff43c700ac23ddffe4d64a02027350666feb3cba18', '2024-10-12 00:11:11', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 23:27:53', 2, '2024-10-12 23:58:32', 2, '2024-10-12 00:00:00', 2),
	(196, 2, '00c6adf4980ca6ccabea33253f32c7ee70f72f80213a743d98a1cfb2b6691e62', '2024-10-13 00:57:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-12 23:58:32', 2, '2024-10-13 08:25:28', 2, '2024-10-13 00:00:00', 2),
	(197, 2, '13b29e76330e6354f2840f301f5d67d3afc73d08347627e310d1fd421df5cbbe', '2024-10-13 09:16:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-13 08:25:28', 2, '2024-10-13 08:47:53', 2, '2024-10-13 00:00:00', 2),
	(198, 2, 'c5a1cd8f006efbd508b342b126cc3e407bd16cdbd60cb18164255acde83fae79', '2024-10-13 12:10:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-13 08:48:02', 2, '2024-10-13 12:59:02', 2, '2024-10-13 00:00:00', 2),
	(199, 2, 'e4ce37291813984080f4504da4aeeb900589c496d4459ada0ec304de27cf6a31', '2024-10-13 17:45:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-13 12:59:02', 2, '2024-10-13 21:17:37', 2, '2024-10-13 00:00:00', 2),
	(200, 2, '1df9c99598e0fa12e913884ad51d02f53cd4e561770d3f1f47b0b7c6ec3515d9', '2024-10-13 23:16:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-13 21:17:37', 2, '2024-10-15 13:11:18', 2, '2024-10-15 00:00:00', 2),
	(201, 2, '78896e706b937a93c8bd268497736d7a5fedec11a80198e94ea4eda8ce0e6f59', '2024-10-15 13:44:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 13:11:18', 2, '2024-10-15 18:44:33', 2, '2024-10-15 00:00:00', 2),
	(202, 2, '43dd7b01a3daef8b1fe3e5ac877f04d1a459916912d7e1a281e336f73f22ed97', '2024-10-15 19:14:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 18:44:33', 2, '2024-10-15 18:56:40', 2, '2024-10-15 00:00:00', 2),
	(203, 2, 'd625e9c95ceba41f5f383f2c9b65a1487dc8686b60fa4877ade225b57bc226ad', '2024-10-15 19:26:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 18:56:40', 2, '2024-10-15 18:57:16', 2, '2024-10-15 00:00:00', 2),
	(204, 2, 'a73480d9f8f961ada0e9236acfa2486cf20afffb4a4764e549b6468e9e0ba7a8', '2024-10-15 20:10:29', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 18:57:16', 2, '2024-10-15 20:00:22', 2, '2024-10-15 00:00:00', 2),
	(205, 2, 'd77de68a5fc599e7b0b60d934a45890975811cb8f52da7b87aea0dda203302f2', '2024-10-15 20:53:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 20:23:09', 2, '2024-10-15 21:21:51', 2, '2024-10-15 00:00:00', 2),
	(206, 2, '4dcfc572586d71da1baace00188843e90544ee487efd52efc35b232d66b5b348', '2024-10-15 21:51:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:21:51', 2, '2024-10-15 21:23:04', 2, '2024-10-15 00:00:00', 2),
	(207, 2, '4642ca08f946bf78b4c155fec0bd9f1d9bb2c9c93ae1bcce370ccc56d4211337', '2024-10-15 21:53:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:23:05', 2, '2024-10-15 21:23:43', 2, '2024-10-15 00:00:00', 2),
	(208, 2, 'ba876e8c31788e0ff27ab1ad1e995e5779a7321a9087b1b02a3184663c2606bb', '2024-10-15 21:54:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:23:43', 2, '2024-10-15 21:25:37', 2, '2024-10-15 00:00:00', 2),
	(209, 2, '8dfeafac25cce34b2bcf96f51543d5e2956d148c850161d99b948f8fc734f7af', '2024-10-15 21:55:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:25:37', 2, '2024-10-15 21:27:13', 2, '2024-10-15 00:00:00', 2),
	(210, 2, 'b4793339f88c0e312ce8aa4cd8d9ca5aa4d4a48fdd43db5e99a22eec9f614f70', '2024-10-15 21:57:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:27:13', 2, '2024-10-15 21:27:17', 2, '2024-10-15 00:00:00', 2),
	(211, 2, '87548282e4ed5d04a0799e4fb28b5737de842fa061ffcb3f71d7d9302968d855', '2024-10-15 21:57:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:27:23', 2, '2024-10-15 21:28:44', 2, '2024-10-15 00:00:00', 2),
	(212, 2, 'e682784e34bc1bc44451e7b3c039c0b7540960be7062f6684a598b20366d8f35', '2024-10-15 21:58:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:28:44', 2, '2024-10-15 21:28:47', 2, '2024-10-15 00:00:00', 2),
	(213, 2, 'a16b880e8b6245077f527b176f80bf0713813048630a1d82de33859fbdb90f17', '2024-10-15 21:59:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:29:04', 2, '2024-10-15 21:29:26', 2, '2024-10-15 00:00:00', 2),
	(214, 2, '9fd66156bf407ca6aa547fe6b348d64c4ba6426e9f94a47d01e82303380c6255', '2024-10-15 21:59:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:29:26', 2, '2024-10-15 21:30:23', 2, '2024-10-15 00:00:00', 2),
	(215, 2, '1f48d298f184d85165472f16922660b649e3d85cd9d8a72f05f85d67f36d629b', '2024-10-15 22:07:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:30:23', 2, '2024-10-15 21:37:27', 2, '2024-10-15 00:00:00', 2),
	(216, 2, '24030d2d56448823185a2ced5a9e176eee56b6a9fa41cd6d65b6434d2f5d254e', '2024-10-15 22:07:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:37:39', 2, '2024-10-15 21:37:47', 2, '2024-10-15 00:00:00', 2),
	(217, 2, '062ca28dde035def1b606ac246a389a64866bbeef527daf0f690108d1e54ab0a', '2024-10-15 22:07:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:37:47', 2, '2024-10-15 21:39:18', 2, '2024-10-15 00:00:00', 2),
	(218, 2, '21ae9ca6a179cc81d20798939aa98c959ebae4ee8d15a8fa6dd5dc8049b0f786', '2024-10-15 22:09:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:39:18', 2, '2024-10-15 21:39:26', 2, '2024-10-15 00:00:00', 2),
	(219, 2, '75587792367011822535dfcf18466687ed5f41e002aafb77c10f2452800541ba', '2024-10-15 22:09:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:39:26', 2, '2024-10-15 21:39:33', 2, '2024-10-15 00:00:00', 2),
	(220, 2, '394463ab292fc54a4ea13be028a7aab75b5d216f9f039dd2b6729ddaaa79158a', '2024-10-15 22:09:33', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:39:33', 2, '2024-10-15 21:40:40', 2, '2024-10-15 00:00:00', 2),
	(221, 2, '9fceaa7448edddbd79645b4c47c4fc8afd25ebf1a025b2281a2db58d963cc014', '2024-10-15 22:10:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:40:40', 2, '2024-10-15 21:40:57', 2, '2024-10-15 00:00:00', 2),
	(222, 4, 'c3959498ae838dd03f69b609db7a3d2c0f1440b637114f1eb2e8f19b958caa5e', '2024-10-15 22:12:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:42:07', 4, '2024-10-15 21:42:12', 4, '2024-10-15 00:00:00', 4),
	(223, 4, 'c391bcbbc0580abd0fd944c55ef757951b0dd2d541e948cd9345a192a407461b', '2024-10-15 22:12:12', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:42:12', 4, '2024-10-15 21:42:16', 4, '2024-10-15 00:00:00', 4),
	(224, 4, '7653d1f663c08752cdf73ff01e3adef24990007a7402c85996b11eb8bdc81fe0', '2024-10-15 22:12:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:42:16', 4, '2024-10-15 21:42:28', 4, '2024-10-15 00:00:00', 4),
	(225, 4, '7ba333ebe473b2dedbf06f04113b2765f6ba2546aac88b370a7f2f45774e2302', '2024-10-15 22:12:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:42:28', 4, '2024-10-15 21:42:28', 4, NULL, NULL),
	(226, 2, '42a392e8af41fb08e557cbd7b1840c6329a6ea8a1168a07986e92105ec9d950d', '2024-10-15 22:22:31', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-15 21:42:33', 2, '2024-10-16 19:10:23', 2, '2024-10-16 00:00:00', 2),
	(227, 2, '78d9745706424e0c9d3e09105d4f6665e39403d36071e48ec900352d5497ef5c', '2024-10-16 19:54:18', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 19:10:23', 2, '2024-10-16 19:24:20', 2, '2024-10-16 00:00:00', 2),
	(228, 2, '46e4ade996c00c978f9b5cc70bcdb4f7c8ddfc12be5fd8c85dc52f4d7560b414', '2024-10-16 19:54:27', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 19:24:27', 2, '2024-10-16 19:24:28', 2, '2024-10-16 00:00:00', 2),
	(229, 2, '1566475c34d3b723c0935a545e6c6e79ad3b9ffaeebe3a598a44ef4a7cbd465b', '2024-10-16 19:54:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 19:24:28', 2, '2024-10-16 19:24:37', 2, '2024-10-16 00:00:00', 2),
	(230, 2, '05d885b93b0fb0d25d12dcbd69e357be3c79249b30c7b8b39b21f4424ac4d9cb', '2024-10-16 20:51:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 19:24:37', 2, '2024-10-16 20:21:48', 2, '2024-10-16 00:00:00', 2),
	(231, 2, 'b51c67014fce4d69679d1aafd165e7996a59c673ed7537039030da3a3e33157a', '2024-10-16 20:52:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 20:21:48', 2, '2024-10-16 20:23:11', 2, '2024-10-16 00:00:00', 2),
	(232, 2, 'a7efdec14bdfb480faffead2e4c9f2e5be26af260bff39680fb5547c8ee482b2', '2024-10-16 21:07:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 20:23:11', 2, '2024-10-16 20:38:08', 2, '2024-10-16 00:00:00', 2),
	(233, 2, '8225c925404b17eeaefb090361ce3fc9c7ee41373f983dc92853ef2d9602b506', '2024-10-16 21:13:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 20:38:17', 2, '2024-10-16 21:32:14', 2, '2024-10-16 00:00:00', 2),
	(234, 1, 'dd184da633c3bd1e4cb697d576528836453afe574164cce6b81b78786c11e3b9', '2024-10-16 21:13:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 20:43:40', 1, '2024-10-16 20:44:00', 1, '2024-10-16 00:00:00', 1),
	(235, 1, 'd4298d84bccbda4f5b03ca4f8b6114031839e593d9b87700cd06c53416ca2802', '2024-10-16 22:02:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 20:44:00', 1, '2024-10-16 21:32:08', 1, '2024-10-16 00:00:00', 1),
	(236, 2, '9c973c821aa5869b2ea2119981fe45a361dbb2f321a22deb5be100263ee0035f', '2024-10-16 23:14:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-16 21:32:14', 2, '2024-10-17 18:42:10', 2, '2024-10-17 00:00:00', 2),
	(237, 2, 'e98493871eed605f6893583e70ebabb1ec27817c5230d88b49f07011a5db46e2', '2024-10-17 19:49:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 18:42:10', 2, '2024-10-17 20:00:37', 2, '2024-10-17 00:00:00', 2),
	(238, 1, '577d7aba859822b6c197a58fdf150a531309a14dc2bc81bff176bd9db1ceb963', '2024-10-17 20:26:25', '::1', 'PostmanRuntime/7.42.0', '2024-10-17 18:52:15', 1, '2024-10-17 19:56:25', 1, NULL, NULL),
	(239, 2, '6986093792840c30ab85998ec28703cad78b736b445629a95f2e6f69a5e06133', '2024-10-17 19:30:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 20:00:37', 2, '2024-10-17 21:27:36', 2, '2024-10-17 00:00:00', 2),
	(240, 2, '67db021804a0bc7fae0857a919256ec41177589959b9911b237136cb4e4ec6e2', '2024-10-17 21:57:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:36', 2, '2024-10-17 21:27:38', 2, '2024-10-17 00:00:00', 2),
	(241, 2, '7897649698f97ab1ae77beb848d6045c8201dec197c414355d680f34fbcdeaad', '2024-10-17 21:57:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:38', 2, '2024-10-17 21:27:38', 2, '2024-10-17 00:00:00', 2),
	(242, 2, '02e2d9c5e74e987d6a5a8941deba1d2fe7eb79451243ab3c216dd6c8d1c707e5', '2024-10-17 21:57:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:38', 2, '2024-10-17 21:27:39', 2, '2024-10-17 00:00:00', 2),
	(243, 2, '56cb1aa937c2062b3fb8192722b36a5b23b4b2f98b66ad1ea763eb66bdc957d1', '2024-10-17 21:57:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:39', 2, '2024-10-17 21:27:39', 2, '2024-10-17 00:00:00', 2),
	(244, 2, 'fede916e3c7b083a95e2fbf6679c4f72fa087f65127eaf6e4b360028a8023b1e', '2024-10-17 21:57:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:39', 2, '2024-10-17 21:27:58', 2, '2024-10-17 00:00:00', 2),
	(245, 2, 'b51c4b229844917cbfe57756d8e3c51d7c0f8f3eff4651a64bb73ad45947fdcd', '2024-10-17 21:58:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', '2024-10-17 21:27:58', 2, '2024-10-17 21:28:49', 2, NULL, NULL);

-- Volcando estructura para tabla clinica.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT (now()),
  `created_by` int NOT NULL DEFAULT '1',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`) USING BTREE,
  KEY `fk_user_role` (`role_id`) USING BTREE,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla clinica.user: ~6 rows (aproximadamente)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `role_id`, `first_name`, `last_name`, `username`, `password`, `active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
	(1, 1, 'Administrador', '', 'admin', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', 1, '2024-05-21 19:02:10', 1, '2024-10-11 20:43:18', 1, NULL, NULL),
	(2, 1, 'Henry', 'Rodríguez', 'hrodriguez', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', 1, '2024-05-23 19:42:32', 1, '2024-10-11 20:43:18', 1, NULL, NULL),
	(3, 1, 'Juan', 'Yat', 'jyat', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', 1, '2024-06-01 16:33:38', 1, '2024-10-11 20:43:19', 1, NULL, NULL),
	(4, 2, 'Wilmer', 'Contreras', 'wcontreras', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', 1, '2024-06-01 17:04:25', 1, '2024-10-15 21:42:06', 1, NULL, NULL),
	(5, 2, 'Jonatan', 'Torres', 'jtorrez', '487edeab14b06207ea401d488a42a9d8c4f58b5661e43ff4f7630ef266f3452e', 1, '2024-06-01 21:51:02', 1, '2024-10-15 21:42:05', 1, NULL, NULL),
	(6, 2, 'Pedro', 'Martínez', 'pmartinez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, '2024-10-17 19:05:51', 1, '2024-10-17 19:56:25', 1, '2024-10-17 19:56:25', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
