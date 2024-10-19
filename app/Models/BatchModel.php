<?php
class BatchModel{
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

    public function getLots(){
        $this->db->query(
            "SELECT 
                b.id,
                b.manufacture_date,
                b.expiration_date,
                b.initial_quantity,
                m.`name` AS name_medicine,
                s.`name` AS name_supplier
            FROM batch b
            INNER JOIN medicine AS m ON m.id = b.id_medicine
            INNER JOIN supplier AS s ON s.id = b.id_supplier
            WHERE b.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertLots($data){
        $this->db->query(
            "INSERT INTO batch
             (manufacture_date, 
              expiration_date,
			  initial_quantity,
			  id_medicine,
			  id_supplier, 
              created_by,
              updated_by)
             VALUES
             (:manufacture_date, 
              :expiration_date,
              :initial_quantity,
              :id_medicine,
              :id_supplier,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":manufacture_date", $data["manufacture_date"]);
        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":initial_quantity", $data["initial_quantity"]);
        $this->db->bind(":id_medicine", $data["id_medicine"]);
        $this->db->bind(":id_supplier", $data["id_supplier"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateLots($data){
        $this->db->query(
            "UPDATE batch
                    SET manufacture_date = :manufacture_date,
                    expiration_date = :expiration_date,
                    initial_quantity = :initial_quantity,
                    id_medicine = :id_medicine,
                    id_supplier = :id_supplier,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":manufacture_date", $data["manufacture_date"]);
        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":initial_quantity", $data["initial_quantity"]);
        $this->db->bind(":id_medicine", $data["id_medicine"]);
        $this->db->bind(":id_supplier", $data["id_supplier"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteLots($data){
        $this->db->query(
            "UPDATE batch
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

    public function fileterLots($id){
        $this->db->query(
            "SELECT 
                b.id,
                b.manufacture_date,
                b.expiration_date,
                b.initial_quantity,
                m.`name` AS name_medicine,
                s.`name` AS name_supplier
                FROM batch b
            INNER JOIN medicine AS m ON m.id = b.id_medicine
            INNER JOIN supplier AS s ON s.id = b.id_supplier
            WHERE b.id = :id
            AND b.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>