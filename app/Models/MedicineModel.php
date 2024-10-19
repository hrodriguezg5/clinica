<?php
class MedicineModel{
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

    public function getMedicines(){
        $this->db->query(
            "SELECT m.id,
                m.name,
                m.description,
                m.price,
                m.brand,
                m.quantity_available,
                m.expiration_date
            FROM medicine AS m
            WHERE m.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertMedicines($data){
        $this->db->query(
            "INSERT INTO medicine
             (`name`, 
              description, 
              price, 
              brand, 
              quantity_available,
              expiration_date,
              created_by,
              updated_by)
             VALUES
             (:name, 
             :description, 
             :price, 
             :brand, 
             :quantity_available, 
             :expiration_date,
             :created_by,
             :updated_by);"
        );

        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":description", $data["description"]);
        $this->db->bind(":price", $data["price"]);
        $this->db->bind(":brand", $data["brand"]);
        $this->db->bind(":quantity_available", $data["quantity_available"]);
        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateMedicines($data){
        $this->db->query(
            "UPDATE medicine
            SET `name` = :name,
            `description` = :description,
            price = :price,
            brand = :brand,
            quantity_available = :quantity_available,
            expiration_date = :expiration_date,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":description", $data["description"]);
        $this->db->bind(":price", $data["price"]);
        $this->db->bind(":brand", $data["brand"]);
        $this->db->bind(":quantity_available", $data["quantity_available"]);
        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteMedicines($data){
        $this->db->query(
            "UPDATE medicine
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

    public function fileterMedicines($id){
        $this->db->query(
            "SELECT m.id,
            m.`name`,
            m.`description`,
            m.price,
            m.brand,
            m.quantity_available,
            m.expiration_date
        FROM medicine AS m
        WHERE m.id = :id
        AND m.deleted_at IS NULL;"
        );

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>