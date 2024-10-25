<?php
class PatientRoomModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getPatientRooms(){
        $this->db->query(
            "SELECT p.id,
            	p1.id AS patient_code,
            	CONCAT(p1.first_name, ' ', p1.last_name) AS name_patient,
            	r.room_number,
            	p.assigned_at,
            	p.released_at,
            	DATE(p.created_at) AS created_at
            FROM patient_room AS p
            INNER JOIN patient AS p1
            ON p.patient_id = p1.id
            INNER JOIN room AS r
            ON p.room_id = r.id
            WHERE p.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertBatch($data){
        $this->db->query(
            "INSERT INTO batch
             (medicine_id,
			  supplier_id,
			  quantity,
              expiration_date,
              created_by,
              updated_by)
             VALUES
             (
              :medicine_id,
              :supplier_id,
              :quantity,
              :expiration_date,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":expiration_date", $data["expiration_date"]);
        $this->db->bind(":quantity", $data["quantity"]);
        $this->db->bind(":medicine_id", $data["medicine_id"]);
        $this->db->bind(":supplier_id", $data["supplier_id"]);
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