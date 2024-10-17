<?php
class PositionModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getTokenByUserId($data){
        $this->db->query(
            "SELECT token
            FROM session_tokens
            WHERE deleted_at IS NULL
            AND user_id = :user_id
            AND expires_at > :token_date
            LIMIT 1;"
        );

        $this->db->bind(":user_id", $data["user_id"]);
        $this->db->bind(":token_date", $data["token_date"]);
        $row = $this->db->record();
        return $row;
    }

    public function getPositions(){
        $this->db->query(
            "SELECT 
                p.id,
                p.name,
                p.active
            FROM position p
            WHERE p.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertEmployee($data){
        $this->db->query(
            "INSERT INTO employee
             (first_name, 
              last_name, 
              phone,
              email,
              `active`,
              id_position,
              created_by,
              updated_by)
             VALUES
             (:first_name, 
              :last_name, 
              :phone, 
              :email, 
              :active, 
              :id_position, 
              :created_by,
              :updated_by);"
        );

        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":email", $data["email"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":id_position", $data["id_position"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateEmployee($data){
        $this->db->query(
            "UPDATE employee
            SET first_name = :first_name,
            last_name = :last_name,
            phone = :phone,
            email = :email,
            `active` = :active,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":email", $data["email"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteEmployee($data){
        $this->db->query(
            "UPDATE employee
            SET deleted_at = CURRENT_TIMESTAMP(),
            deleted_by = :deleted_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":deleted_by", $data["deleted_by"]);

        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function searchEmployees($name){
        $this->db->query(
            "SELECT e.id,
                    e.first_name,
                    e.last_name,
                    e.phone,
                    e.email,
                    e.`active`,
                    p.`name`
                FROM employee AS e
                INNER JOIN position p ON p.id = e.id_position
                WHERE (e.first_name LIKE :name 
                            OR e.last_name LIKE :name  
                            OR e.phone LIKE :name 
                            OR e.email LIKE :name
                            OR e.active LIKE :name
                            OR p.name LIKE :name)
                        AND e.deleted_at IS NULL;"
        );

        $this->db->bind(':name', '%' . $name . '%');

        $row = $this->db->records();
        return $row;
    }

    public function fileterEmployee($id){
        $this->db->query(
            "SELECT e.id,
                e.first_name,
                e.last_name,
                e.phone,
                e.email,
                e.active,
                p.name
            FROM employee AS e
            INNER JOIN position AS p ON p.id = e.id_position
            WHERE e.id = :id
            AND e.deleted_at IS NULL;"
        );

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>