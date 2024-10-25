<?php
class InventoryModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
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

    public function insertInventory($data){
        $this->db->query(
            "INSERT INTO inventory (batch_id, branch_id, quantity, created_by, updated_by)
            VALUES (:batch_id, :branch_id, :quantity, :created_by, :updated_by);"
        );

        $this->db->bind(":batch_id", $data["batch_id"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":quantity", $data["quantity"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateInventory($data){
        $this->db->query(
            "UPDATE inventory
                SET branch_id = :branch_id,
                updated_at = CURRENT_TIMESTAMP(),
                updated_by = :updated_by
                WHERE batch_id = :batch_id;"
        );

        $this->db->bind(":batch_id", $data["batch_id"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteInventory($data){
        $this->db->query(
            "UPDATE inventory
            SET deleted_at = CURRENT_TIMESTAMP(),
            deleted_by = :deleted_by
            WHERE batch_id = :batch_id;"
        );

        $this->db->bind(":batch_id", $data["batch_id"]);
        $this->db->bind(":deleted_by", $data["deleted_by"]);

        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function filterInventory($id){
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