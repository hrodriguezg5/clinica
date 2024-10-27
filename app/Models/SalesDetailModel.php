<?php
class SalesDetailModel{
    private $db;

    public function __construct(){
        $this->db = new Database;
    }
    
    public function closeConnection() {
        $this->db->closeConnection();
    }

    public function getSalesDetail(){
        $this->db->query(
            "SELECT s.id,
            	s1.sale_date,
            	m.`name` AS medicine_name,
            	m.selling_price,
            	b.quantity AS batch_quantity,
               b.expiration_date,
            	s.quantity,
            	s.unit_price,
            	s.subtotal,
            	s1.total_amount,
            	s.created_at
            FROM sale_detail AS s
            INNER JOIN sale AS s1
            ON s.sale_id = s1.id
            AND s1.deleted_at IS NULL
            LEFT JOIN medicine AS m
            ON s.medicine_id = m.id
            AND m.deleted_at IS NULL
            LEFT JOIN batch AS b
            ON s.batch_id = b.id
            AND b.deleted_at IS NULL
            WHERE s.deleted_at IS NULL;"
        );

        $row = $this->db->records();
        return $row;
    }

    public function insertSalesDetail($data){
        $this->db->query(
            "INSERT INTO sale_detail
             (sale_id,
			  medicine_id,
              batch_id,
			  quantity,
              unit_price,
              created_by,
              updated_by)
             VALUES
             (
              :sale_id,
              :medicine_id,
              :batch_id,
              :quantity,
              :unit_price,
			  :created_by,
			  :updated_by);"
        );

        $this->db->bind(":sale_id", $data["sale_id"]);
        $this->db->bind(":medicine_id", $data["medicine_id"]);
        $this->db->bind(":batch_id", $data["batch_id"]);
        $this->db->bind(":quantity", $data["quantity"]);
        $this->db->bind(":unit_price", $data["unit_price"]);
        $this->db->bind(":created_by", $data["created_by"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        
        if($this->db->execute()){
            return $this->db->lastInsertId();
        } else{
            return false;
        }
    }

    public function updateSalesDetail($data){
        $this->db->query(
            "UPDATE sale_detail
                    SET sale_id = :sale_id,
                    medicine_id = :medicine_id,
                    batch_id = :batch_id,
                    quantity = :quantity,
                    unit_price = :unit_price,
                    updated_at = CURRENT_TIMESTAMP(),
                    updated_by = :updated_by
                    WHERE id = :id;"
        );

        $this->db->bind(":id", $data["id"]);
        $this->db->bind(":sale_id", $data["sale_id"]);
        $this->db->bind(":batch_id", $data["batch_id"]);
        $this->db->bind(":medicine_id", $data["medicine_id"]);
        $this->db->bind(":quantity", $data["quantity"]);
        $this->db->bind(":unit_price", $data["unit_price"]);
        $this->db->bind(":updated_by", $data["updated_by"]);
        if($this->db->execute()){
            return true;
        } else{
            return false;
        }
    }

    public function deleteSalesDetail($data){
        $this->db->query(
            "UPDATE sale_detail
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
            	i.branch_id,
            	ba.`name` AS branch_name,
                b.purchase_price,
            	b.quantity,
            	DATE(b.created_at) AS created_at,
            	b.expiration_date
            FROM batch AS b
            INNER JOIN medicine AS m
            ON b.medicine_id = m.id
            INNER JOIN supplier AS s
            ON b.supplier_id = s.id
            INNER JOIN inventory AS i
            ON b.id = i.batch_id
            INNER JOIN branch AS ba
            ON i.branch_id = ba.id
            WHERE b.id = :id
            AND b.deleted_at IS NULL;");

        $this->db->bind(':id', $id);

        $row = $this->db->record();
        return $row;
    }
}
?>