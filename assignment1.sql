create database techshops;
use techshops;
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inserting sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
('Ravi', 'Kumar', 'ravi.kumar@example.com', '1234567890', '123 Main St, Bangalore'),
('Priya', 'Sharma', 'priya.sharma@example.com', '0987654321', '456 Elm St, Mumbai'),
('Amit', 'Patel', 'amit.patel@example.com', '1122334455', '789 Park St, Delhi'),
('Anjali', 'Desai', 'anjali.desai@example.com', '5566778899', '101 Lake St, Chennai'),
('Rahul', 'Mehta', 'rahul.mehta@example.com', '3344556677', '202 River St, Kolkata'),
('Sunita', 'Rao', 'sunita.rao@example.com', '9988776655', '303 Hill St, Pune'),
('Sanjay', 'Gupta', 'sanjay.gupta@example.com', '4433221100', '404 Sky St, Hyderabad'),
('Neha', 'Singh', 'neha.singh@example.com', '7788990011', '505 Cloud St, Jaipur'),
('Rajesh', 'Verma', 'rajesh.verma@example.com', '9900112233', '606 Sun St, Lucknow'),
('Pooja', 'Chopra', 'pooja.chopra@example.com', '1122334455', '707 Moon St, Ahmedabad');

-- Inserting sample data into Products
INSERT INTO Products (ProductName, Description, Price)
VALUES
('Laptop', 'Dell Laptop', 800.00),
('Smartphone', 'iPhone', 1000.00),
('Tablet', 'Samsung Galaxy Tab', 500.00),
('Headphones', 'Sony WH-1000XM4', 350.00),
('Smartwatch', 'Apple Watch', 400.00),
('Camera', 'Canon EOS', 600.00),
('Speaker', 'Bose SoundLink', 250.00),
('Printer', 'HP LaserJet', 300.00),
('Router', 'Netgear Nighthawk', 150.00),
('Monitor', 'LG UltraGear', 700.00);

-- Inserting sample data into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2024-04-25', 1800.00),
(2, '2024-04-24', 2500.00),
(3, '2024-04-23', 800.00),
(4, '2024-04-22', 500.00),
(5, '2024-04-21', 950.00),
(6, '2024-04-20', 1300.00),
(7, '2024-04-19', 750.00),
(8, '2024-04-18', 1050.00),
(9, '2024-04-17', 600.00),
(10, '2024-04-16', 850.00);

-- Inserting sample data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1),
(3, 5, 1),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 1),
(5, 10, 1);

-- Inserting sample data into Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES
(1, 10, '2024-04-25'),
(2, 15, '2024-04-25'),
(3, 20, '2024-04-25'),
(4, 25, '2024-04-25'),
(5, 30, '2024-04-25'),
(6, 35, '2024-04-25'),
(7, 40, '2024-04-25'),
(8, 45, '2024-04-25'),
(9, 50, '2024-04-25'),
(10, 55, '2024-04-25');

-- task2

select FirstName,Lastname,Email from customers;
SELECT * FROM orders;
select  ORDERID,CUSTOMERID,ORDERDATE FROM ORDERS;
INSERT INTO CUSTOMERS ( Customerid, firstname, lastname, email, phone, address) values (11 , 'RAJA','VELU' , 'raja.velu@example.com', 1234567890 , '122, sun street, Ahmedabad');

delete FROM orderdetails WHERE ORDERID=1;
INSERT INTO ORDERS (ORDERID,CUSTOMERID,ORDERDATE,TOTALAMOUNT) VALUES(11,11,'2024-05-02',452);
UPDATE PRODUCTS SET PRICE=PRICE*1.10 WHERE PRODUCTNAME IN  ('LAPTOP','SMARTPHONE' ,'TABLET', 'HEADPHONES' 'SMARTWATCH' ,' CAMERA');
update CUSTOMERS SET EMAIL='newmail@mail.com' ,phone=0463635754 , address='124 Main street,Chennai' where customerid=1;
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Products.Price) 
    FROM OrderDetails 
    JOIN Products ON OrderDetails.ProductID = Products.ProductID 
    WHERE Orders.OrderID = OrderDetails.OrderID
);
delete FROM orderdetails WHERE orderid IN (SELECT ORDERID FROM ORDERS WHERE CUSTOMERID=1) ;
delete from orders where customerid=1;
INSERT INTO Products (ProductName, Description, Price)
VALUES ('Bluetooth Speaker', 'boat', 1200.00);
ALTER TABLE ORDERS ADD COLUMN STATUS VARCHAR (20);
update ORDERS SET STATUS='shipped' where CustomerID=1;
ALTER TABLE customers ADD COLUMN numberoforders int;

UPDATE Customers SET numberoforders = (SELECT COUNT(*)  FROM Orders 
WHERE Orders.CustomerID = Customers.CustomerID);

-- task 3
select * from orders;
 select orders.OrderID,orders.OrderDate,
 customers.CustomerID,customers.FirstName,customers.LastName 
 from orders join Customers on orders.customerid=customers.customerid;
 select products.ProductName , sum(products.Price* orderdetails.Quantity) as totalrevenue from orderdetails 
 join products on orderdetails.ProductID = products.ProductID group by products.ProductName;
 select customerid,firstname,lastname,phone,address from customers
 where numberoforders >=1;
SELECT products.ProductName, MAX(orderdetails.Quantity) as MaxQuantity
FROM products
JOIN orderdetails ON products.ProductId = orderdetails.ProductId
GROUP BY products.ProductName
ORDER BY MaxQuantity DESC
LIMIT 1;
select productname,description from products; -- 5
select customers.FirstName,customers.LastName, avg(orders.TotalAmount) as avgamaount
 from customers join orders on orders.CustomerID=customers.CustomerID group by customers.FirstName,customers.LastName;
SELECT o.OrderID, c.FirstName, c.LastName, o.TotalAmount AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount = (SELECT MAX(TotalAmount) FROM Orders)
LIMIT 1;
SELECT products.ProductName , COUNT(orderdetails.OrderID) AS NOOFORDERS 
FROM products JOIN orderdetails ON products.ProductID=orderdetails.OrderID 
GROUP BY ProductName;
SELECT Customers.FirstName, Customers.LastName, Products.ProductName
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = '1'; -- 9

SELECT SUM(Orders.TotalAmount) AS TotalRevenue
FROM Orders
WHERE Orders.OrderDate BETWEEN '2024-04-21' AND '2024-04-23';
-- TASK 4
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);
SELECT COUNT(*) AS TotalProducts
FROM Products;
SELECT SUM(Orders.TotalAmount) AS TotalRevenue
FROM Orders;

SELECT AVG(OrderDetails.Quantity) AS AverageQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 2;

ALTER TABLE Products
ADD Category VARCHAR(100);


UPDATE Products
SET Category = CASE 
    WHEN ProductName IN ('Laptop', 'Desktop', 'Tablet') THEN 'Electronics'
    WHEN ProductName IN ('Smartphone', 'Smartwatch') THEN 'Mobile Devices'
    WHEN ProductName IN ('Headphones', 'Bluetooth Speaker') THEN 'Audio Accessories'
    WHEN ProductName IN ('External Hard Drive', 'USB Flash Drive') THEN 'Storage Devices'
    ELSE 'Other'
END;

SELECT AVG(od.Quantity) AS AverageQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Electronics';


SELECT SUM(Quantity * Price) AS TotalRevenue
FROM OrderDetails
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Orders.CustomerID = 5;

SELECT Customers.FirstName, Customers.LastName, COUNT(*) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
ORDER BY TotalOrders DESC
LIMIT 1;

SELECT p.Category, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalQuantityOrdered DESC
LIMIT 1;

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Electronic Gadgets'
GROUP BY c.CustomerID
ORDER BY TotalSpending DESC
LIMIT 1;

 
 SELECT AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Orders;
SELECT c.FirstName, c.LastName, 
(SELECT COUNT(OrderID) FROM Orders WHERE CustomerID = c.CustomerID) AS OrderCount
FROM Customers c;


