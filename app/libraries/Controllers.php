<?php
//Clase controlador que se encarga de cargar los módelos y las vistas
class Controllers{
    protected $model;
    protected $authMiddleware;

    public function __construct(){
        $this->model();
        $this->authMiddleware();
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

    public function authMiddleware(){
        $routClass = "../app/middleware/AuthMiddleware.php";
        if(file_exists($routClass)){
            require_once($routClass);
            $this->authMiddleware = new AuthMiddleware;
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

    protected function getUserAndModules($data) {
        if (!isset($data['user']) || !isset($data['modules'])) {
            return $data; // O maneja el error de alguna otra manera
        }

        $user = $data['user'];
        $modules = $data['modules'];
        
        if ($user) {
            $moduleData = [];
            if ($modules) {
                foreach ($modules as $module) {
                    $moduleData[] = [
                        'module' => $module->module,
                        'link' => $module->link,
                        'icon' => $module->icon,
                        'create_operation' => $module->create_operation,
                        'update_operation' => $module->update_operation,
                        'delete_operation' => $module->delete_operation
                    ];
                }
            }

            return [
                'user_id' => $user->user_id,
                'role_id' => $user->role_id,
                'user_name' => $user->user_name,
                'role_name' => $user->role_name,
                'modules' => $moduleData
            ];
        }
    }

    // Destructor para cerrar la conexión
    public function __destruct() {
        if(isset($this->model)) {
            $this->model->closeConnection();
        }
    }
}
?>