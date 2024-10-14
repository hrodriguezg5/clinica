<?php
class RoleController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index()  {
        $this->view("RoleView");
    }

    public function token() {
        $data = $this->authMiddleware->validateToken();
        $response = $this->getUserAndModules($data);
        $this->jsonResponse($response);
    }
    
    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $roles = $this->model->getRoles();

            if ($roles) {
                foreach ($roles as $role) {
                    $response[] = [
                        'id' => $role->id,
                        'role' => $role->role,
                        'description' => $role->description,
                        'active' => $role->active
                    ];
                }

                $this->jsonResponse($response);
            }
        }
    }

    public function filter() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);
            $role_id = filter_var($input['role_id'], FILTER_SANITIZE_FULL_SPECIAL_CHARS) ?? null;
            $role = $this->model->filterRole(['role_id' => $role_id]);
            if ($role) {
                $response = [
                    'id' => $role->id,
                    'role' => $role->role,
                    'description' => $role->description,
                    'active' => $role->active
                ];
            
                $this->jsonResponse($response);
            }
        }
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);
            
            $data = [
                "name" => htmlspecialchars($input['name'], ENT_QUOTES, 'UTF-8') ?? null,
                "description" => htmlspecialchars($input['description'], ENT_QUOTES, 'UTF-8') ?? null,
                "active" => filter_var($input['active'], FILTER_VALIDATE_INT) ?? null,
                "user_id" => filter_var($input['user_id'], FILTER_VALIDATE_INT) ?? null,
                "role_id" => filter_var($input['role_id'], FILTER_VALIDATE_INT) ?? null
            ];

            if ($this->model->updateRole($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function delete() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $userId = $_SESSION['user_id'] ?? 1;

            $data = [
                "id" => filter_input(INPUT_POST, 'id', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                "user_id" => $userId
            ];

            if ($this->model->deleteReservation($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }
}

?>