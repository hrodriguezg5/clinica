<?php
class LoginController extends Controllers{
    public function __construct(){
        parent::__construct();
    }

    public function index(){
        $this->view("LoginView");
    }

    public function login(){
        echo "Login";
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            
            $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $user = $this->model->getLoginUser(['username' => $username, 'password' => $password]);

            if($user){
                $tokenData = [
                    "user_id" => $user->user_id,
                    "token" => bin2hex(random_bytes(32)),
                    "expires_at" => date('Y-m-d H:i:s', strtotime('+' . TOKEN_TTL . ' seconds')),
                    "ip_address" => $_SERVER['REMOTE_ADDR'],
                    "user_agent" => $_SERVER['HTTP_USER_AGENT']
                ];

                $this->model->deleteSessionToken($tokenData);
                $this->model->storeSessionToken($tokenData);

                $response = [
                    'user_id' => $user->user_id,
                    'token' => $tokenData["token"],
                    'expires_at' => $tokenData["expires_at"],
                    'user_name' => $user->user_name,
                    'role_name' => $user->role_name
                ];
                $this->jsonResponse($response);
            } else{
                $this->jsonResponse(["success" => false, "message" => "Credenciales inválidas."]);
            }
        }
    }
}
?>