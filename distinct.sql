-- =====================================================
-- MYSQL DISTINCT CLAUSE WITH OUTPUT & EXPLANATION
-- =====================================================


-- =====================================================
-- SECTION 1: DATABASE SETUP & SAMPLE DATA
-- =====================================================

CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Create employees table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique employee ID
    name VARCHAR(50),                   -- Employee name
    department VARCHAR(50),             -- Department name
    salary DECIMAL(10,2)                -- Employee salary
);

-- Insert sample data (including duplicates)
INSERT INTO employees (name, department, salary) VALUES
('Alice', 'HR', 50000),
('Bob', 'Finance', 60000),
('Charlie', 'IT', 70000),
('Alice', 'HR', 50000),      -- Duplicate row
('David', 'Finance', 55000),
('Eve', 'IT', 70000),        -- Duplicate salary
('Frank', 'HR', 50000);      -- Duplicate department & salary


-- =====================================================
-- SECTION 2: VIEW ALL DATA
-- =====================================================

SELECT * FROM employees;

-- OUTPUT:
-- Shows all rows including duplicates
-- WHY:
-- No DISTINCT used, so every record is displayed


-- =====================================================
-- SECTION 3: DISTINCT ON SINGLE COLUMN
-- =====================================================

SELECT DISTINCT department 
FROM employees;

-- OUTPUT:
-- HR
-- Finance
-- IT
-- WHY:
-- DISTINCT removes duplicate department values
-- Each department appears only once


-- =====================================================
-- SECTION 4: DISTINCT ON MULTIPLE COLUMNS
-- =====================================================

SELECT DISTINCT department, salary 
FROM employees;

-- OUTPUT:
-- HR        | 50000
-- Finance  | 60000
-- Finance  | 55000
-- IT       | 70000
-- WHY:
-- DISTINCT checks the COMBINATION of columns
-- Duplicate pairs are removed, not individual columns


-- =====================================================
-- SECTION 5: DISTINCT WITH AGGREGATE FUNCTION
-- =====================================================

SELECT COUNT(DISTINCT department) AS unique_departments
FROM employees;

-- OUTPUT:
-- unique_departments
-- 3
-- WHY:
-- DISTINCT removes duplicates first
-- COUNT then counts unique departments only


-- =====================================================
-- SECTION 6: DISTINCT WITH STRING FUNCTION
-- =====================================================

SELECT DISTINCT CONCAT(name, '-', department) 
FROM employees;

-- OUTPUT:
-- Alice-HR
-- Bob-Finance
-- Charlie-IT
-- David-Finance
-- Eve-IT
-- Frank-HR
-- WHY:
-- CONCAT combines name and department
-- DISTINCT removes duplicate combined values


-- =====================================================
-- SECTION 7: DISTINCT WITH ORDER BY
-- =====================================================

SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC;

-- OUTPUT:
-- 70000
-- 60000
-- 55000
-- 50000
-- WHY:
-- DISTINCT removes duplicate salaries
-- ORDER BY sorts remaining values in descending order


-- =====================================================
-- SECTION 8: DISTINCT WITH WHERE CLAUSE
-- =====================================================

SELECT DISTINCT department
FROM employees
WHERE salary > 50000;

-- OUTPUT:
-- Finance
-- IT
-- WHY:
-- WHERE filters rows first (salary > 50000)
-- DISTINCT then removes duplicate departments


-- =====================================================
-- SECTION 9: DISPLAY CURRENT DATA
-- =====================================================

SELECT * FROM employees;

-- OUTPUT:
-- Shows current employee records
-- WHY:
-- Helps verify table state before next operations


-- =====================================================
-- SECTION 10: DISTINCT WITH NULL VALUES
-- =====================================================

-- Insert records with NULL department
INSERT INTO employees (name, department, salary) VALUES
('Grace', NULL, 48000),
('Bobby', NULL, 48000);

SELECT DISTINCT department
FROM employees;

-- OUTPUT:
-- HR
-- Finance
-- IT
-- NULL
-- WHY:
-- DISTINCT treats all NULLs as a single unique value
-- Multiple NULL rows result in one NULL output only


-- =====================================================
-- SECTION 11: INTERVIEW TAKEAWAYS
-- =====================================================

-- DISTINCT removes duplicate ROWS, not duplicate columns
-- DISTINCT works on column combinations
-- DISTINCT is applied AFTER WHERE
-- DISTINCT counts NULL as one unique value
-- DISTINCT can be used with COUNT, ORDER BY, functions
