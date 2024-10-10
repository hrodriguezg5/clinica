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
                foreach ($patients as $patient){
                    $response = [
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

    

    public function hour() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;

            $date = filter_input(INPUT_POST, 'date', FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $hour = filter_input(INPUT_POST, 'hour', FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $availableHours = $this->model->getAvailableHours(['date' => $date, 'hour' => $hour]);
            $html = '';

            if ($availableHours) {
                foreach ($availableHours as $availableHour) {
                    $selected = $availableHour->reservation_hour == $hour ? 'selected' : '';
                    $html .= '<option ' . $selected . ' value="' . htmlspecialchars($availableHour->id) . '">
                                ' . htmlspecialchars($availableHour->reservation_hour) . '
                            </option>';
                }
            } else {
                $html .= '<option selected value="">Horario no disponible</option>';
            }

            $this->htmlResponse($html);
        }
    }

    public function product() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;

            $product = filter_input(INPUT_POST, 'product', FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? '';
            $products = $this->model->getProducts();
            $html = '';

            if ($products) {
                foreach ($products as $productData) {
                    $selected = $productData->product == $product ? 'selected' : '';
                    $html .= '<option ' . $selected . ' value="' . htmlspecialchars($productData->id) . '">
                    ' . htmlspecialchars($productData->product) . '
                    </option>';
                }
            }

            $this->htmlResponse($html);
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