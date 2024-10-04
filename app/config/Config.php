<?php
require_once("Database.php");
require_once("RouteMap.php");

//Ruta de la aplicación
define("APP_ROUTE", dirname(dirname(__FILE__)));

//Ruta URL
const URL_ROUTE = "/clinica";

//Nombre del sitio
const SITE_NAME = "Clinica";

//Zona horaria
date_default_timezone_set('America/Guatemala');


?>