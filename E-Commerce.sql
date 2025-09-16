CREATE DATABASE E_commerce;
USE E_commerce;
-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    description TEXT
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    status VARCHAR(50) DEFAULT 'pending',
    shipping_address VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_state VARCHAR(100),
    shipping_postal_code VARCHAR(20),
    shipping_country VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    total DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Reviews table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Shopping Cart
CREATE TABLE Shopping_Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Aditya Kumar and Arti Singh
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, postal_code, country, password_hash)
VALUES
('Aditya', 'Kumar', 'aditya@example.com', '9876543210', '123 Street, City', 'Delhi', 'Delhi', '110001', 'India', 'hashed_pw_123'),
('Arti', 'Singh', 'arti@example.com', '1234567890', '456 Avenue, City', 'Mumbai', 'Maharashtra', '400001', 'India', 'hashed_pw_456');

INSERT INTO Categories (name, description)
VALUES
('Electronics', 'Electronic gadgets and devices'),
('Books', 'All kinds of books'),
('Clothing', 'Men and women apparel');


INSERT INTO Products (name, description, price, stock_quantity, category_id)
VALUES
('Smartphone', 'Latest model with 128GB storage', 699.99, 50, 1),
('Laptop', '15-inch screen, 16GB RAM', 999.99, 30, 1),
('Bike', 'Hero Honda', 1.20000, 10, 2),
('T-Shirt', 'Cotton round-neck', 9.99, 200, 3);

-- Insert Orders for Aditya Kumar and Arti Singh
INSERT INTO Orders (customer_id, total_price, status, shipping_address, shipping_city, shipping_state, shipping_postal_code, shipping_country)
VALUES
(1, 719.98, 'shipped', '123 Street, City', 'Delhi', 'Delhi', '110001', 'India'),
(2, 29.97, 'processing', '456 Avenue, City', 'Mumbai', 'Maharashtra', '400001', 'India');

INSERT INTO Order_Items (order_id, product_id, quantity, price, total)
VALUES
(1, 1, 1, 699.99, 699.99),
(1, 3, 1, 19.99, 19.99),
(2, 4, 3, 9.99, 29.97);

INSERT INTO Payments (order_id, payment_method, payment_status, amount)
VALUES
(1, 'Credit Card', 'completed', 719.98),
(2, 'PayPal', 'pending', 29.97);

INSERT INTO Reviews (product_id, customer_id, rating, review_text)
VALUES
(1, 1, 5, 'Excellent smartphone, very fast and sleek.'),
(3, 1, 4, 'Good bike, enjoyable run.'),
(4, 2, 3, 'Average quality T-shirt.');

INSERT INTO Shopping_Cart (customer_id, product_id, quantity)
VALUES
(1, 2, 1),  -- Aditya added 1 Laptop
(2, 3, 2);  -- Arti added 2  Bike

SELECT p.name, p.price, p.stock_quantity, c.name AS category
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
WHERE c.name = 'Electronics';

SELECT o.order_id, o.order_date, o.status, o.total_price,
       c.first_name, c.last_name, c.email
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

SELECT oi.order_id, p.name, oi.quantity, oi.price, oi.total
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
WHERE oi.order_id = 1;

SELECT p.payment_id, o.order_id, p.payment_method, p.payment_status, p.amount
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id;

SELECT p.name AS product, c.first_name, r.rating, r.review_text, r.created_at
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Customers c ON r.customer_id = c.customer_id;

CREATE VIEW Order_Summary AS
SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_price, o.status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;
SELECT * FROM Order_Summary;

DELIMITER //

CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;



