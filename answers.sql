
-- STEP 1: Creating the Database

CREATE DATABASE IF NOT EXISTS BookStoreDB;
USE BookStoreDB;

-- STEP 2: Create Tables with Relationships

-- book language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);
-- inserting book language table details
INSERT INTO book_language (language_name) VALUES
('English'),
('French'),
('Arabic'),
('Spanish');

-- publisher table 
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info TEXT
);
-- inserting book publisher table details
INSERT INTO publisher (name, contact_info) VALUES
('Mackmillan publishers', 'macmillan809@gmail.com'),
('Scholastic', 'scholasticmu@gmail.com'),
('Free press', 'pressfree@gmail.com'),
('Penguin Random House', 'penguinrh09@gmail.com');
-- book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2),
    publication_year YEAR,
    stock_quantity INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);
-- inserting book table details
INSERT INTO book (title, publisher_id, language_id, price, publication_year, stock_quantity) VALUES
('Learning MySQL', 1, 1, 49.99, 2021, 100),
('Data Structures in C++', 2, 1, 59.99, 2020, 75),
('Python learning', 2, 2, 70.10, 2023, 80),
('Apprendre le SQL', 2, 3, 39.99, 2019, 50);

-- author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    bio TEXT
);

-- inserting author table details
INSERT INTO author (name, bio) VALUES
('Felix Kapleng', 'Expert in databases.'),
('Gladys Mwangi', 'Software engineer and author.'),
('Mary Mwai', 'Python Expertise.'),
('Rashid Abdul', 'Expert in My sql.');

-- book author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- inserting book author details
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 1);

-- customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

-- inserting customer details
INSERT INTO customer (first_name, last_name, email, phone_number) VALUES
('Alice', 'Wambua', 'alicewambua@gmail.com', '0745677843'),
('Allan', 'Kim', 'kimallan@gmail.com', '0789676789'),
('Bob', 'Jessy', 'bobjay01@gmail.com', '0987654321');

-- country table 
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- inserting countries details
INSERT INTO country (country_name) VALUES
('Kenya'),
('USA'),
('Russia');

-- address table 
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
-- inserting address details
INSERT INTO address (street, city, postal_code, country_id) VALUES
('123 River Road', 'Nairobi', '00100', 1),
('456 Main Street', 'New York', '10001', 2),
('789 Tverskaya Street', 'Moscow', '90090', 3);

-- address status table 
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- inserting address status details
INSERT INTO address_status (status_name) VALUES
('Current'),
('New town'),
('Old');

-- customer address table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- inserting customer address details
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 1);

-- shipping method table
CREATE TABLE shipping_method (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2)
);

-- inserting shipping method details
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard', 5.99),
('Express', 12.99);

-- order status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- inserting order status details
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Shipped'),
('Delivered'),
('Cancelled');

-- cust order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    shipping_id INT,
    status_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- inserting cust order details
INSERT INTO cust_order (customer_id, shipping_id, status_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 1),  
(1, 2, 2); 

-- order line table
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- inserting order line table details
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 49.99),
(2, 2, 1, 59.99),
(3, 3, 2, 70.10),
(4, 4, 3, 39.99);

-- order history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    changed_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- inserting order history table
INSERT INTO order_history (order_id, status_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

-- STEP 3: User Management

-- Create administrator user with full access
DROP USER IF EXISTS 'book_admin'@'localhost';
CREATE USER 'book_admin'@'localhost' IDENTIFIED BY 'S3cur3P@ssw0rd!';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'book_admin'@'localhost';
FLUSH PRIVILEGES;

-- Create viewer user with read-only access
DROP USER IF EXISTS 'book_viewer'@'localhost';
CREATE USER 'book_viewer'@'localhost' IDENTIFIED BY 'R3adOnly@2025';
GRANT SELECT ON BookStoreDB.* TO 'book_viewer'@'localhost';
FLUSH PRIVILEGES;
