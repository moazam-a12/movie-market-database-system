USE movie_market;

-- 1. Daily Rentals Report
SELECT rental_date, COUNT(*) AS total_rentals
FROM Rentals
GROUP BY rental_date
ORDER BY rental_date DESC;

-- 2. Genre Popularity Report
SELECT genre, COUNT(*) AS rental_count
FROM Rentals r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY genre
ORDER BY rental_count DESC;

-- 3. Customer Purchase History View
CREATE OR REPLACE VIEW CustomerPurchaseHistory AS
SELECT c.customer_id, c.name AS customer_name, m.title AS movie_title, s.purchase_date, p.amount
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Payments p ON s.payment_id = p.payment_id;

-- 4. Out-of-Stock Movies
SELECT title, genre, stock
FROM Movies
WHERE stock = 0;

-- 5. High Value Customers (spent over $30)
SELECT c.name, SUM(p.amount) AS total_spent
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id
JOIN Payments p ON s.payment_id = p.payment_id
GROUP BY c.customer_id
HAVING total_spent > 30;
