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

    public function getsuppliers(){
        $this->db->query(
            "SELECT 
                s.`name`,
                s.phone,
                s.address
            FROM supplier AS s
            WHERE s.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertPositions($data){
        $this->db->query(
            "INSERT INTO position 
             (name, 
              active, 
              created_by,
              updated_by)
             VALUES
             (:name, 
              :active,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updatePositions($data){
        $this->db->query(
            "UPDATE position
            SET NAME = :name,
            active = :active,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :updated_by
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":name", $data["name"]);
        $this->db->bind(":active", $data["active"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deletePositions($data){
        $this->db->query(
            "UPDATE position
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

    public function fileterPositions($id){
        $this->db->query(
            "SELECT p.id,
                    p.name,
                    p.active
                FROM position AS p
                WHERE p.id = :id
                AND p.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->records();
        return $row;
    }
}
?>