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
                "manufacture_date" => isset($decodedData['manufacture_date']) ? filter_var($decodedData['manufacture_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "expiration_date" => isset($decodedData['expiration_date']) ? filter_var($decodedData['expiration_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "initial_quantity" => isset($decodedData['initial_quantity']) ? filter_var($decodedData['initial_quantity'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_medicine" => isset($decodedData['id_medicine']) ? filter_var($decodedData['id_medicine'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_supplier" => isset($decodedData['id_supplier']) ? filter_var($decodedData['id_supplier'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertLots($data)) {
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
                "manufacture_date" => isset($decodedData['manufacture_date']) ? filter_var($decodedData['manufacture_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "expiration_date" => isset($decodedData['expiration_date']) ? filter_var($decodedData['expiration_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "initial_quantity" => isset($decodedData['initial_quantity']) ? filter_var($decodedData['initial_quantity'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_medicine" => isset($decodedData['id_medicine']) ? filter_var($decodedData['id_medicine'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "id_supplier" => isset($decodedData['id_supplier']) ? filter_var($decodedData['id_supplier'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updateLots($data)) {
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
    
    
            if ($this->model->deleteLots($data)) {
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
            $lots = $this->model->fileterLots($id);
    
            if ($lots) {
                foreach ($lots as $batch){
                    $response = [
                        'id' => $batch->id,
                        'manufacture_date' => $batch->manufacture_date,
                        'expiration_date' =>$batch->expiration_date,
                        'initial_quantity' =>$batch->initial_quantity,
                        'name_medicine' =>$batch->name_medicine,
                        'name_supplier' =>$batch->name_supplier
                    ];
                
                }   
                $this->jsonResponse($response);

                
            }
        }
        
    }
    
}

?>