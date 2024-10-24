<?php
class RoomModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getRooms(){
        $this->db->query(
            "SELECT r.id,
            	r.room_number,
            	b.name AS branch_name,
            	r.available,
              	DATE(b.created_at) AS created_at
            FROM room AS r
            INNER JOIN branch AS b
            ON b.id = r.id;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertRooms($data){
        $this->db->query(
            "INSERT INTO room
             (room_number,
			  branch_id,
			  available,
              created_by,
              updated_by)
             VALUES
             (
              :room_number,
              :branch_id,
              :available,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":room_number", $data["room_number"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":available", $data["available"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateBatch($data){
        $this->db->query(
            "UPDATE batch
                    SET expiration_date = :expiration_date,
                    quantity = :quantity,
                    medicine_id = :medicine_id,
                    supplier_id = :supplier_id,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":quantity", $data["quantity"]);
        $this->db->bind(":medicine_id", $data["medicine_id"]);
        $this->db->bind(":supplier_id", $data["supplier_id"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteBatch($data){
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

    public function filterBatch($id){
        $this->db->query(
            "SELECT b.id,
            	b.medicine_id,
            	m.`name` AS medicine_name,
            	b.supplier_id,
            	s.`name` AS supplier_name,
            	b.quantity,
            	DATE(b.created_at) AS created_at,
            	b.expiration_date
            FROM batch AS b
            INNER JOIN medicine AS m
            ON b.medicine_id = m.id
            INNER JOIN supplier AS s
            ON b.supplier_id = s.id
            WHERE b.id = :id
            AND b.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->record();
        return $row;
    }
}
?>