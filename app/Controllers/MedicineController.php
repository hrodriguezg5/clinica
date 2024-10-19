<?php
class MedicineController extends Controllers {
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
            $medicines = $this->model->getMedicines();
        
            if ($medicines) {
                foreach ($medicines as $medicine){
                    $response[] = [
                        'id' => $medicine->id,
                        'name' =>$medicine->name,
                        'description' =>$medicine->description,
                        'price' =>$medicine->price,
                        'brand' =>$medicine->brand,
                        'quantity_available' =>$medicine->quantity_available,
                        'expiration_date' =>$medicine->expiration_date
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
                "description" => isset($decodedData['description']) ? filter_var($decodedData['description'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "price" => isset($decodedData['price']) ? filter_var($decodedData['price'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "brand" => isset($decodedData['brand']) ? filter_var($decodedData['brand'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "quantity_available" => isset($decodedData['quantity_available']) ? filter_var($decodedData['quantity_available'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "expiration_date" => isset($decodedData['expiration_date']) ? filter_var($decodedData['expiration_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_EMAIL) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null,
            ];
    
            if ($this->model->insertMedicines($data)) {
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
                "id" => isset($decodedData['id']) ? filter_var($decodedData['id'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "name" => isset($decodedData['name']) ? filter_var($decodedData['name'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "description" => isset($decodedData['description']) ? filter_var($decodedData['description'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "price" => isset($decodedData['price']) ? filter_var($decodedData['price'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "brand" => isset($decodedData['brand']) ? filter_var($decodedData['brand'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "quantity_available" => isset($decodedData['quantity_available']) ? filter_var($decodedData['quantity_available'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "expiration_date" => isset($decodedData['expiration_date']) ? filter_var($decodedData['expiration_date'], FILTER_SANITIZE_SPECIAL_CHARS) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_EMAIL) : null
            ];
            
            if ($this->model->updateMedicines($data)) {
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
    
    
            if ($this->model->deleteMedicines($data)) {
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
            $medicines = $this->model->fileterMedicines($id);
    
            if ($medicines) {
                foreach ($medicines as $medicine){
                    $response = [
                        'id' => $medicine->id,
                        'name' =>$medicine->name,
                        'description' =>$medicine->description,
                        'price' =>$medicine->price,
                        'brand' =>$medicine->brand,
                        'quantity_available' =>$medicine->quantity_available,
                        'expiration_date' =>$medicine->expiration_date
                    ];
                
                }   
                $this->jsonResponse($response);

                
            }
        }
        
    }
    
}

?>