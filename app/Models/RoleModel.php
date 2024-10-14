<?php
class RoleModel{
    private $db;

    public function __construct() {
        $this->db = new Database;
    }
    
    public function closeConnection()  {
        $this->db->closeConnection();
    }

    public function getRoles() {
        $this->db->query(
            "SELECT r.id,
                r.`name` AS `role`,
                r.`description`,
                r.`active`
            FROM `role` AS r
            WHERE r.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function filterRole($data){
        $this->db->query(
            "SELECT r.id,
                r.`name` AS `role`,
                r.`description`,
                r.`active`
            FROM `role` AS r
            WHERE r.id = :role_id
            AND r.deleted_at IS NULL
            LIMIT 1;"
        );

        $this->db->bind(":role_id", $data["role_id"]);
        $row = $this->db->record();
        return $row;
    }

    public function updateRole($data){
        $this->db->query(
            "UPDATE role
            SET name = :name,
            description = :description,
            updated_by = :user_id,
            active = :active
            WHERE id = :role_id;"
        );
        
        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":description", $data["description"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":user_id", $data["user_id"]);
        $this->db->bind(":role_id", $data["role_id"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteRole($data) {
        $this->db->query(
            "UPDATE reservation
            SET deleted_at = CURRENT_TIMESTAMP(),
            deleted_by = :user_id
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":user_id", $data["user_id"]);

        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }
}
?>