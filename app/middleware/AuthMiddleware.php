<?php
class AuthMiddleware {
    private $model;

    public function __construct() {
        $routClassModel = "../app/Models/MiddlewareModel.php";
        if(file_exists($routClassModel)){
            require_once($routClassModel);
            $this->model = new MiddlewareModel;
        }
    }

    public function validateToken() {
        $headers = getallheaders();
        if (isset($headers['Authorization'])) {
            $token = str_replace('Bearer ', '', $headers['Authorization']);
            $session = $this->model->getToken(['token' => $token]);
            
            if ($session) {
                $user = $this->model->getUser(['user_id' => $session->user_id]);
                $modules = $this->model->getModules(['role_id' => $user->role_id]);
                return [
                    'user' => $user,
                    'modules' => $modules
                ];
            } else {
                http_response_code(401);
                echo json_encode(['message' => 'Token no válido o caducado']);
                exit;
            }
        } else {
            http_response_code(401);
            echo json_encode(['message' => 'Encabezado de autorización no encontrado']);
            exit;
        }
    }
}
?>