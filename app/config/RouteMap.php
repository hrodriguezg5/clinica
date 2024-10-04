<?php
//Rutas de controladores de español a inglés
const ROUTE_MAP = [
    "inicio" => "HomeController",
    "paciente" => "PatientController"
];

//Rutas de métodos de español a inglés
const ROUTE_METHOD_MAP = [
    //Home
    "ingresar" => "login",
    "registrar" => "register",
    "agendar" => "reservation",

    //Admin
    "reservacion" => "reservation",
    "cliente" => "customer",
    "hora" => "hour",
    "producto" => "product",
    "usuarios" => "users",
    "usuario" => "user",


    "actualizar" => "update",
    "eliminar" => "delete",
    "agregar" => "insert",
    "buscar" => "search",
    "mostrar" => "show"
];

?>