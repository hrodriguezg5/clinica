<?php
//Rutas de controladores de español a inglés
const ROUTE_MAP = [
    "login" => "LoginController",
    "inicio" => "HomeController",
    "rol" => "RoleController",
    "permiso" => "PermissionController",
    "paciente" => "PatientController",
    "empleado" => "EmployeController",
    "posicion" => "PositionController"
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
    "salir" => "logout",
    "token" => "token",
    "actualizar" => "update",
    "eliminar" => "delete",
    "agregar" => "insert",
    "buscar" => "search",
    "mostrar" => "show",
    "filtrar" => "filter"
];
?>