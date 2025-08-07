show databases;
use onlineretailstore;
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  join_date DATE
);
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2),
  stock_quantity INT
);
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Details (
  order_detail_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES 
(1, 'Amit Sharma', 'amit@email.com', '2023-01-15'),
(2, 'Priya Mehta', 'priya@email.com', '2023-02-20'),
(3, 'Rahul Verma', 'rahul@email.com', '2023-03-05'),
(4, 'Sneha Kapoor', 'sneha@email.com', '2023-04-10'),
(5, 'Karan Malhotra', 'karan@email.com', '2023-05-18');
INSERT INTO Products VALUES 
(101, 'T-shirt', 'Clothing', 499.00, 150),
(102, 'Jeans', 'Clothing', 999.00, 80),
(103, 'Sneakers', 'Footwear', 1999.00, 50),
(104, 'Cap', 'Accessories', 299.00, 100),
(105, 'Watch', 'Accessories', 2999.00, 30),
(106, 'Backpack', 'Bags', 1499.00, 60),
(107, 'Socks (Pack of 3)', 'Clothing', 199.00, 120),
(108, 'Sandals', 'Footwear', 899.00, 40);
INSERT INTO Orders VALUES 
(1001, 1, '2023-08-01', 998.00),
(1002, 2, '2023-08-02', 2999.00),
(1003, 3, '2023-08-03', 1999.00),
(1004, 1, '2023-08-04', 1499.00),
(1005, 4, '2023-08-05', 299.00),
(1006, 5, '2023-08-06', 1898.00),
(1007, 3, '2023-08-07', 999.00),
(1008, 2, '2023-08-08', 2198.00);
INSERT INTO Order_Details VALUES 
(1, 1001, 101, 2, 499.00),         -- T-shirt x2
(2, 1002, 105, 1, 2999.00),        -- Watch x1
(3, 1003, 103, 1, 1999.00),        -- Sneakers x1
(4, 1004, 106, 1, 1499.00),        -- Backpack x1
(5, 1005, 104, 1, 299.00),         -- Cap x1
(6, 1006, 108, 2, 899.00),         -- Sandals x2
(7, 1007, 102, 1, 999.00),         -- Jeans x1
(8, 1008, 103, 1, 1999.00),        -- Sneakers x1
(9, 1008, 107, 1, 199.00);         -- Socks x1
-- Total revenue
SELECT SUM(total_amount) AS total_revenue FROM Orders; 
-- Best selling product
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
-- Low stock products
SELECT product_name, stock_quantity
FROM Products
WHERE stock_quantity < 50;
-- Customers with Most Orders
SELECT c.name, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY order_count DESC;
-- Monthly Sales Summary
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM Orders
GROUP BY month
ORDER BY month;