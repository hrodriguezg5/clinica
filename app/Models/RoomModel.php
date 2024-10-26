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
                r.
            	b.name AS branch_name,
            	r.active,
              	DATE(b.created_at) AS created_at
            FROM room AS r
            LEFT JOIN branch AS b
            ON b.id = r.branch_id
            AND b.active = 1
            AND b.deleted_at IS NULL
            WHERE r.deleted_at IS NULL;"
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

    public function updateRooms($data){
        $this->db->query(
            "UPDATE room
                    SET room_number = :room_number,
                    branch_id = :branch_id,
                    available = :available,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":room_number", $data["room_number"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":available", $data["available"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteRooms($data){
        $this->db->query(
            "UPDATE room
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

    public function filterRooms($id){
        $this->db->query(
            "SELECT r.id,
            	r.room_number,
            	b.name AS branch_name,
            	r.available,
              	DATE(b.created_at) AS created_at
            FROM room AS r
            INNER JOIN branch AS b
            ON b.id = r.branch_id
            WHERE r.id = :id
            AND r.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->record();
        return $row;
    }
}
?>