<?php
class LoginController extends Controllers{
    public function __construct(){
        parent::__construct();
    }

    public function index(){
        $this->view("LoginView");
    }

    public function login(){
        if($_SERVER["REQUEST_METHOD"] == "POST") {
            $input = json_decode(file_get_contents("php://input"), true);
            $username = filter_var($input['username'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $password = filter_var($input['password'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
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
                    "success" => true,
                    'user_id' => $user->user_id,
                    'token' => $tokenData["token"],
                    'expires_at' => $tokenData["expires_at"],
                    'user_name' => $user->user_name,
                    'role_name' => $user->role_name
                ];
                $this->jsonResponse($response);
            } else{
                $this->jsonResponse(["success" => false, "message" => "Usuario o contraseña incorrectos."]);
            }
        }
    }
}
?>