<?php
class InventoryController extends Controllers {
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
            $inventories = $this->model->getInventories();
        
            if ($inventories) {
                foreach ($inventories as $inventory){
                    $response[] = [
                        'id' => $inventory->id,
                        'quantity_available' => $inventory->quantity_available,
                        'last_update_date' =>$inventory->last_update_date,
                        'name_branch' =>$inventory->name_branch
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
                "id_batch" => isset($decodedData['id_batch']) ? filter_var($decodedData['id_batch'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "quantity_available" => isset($decodedData['quantity_available']) ? filter_var($decodedData['quantity_available'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "last_update_date" => isset($decodedData['last_update_date']) ? filter_var($decodedData['last_update_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_branch" => isset($decodedData['id_branch']) ? filter_var($decodedData['id_branch'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertInventories($data)) {
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
                "id_batch" => isset($decodedData['id_batch']) ? filter_var($decodedData['id_batch'], FILTER_SANITIZE_NUMBER_INT) : null,
                "quantity_available" => isset($decodedData['quantity_available']) ? filter_var($decodedData['quantity_available'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "last_update_date" => isset($decodedData['last_update_date']) ? filter_var($decodedData['last_update_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_branch" => isset($decodedData['id_branch']) ? filter_var($decodedData['id_branch'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updateInventories($data)) {
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
    
    
            if ($this->model->deleteInventories($data)) {
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
            $inventories = $this->model->fileterInventories($id);
    
            if ($inventories) {
                foreach ($inventories as $inventory){
                    $response = [
                        'id' => $inventory->id,
                        'quantity_available' => $inventory->quantity_available,
                        'last_update_date' =>$inventory->last_update_date,
                        'name_branch' =>$inventory->name_branch
                    ];
                
                }   
                $this->jsonResponse($response);

                
            }
        }
        
    }
    
}

?>