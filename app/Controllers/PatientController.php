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

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $patients = $this->model->getPatients();
        
            if ($patients) {
            //    $response = [];
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
            if (!$this->authMiddleware->validateToken()) return;
            
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
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) {
                
                return;
            }
            
            // Obtener el contenido de la solicitud y decodificar el JSON
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); // Decodifica el JSON en un array asociativo
    
            $data = [
                "id" => isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "first_name" => isset($decodedData['first_name']) ? filter_var($decodedData['first_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "last_name" => isset($decodedData['last_name']) ? filter_var($decodedData['last_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "birth_date" => isset($decodedData['birth_date']) ? filter_var($decodedData['birth_date'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "gender" => isset($decodedData['gender']) ? filter_var($decodedData['gender'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "address" => isset($decodedData['address']) ? filter_var($decodedData['address'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "email" => isset($decodedData['email']) ? filter_var($decodedData['email'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updatePatient($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }
    

    public function delete() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
    
            // Obtener el contenido de la solicitud y decodificar el JSON
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); // Decodifica el JSON en un array asociativo
    
            $data = [
                "id" => isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_NUMBER_INT) : null, 
                "deleted_by" => isset($decodedData['deleted_by']) ? filter_var($decodedData['deleted_by'], FILTER_SANITIZE_NUMBER_INT) : null 
            ];
    
    
            if ($this->model->deletePatient($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function search() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); 
    
            $name = isset($decodedData['name']) ? filter_var($decodedData['name'], FILTER_SANITIZE_SPECIAL_CHARS) : null;
            $patients = $this->model->searchPatients($name);
    
            if ($patients) {
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

    public function filter() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); 
    
            $id = isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_SPECIAL_CHARS) : null;
            $patients = $this->model->fileterPatient($id);
    
            if ($patients) {
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
    
}

?>