USE movie_market;

-- 1. Customers with rentals (list)
SELECT c.name AS customer_name, m.title AS movie_title, r.rental_date, r.return_date, r.late_fee
FROM Customers c
JOIN Rentals r ON c.customer_id = r.customer_id
JOIN Movies m ON r.movie_id = m.movie_id;

-- 2. Movies in our Inventory that are available
SELECT title, genre, release_year, stock
FROM Movies
WHERE is_available = TRUE AND stock > 0;

-- 3. Late fees
SELECT c.name, COUNT(r.rental_id) AS total_rentals, SUM(r.late_fee) AS total_late_fees
FROM Customers c
JOIN Rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 4. Most Rented Movies (top 3)
SELECT m.title, COUNT(r.movie_id) AS times_rented
FROM Movies m
JOIN Rentals r ON m.movie_id = r.movie_id
GROUP BY m.movie_id
ORDER BY times_rented DESC
LIMIT 3;

-- 5. Purchases
SELECT DISTINCT c.name AS customer_name, m.title AS purchased_movie, s.purchase_date
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Movies m ON s.movie_id = m.movie_id;

-- 6. Revenue
SELECT 
    (SELECT SUM(amount) FROM Payments WHERE transaction_type = 'rental') AS total_rental_revenue,
    (SELECT SUM(amount) FROM Payments WHERE transaction_type = 'purchase') AS total_purchase_revenue;

-- 7. Rental Summary
CREATE OR REPLACE VIEW CustomerRentalSummary AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    SUM(r.late_fee) AS total_late_fees
FROM Customers c
LEFT JOIN Rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 8. Repeat Customers
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Rentals
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);

-- 9. Oblivion Movies
SELECT title FROM Movies
WHERE movie_id NOT IN (SELECT movie_id FROM Rentals);

-- 10. Recent Purchases
SELECT c.name AS customer_name, m.title AS movie_title, s.purchase_date
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Movies m ON s.movie_id = m.movie_id
WHERE (s.customer_id, s.purchase_date) IN (
    SELECT customer_id, MAX(purchase_date)
    FROM Sales
    GROUP BY customer_id
);
