<?php
class PatientModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getPatients(){
        $this->db->query(
            "SELECT p.id,
                CONCAT(p.first_name, ' ', p.last_name) AS full_name,
                p.birth_date,
                p.gender,
                p.address,
                p.phone,
                p.email
            FROM patient AS p
            WHERE p.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertPatient($data){
        $this->db->query(
            "INSERT INTO patient
             (first_name, 
              last_name, 
              birth_date, 
              gender, 
              address,
              phone,
              email,
              created_by,
              updated_by)
             VALUES
             (:first_name, 
              :last_name, 
              :birth_date, 
              :gender, 
              :address, 
              :phone, 
              :email,
              :created_by,
              :updated_by);"
        );

        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":birth_date", $data["birth_date"]);
        $this->db->bind(":gender", $data["gender"]);
        $this->db->bind(":address", $data["address"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":email", $data["email"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updatePatient($data){
        $this->db->query(
            "UPDATE patient
            SET first_name = :first_name,
            last_name = :last_name,
            birth_date = :birth_date,
            gender = :gender,
            address = :address,
            phone = :phone,
            email = :email,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":birth_date", $data["birth_date"]);
        $this->db->bind(":gender", $data["gender"]);
        $this->db->bind(":address", $data["address"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":email", $data["email"]);
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