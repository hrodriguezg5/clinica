<?php
class HomeController extends Controllers {
    public function __construct() {
        $this->authMiddleware();
    }
    
    public function index() {
        $this->view("HomeView");
    }

    public function token(){
        $data = $this->authMiddleware->validateToken();
        $response = $this->getUserAndModules($data);
        $this->jsonResponse($response);
    }
}
?>