<?php
class PatientHistoryModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getPatientHistory(){
        $this->db->query(
            "SELECT p.id,
            	CONCAT(p1.first_name, ' ', p1.last_name) AS name_patient,
            	p.visit_date,
            	CONCAT(e.first_name, ' ', e.last_name) AS name_employee,
            	p2.`name` AS potition,
            	p.notes,
            	DATE(p.created_at) AS created_at
            FROM patient_history AS p
            INNER JOIN patient AS p1
            ON p.patient_id = p1.id
            INNER JOIN employee AS e
            ON p.employee_id = e.id
            INNER JOIN position AS p2
            ON e.position_id = p2.id
            WHERE p.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertPatientHistory($data){
        $this->db->query(
            "INSERT INTO patient_history
             (patient_id,
			  visit_date,
			  employee_id,
              notes,
              created_by,
              updated_by)
             VALUES
             (
              :patient_id,
              :visit_date,
              :employee_id,
              :notes,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":employee_id", $data["employee_id"]);
        $this->db->bind(":patient_id", $data["patient_id"]);
        $this->db->bind(":visit_date", $data["visit_date"]);
        $this->db->bind(":notes", $data["notes"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updatePatientHistory($data){
        $this->db->query(
            "UPDATE patient_history
                    SET patient_id = :patient_id,
                    visit_date = :visit_date,
                    employee_id = :employee_id,
                    notes = :notes,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":patient_id", $data["patient_id"]);
        $this->db->bind(":visit_date", $data["visit_date"]);
        $this->db->bind(":employee_id", $data["employee_id"]);
        $this->db->bind(":notes", $data["notes"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deletePatientHistorys($data){
        $this->db->query(
            "UPDATE patient_history
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

    public function filterPatientHistorys($id){
        $this->db->query(
            "SELECT p.id,
            	CONCAT(p1.first_name, ' ', p1.last_name) AS name_patient,
            	p.visit_date,
            	CONCAT(e.first_name, ' ', e.last_name) AS name_employee,
            	p2.`name` AS potition,
            	p.notes,
            	DATE(p.created_at) AS created_at
            FROM patient_history AS p
            INNER JOIN patient AS p1
            ON p.patient_id = p1.id
            INNER JOIN employee AS e
            ON p.employee_id = e.id
            INNER JOIN position AS p2
            ON e.position_id = p2.id
            WHERE p.id = :id
            AND p.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->record();
        return $row;
    }
}
?>