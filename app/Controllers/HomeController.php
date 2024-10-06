<?php
class HomeController extends Controllers{
    public function __construct(){
        parent::__construct();
    }

    public function index(){
        session_start();

        $data = [
            "login_email" => "",
            "login_password" => "",
            "register_email" => "",
            "register_first_name" => "",
            "register_last_name" => "",
            "register_phone" => "",
            "register_address" => "",
            "register_password" => "",
            "register_confirm_password" => ""
        ];

        if(isset($_SESSION['form_data'])) {
            foreach ($_SESSION['form_data'] as $key => $value) {
                if (!empty($value)) {
                    $data[$key] = $value;
                }
            }

            unset($_SESSION['form_data']);
        }
        $this->view("Home/HomeView", $data);
    }

    public function login(){
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            session_start();
            $data = [
                "login_email" => trim($_POST["login_email"]),
                "login_password" => trim($_POST["login_password"])
            ];

            $user = $this->model->getLoginUser($data);

            if($user){
                $tokenData = [
                    "user_id" => $user->user_id,
                    "token" => bin2hex(random_bytes(32)),
                    "expires_at" => date('Y-m-d H:i:s', strtotime('+3600 seconds')),
                    "ip_address" => $_SERVER['REMOTE_ADDR'],
                    "user_agent" => $_SERVER['HTTP_USER_AGENT']
                ];

                $this->model->deleteSessionToken($tokenData);
                $this->model->storeSessionToken($tokenData);
                
                $_SESSION['loggedin'] = true;
                $_SESSION['user_id'] = $user->user_id;
                $_SESSION['user_name'] = $user->user_name;
                $_SESSION['role_name'] = $user->role_name;
                $view = $this->model->getLoginView($data);
                $redirectUrl = URL_ROUTE . "/" . $view->view;

                echo "
                <script>
                    localStorage.setItem('session_token', '{$tokenData['token']}');
                    window.location.href = '{$redirectUrl}';
                </script>";
                exit();

            } else{
                $_SESSION['loggedin_error'] = true;
                $_SESSION['form_data'] = $data;
                redirect("");
            }
        }
    }

    public function register(){
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            session_start();
            
            $data = [
                "register_email" => trim($_POST["register_email"]),
                "register_first_name" => trim($_POST["register_first_name"]),
                "register_last_name" => trim($_POST["register_last_name"]),
                "register_phone" => trim($_POST["register_phone"]),
                "register_address" => trim($_POST["register_address"]),
                "register_password" => trim($_POST["register_password"]),
                "register_confirm_password" => trim($_POST["register_confirm_password"])
            ];
            
            $registerEmail = $this->model->getRegisterUser($data);

            if($registerEmail->email == $data["register_email"]){
                $_SESSION['duplicate_email'] = true;
                $_SESSION['form_data'] = $data;
                redirect("");
            } else if($data["register_password"] != $data["register_confirm_password"]){
                $_SESSION['distinct_password'] = true;
                $_SESSION['form_data'] = $data;
                redirect("");
            } else{
                if($this->model->insertUser($data)){
                    $_SESSION['loggedin'] = true;
                    $user = $this->model->getRegisterUser($data);
                    $_SESSION['user_id'] = $user->user_id;
                    $_SESSION['user_name'] = $user->user_name;
                    $view = $this->model->getRegisterView($data);
                    redirect("/".$view->view);
                } else{
                    die("Algo salió mal");
                }
            }
        }
    }

    public function reservation(){
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            $data = [
                "reservation_first_name" => trim($_POST["reservation_first_name"]),
                "reservation_last_name" => trim($_POST["reservation_last_name"]),
                "reservation_email" => trim($_POST["reservation_email"]),
                "reservation_phone_number" => trim($_POST["reservation_phone_number"]),
                "reservation_product" => trim($_POST["reservation_product"]),
                "reservation_product_quantity" => trim($_POST["reservation_product_quantity"]),
                "reservation_address" => trim($_POST["reservation_address"]),
                "reservation_date" => trim($_POST["reservation_date"]),
                "reservation_hour" => trim($_POST["reservation_hour"])
            ];
            
            $productId = $this->model->getProduct($data);
            $reservationHourId = $this->model->getReservationHour($data);

            $data["product_id"] = $productId->id;
            $data["hour_id"] = $reservationHourId->id;


            if($this->model->insertReservation($data)){
                redirect("");
            } else{
                die("Algo salió mal");
            }
        }
    }

    public function hour($date){
        if (isset($date)){
            $data["date"] = $date;
            $data["hours"] = $this->model->getAvailableHour($data);
            // Preparar la respuesta como un array
            $response = [];
    
            if ($data["hours"]) {
                // Agregar cada hora disponible al array
                foreach ($data["hours"] as $hour) {
                    $response[] = htmlspecialchars($hour->reservation_hour);
                }
            }
    
            // Devolver la respuesta como un JSON
            header('Content-Type: application/json');
            echo json_encode($response);
        }
    }
}
?>