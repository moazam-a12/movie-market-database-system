USE movie_market;

-- Sample Customers Data
INSERT INTO Customers (name, email, phone) VALUES
('Alice Johnson', 'alice.johnson@example.com', '123-456-7890'),
('Bob Smith', 'bob.smith@example.com', '234-567-8901'),
('Charlie Davis', 'charlie.davis@example.com', '345-678-9012'),
('Diana King', 'diana.king@example.com', '456-789-0123'),
('Ethan Wright', 'ethan.wright@example.com', '567-890-1234');

-- Sample Movies Data
INSERT INTO Movies (title, genre, release_year, stock, price, is_available) VALUES
('The Matrix', 'Sci-Fi', 1999, 10, 14.99, TRUE),
('Inception', 'Sci-Fi', 2010, 8, 16.50, TRUE),
('Titanic', 'Romance', 1997, 5, 12.00, TRUE),
('The Godfather', 'Crime', 1972, 4, 15.00, TRUE),
('Interstellar', 'Sci-Fi', 2014, 7, 17.25, TRUE),
('Joker', 'Drama', 2019, 6, 13.75, TRUE);

-- Sample Rentals Data
INSERT INTO Rentals (customer_id, movie_id, rental_date, return_date, late_fee) VALUES
(1, 1, '2024-03-01', '2024-03-05', 0.00),
(2, 2, '2024-03-03', '2024-03-08', 1.50),
(3, 3, '2024-03-05', NULL, 0.00),
(4, 4, '2024-03-06', '2024-03-10', 0.00),
(5, 5, '2024-03-07', '2024-03-12', 2.00);

-- Sample Payments Data
INSERT INTO Payments (transaction_type, amount, payment_date) VALUES
('rental', 4.99, '2024-03-01'),
('rental', 5.50, '2024-03-03'),
('rental', 4.50, '2024-03-05'),
('rental', 5.00, '2024-03-06'),
('rental', 6.25, '2024-03-07'),
('purchase', 14.99, '2024-03-08'),
('purchase', 17.25, '2024-03-09'),
('purchase', 13.75, '2024-03-10'),
('purchase', 13.75, '2024-03-11'),
('purchase', 13.75, '2024-03-12'),
('purchase', 13.75, '2024-03-13');

-- Sample Sales Data
INSERT INTO Sales (customer_id, movie_id, purchase_date, payment_id) VALUES
(1, 6, '2024-03-08', 6),
(2, 5, '2024-03-09', 7),
(3, 2, '2024-03-10', 8),
(3, 2, '2024-03-10', 9),
(3, 2, '2024-03-10', 10),
(3, 2, '2024-03-10', 11);

