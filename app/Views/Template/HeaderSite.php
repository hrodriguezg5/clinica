<?php
    if (session_status() == PHP_SESSION_NONE) {
        session_start();
    }
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Fuente awesome -->
    <link href="css/font-awesome.min.css" rel="stylesheet" />

    <!-- Ruta de archivo styleSite -->
    <link rel="stylesheet" href="<?= URL_ROUTE; ?>/css/styleSite.css" />

    <!-- Link de iconos-->
	<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css" />

	<!-- Ruta de archivo boostrap css -->
    <!-- <link rel="stylesheet" href="<?= URL_ROUTE; ?>/css/bootstrap.css" /> -->

    <!-- Ruta del icono de GPSgt -->
    <link rel="shortcut icon" href="<?= URL_ROUTE; ?>/img/favicon.ico" />

    <title><?= SITE_NAME; ?></title>
</head>
<body>
    <header class="header">
        <nav class="navigation">

            <!-- Logotipo -->
            <a href="<?= URL_ROUTE; ?>" class="logo">
				<img src="<?= URL_ROUTE; ?>/img/logo.png" class="logo_img" />
			</a>
            <ul class="nav_items">

                <!-- Menú de navegacion -->
                <li class="nav_item">
                    <a href="#home" class="nav_link">Inicio</a>
                    <a href="#products" class="nav_link">Productos</a>
                    <a href="#reservation" class="nav_link">Cita</a>
                    <a href="#contact" class="nav_link">Contacto</a>
                </li>
            </ul>

            <!-- Botón de inicio de sesión -->
            <button class="button" id="form_open">Iniciar Sesión</button>
        </nav>
    </header>
    <div class="page">