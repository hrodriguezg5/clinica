<?php
class RoomAvailableController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("RoomAvailableView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $roomsAvailables = $this->model->getRoomsAvailables();
        
            if ($roomsAvailables) {
                foreach ($roomsAvailables as $roomAvailable){
                    $response[] = [
                        'room_name' => $roomAvailable->room_name,
                        'branch_name' =>$roomAvailable->branch_name,
                        'occupied_quantity' =>$roomAvailable->occupied_quantity,
                        'available_quantity' =>$roomAvailable->available_quantity
                    ];
                }

                $this->jsonResponse($response);
            }
        }
    }
}
?>