<?php
class SaleModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getSales(){
        $this->db->query(
            "SELECT s.id,
            s.sale_date,
            s.total_amount,
            b.`name` AS name_branch,
            DATE(b.created_at) AS created_at
        FROM sale AS s
        INNER JOIN branch AS b
        ON s.branch_id = b.id
        WHERE s.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertSales($data){
        $this->db->query(
            "INSERT INTO sale
             (sale_date,
			  total_amount,
			  branch_id,
              created_by,
              updated_by)
             VALUES
             (
              :sale_date,
              :total_amount,
              :branch_id,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":sale_date", $data["sale_date"]);
        $this->db->bind(":total_amount", $data["total_amount"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function updateSales($data){
        $this->db->query(
            "UPDATE sale
                    SET sale_date = :sale_date,
                    total_amount = :total_amount,
                    branch_id = :branch_id,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":sale_date", $data["sale_date"]);
        $this->db->bind(":total_amount", $data["total_amount"]);
        $this->db->bind(":branch_id", $data["branch_id"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteSales($data){
        $this->db->query(
            "UPDATE sale
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

    public function filterInventory($data){
        $this->db->query(
            "SELECT m.id AS medicine_id,
                m.name AS medicine_name, 
                b.id AS batch_id,
                i.branch_id,
                m.selling_price,
				b.purchase_price,
				b.quantity AS original_quantity,
				IFNULL(i.quantity, 0) AS current_quantity,
				b.expiration_date,
				i.created_at,
				i.updated_at
            FROM medicine AS m
            INNER JOIN batch AS b
            ON m.id = b.medicine_id
            INNER JOIN inventory AS i
            ON b.id = i.batch_id
            INNER JOIN branch AS ba
            ON ba.id = i.branch_id
            WHERE m.deleted_at IS NULL
            AND b.deleted_at IS NULL
            AND i.deleted_at IS NULL
            AND ba.deleted_at IS NULL
            AND m.id = :id
            AND i.branch_id = :branch_id
            ORDER BY i.created_at ASC;"
        );

        $this->db->bind(':id', $data["id"]);
        $this->db->bind(':branch_id', $data["branch_id"]);
        $row = $this->db->records();
        return $row;
    }

    public function filterMedicine($data){
        $this->db->query(
            "SELECT m.id,
                m.selling_price,
                IFNULL(mq.quantity, 0) AS quantity
            FROM medicine AS m
            LEFT JOIN (
            	SELECT b.medicine_id,
	            	SUM(i.quantity) AS quantity
	            FROM inventory AS i
	            INNER JOIN batch AS b
	            ON i.batch_id = b.id
	    		WHERE i.quantity != 0
	    		AND i.deleted_at IS NULL
	    		AND b.deleted_at IS NULL
                AND i.branch_id = :branch_id
	            GROUP BY b.medicine_id
			) AS mq
			ON m.id = mq.medicine_id
            WHERE m.id = :id
            AND m.deleted_at IS NULL;"
        );

        $this->db->bind(':id', $data["id"]);
        $this->db->bind(':branch_id', $data["branch_id"]);

        $row = $this->db->record();
        return $row;
    }
}
?>