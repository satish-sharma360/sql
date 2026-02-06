-- =====================================================
-- SQL ORDER BY (SORTING) WITH OUTPUT & EXPLANATION
-- =====================================================


-- =====================================================
-- SECTION 1: DATABASE & TABLE SETUP
-- =====================================================

CREATE DATABASE db12;
USE db12;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    last_updated TIMESTAMP
);

INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1299.99, 50, '2024-01-15 10:00:00'),
(2, 'Desk Chair', 'Furniture', 199.99, 30, '2024-01-16 11:30:00'),
(3, 'Coffee Maker', 'Appliances', 79.99, 100, '2024-01-14 09:15:00'),
(4, 'Gaming Mouse', 'Electronics', 59.99, 200, '2024-01-17 14:20:00'),
(5, 'Bookshelf', 'Furniture', 149.99, 25, '2024-01-13 16:45:00');


-- =====================================================
-- SECTION 2: BASIC ORDER BY
-- =====================================================

SELECT * FROM products;

-- OUTPUT:
-- Records appear in insertion order
-- WHY:
-- Without ORDER BY, SQL does NOT guarantee sorting


SELECT * FROM products ORDER BY price;

-- OUTPUT (price ASC):
-- Gaming Mouse   59.99
-- Coffee Maker  79.99
-- Bookshelf     149.99
-- Desk Chair    199.99
-- Laptop Pro    1299.99
-- WHY:
-- Default ORDER BY sorting is ASC (small to large)


SELECT * FROM products ORDER BY last_updated;

-- OUTPUT (oldest first):
-- Bookshelf
-- Coffee Maker
-- Laptop Pro
-- Desk Chair
-- Gaming Mouse
-- WHY:
-- Timestamp sorted chronologically


-- =====================================================
-- SECTION 3: MULTI-COLUMN SORTING
-- =====================================================

SELECT * FROM products ORDER BY category DESC, price DESC;

-- OUTPUT ORDER:
-- Furniture    -> Desk Chair, Bookshelf
-- Electronics  -> Laptop Pro, Gaming Mouse
-- Appliances   -> Coffee Maker
-- WHY:
-- First sorted by category (Z-A)
-- Then price (high to low) inside same category


SELECT * FROM products ORDER BY 4;

-- OUTPUT:
-- Same as ORDER BY price
-- WHY:
-- Column 4 = price
-- NOTE:
-- Works but bad practice (column order change breaks query)


-- =====================================================
-- SECTION 4: WHERE + ORDER BY
-- =====================================================

SELECT * FROM products
WHERE category = 'Electronics'
ORDER BY price;

-- OUTPUT:
-- Gaming Mouse 59.99
-- Laptop Pro 1299.99
-- WHY:
-- WHERE filters rows first
-- ORDER BY sorts filtered result


-- =====================================================
-- SECTION 5: FUNCTION-BASED SORTING
-- =====================================================

SELECT * FROM products ORDER BY LENGTH(product_name);

-- OUTPUT (short name first):
-- Bookshelf
-- Desk Chair
-- Laptop Pro
-- Gaming Mouse
-- Coffee Maker
-- WHY:
-- LENGTH() returns character count
-- Sorting happens on calculated value


SELECT * FROM products ORDER BY DAY(last_updated);

-- OUTPUT:
-- Bookshelf (13)
-- Coffee Maker (14)
-- Laptop Pro (15)
-- Desk Chair (16)
-- Gaming Mouse (17)
-- WHY:
-- DAY() extracts day number from date


-- =====================================================
-- SECTION 6: ORDER BY + LIMIT
-- =====================================================

SELECT * FROM products
ORDER BY stock_quantity DESC
LIMIT 1;

-- OUTPUT:
-- Gaming Mouse (200)
-- WHY:
-- DESC puts highest stock first
-- LIMIT 1 returns top row only


-- =====================================================
-- SECTION 7: CUSTOM SORT USING FIELD
-- =====================================================

SELECT * FROM products
ORDER BY FIELD(category,'Electronics','Appliances','Furniture'), price DESC;

-- OUTPUT ORDER:
-- Electronics first
-- Appliances second
-- Furniture last
-- WHY:
-- FIELD() assigns ranking numbers
-- Sorting follows those numbers


-- =====================================================
-- SECTION 8: CONDITIONAL SORTING
-- =====================================================

SELECT *,
    stock_quantity <= 50 AND price >= 200 AS priority_flag
FROM products
ORDER BY priority_flag DESC;

-- OUTPUT:
-- Laptop Pro (priority_flag = 1)
-- Others (priority_flag = 0)
-- WHY:
-- Boolean condition returns 1 (true) or 0 (false)
-- DESC brings true values first


SELECT *,
    CASE
        WHEN stock_quantity <= 50 AND price >= 200 THEN 1
        WHEN stock_quantity <= 50 THEN 2
        ELSE 3
    END AS priority
FROM products
ORDER BY priority;

-- OUTPUT ORDER:
-- Priority 1 -> Laptop Pro
-- Priority 2 -> Desk Chair, Bookshelf
-- Priority 3 -> Others
-- WHY:
-- CASE creates custom numeric priority
-- ORDER BY sorts by priority number


-- =====================================================
-- SECTION 9: NULL SORTING
-- =====================================================

INSERT INTO products VALUES
(6, 'Desk Lamp', 'Furniture', NULL, 45, '2024-01-18 13:25:00'),
(7, 'Keyboard', 'Electronics', 89.99, NULL, '2024-01-19 15:10:00');


SELECT * FROM products ORDER BY price;

-- OUTPUT:
-- Desk Lamp (NULL price appears first)
-- WHY:
-- MySQL treats NULL as lowest value


SELECT * FROM products
ORDER BY price IS NULL, price;

-- OUTPUT:
-- Non-NULL prices first
-- NULL prices at bottom
-- WHY:
-- price IS NULL returns 0 or 1
-- 0 sorted before 1


-- =====================================================
-- SECTION 10: CALCULATED COLUMN SORT
-- =====================================================

SELECT *,
    price * stock_quantity AS total_value
FROM products
ORDER BY total_value DESC;

-- OUTPUT (top rows):
-- Laptop Pro (highest total value)
-- Gaming Mouse
-- WHY:
-- total_value calculated per row
-- ORDER BY uses calculated alias


-- =====================================================
-- SECTION 11: PERFORMANCE CHECK
-- =====================================================

EXPLAIN SELECT * FROM products ORDER BY category, price;

-- OUTPUT:
-- Extra: Using filesort
-- WHY:
-- Sorting on non-indexed columns


EXPLAIN SELECT * FROM products ORDER BY product_id;

-- OUTPUT:
-- Faster execution
-- WHY:
-- product_id is PRIMARY KEY (indexed)
