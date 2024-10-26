<?php
class AuthMiddleware {
    private $model;

    public function __construct() {
        $this->model();
    }

    public function model(){
        $routClass = "../app/Models/MiddlewareModel.php";
        
        if(file_exists($routClass)){
            require_once $routClass;
            $this->model = new MiddlewareModel;
        }
    }

    public function validateToken() {
        $headers = getallheaders();
        if (isset($headers['Authorization'])) {
            $token = str_replace('Bearer ', '', $headers['Authorization']);
            $session = $this->model->getSessionToken(['token' => $token]);
            
            if ($session) {
                $tokenData = [
                    "token" => $token,
                    "expires_at" => date('Y-m-d H:i:s', strtotime('+' . TOKEN_TTL . ' seconds'))
                ];

                $this->model->updateSessionToken($tokenData);
                $user = $this->model->getUser(['user_id' => $session->user_id]);

                if (!$user) {
                    http_response_code(401);
                    return false;
                }
                
                $modules = $this->model->getModules(['role_id' => $user->role_id]);
                return [
                    "success" => true,
                    'user' => $user,
                    'modules' => $modules
                ];
            } else {
                http_response_code(401);
                return false;
            }
        } else {
            http_response_code(401);
            return false;
        }
    }
}
?>