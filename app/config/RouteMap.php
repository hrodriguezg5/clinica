<?php
//Rutas de controladores de español a inglés
const ROUTE_MAP = [
    "login" => "LoginController",
    "inicio" => "HomeController",
    "usuario" => "UserController",
    "rol" => "RoleController",
    "permiso" => "PermissionController",
    "paciente" => "PatientController",
    "empleado" => "EmployeController",
    "posicion" => "PositionController",
    "lote" => "BatchController",
    "medicina" => "MedicineController",
    "proveedor" => "SupplierController"
];

//Rutas de métodos de español a inglés
const ROUTE_METHOD_MAP = [
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