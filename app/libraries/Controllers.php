<?php
//Clase controlador que se encarga de cargar los módelos y las vistas
class Controllers{
    protected $model;

    public function __construct(){
        $this->model();
    }

    //Cargar módelo
    public function model(){
        $model = get_class($this);
        $model = str_replace("Controller","Model", $model);
        $routClassModel = "../app/Models/".$model.".php";
        
        if(file_exists($routClassModel)){
            require_once($routClassModel);
            $this->model = new $model;
        }
    }

    //Cargar vista
    public function view($view, $data = []){
        require_once("../app/Views/".$view.".php");
    }

     // Respuesta en formato JSON
     protected function jsonResponse($data) {
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }

    // Respuesta en formato HTML
    protected function htmlResponse($html) {
        header('Content-Type: text/html');
        echo $html;
        exit;
    }

    // Método para validar el token
    protected function validateToken($token, $userId, $tokenDate) {
        $storedToken = $this->model->getTokenByUserId(['user_id' => $userId, 'token_date' => $tokenDate]);
        if (!$storedToken) {
            return false; // No se encontró el token en la base de datos
        }

        return hash_equals($storedToken->token, $token); // Compara el token almacenado con el proporcionado
    }
    
    // Destructor para cerrar la conexión
    public function __destruct() {
        if(isset($this->model)) {
            $this->model->closeConnection();
        }
    }
}
?>