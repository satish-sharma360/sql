-- =====================================================
-- MYSQL LIMIT CLAUSE WITH OUTPUT & EXPLANATION
-- =====================================================


-- =====================================================
-- SECTION 1: DATABASE SETUP & SAMPLE DATA
-- =====================================================

CREATE DATABASE db13;
USE db13;

-- Create products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- Auto-increment product ID
    name VARCHAR(100),                       -- Product name
    price DECIMAL(10,2),                     -- Product price
    category VARCHAR(50),                    -- Product category
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Created time
);

-- Insert sample records
INSERT INTO products (name, price, category) VALUES
('Laptop', 999.99, 'Electronics'),
('Smartphone', 499.99, 'Electronics'),
('Coffee Maker', 79.99, 'Appliances'),
('Headphones', 149.99, 'Electronics'),
('Blender', 59.99, 'Appliances'),
('Tablet', 299.99, 'Electronics'),
('Microwave', 199.99, 'Appliances'),
('Smart Watch', 249.99, 'Electronics'),
('Toaster', 39.99, 'Appliances'),
('Speaker', 89.99, 'Electronics');


-- =====================================================
-- SECTION 2: BASIC LIMIT USAGE
-- =====================================================

SELECT * FROM products
ORDER BY id
LIMIT 2;

-- OUTPUT:
-- id | name
-- 1  | Laptop
-- 2  | Smartphone
-- WHY:
-- LIMIT 2 returns only the first 2 rows
-- ORDER BY id ensures predictable ordering


-- =====================================================
-- SECTION 3: LIMIT WITH OFFSET
-- =====================================================

-- Syntax 1: LIMIT row_count OFFSET offset
SELECT * FROM products
ORDER BY id
LIMIT 2 OFFSET 2;

-- OUTPUT:
-- id | name
-- 3  | Coffee Maker
-- 4  | Headphones
-- WHY:
-- OFFSET 2 skips first 2 rows
-- LIMIT 2 fetches next 2 rows


-- Syntax 2: LIMIT offset, row_count
-- Syntax 2: LIMIT [offset], [row_count]
SELECT * FROM products
ORDER BY id
LIMIT 2, 2;

-- OUTPUT:
-- id | name
-- 3  | Coffee Maker
-- 4  | Headphones
-- WHY:
-- LIMIT 2,2 means skip 2 rows and return next 2
-- Both syntaxes give same result


-- =====================================================
-- SECTION 4: PAGINATION IMPLEMENTATION
-- =====================================================

-- Page size = 3 products per page

-- Page 1
SELECT * FROM products
ORDER BY id
LIMIT 3 OFFSET 0;

-- OUTPUT:
-- Laptop
-- Smartphone
-- Coffee Maker
-- WHY:
-- OFFSET 0 starts from first row
-- LIMIT 3 returns first 3 rows


-- Page 2
SELECT * FROM products
ORDER BY id
LIMIT 3 OFFSET 3;

-- OUTPUT:
-- Headphones
-- Blender
-- Tablet
-- WHY:
-- OFFSET 3 skips first page records
-- LIMIT 3 fetches next page data


-- Page 3
SELECT * FROM products
ORDER BY id
LIMIT 3 OFFSET 6;

-- OUTPUT:
-- Microwave
-- Smart Watch
-- Toaster
-- WHY:
-- OFFSET keeps jumping page-size rows


-- Alternative syntax using LIMIT offset, count

-- Page 1
SELECT * FROM products
ORDER BY id
LIMIT 0, 3;

-- Page 2
SELECT * FROM products
ORDER BY id
LIMIT 3, 3;

-- Page 3
SELECT * FROM products
ORDER BY id
LIMIT 6, 3;

-- WHY:
-- LIMIT offset, count works same as OFFSET syntax
-- Commonly used in backend pagination


-- Generic pagination formula:
-- LIMIT (page_number - 1) * items_per_page, items_per_page


-- =====================================================
-- SECTION 5: COMMON USE CASES
-- =====================================================

-- Top 3 most expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 3;

-- OUTPUT:
-- Laptop (999.99)
-- Smartphone (499.99)
-- Tablet (299.99)
-- WHY:
-- ORDER BY price DESC puts highest price first
-- LIMIT 3 returns top 3 rows


-- Get 5 random products
SELECT * FROM products
ORDER BY RAND()
LIMIT 5;

-- OUTPUT:
-- Any 5 random products (different each time)
-- WHY:
-- RAND() assigns random number to each row
-- ORDER BY RAND() shuffles rows
-- LIMIT 5 picks first 5 shuffled rows


-- =====================================================
-- SECTION 6: PERFORMANCE CONSIDERATIONS
-- =====================================================

-- Example of slow query with large OFFSET
SELECT *
FROM products
ORDER BY created_at
LIMIT 1000000, 10;

-- OUTPUT:
-- Returns 10 rows after skipping 1,000,000 rows
-- WHY:
-- MySQL still scans and skips those rows
-- Very slow on large tables


-- Better alternative using WHERE
SELECT *
FROM products
WHERE created_at > '2025-01-01 00:00:00'
ORDER BY created_at
LIMIT 10;

-- OUTPUT:
-- First 10 rows after given timestamp
-- WHY:
-- WHERE filters rows early
-- Less scanning = better performance


-- =====================================================
-- SECTION 7: KEY TAKEAWAYS
-- =====================================================

-- LIMIT controls number of rows returned
-- OFFSET is used to skip rows
-- ORDER BY + LIMIT is critical for predictable results
-- High OFFSET values can hurt performance
-- Prefer WHERE-based pagination for large datasets
