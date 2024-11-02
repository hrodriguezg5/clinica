<?php
class PatientExamModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function insertPatientExams($data){
        $this->db->query(
            "INSERT INTO patient_exams (patient_diagnoses_id, exam_id, assigned)
             VALUES (:patient_diagnoses_id, :exam_id, :assigned);"
        );

        $this->db->bind(":patient_diagnoses_id", $data["patient_diagnoses_id"]);
        $this->db->bind(":exam_id", $data["exam_id"]);
        $this->db->bind(":assigned", $data["assigned"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updatePatientExams($data){
        $this->db->query(
            "UPDATE patient_exams
            SET patient_diagnoses_id = :patient_diagnoses_id,
            exam_id = :exam_id,
            assigned = :assigned,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":patient_diagnoses_id", $data["patient_diagnoses_id"]);
        $this->db->bind(":exam_id", $data["exam_id"]);
        $this->db->bind(":assigned", $data["assigned"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }
}
?>