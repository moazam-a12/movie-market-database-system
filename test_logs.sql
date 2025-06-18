USE movie_market;

-- 1. Check Customer Insertion
INSERT INTO Customers (name, email, phone) 
VALUES ('Test User', 'test.user@example.com', '777-888-9999');

SELECT * FROM Customers WHERE email = 'test.user@example.com';

-- 2. Rental and Stock Check
INSERT INTO Rentals (customer_id, movie_id, rental_date) 
VALUES (1, 1, '2024-04-01');

SELECT * FROM Rentals WHERE customer_id = 1 AND movie_id = 1;

-- Late fee check
UPDATE Rentals 
SET return_date = '2024-04-07' 
WHERE rental_id = (SELECT MAX(rental_id) FROM Rentals);

-- Late fee triger check
SELECT rental_id, rental_date, return_date, late_fee 
FROM Rentals 
WHERE rental_id = (SELECT MAX(rental_id) FROM Rentals);

-- 4. Purchase Entry
INSERT INTO Payments (transaction_type, amount, payment_date) 
VALUES ('purchase', 15.00, '2024-04-02');

INSERT INTO Sales (customer_id, movie_id, purchase_date, payment_id)
VALUES (1, 2, '2024-04-02', LAST_INSERT_ID());

SELECT * FROM Sales WHERE customer_id = 1 AND movie_id = 2;

-- 5. Storing Check
CALL GetCustomerRentalSummary(1);

-- 6. Cheching View
SELECT * FROM CustomerRentalSummary WHERE customer_id = 1;

-- 7. Unavailabe Movie check
UPDATE Movies SET stock = 0 WHERE movie_id = 3;
SELECT title, stock, is_available FROM Movies WHERE movie_id = 3;