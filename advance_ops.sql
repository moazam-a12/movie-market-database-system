USE movie_market;

-- Trigger to auto-calculate late fee when return_date is updated
DELIMITER //
CREATE TRIGGER trg_calculate_late_fee
BEFORE UPDATE ON Rentals
FOR EACH ROW
BEGIN
    DECLARE days_late INT;
    IF NEW.return_date IS NOT NULL AND NEW.return_date > NEW.rental_date THEN
        SET days_late = DATEDIFF(NEW.return_date, NEW.rental_date) - 3; -- Assuming 3-day rental period
        IF days_late > 0 THEN
            SET NEW.late_fee = days_late * 1.50; -- $1.50 per late day
        ELSE
            SET NEW.late_fee = 0.00;
        END IF;
    END IF;
END;//
DELIMITER ;

-- Trigger to update movie availability based on stock
DELIMITER //
CREATE TRIGGER trg_update_movie_availability
AFTER UPDATE ON Movies
FOR EACH ROW
BEGIN
    IF NEW.stock = 0 THEN
        UPDATE Movies SET is_available = FALSE WHERE movie_id = NEW.movie_id;
    ELSE
        UPDATE Movies SET is_available = TRUE WHERE movie_id = NEW.movie_id;
    END IF;
END;//
DELIMITER ;

-- Stored procedure to get rental summary for a customer
DELIMITER //
CREATE PROCEDURE GetCustomerRentalSummary (IN cust_id INT)
BEGIN
    SELECT c.name AS customer_name,
           COUNT(r.rental_id) AS total_rentals,
           SUM(r.late_fee) AS total_late_fees
    FROM Customers c
    JOIN Rentals r ON c.customer_id = r.customer_id
    WHERE c.customer_id = cust_id
    GROUP BY c.customer_id;
END;//
DELIMITER ;