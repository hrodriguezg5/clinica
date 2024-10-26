<?php
class PatientRoomController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("PatientRoomView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $rooms = $this->model->getPatientRooms();
        
            if ($rooms) {
                foreach ($rooms as $room){
                    $response[] = [
                        'id' => $room->id,
                        'patient_code' =>$room->patient_code,
                        'name_patient' =>$room->name_patient,
                        'room_number' =>$room->room_number,
                        'assigned_at' =>$room->assigned_at,
                        'released_at' =>$room->released_at,
                        'created_at' => $room->created_at
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
                "patient_id" => isset($decodedData['patient_id']) ? filter_var($decodedData['patient_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "room_id" => isset($decodedData['room_id']) ? filter_var($decodedData['room_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "assigned_at" => isset($decodedData['assigned_at']) ? filter_var($decodedData['assigned_at'], FILTER_SANITIZE_NUMBER_INT) : null,
                "created_by" => isset($decodedData['created_by']) ? filter_var($decodedData['created_by'], FILTER_SANITIZE_NUMBER_INT) : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];
    
            if ($this->model->insertPatientRooms($data)) {
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
                "patient_id" => isset($decodedData['patient_id']) ? filter_var($decodedData['patient_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "room_id" => isset($decodedData['room_id']) ? filter_var($decodedData['room_id'], FILTER_SANITIZE_NUMBER_INT) : null,
                "assigned_at" => isset($decodedData['assigned_at']) ? filter_var($decodedData['assigned_at'], FILTER_SANITIZE_NUMBER_INT) : null,
                "released_at" => isset($decodedData['released_at']) ? htmlspecialchars($decodedData['released_at'], ENT_QUOTES, 'UTF-8') : null,
                "updated_by" => isset($decodedData['updated_by']) ? filter_var($decodedData['updated_by'], FILTER_SANITIZE_NUMBER_INT) : null
            ];
            
            if ($this->model->updatePatientRooms($data)) {
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
    
    
            if ($this->model->deletePatientRooms($data)) {
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
            $rooms = $this->model->filterPatientRooms($id);
    
            if ($rooms) {
                $response = [
                    'id' => $rooms->id,
                    'patient_code' =>$rooms->patient_code,
                    'name_patient' =>$rooms->name_patient,
                    'room_number' =>$rooms->room_number,
                    'assigned_at' =>$rooms->assigned_at,
                    'released_at' =>$rooms->released_at,
                    'created_at' => $rooms->created_at
                ];

                $this->jsonResponse($response);
            }
        }
    }
}
?>