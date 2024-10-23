<?php
class BranchController extends Controllers {
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
            $branches = $this->model->getBranches();
        
            if ($branches) {
                foreach ($branches as $branch){
                    $response[] = [
                        'id' => $branch->id,
                        'name' => $branch->name,
                        'address' =>$branch->address,
                        'phone' =>$branch->phone,
                        'city' =>$branch->city
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
                "address" => isset($decodedData['address']) ? filter_var($decodedData['address'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "city" => isset($decodedData['city']) ? filter_var($decodedData['city'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertBranches($data)) {
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
                "name" => isset($decodedData['name']) ? filter_var($decodedData['name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "address" => isset($decodedData['address']) ? filter_var($decodedData['address'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "phone" => isset($decodedData['phone']) ? filter_var($decodedData['phone'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "city" => isset($decodedData['city']) ? filter_var($decodedData['city'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updateBranches($data)) {
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
    
    
            if ($this->model->deleteBranches($data)) {
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
            $branches = $this->model->fileterBranches($id);
    
            if ($branches) {
                foreach ($branches as $branch){
                    $response = [
                        'id' => $branch->id,
                        'name' => $branch->name,
                        'address' =>$branch->address,
                        'phone' =>$branch->phone,
                        'city' =>$branch->city
                    ];
                
                }   
                $this->jsonResponse($response);

                
            }
        }
        
    }
    
}

?>