<?php
class SaleController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("SaleView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $sales = $this->model->getSales();
        
            if ($sales) {
                foreach ($sales as $sale){
                    $response[] = [
                        'id' => $sale->id,
                        'sale_date' =>$sale->sale_date,
                        'total_amount' =>$sale->total_amount,
                        'name_branch' =>$sale->name_branch,
                        'created_at' =>$sale->created_at
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
                "sale_date" => isset($decodedData['sale_date']) ? filter_var($decodedData['sale_date'], FILTER_SANITIZE_NUMBER_INT) : null,
                "total_amount" => isset($decodedData['total_amount']) ? filter_var($decodedData['total_amount'], FILTER_VALIDATE_FLOAT) : null,
                "branch_id" => isset($decodedData['branch_id']) ? filter_var($decodedData['branch_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_NUMBER_INT) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];
    
            if ($this->model->insertSales($data)) {
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
                "sale_date" => isset($decodedData['sale_date']) ? filter_var($decodedData['sale_date'], FILTER_SANITIZE_NUMBER_INT) : null,
                "total_amount" => isset($decodedData['total_amount']) ? filter_var($decodedData['total_amount'], FILTER_VALIDATE_FLOAT) : null,
                "branch_id" => isset($decodedData['branch_id']) ? filter_var($decodedData['branch_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];
            
            if ($this->model->updateSales($data)) {
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
    
    
            if ($this->model->deleteSales($data)) {
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
            $sale = $this->model->filterSales($id);
    
            if ($sale) {
                $response = [
                    'id' => $sale->id,
                    'sale_date' =>$sale->sale_date,
                    'total_amount' =>$sale->total_amount,
                    'name_branch' =>$sale->name_branch,
                    'created_at' =>$sale->created_at
                ];

                $this->jsonResponse($response);
            }
        }
    }
}
?>