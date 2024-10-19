<?php
class UserModel {
    private $db;

    public function __construct() {
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getUsers() {
        $this->db->query(
            "SELECT u.id,
                CONCAT(u.first_name, ' ', u.last_name) AS user_name,
                u.username,
                u.`active`,
                r.id AS role_id,
                r.`name` AS role_name
            FROM `user` AS u
            LEFT JOIN `role` AS r
            ON u.role_id = r.id
            AND r.active = 1
            WHERE u.deleted_at IS NULL
            AND r.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function filterUser($data) {
        $this->db->query(
            "SELECT u.id,
                u.first_name,
                u.last_name,
                u.username,
                u.`active`,
                r.id AS role_id,
                r.`name` AS role_name
            FROM `user` AS u
            LEFT JOIN `role` AS r
            ON u.role_id = r.id
            AND r.active = 1
            WHERE u.deleted_at IS NULL
            AND r.deleted_at IS NULL
            AND u.id = :id
            LIMIT 1;"
        );

        $this->db->bind(":id", $data["id"]);
        $row = $this->db->record();
        return $row;
    }

    public function searchUsername($data) {
        $this->db->query(
            "SELECT u.username
            FROM `user` AS u
            WHERE u.deleted_at IS NULL
            AND u.username = :username
            LIMIT 1;"
        );

        $this->db->bind(":username", $data["username"]);
        $row = $this->db->record();
        return $row;
    }

    public function insertUser($data) {
        $this->db->query(
            "INSERT INTO `user` (role_id, first_name, last_name, username, password, active, created_by, updated_by)
            VALUES (:role_id, :first_name, :last_name, :username, SHA2(:password , 256), :active, :user_id, :user_id);"
        );
        
        $this->db->bind(":role_id", $data["role_id"]);
        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":username", $data["username"]);
        $this->db->bind(":password", $data["password"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":user_id", $data["user_id"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateUser($data) {
        $this->db->query(
            "UPDATE `user`
            SET role_id = :role_id,
            first_name = :first_name,
            last_name = :last_name,
            `password` = IF(:password = '', `password`, SHA2(:password, 256)),
            `active` = :active,
            updated_by = :user_id
            WHERE id = :id;"
        );
        
        $this->db->bind(":role_id", $data["role_id"]);
        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":password", $data["password"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":user_id", $data["user_id"]);
        $this->db->bind(":id", $data["id"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteUser($data) {
        $this->db->query(
            "UPDATE `user`
            SET deleted_at = CURRENT_TIMESTAMP(),
            deleted_by = :user_id
            WHERE id = :id;"
        );

        $this->db->bind(":user_id", $data["user_id"]);
        $this->db->bind(":id", $data["id"]);

        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }
}
?>