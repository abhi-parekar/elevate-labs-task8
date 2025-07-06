USE ecommerce;

-- 1. Stored Procedure: Insert new customer
DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN cust_name VARCHAR(100),
    IN cust_email VARCHAR(100),
    IN cust_phone VARCHAR(15),
    IN cust_address TEXT
)
BEGIN
    INSERT INTO Customer(name, email, phone, address)
    VALUES (cust_name, cust_email, cust_phone, cust_address);
END;
//
DELIMITER ;

-- Usage:
-- CALL AddCustomer('Ramesh', 'ramesh@example.com', '9876543210', 'Hyderabad');

-- 2. Stored Procedure: Get total orders by a customer
DELIMITER //
CREATE PROCEDURE TotalOrdersByCustomer(IN cid INT)
BEGIN
    SELECT COUNT(*) AS total_orders
    FROM OrderTable
    WHERE customer_id = cid;
END;
//
DELIMITER ;

-- 3. Scalar Function: Get total amount paid by a customer
DELIMITER //
CREATE FUNCTION TotalPaidByCustomer(cid INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(p.amount)
    INTO total
    FROM OrderTable o
    JOIN Payment p ON o.order_id = p.order_id
    WHERE o.customer_id = cid;
    RETURN IFNULL(total, 0.00);
END;
//
DELIMITER ;

-- Usage:
-- SELECT TotalPaidByCustomer(1);
