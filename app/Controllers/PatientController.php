<?php
class PatientController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("PatientView");
    }

    public function token(){
        $data = $this->authMiddleware->validateToken();
        $response = $this->getUserAndModules($data);
        $this->jsonResponse($response);
    }
    
    public function customer() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);
            $id = filter_var($input['id'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $customer = $this->model->getCustomer(['id' => $id]);

            if ($customer) {
                $response = [
                    'id' => $customer->id,
                    'first_name' => $customer->first_name,
                    'last_name' => $customer->last_name,
                    'email' => $customer->email,
                    'phone_number' => $customer->phone_number,
                    'address' => $customer->address,
                    'product' => $customer->product,
                    'product_quantity' => $customer->product_quantity,
                    'hour' => $customer->reservation_hour,
                    'date' => $customer->reservation_date
                ];
                $this->jsonResponse($response);
            }
        }
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $patients = $this->model->getPatients();
        
            if ($patients) {
                $response = [];
                foreach ($patients as $patient){
                    $response[] = [
                        'id' => $patient->id,
                        'first_name' => $patient->first_name,
                        'last_name' => $patient->last_name,
                        'birth_date' => $patient->birth_date,
                        'gender' =>$patient->gender,
                        'address' =>$patient->address,
                        'phone' =>$patient->phone,
                        'email' => $patient->email
                    ];
                
                }   
                $this->jsonResponse($response);
            }
        }
    }

    public function insert() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) {
                $this->jsonResponse(["success" => false, "message" => "Token de autenticación inválido."]);
                return;
            }
            
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); 
    
            $data = [
                "first_name" => isset($decodedData['first_name']) ? filter_var($decodedData['first_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "last_name" => isset($decodedData['last_name']) ? filter_var($decodedData['last_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "birth_date" => isset($decodedData['birth_date']) ? filter_var($decodedData['birth_date'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "gender" => isset($decodedData['gender']) ? filter_var($decodedData['gender'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "address" => isset($decodedData['address']) ? filter_var($decodedData['address'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "email" => isset($decodedData['email']) ? filter_var($decodedData['email'], FILTER_SANITIZE_EMAIL) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertPatient($data)) {
                $this->jsonResponse(["success" => true, "message" => "Paciente insertado exitosamente."]);
            } else {
                $this->jsonResponse(["success" => false, "message" => "Error al insertar el paciente."]);
            }
        } else {
            $this->jsonResponse(["success" => false, "message" => "Método no permitido."]);
        }
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $userId = $_SESSION['user_id'] ?? 1;

            $data = [
                "id" => filter_input(INPUT_POST, 'id', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "first_name" => filter_input(INPUT_POST, 'first_name', FILTER_SANITIZE_SPECIAL_CHARS),
                "last_name" => filter_input(INPUT_POST, 'last_name', FILTER_SANITIZE_SPECIAL_CHARS),
                "email" => filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL),
                "phone_number" => filter_input(INPUT_POST, 'phone_number', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "product_id" => filter_input(INPUT_POST, 'product_id', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "product_quantity" => filter_input(INPUT_POST, 'product_quantity', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "address" => filter_input(INPUT_POST, 'address', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "date" => filter_input(INPUT_POST, 'date', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "hour_id" => filter_input(INPUT_POST, 'hour_id', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "user_id" => $userId
            ];

            if ($this->model->updateReservation($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function delete() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $userId = $_SESSION['user_id'] ?? 1;

            $data = [
                "id" => filter_input(INPUT_POST, 'id', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "user_id" => $userId
            ];

            if ($this->model->deleteReservation($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }
}

?>