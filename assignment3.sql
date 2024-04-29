CREATE DATABASE bankingsystem;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- task 2

INSERT INTO Customers (customer_id,first_name, last_name, DOB, email, phone_number, address)
VALUES 
(1,'Arjun', 'Reddy', '1990-05-15', 'arjun@email.com', '1234567890', '123 Main Street, Bangalore'),
(2,'Kavya', 'Rao', '1985-09-20', 'kavya@email.com', '2345678901', '456 Park Avenue, Chennai'),
(3,'Sanjay', 'Kumar', '1988-03-10', 'sanjay@email.com', '3456789012', '789 Elm Street, Hyderabad'),
(4,'Priya', 'Menon', '1992-11-25', 'priya@email.com', '4567890123', '101 Oak Street, Mumbai'),
(5,'Akash', 'Patel', '1987-07-12', 'akash@email.com', '5678901234', '456 Pine Street, Bangalore'),
(6,'Divya', 'Sharma', '1991-04-30', 'divya@email.com', '6789012345', '789 Maple Avenue, Chennai'),
(7,'Rahul', 'Verma', '1989-08-05', 'rahul@email.com', '7890123456', '101 Cedar Street, Hyderabad'),
(8,'Ananya', 'Gupta', '1993-02-18', 'ananya@email.com', '8901234567', '123 Birch Street, Mumbai'),
(9,'Vikram', 'Singh', '1986-06-23', 'vikram@email.com', '9012345678', '234 Elm Street, Bangalore'),
(10,'Meera', 'Rajan', '1990-12-07', 'meera@email.com', '0123456789', '345 Oak Avenue, Chennai');

INSERT INTO Accounts (account_id, customer_id, account_type, balance)
VALUES 
(1001, 1, 'Savings', 5000.00),
(1002, 2, 'Current', 10000.00),
(1003, 3, 'Savings', 7500.00),
(1004, 4, 'Current', 12000.00),
(1005, 5, 'Savings', 6000.00),
(1006, 6, 'Current', 11000.00),
(1007, 7, 'Savings', 9000.00),
(1008, 8, 'Current', 13000.00),
(1009, 9, 'Savings', 5500.00),
(1010, 10, 'Current', 11500.00);
 
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES 
(2001, 1001, 'Deposit', 1000.00, '2024-04-25'),
(2002, 1002, 'Withdrawal', 500.00, '2024-04-26'),
(2003, 1003, 'Deposit', 1500.00, '2024-04-24'),
(2004, 1004, 'Withdrawal', 700.00, '2024-04-25'),
(2005, 1005, 'Deposit', 800.00, '2024-04-23'),
(2006, 1006, 'Withdrawal', 600.00, '2024-04-26'),
(2007, 1007, 'Deposit', 1200.00, '2024-04-22'),
(2008, 1008, 'Withdrawal', 900.00, '2024-04-25'),
(2009, 1009, 'Deposit', 1300.00, '2024-04-21'),
(2010, 1010, 'Withdrawal', 400.00, '2024-04-26');

SELECT c.first_name, c.last_name, a.account_type, c.email
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

SELECT t.*, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = 1;

UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 1001;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers;

DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

SELECT * FROM Customers WHERE LOWER(address) LIKE '%chennai%';

SELECT balance FROM Accounts WHERE account_id = 1002;

SELECT * FROM Accounts WHERE account_type = 'current' AND balance > 1000;

SELECT *
FROM Transactions
WHERE account_id = 1002;

SELECT account_id, balance * 3.5/ 100 AS interest_accrued
FROM Accounts
WHERE account_type = 'savings';

SELECT *
FROM Accounts
WHERE balance < 10000;

SELECT *
FROM Customers
WHERE lower(address) NOT LIKE '%chennai%';

--  task 3

SELECT AVG(balance) AS average_balance;

SELECT * FROM Accounts ORDER BY balance DESC LIMIT 10; 

SELECT SUM(amount) AS total_deposits FROM Transactions
WHERE transaction_type = 'deposit' AND transaction_date = '2024-04-24';

SELECT MIN(DOB) AS oldest_customer, MAX(DOB) AS newest_customer FROM Customers;

SELECT t.*, a.account_type FROM Transactions t 
JOIN Accounts a ON t.account_id = a.account_id;

SELECT c.*, a.* FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

SELECT t.*, c.* FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE t.account_id = 1004;

SELECT customer_id, COUNT(*) AS num_accounts FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT SUM(
CASE WHEN transaction_type = 'deposit' THEN amount ELSE -amount END) AS difference
FROM Transactions;

SELECT t.account_id, AVG(a.balance) AS average_daily_balance
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
GROUP BY t.account_id;

SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

SELECT account_id, COUNT(*) AS num_transactions
FROM Transactions
GROUP BY account_id
ORDER BY num_transactions DESC;

SELECT c.*, SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING total_balance > 8000;

SELECT transaction_id, transaction_type, amount, transaction_date, account_id, COUNT(*)
FROM Transactions
GROUP BY transaction_id, transaction_type, amount, transaction_date, account_id
HAVING COUNT(*) > 1;

-- task 4

SELECT c.*
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance = (SELECT MAX(balance) FROM Accounts);

SELECT AVG(balance) AS avg_balance
FROM Accounts WHERE customer_id IN 
(SELECT customer_id FROM Accounts GROUP BY customer_id HAVING COUNT(*) > 1);

SELECT a.*
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > (SELECT AVG(amount) FROM Transactions);

SELECT c.*
FROM Customers c
LEFT JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.account_id IS NULL;

SELECT SUM(balance) AS total_balance
FROM Accounts
WHERE account_id NOT IN (SELECT account_id FROM Transactions);

SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.balance = (SELECT MIN(balance) FROM Accounts);

SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1;

SELECT account_type, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts GROUP BY account_type;

SELECT * FROM Transactions
WHERE account_id IN (SELECT account_id FROM Accounts WHERE customer_id = 3);

SELECT account_type, (SELECT SUM(balance) FROM Accounts WHERE account_type = a.account_type) AS total_balance
FROM Accounts a GROUP BY account_type;
