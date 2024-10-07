<?php
//Rutas de controladores de español a inglés
const ROUTE_MAP = [
    "login" => "LoginController",
    "paciente" => "PatientController"
];

//Rutas de métodos de español a inglés
const ROUTE_METHOD_MAP = [
    "reservacion" => "reservation",
    "cliente" => "customer",
    "hora" => "hour",
    "producto" => "product",
    "usuarios" => "users",
    "usuario" => "user",

    "ingresar" => "login",
    "token" => "token",
    "actualizar" => "update",
    "eliminar" => "delete",
    "agregar" => "insert",
    "buscar" => "search",
    "mostrar" => "show"
];
?>