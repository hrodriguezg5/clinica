<?php
class InventoryModel{
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

    public function getInventories(){
        $this->db->query(
            "SELECT 
                i.id,
                i.quantity_available,
                i.last_update_date,
                b1.`name` AS name_branch
            FROM inventory i
            INNER JOIN batch AS b ON b.id = i.id_batch
            INNER JOIN branch AS b1 ON b1.id = i.id_branch
            WHERE i.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertInventories($data){
        $this->db->query(
            "INSERT INTO inventory
             (id_batch, 
             quantity_available,
             last_update_date,
             id_branch, 
              created_by,
              updated_by)
             VALUES
             (:id_batch, 
              :quantity_available,
              :last_update_date,
              :id_branch,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":id_batch", $data["id_batch"]);
        $this->db->bind(":quantity_available", $data["quantity_available"]);
        $this->db->bind(":last_update_date", $data["last_update_date"]);
        $this->db->bind(":id_branch", $data["id_branch"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateInventories($data){
        $this->db->query(
            "UPDATE inventory
                SET id_batch = :id_batch,
                quantity_available = :quantity_available,
                last_update_date = :last_update_date,
                id_branch = :id_branch,
                updated_at = CURRENT_TIMESTAMP(),
                updated_by = :updated_by
                WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":id_batch", $data["id_batch"]);
        $this->db->bind(":quantity_available", $data["quantity_available"]);
        $this->db->bind(":last_update_date", $data["last_update_date"]);
        $this->db->bind(":id_branch", $data["id_branch"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteInventories($data){
        $this->db->query(
            "UPDATE inventory
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

    public function fileterInventories($id){
        $this->db->query(
            "SELECT 
                i.id,
                i.quantity_available,
                i.last_update_date,
                b1.`name` AS name_branch
            FROM inventory i
            INNER JOIN batch AS b ON b.id = i.id_batch
            INNER JOIN branch AS b1 ON b1.id = i.id_branch
            WHERE i.id = :id
            AND b.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>