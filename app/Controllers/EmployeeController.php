<?php
class EmployeeController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("EmployeeView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $employees = $this->model->getEmployees();
        
            if ($employees) {
                foreach ($employees as $employee){
                    $response[] = [
                        'id' => $employee->id,
                        'employee_name' => $employee->employee_name,
                        'phone' =>$employee->phone,
                        'email' => $employee->email,
                        'active' => $employee->active,
                        'position_id' =>$employee->position_id,
                        'position' =>$employee->position
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
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "email" => isset($decodedData['email']) ? filter_var($decodedData['email'], FILTER_SANITIZE_EMAIL) : null,
                "active" => isset($decodedData['active']) ? filter_var($decodedData['active'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "position_id" => isset($decodedData['position_id']) ? filter_var($decodedData['position_id'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertEmployee($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            
            // Obtener el contenido de la solicitud y decodificar el JSON
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); // Decodifica el JSON en un array asociativo
    
            $data = [
                "id" => isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "first_name" => isset($decodedData['first_name']) ? filter_var($decodedData['first_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "last_name" => isset($decodedData['last_name']) ? filter_var($decodedData['last_name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) : null,
                "email" => isset($decodedData['email']) ? filter_var($decodedData['email'], FILTER_SANITIZE_EMAIL) : null,
                "active" => isset($decodedData['active']) ? filter_var($decodedData['active'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updateEmployee($data)) {
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
    
    
            if ($this->model->deleteEmployee($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function filter() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); 
    
            $id = isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_SPECIAL_CHARS) : null;
            $employee = $this->model->fileterEmployee($id);
    
            if ($employee) {
                $response = [
                    'id' => $employee->id,
                    'first_name' => $employee->first_name,
                    'last_name' => $employee->last_name,
                    'phone' => $employee->phone,
                    'email' => $employee->email,
                    'active' =>$employee->active,
                    'position_id' =>$employee->position_id,
                    'position' =>$employee->position
                ];
                
                $this->jsonResponse($response);                
            }
        }
    }
}
?>