<?php
class MiddlewareModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }

    public function closeConnection() {
        $this->db->closeConnection();
    }
    
    public function getSessionToken($data) {
        $this->db->query(
                "SELECT *
            FROM session_tokens 
            WHERE token = :token
            AND deleted_at IS NULL
            AND expires_at > NOW()
            LIMIT 1;"
        );
        
        $this->db->bind(":token", $data["token"]);
        $row = $this->db->record();
        return $row;
    }

    public function updateSessionToken($data){
        $this->db->query(
            "UPDATE session_tokens SET expires_at = :expires_at
            WHERE token = :token AND deleted_at IS NULL;"
        );

        $this->db->bind(":expires_at", $data["expires_at"]);
        $this->db->bind(":token", $data["token"]);
        $row = $this->db->record();
        return $row;
    }
    
    public function getUser($data){
        $this->db->query(
            "SELECT u.id AS user_id,
                u.first_name,
                CONCAT(u.first_name, ' ', u.last_name) AS user_name,
                u.role_id,
                r.`name` AS role_name
            FROM `user` AS u
            INNER JOIN `role` AS r
            ON u.role_id = r.id
            WHERE u.deleted_at IS NULL
            AND r.deleted_at IS NULL
            AND u.id = :user_id LIMIT 1;"
        );

        $this->db->bind(":user_id", $data["user_id"]);
        $row = $this->db->record();
        return $row;
    }

    public function getModules($data){
        $this->db->query(
            "SELECT m.`name` AS module,
                m.link,
                m.icon,
                p.create_operation,
                p.update_operation,
                p.delete_operation
            FROM `module` AS m
            INNER JOIN `permission` AS p
            ON m.id = p.module_id
            WHERE m.deleted_at IS NULL
            AND p.deleted_at IS NULL 
            AND p.role_id = :role_id
            ORDER BY m.order ASC;"
        );

        $this->db->bind(":role_id", $data["role_id"]);
        $row = $this->db->records();
        return $row;
    }
}
?>