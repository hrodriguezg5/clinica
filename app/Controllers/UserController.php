<?php
class UserController extends Controllers {
    public function __construct() {
        parent::__construct();
    }
    
    public function index() {
        $this->view("UserView");
    }

    public function show() {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            if (!$this->authMiddleware->validateToken()) return;
            $users = $this->model->getUsers();

            if ($users) {
                foreach ($users as $user) {
                    $response[] = [
                        'id' => $user->id,
                        'user_name' => $user->user_name,
                        'username' => $user->username,
                        'active' => $user->active,
                        'role_id' => $user->role_id,
                        'role_name' => $user->role_name
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
            $id = filter_var($input['id'], FILTER_VALIDATE_INT) ?? null;
            $user = $this->model->filterUser(['id' => $id]);
            if ($user) {
                $response = [
                    'id' => $user->id,
                    'first_name' => $user->first_name,
                    'last_name' => $user->last_name,
                    'username' => $user->username,
                    'active' => $user->active,
                    'role_id' => $user->role_id,
                    'role_name' => $user->role_name
                ];
            
                $this->jsonResponse($response);
            }
        }
    }

    public function search() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);
            $username = htmlspecialchars($input['username'], ENT_QUOTES, 'UTF-8') ?? null;
            $user = $this->model->searchUsername(['username' => $username]);
            if ($user) {
                $response = [
                    'username' => $user->username
                ];
            
                $this->jsonResponse($response);
            }
        }
    }

    public function insert() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);

            $data = [
                "role_id" => filter_var($input['role_id'], FILTER_VALIDATE_INT) ?? null,
                "first_name" => htmlspecialchars($input['first_name'], ENT_QUOTES, 'UTF-8') ?? null,
                "last_name" => htmlspecialchars($input['last_name'], ENT_QUOTES, 'UTF-8') ?? null,
                "username" => htmlspecialchars($input['username'], ENT_QUOTES, 'UTF-8') ?? null,
                "password" => htmlspecialchars($input['password'], ENT_QUOTES, 'UTF-8') ?? null,
                "active" => filter_var($input['active'], FILTER_VALIDATE_INT) ?? null,
                "user_id" => filter_var($input['user_id'], FILTER_VALIDATE_INT) ?? null
            ];

            if ($this->model->insertUser($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);

            $data = [
                "role_id" => filter_var($input['role_id'], FILTER_VALIDATE_INT) ?? null,
                "first_name" => htmlspecialchars($input['first_name'], ENT_QUOTES, 'UTF-8') ?? null,
                "last_name" => htmlspecialchars($input['last_name'], ENT_QUOTES, 'UTF-8') ?? null,
                "username" => htmlspecialchars($input['username'], ENT_QUOTES, 'UTF-8') ?? null,
                "password" => htmlspecialchars($input['password'], ENT_QUOTES, 'UTF-8') ?? null,
                "active" => filter_var($input['active'], FILTER_VALIDATE_INT) ?? null,
                "user_id" => filter_var($input['user_id'], FILTER_VALIDATE_INT) ?? null,
                "id" => filter_var($input['id'], FILTER_VALIDATE_INT) ?? null
            ];

            if ($this->model->updateUser($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }

    public function delete() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!$this->authMiddleware->validateToken()) return;
            $input = json_decode(file_get_contents("php://input"), true);
            
            $data = [
                "user_id" => filter_var($input['user_id'], FILTER_VALIDATE_INT) ?? null,
                "id" => filter_var($input['id'], FILTER_VALIDATE_INT) ?? null
            ];

            if ($this->model->deleteUser($data)) {
                $this->jsonResponse(["success" => true]);
            } else {
                $this->jsonResponse(["success" => false]);
            }
        }
    }
}
?>