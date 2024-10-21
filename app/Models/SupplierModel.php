<?php
class SupplierModel{
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

    public function getSuppliers(){
        $this->db->query(
            "SELECT 
                s.id,
                s.`name`,
                s.phone,
                s.address
            FROM supplier AS s
            WHERE s.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertSuppliers($data){
        $this->db->query(
            "INSERT INTO supplier 
             (`name`, 
              phone,
			  address, 
              created_by,
              updated_by)
             VALUES
             (:name, 
              :phone,
              :address,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":address", $data["address"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateSuppliers($data){
        $this->db->query(
            "UPDATE supplier
            SET `name` = :name,
            phone = :phone,
            address = :address,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":phone", $data["phone"]);
        $this->db->bind(":address", $data["address"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteSuppliers($data){
        $this->db->query(
            "UPDATE supplier
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

    public function fileterSuppliers($id){
        $this->db->query(
            "SELECT 
                s.id,
                s.`name`,
                s.phone,
                s.address
            FROM supplier AS s
            WHERE id = :id
            AND s.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>