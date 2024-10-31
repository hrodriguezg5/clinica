<?php
require_once("Database.php");
require_once("RouteMap.php");
require_once("ApiKey.php");

//Ruta de la aplicación
define("APP_ROUTE", dirname(dirname(__FILE__)));

//Ruta URL
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https://' : 'http://';
$basePath = rtrim(dirname(dirname(dirname($_SERVER['PHP_SELF']))), '/');
define('URL_ROUTE', $protocol . $_SERVER['HTTP_HOST'] . $basePath);

//Nombre del sitio
const SITE_NAME = "Clínica";

//Tiempo de expiración del token
const TOKEN_TTL = 1800;

//Zona horaria
date_default_timezone_set('America/Guatemala');
?>