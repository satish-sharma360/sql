-- =====================================================
-- SQL ORDER BY / SORTING TUTORIAL
-- Demonstrates basic to advanced sorting techniques
-- Using ONLY single-line comments for easy copy-paste
-- =====================================================


-- =====================================================
-- SECTION 1: DATABASE & TABLE SETUP
-- =====================================================

-- Create database
CREATE DATABASE db12;

-- Select database
USE db12;

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,        -- Unique product ID
    product_name VARCHAR(100),          -- Name of product
    category VARCHAR(50),               -- Product category
    price DECIMAL(10,2),                -- Product price
    stock_quantity INT,                 -- Available stock
    last_updated TIMESTAMP              -- Last updated time
);

-- Insert initial sample records
INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1299.99, 50, '2024-01-15 10:00:00'),
(2, 'Desk Chair', 'Furniture', 199.99, 30, '2024-01-16 11:30:00'),
(3, 'Coffee Maker', 'Appliances', 79.99, 100, '2024-01-14 09:15:00'),
(4, 'Gaming Mouse', 'Electronics', 59.99, 200, '2024-01-17 14:20:00'),
(5, 'Bookshelf', 'Furniture', 149.99, 25, '2024-01-13 16:45:00');


-- =====================================================
-- SECTION 2: BASIC SORTING OPERATIONS
-- =====================================================

-- Fetch all records (no sorting applied)
SELECT * FROM products;

-- Sort products by price in ascending order (ASC is default)
SELECT * FROM products 
ORDER BY price;

-- Sort products by last updated timestamp (oldest to newest)
SELECT * FROM products 
ORDER BY last_updated;


-- =====================================================
-- SECTION 3: ADVANCED SORTING TECHNIQUES
-- =====================================================

-- Sort by category in descending order
-- If category is same, sort by price in descending order
SELECT * FROM products 
ORDER BY category DESC, price DESC;

-- Sort using column position
-- Here, 4 refers to the "price" column
SELECT * FROM products 
ORDER BY 4;

-- Use WHERE clause with ORDER BY
-- First filter Electronics, then sort by price
SELECT * FROM products 
WHERE category = 'Electronics' 
ORDER BY price;

-- Case-sensitive sorting using BINARY
-- Uppercase and lowercase values are treated differently
SELECT * FROM products 
ORDER BY BINARY category;


-- =====================================================
-- SECTION 4: FUNCTION-BASED SORTING
-- =====================================================

-- Sort products based on length of product name
SELECT * FROM products 
ORDER BY LENGTH(product_name);

-- Sort products based on day extracted from timestamp
SELECT * FROM products 
ORDER BY DAY(last_updated);

-- Get product with highest stock quantity
SELECT * FROM products 
ORDER BY stock_quantity DESC 
LIMIT 1;


-- =====================================================
-- SECTION 5: CUSTOM SORTING ORDER
-- =====================================================

-- Default alphabetical sorting of categories
SELECT * FROM products 
ORDER BY category;

-- Custom sorting order using FIELD function
-- Electronics first, then Appliances, then Furniture
-- Price sorted in descending order within category
SELECT * FROM products 
ORDER BY FIELD(category, 'Electronics', 'Appliances', 'Furniture'), price DESC;


-- =====================================================
-- SECTION 6: CONDITIONAL / PRIORITY SORTING
-- =====================================================

-- Create a priority flag for:
-- Low stock (<=50) AND high price (>=200)
SELECT *,
    stock_quantity <= 50 AND price >= 200 AS priority_flag
FROM products 
ORDER BY priority_flag DESC;

-- Advanced priority sorting using CASE expression
-- Priority 1: Low stock & high price
-- Priority 2: Low stock only
-- Priority 3: All others
SELECT *,
    CASE
        WHEN stock_quantity <= 50 AND price >= 200 THEN 1
        WHEN stock_quantity <= 50 THEN 2
        ELSE 3
    END AS priority
FROM products 
ORDER BY priority;


-- =====================================================
-- SECTION 7: HANDLING NULL VALUES
-- =====================================================

-- Insert records with NULL values
INSERT INTO products VALUES
(6, 'Desk Lamp', 'Furniture', NULL, 45, '2024-01-18 13:25:00'),
(7, 'Keyboard', 'Electronics', 89.99, NULL, '2024-01-19 15:10:00');

-- Sorting by price (NULLs appear first by default in MySQL)
SELECT * FROM products 
ORDER BY price;

-- Explicitly push NULL prices to bottom
SELECT *,
    price IS NULL AS is_price_null
FROM products 
ORDER BY price IS NULL, price;


-- =====================================================
-- SECTION 8: SORTING USING CALCULATED COLUMNS
-- =====================================================

-- Calculate total inventory value (price * quantity)
-- Sort by highest total value
SELECT *,
    price * stock_quantity AS total_value
FROM products 
ORDER BY total_value DESC;


-- =====================================================
-- SECTION 9: QUERY PERFORMANCE ANALYSIS
-- =====================================================

-- Analyze execution plan for multi-column sorting
EXPLAIN 
SELECT * FROM products 
ORDER BY category, price;

-- Analyze execution plan for primary key sorting
-- Faster because product_id is indexed
EXPLAIN 
SELECT * FROM products 
ORDER BY product_id;
