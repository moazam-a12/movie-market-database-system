-- Database
CREATE DATABASE IF NOT EXISTS movie_market;
USE movie_market;

-- Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- Movies table
CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_year YEAR,
    stock INT DEFAULT 0,
    price DECIMAL(6,2),
    is_available BOOLEAN DEFAULT TRUE
);

-- Rentals table
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rental_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    late_fee DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Payments table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_type ENUM('rental', 'purchase') NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE)
);

-- Sales table
CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    purchase_date DATE DEFAULT (CURRENT_DATE),
    payment_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);
