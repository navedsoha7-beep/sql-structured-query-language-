**Introduction to SQL and Advanced Functions | Assignment**

#1. Explain the fundamental differences between DDL, DML, and DQL
commands in SQL. Provide one example for each type of command.


    - 1. DDL (Data Definition Language)
        Defines and manages the structure of database objects (tables, schemas, indexes).

      
        DML(Data Manipulation Language)
        Deals with inserting, updating, deleting, and managing data inside tables.

        

        DQL(Data Query Language)
        Focuses on retrieving data from the database.





2. What is the purpose of SQL constraints? Name and describe three common types
of constraints, providing a simple scenario where each would be useful.  


    - SQL constraints are rules applied to table columns that enforce data integrity, accuracy, and consistency. They prevent invalid or inconsistent data from being entered into the database, ensuring that the stored information adheres to business logic and structural requirements.


     - Primary Key -Ensures each row in a table is uniquely identifiable.
     - Foreign Key -Maintains referential integrity by linking one table’s column to another table’s primary key. Prevents orphan records.


     - NOT NULL -Prevents a column from having NULL values, ensuring that essential data is always provided.




3.  Explain the difference between LIMIT and OFFSET clauses in SQL. How
would you use them together to retrieve the third page of results, assuming each page
has 10 records?



  - LIMIT- Specifies the maximum number of records to return.
    OFFSET- Skips a specified number of rows before starting to return results.

     - Page 1 → rows 1–10 (LIMIT 10 OFFSET 0)
- Page 2 → rows 11–20 (LIMIT 10 OFFSET 10)
- Page 3 → rows 21–30 (LIMIT 10 OFFSET 20)




4. What is a Common Table Expression (CTE) in SQL, and what are its main
benefits? Provide a simple SQL example demonstrating its usage.
    


      - A Common Table Expression (CTE) in SQL is a temporary, named result set that you can reference within a query. It’s defined using the WITH keyword and exists only for the duration of that query.


5. Describe the concept of SQL Normalization and its primary goals. Briefly
explain the first three normal forms (1NF, 2NF, 3NF).









    - SQL Normalization is the process of organizing data in a relational database to reduce redundancy and improve data integrity. It involves dividing large, complex tables into smaller, well-structured ones and defining relationships between them.

Primary Goals of Normalization
- Minimize redundancy (avoid storing the same data in multiple places).
- Prevent anomalies (insertion, update, and deletion errors).
- Improve consistency (data remains accurate and reliable).
- Enhance maintainability (schemas are easier to update and scale).





#6.Create a database named ECommerceDB and perform the following 
#tasks: 
#1. Create the following tables with appropriate data types and constraints: 
#● Categories 
#○ CategoryID (INT, PRIMARY KEY) 
#○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE) 
#● Products 
#○ ProductID (INT, PRIMARY KEY) 
#○ ProductName (VARCHAR(100), NOT NULL, UNIQUE) 
#○ CategoryID (INT, FOREIGN KEY → Categories) 
#○ Price (DECIMAL(10,2), NOT NULL) 
#○ StockQuantity (INT) 
#● Customers 
#○ CustomerID (INT, PRIMARY KEY) 
#○ CustomerName (VARCHAR(100), NOT NULL) 
#○ Email (VARCHAR(100), UNIQUE) 
#○ JoinDate (DATE) 
#● Orders 
#○ OrderID (INT, PRIMARY KEY) 
#○ CustomerID (INT, FOREIGN KEY → Customers) 
#○ OrderDate (DATE, NOT NULL) 
#○ TotalAmount (DECIMAL(10,2)) 

CREATE DATABASE ECommerceDB ;
USE ECommerceDB;
CREATE TABLE CATEGORIES(CategoryID INT PRIMARY KEY,CategoryName VARCHAR(50) NOT NULL UNIQUE);

 CREATE TABLE Products (ProductID INT PRIMARY KEY,
 ProductName VARCHAR(100) NOT NULL UNIQUE, FOREIGN KEY (ProductID) REFERENCES Categories(CategoryID),
 Price DECIMAL(10,2)NOT NULL,
 StockQuantity INT ) ;
 
 CREATE TABLE CUSTOMERS(CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
 JoinDate DATE DEFAULT(CURDATE())
 );
 
 
 CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID));
    
    INSERT INTO CATEGORIES(CategoryID,CategoryName)
    VALUES
    (1,"Electronics"),
    (2,"Books"),
    (3,"Home Goods"),
    (4,"Apparel");
    
    
    
    
   
ALTER TABLE Products
ADD CustomerID INT ;
    
    
    
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity)
VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 1, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 1, 120.00, 60),
(108, 'T-Shirt Casual', 2, 20.00, 300);
    
    
    INSERT INTO Customers (CustomerID, CustomerName, Email,JoinDate)
VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');
    
    
    ALTER TABLE Orders
ADD ProductName VARCHAR(50);

    
    
    
    
    
    INSERT INTO Orders (OrderID, ProductName, CustomerID, OrderDate, TotalAmount)
VALUES
(1001, 'Coffee Maker', 3, '2023-04-26', 1245.50),
(1002, 'Novel: The Great SQL', 2, '2023-10-12', 99.99),
(1003, 'Wireless Earbuds', 1, '2023-07-01', 145.00),
(1004, 'Blender X', 3, '2023-01-14', 150.00),
(1005, 'T-Shirt Casual', 2, '2023-09-24', 120.00),
(1006, 'Smart Speaker', 1, '2023-06-19', 20.00);
    
    
    
    
    
    
    
#7. Generate a report showing CustomerName, Email, and the 
#TotalNumberofOrders for each customer. Include customers who have not placed 
#any orders, in which case their TotalNumberofOrders should be 0. Order the results 
#by CustomerName.


SELECT 
    c.CustomerName,
    c.Email,
    COALESCE(COUNT(o.OrderID), 0) AS TotalNumberOfOrders
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName, c.Email
ORDER BY c.CustomerName;




#8.  Retrieve Product Information with Category: Write a SQL query to 
#display the ProductName, Price, StockQuantity, and CategoryName for all 
#products. Order the results by CategoryName and then ProductName alphabetically.
  SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
INNER JOIN Categories c 
    ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName;



#9.  Write a SQL query that uses a Common Table Expression (CTE) and a 
#Window Function (specifically ROW_NUMBER() or RANK()) to display the 
#CategoryName, ProductName, and Price for the top 2 most expensive products in 
#each CategoryName.




WITH RankedProducts AS (
    SELECT 
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName 
            ORDER BY p.Price DESC
        ) AS RowNum
    FROM Products p
    INNER JOIN Categories c 
        ON p.CategoryID = c.CategoryID
)
SELECT 
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE RowNum <= 2
ORDER BY CategoryName, Price DESC;









   