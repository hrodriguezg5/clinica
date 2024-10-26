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

    public function insertPatientRooms($data){
        $this->db->query(
            "INSERT INTO patient_room
             (patient_id,
			  room_id,
			  assigned_at,
              created_by,
              updated_by)
             VALUES
             (
              :patient_id,
              :room_id,
              :assigned_at,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":patient_id", $data["patient_id"]);
        $this->db->bind(":room_id", $data["room_id"]);
        $this->db->bind(":assigned_at", $data["assigned_at"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updatePatientRooms($data){
        $this->db->query(
            "UPDATE patient_room
                    SET patient_id = :patient_id,
                    room_id = :room_id,
                    assigned_at = :assigned_at,
                    released_at = :released_at,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":patient_id", $data["patient_id"]);
        $this->db->bind(":room_id", $data["room_id"]);
        $this->db->bind(":assigned_at", $data["assigned_at"]);
        $this->db->bind(":released_at", $data["released_at"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deletePatientRooms($data){
        $this->db->query(
            "UPDATE patient_room
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

    public function filterPatientRooms($id){
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
            WHERE p.id = :id
            AND p.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->record();
        return $row;
    }
}
?>