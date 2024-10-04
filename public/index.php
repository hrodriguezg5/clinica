<?php
require_once("../app/Config/Config.php");
require_once("../app/Helpers/Helpers.php");

//Autocarga de las librerias
spl_autoload_register(function($class){
    require_once("../app/Libraries/".$class.".php");
});

//Instanciamos la clase Core
$init = new Core;
?>