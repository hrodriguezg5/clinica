<?php
class SalesDetailController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("SalesDetailView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $sales = $this->model->getSalesDetail();
        
            if ($sales) {
                foreach ($sales as $sale){
                    $response[] = [
                        'id' => $sale->id,
                        'sale_date' =>$sale->sale_date,
                        'medicine_name' =>$sale->medicine_name,
                        'selling_price' =>$sale->selling_price,
                        'batch_quantity' =>$sale->batch_quantity,
                        'expiration_date' =>$sale->expiration_date,
                        'quantity' =>$sale->quantity,
                        'unit_price' =>$sale->unit_price,
                        'subtotal' =>$sale->subtotal,
                        'total_amount' =>$sale->total_amount,
                        'created_at' => $sale->created_at
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
                "sale_id" => isset($decodedData['sale_id']) ? filter_var($decodedData['sale_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "medicine_id" => isset($decodedData['medicine_id']) ? filter_var($decodedData['medicine_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "batch_id" => isset($decodedData['batch_id']) ? filter_var($decodedData['batch_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "quantity" => isset($decodedData['quantity']) ? filter_var($decodedData['quantity'], FILTER_SANITIZE_NUMBER_INT) : null,
                "unit_price" => isset($decodedData['unit_price']) ? filter_var($decodedData['unit_price'], FILTER_VALIDATE_FLOAT) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_NUMBER_INT) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];

    
            if ($this->model->insertSalesDetail($data)) {
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
                "medicine_id" => isset($decodedData['medicine_id']) ? filter_var($decodedData['medicine_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "supplier_id" => isset($decodedData['supplier_id']) ? filter_var($decodedData['supplier_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "branch_id" => isset($decodedData['branch_id']) ? filter_var($decodedData['branch_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "purchase_price" => isset($decodedData['purchase_price']) ? filter_var($decodedData['purchase_price'], FILTER_VALIDATE_FLOAT) : null,
                "expiration_date" => isset($decodedData['expiration_date']) ? htmlspecialchars($decodedData['expiration_date'], ENT_QUOTES, 'UTF-8') : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];
            
            if ($this->model->updateBatch($data)) {
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
    
    
            if ($this->model->deleteBatch($data)) {
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
            $batch = $this->model->filterBatch($id);
    
            if ($batch) {
                $response = [
                    'id' => $batch->id,
                    'medicine_id' =>$batch->medicine_id,
                    'medicine_name' =>$batch->medicine_name,
                    'supplier_id' =>$batch->supplier_id,
                    'supplier_name' =>$batch->supplier_name,
                    'branch_id' =>$batch->branch_id,
                    'branch_name' =>$batch->branch_name,
                    'purchase_price' =>$batch->purchase_price,
                    'quantity' =>$batch->quantity,
                    'created_at' =>$batch->created_at,
                    'expiration_date' =>$batch->expiration_date
                ];

                $this->jsonResponse($response);
            }
        }
    }
}
?>