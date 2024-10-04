<?php
class PatientModel{
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


    public function getReservations($data){
        $this->db->query(
            "SELECT r.id,
                CONCAT(r.first_name, ' ', r.last_name) AS customer_name,
                r.email,
                r.phone_number,
                r.address,
                p.`name` AS product,
                r.product_quantity AS quantity,
                rh.`name` AS reservation_hour,
                r.reservation_date
            FROM reservation AS r
            INNER JOIN product AS p
            ON r.product_id = p.id
            INNER JOIN reservation_hour AS rh
            ON r.reservation_hour_id = rh.id
            WHERE r.deleted_at IS NULL
            AND p.deleted_at IS NULL
            AND rh.deleted_at IS NULL
            AND r.reservation_date BETWEEN :start_date
            AND :end_date
            ORDER BY r.reservation_date ASC,
            rh.hour_order ASC;"
        );

        $this->db->bind(":start_date", $data["start_date"]);
        $this->db->bind(":end_date", $data["end_date"]);
        $row = $this->db->records();
        return $row;
    }

    public function getCustomer($data){
        $this->db->query(
            "SELECT r.id,
                r.first_name,
                r.last_name,
                r.email,
                r.phone_number,
                r.address,
                p.`name` AS product,
                r.product_quantity,
                rh.`name` AS reservation_hour,
                r.reservation_date
            FROM reservation AS r
            INNER JOIN product AS p
            ON r.product_id = p.id
            INNER JOIN reservation_hour AS rh
            ON r.reservation_hour_id = rh.id
            WHERE r.deleted_at IS NULL
            AND p.deleted_at IS NULL
            AND rh.deleted_at IS NULL
            AND r.id = :id
            LIMIT 1;"
        );

        $this->db->bind(":id", $data["id"]);
        $row = $this->db->record();
        return $row;
    }
    
    public function getAvailableHours($data){
        $this->db->query(
            "SELECT rh.id,
                rh.`name` AS reservation_hour
            FROM reservation_hour AS rh
            WHERE rh.`active` = 1
            AND rh.deleted_at IS NULL
            AND NOT EXISTS (
                SELECT 1
                FROM reservation AS r
                WHERE r.reservation_hour_id = rh.id
                AND r.deleted_at IS NULL
                AND r.reservation_date = :date
                AND rh.`name` != :hour
            );"
        );

        $this->db->bind(":date", $data["date"]);
        $this->db->bind(":hour", $data["hour"]);
        $row = $this->db->records();
        return $row;
    }

    public function getProducts(){
        $this->db->query(
            "SELECT p.id,
                p.name AS product
            FROM product AS p
            WHERE p.`active` = 1
            AND p.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function getProduct($data){
        $this->db->query(
            "SELECT p.id
            FROM product AS p
            WHERE p.`active` = 1
            AND p.deleted_at IS NULL
            AND p.`name` = :product
            LIMIT 1;"
        );

        $this->db->bind(":product", $data["update_product"]);
        $row = $this->db->record();
        return $row;
    }

    public function getReservationHour($data){
        $this->db->query(
            "SELECT rh.id
            FROM reservation_hour AS rh
            WHERE rh.`active` = 1
            AND rh.deleted_at IS NULL
            AND rh.`name` = :hour
            LIMIT 1;"
        );

        $this->db->bind(":hour", $data["update_hour"]);
        $row = $this->db->record();
        return $row;
    }

    public function updateReservation($data){
        $this->db->query(
            "UPDATE reservation
            SET first_name = :first_name,
            last_name = :last_name,
            email = :email,
            phone_number = :phone_number,
            product_id = :product_id,
            product_quantity = :product_quantity,
            address = :address,
            reservation_date = :date,
            reservation_hour_id = :hour_id,
            updated_at = CURRENT_TIMESTAMP(),
            updated_by = :user_id
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":first_name", $data["first_name"]);
        $this->db->bind(":last_name", $data["last_name"]);
        $this->db->bind(":email", $data["email"]);
        $this->db->bind(":phone_number", $data["phone_number"]);
        $this->db->bind(":product_id", $data["product_id"]);
        $this->db->bind(":product_quantity", $data["product_quantity"]);
        $this->db->bind(":address", $data["address"]);
        $this->db->bind(":date", $data["date"]);
        $this->db->bind(":hour_id", $data["hour_id"]);
        $this->db->bind(":user_id", $data["user_id"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteReservation($data){
        $this->db->query(
            "UPDATE reservation
            SET deleted_at = CURRENT_TIMESTAMP(),
            deleted_by = :user_id
            WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":user_id", $data["user_id"]);

        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }
}
?>