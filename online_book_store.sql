/* =====================================================
   PROJECT: Online Bookstore Analysis
   DATABASE: Online_Bookstore
   PURPOSE: Analyze sales, customers, and inventory
   ===================================================== */
   /* =====================================================
   SCHEMA SETUP (Run once)
   ===================================================== 

-- Books Table
CREATE TABLE dbo.Books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
    );

-- Customers Table
CREATE TABLE dbo.Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(100)
);

-- Orders Table
CREATE TABLE dbo.Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES dbo.Customers(Customer_ID),
    Book_ID INT REFERENCES dbo.Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);


=====================================================
   ANALYTICAL QUERIES
===================================================== 

-- 1. Available products in the store

SELECT Book_ID,Title,Genre,Price,Stock
FROM dbo.Books
ORDER BY Title;   
    
 -- 2. Low-stock books (reorder risk)
 SELECT Book_ID, Title,Stock
 FROM dbo.Books
WHERE Stock < 20
ORDER BY Stock ASC; 

-- 3. Total revenue generated
SELECT
SUM(Total_Amount) AS Total_Revenue    
FROM dbo.Orders;

-- 4. Revenue by book
SELECT b.Title,
SUM(o.Total_Amount) AS Revenue    
FROM dbo.Orders o
JOIN dbo.Books b 
ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Revenue DESC;    

-- 5. Top 5 best-selling books (by quantity)
SELECT TOP 5 b.Title,
SUM(o.Quantity) AS Total_Units_Sold
FROM dbo.Orders o
JOIN dbo.Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Total_Units_Sold DESC;   
    


-- 6. Monthly sales trend
SELECT
FORMAT(Order_Date, 'yyyy-MM') AS Order_Month,
SUM(Total_Amount) AS Monthly_Revenue    
FROM dbo.Orders
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Order_Month;

-- 7. Customer contribution to revenue
SELECT  c.Name,
SUM(o.Total_Amount) AS Customer_Revenue   
FROM dbo.Orders o
JOIN dbo.Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
ORDER BY Customer_Revenue DESC;   


-- 8. Average order value
SELECT AVG(Total_Amount) AS Avg_Order_Value
FROM dbo.Orders;  

-- 9. Orders by country
SELECT c.Country,
COUNT(o.Order_ID) AS Total_Orders
FROM dbo.Orders o
JOIN dbo.Customers c ON o.Customer_ID = c.Customer_ID   
 GROUP BY c.Country
ORDER BY Total_Orders DESC;  

-- 10. Inventory value by genre
SELECT Genre,
SUM(Price * Stock) AS Inventory_Value    
FROM dbo.Books
GROUP BY Genre
ORDER BY Inventory_Value DESC;    

-- 11. High-value customers (above average spend)
SELECT c.Customer_ID,c.Name,
SUM(o.Total_Amount) AS Total_Spent    
FROM dbo.Orders o
JOIN dbo.Customers c ON o.Customer_ID = c.Customer_ID    
GROUP BY c.Customer_ID, c.Name   
HAVING SUM(o.Total_Amount) > (SELECT AVG(Total_Amount) FROM dbo.Orders)
ORDER BY Total_Spent DESC;

--12. Repeat customers (more than one order)
SELECT c.Customer_ID,c.Name,
COUNT(o.Order_ID) AS Order_Count   
 FROM dbo.Orders o   
 JOIN dbo.Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) > 1
ORDER BY Order_Count DESC;   

--13. Books that have never been ordered
SELECT b.Book_ID,
    b.Title,
    b.Stock
 FROM dbo.Books b
LEFT JOIN dbo.Orders o ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;   

--14. -- Order value segmentation
SELECT CASE
       WHEN Total_Amount < 20 THEN 'Low Value'
       WHEN Total_Amount BETWEEN 20 AND 50 THEN 'Medium Value'
       ELSE 'High Value'
       END AS Order_Category,
    COUNT(*) AS Order_Count 
    FROM dbo.Orders
    GROUP BY 
    CASE
    WHEN Total_Amount < 20 THEN 'Low Value'
        WHEN Total_Amount BETWEEN 20 AND 50 THEN 'Medium Value'
        ELSE 'High Value'
    END;
        
    



       











