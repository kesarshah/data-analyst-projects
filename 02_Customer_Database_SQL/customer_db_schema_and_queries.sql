
-- Customer Database: schema and sample queries

-- Create tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50),
    SignupDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample queries
-- 1. Total revenue per customer
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.Quantity * p.Price) AS TotalRevenue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalRevenue DESC;

-- 2. Top 5 products by revenue
SELECT p.ProductID, p.ProductName, SUM(o.Quantity * p.Price) AS ProductRevenue
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY ProductRevenue DESC
LIMIT 5;

-- 3. Customer segmentation by frequency (example)
SELECT CustomerID,
       COUNT(OrderID) AS OrdersCount,
       CASE
         WHEN COUNT(OrderID) >= 20 THEN 'High'
         WHEN COUNT(OrderID) BETWEEN 10 AND 19 THEN 'Medium'
         ELSE 'Low'
       END AS FrequencySegment
FROM Orders
GROUP BY CustomerID
ORDER BY OrdersCount DESC;
