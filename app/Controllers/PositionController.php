<?php
class PositionController extends Controllers {
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
            $positions = $this->model->getPositions();
        
            if ($positions) {
                foreach ($positions as $position){
                    $response[] = [
                        'id' => $position->id,
                        'name' =>$position->name,
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
                "name" => isset($decodedData['name']) ? filter_var($decodedData['name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "active" => isset($decodedData['active']) ? filter_var($decodedData['active'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertPositions($data)) {
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

    public function search() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $json = file_get_contents('php://input');
            $decodedData = json_decode($json, true); 
    
            $name = isset($decodedData['name']) ? filter_var($decodedData['name'], FILTER_SANITIZE_SPECIAL_CHARS) : null;
            $employees = $this->model->searchEmployees($name);
    
            if ($employees) {
                foreach ($employees as $employee){
                    $response[] = [
                        'id' => $employee->id,
                        'first_name' => $employee->first_name,
                        'last_name' => $employee->last_name,
                        'phone' =>$employee->phone,
                        'email' => $employee->email,
                        'active' => $employee->active,
                        'name' => $employee->name

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
            $employees = $this->model->fileterEmployee($id);
    
            if ($employees) {
                foreach ($employees as $employee){
                    $response = [
                        'id' => $employee->id,
                        'first_name' => $employee->first_name,
                        'last_name' => $employee->last_name,
                        'phone' => $employee->phone,
                        'email' => $employee->email,
                        'active' =>$employee->active,
                        'name' =>$employee->name
                    ];
                
                }   
                $this->jsonResponse($response);

                
            }
        }
        
    }
    
}

?>