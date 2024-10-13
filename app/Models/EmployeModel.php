<?php
class EmployeModel{
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

    public function getEmployees(){
        $this->db->query(
            "SELECT 
                e.id,
                e.first_name,
                e.last_name,
                e.phone,
                e.email,
                e.active,
                p.name
            FROM employee e
            LEFT JOIN position p ON p.id = e.id_position
            WHERE e.deleted_at IS NULL;"
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

    public function deletePatient($data){
        $this->db->query(
            "UPDATE patient
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

    public function searchPatients($name){
        $this->db->query(
            "SELECT p.id,
                p.first_name,
                p.last_name,
                p.birth_date,
                p.gender,
                p.address,
                p.phone,
                p.email
            FROM patient AS p
            WHERE (p.first_name LIKE :name 
				OR p.last_name LIKE :name 
				OR p.birth_date LIKE :name 
				OR p.gender LIKE :name 
				OR p.gender LIKE :name 
				OR p.address LIKE :name 
				OR p.phone LIKE :name 
				OR p.email LIKE :name)
            AND p.deleted_at IS NULL;"
        );

        $this->db->bind(':name', '%' . $name . '%');

        $row = $this->db->records();
        return $row;
    }

    public function fileterPatient($id){
        $this->db->query(
            "SELECT p.id,
                p.first_name,
                p.last_name,
                p.birth_date,
                p.gender,
                p.address,
                p.phone,
                p.email
            FROM patient AS p
            WHERE p.id = :id
            AND p.deleted_at IS NULL;"
        );

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>