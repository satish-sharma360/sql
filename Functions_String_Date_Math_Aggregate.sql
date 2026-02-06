-- =====================================================
-- SQL FUNCTIONS DEMO
-- STRING + NUMERIC + DATE + AGGREGATE FUNCTIONS
-- =====================================================


-- =====================================================
-- STRING FUNCTIONS
-- =====================================================

CREATE DATABASE StringFunctionsDB;
USE StringFunctionsDB;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO employees (first_name, last_name, email, department) VALUES
('John', 'Doe', 'john.doe@example.com', 'Marketing'),
('Jane', 'Smith', 'jane.smith@example.com', 'Sales'),
('Michael', 'Johnson', 'michael.johnson@example.com', 'IT'),
('Emily', 'Davis', 'emily.davis@example.com', 'HR'),
('Chris', 'Brown', 'chris.brown@example.com', 'Finance');


-- CONCAT: Combine first & last name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- OUTPUT:
-- John Doe
-- Jane Smith
-- Michael Johnson
-- WHY:
-- CONCAT joins multiple strings into one


-- LENGTH: Count characters in first name
SELECT first_name, LENGTH(first_name) AS name_length FROM employees;

-- OUTPUT:
-- John -> 4
-- Michael -> 7
-- WHY:
-- LENGTH returns number of characters (bytes for ASCII)


-- UPPER & LOWER
SELECT first_name,
       UPPER(first_name) AS upper_name,
       LOWER(first_name) AS lower_name
FROM employees;

-- WHY:
-- Used for case formatting and case-insensitive comparisons


-- TRIM
SELECT TRIM(UPPER('      ok.   ')) AS trimmed_sample;

-- OUTPUT:
-- OK.
-- WHY:
-- TRIM removes leading & trailing spaces


-- SUBSTRING
SELECT first_name,
       SUBSTRING(first_name, 1, 3) AS first_three
FROM employees;

-- OUTPUT:
-- John -> Joh
-- Michael -> Mic
-- WHY:
-- SUBSTRING extracts part of string


-- LOCATE
SELECT first_name,
       LOCATE('a', first_name) AS position_of_a
FROM employees;

-- OUTPUT:
-- Jane -> 2
-- Michael -> 3
-- John -> 0
-- WHY:
-- LOCATE returns position, 0 if not found


-- REPLACE
SELECT first_name,
       REPLACE(email, 'example.com', 'amazon.com') AS new_email
FROM employees;

-- WHY:
-- Replaces part of string with another string


-- REVERSE
SELECT first_name,
       REVERSE(first_name) AS reversed_name
FROM employees;

-- WHY:
-- Reverses characters (often used in puzzles)


-- LEFT & RIGHT
SELECT first_name,
       LEFT(first_name, 2) AS first_two,
       RIGHT(first_name, 2) AS last_two
FROM employees;

-- WHY:
-- Extract characters from start or end


-- ASCII
SELECT first_name,
       ASCII(first_name) AS ascii_value
FROM employees;

-- WHY:
-- ASCII returns numeric code of first character


-- =====================================================
-- FIELD FUNCTION (CUSTOM ORDERING)
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
(3, 'Coffee Maker', 'Appliances', 79.99, 100, '2024-01-14 09:15:00');

SELECT *,
       FIELD(category, 'Electronics', 'Appliances', 'Furniture') AS category_order
FROM products
ORDER BY category_order DESC;

-- WHY:
-- FIELD assigns custom ranking numbers
-- Used for business-specific sorting


-- =====================================================
-- LENGTH vs CHAR_LENGTH
-- =====================================================

SELECT LENGTH('hello') AS length_bytes;
SELECT CHAR_LENGTH('hello') AS length_chars;

-- OUTPUT:
-- Both return 5
-- WHY:
-- ASCII characters = 1 byte each

SELECT LENGTH('こんにちは') AS length_bytes;
SELECT CHAR_LENGTH('こんにちは') AS length_chars;

-- OUTPUT:
-- LENGTH > 5
-- CHAR_LENGTH = 5
-- WHY:
-- Multibyte characters take more bytes


-- =====================================================
-- SOUNDEX (PHONETIC MATCHING)
-- =====================================================

SELECT SOUNDEX('Smith'), SOUNDEX('Smyth');

-- OUTPUT:
-- Both return S530
-- WHY:
-- SOUNDEX matches pronunciation, not spelling

SELECT * FROM employees
WHERE SOUNDEX(first_name) = SOUNDEX('Jane');

-- WHY:
-- Finds names that sound similar


-- =====================================================
-- NUMERIC FUNCTIONS
-- =====================================================

CREATE DATABASE NumericFunctionsDB;
USE NumericFunctionsDB;

CREATE TABLE numbers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_value DECIMAL(10,5)
);

INSERT INTO numbers (num_value) VALUES
(25.6789),
(-17.5432),
(100.999),
(-0.4567),
(9.5),
(0);


SELECT num_value, ABS(num_value) AS absolute_value FROM numbers;

-- WHY:
-- ABS converts negative to positive


SELECT num_value,
       CEIL(num_value) AS rounded_up,
       FLOOR(num_value) AS rounded_down
FROM numbers;

-- WHY:
-- CEIL rounds up
-- FLOOR rounds down


SELECT num_value,
       ROUND(num_value, 2) AS rounded,
       TRUNCATE(num_value, 2) AS truncated
FROM numbers;

-- WHY:
-- ROUND rounds mathematically
-- TRUNCATE cuts decimals


SELECT num_value,
       POWER(num_value, 2) AS squared,
       MOD(num_value, 3) AS remainder
FROM numbers;

-- WHY:
-- POWER for exponent
-- MOD for remainder


-- =====================================================
-- DATE FUNCTIONS
-- =====================================================

SELECT NOW() AS current_datetime;
SELECT CURDATE() AS current_date;
SELECT CURTIME() AS current_time;

-- WHY:
-- System current date & time


SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW());

-- WHY:
-- Extract date parts


SELECT DATE_ADD('2025-03-13', INTERVAL 7 DAY) AS plus_7_days;
SELECT DATE_SUB('2025-03-13', INTERVAL 7 DAY) AS minus_7_days;

-- WHY:
-- Date arithmetic


SELECT DATEDIFF('2025-03-10', '2024-03-03') AS days_between;

-- WHY:
-- Difference in days only


SELECT UNIX_TIMESTAMP('2025-03-03');
SELECT FROM_UNIXTIME(1741392000);

-- WHY:
-- Unix time conversion


-- =====================================================
-- AGGREGATE FUNCTIONS
-- =====================================================

CREATE DATABASE CompanyDB2;
USE CompanyDB2;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (name, department, salary, hire_date) VALUES
('Alice', 'HR', 50000, '2018-06-23'),
('Bob', 'IT', 70000, '2019-08-01'),
('Charlie', 'Finance', 80000, '2017-04-15'),
('David', 'HR', 55000, '2020-11-30'),
('Eve', 'IT', 75000, '2021-01-25');


SELECT COUNT(*) FROM employees WHERE department = 'HR';

-- WHY:
-- COUNT returns number of rows


SELECT SUM(salary), AVG(salary), MIN(salary), MAX(salary)
FROM employees;

-- WHY:
-- SUM = total
-- AVG = average
-- MIN / MAX = boundaries


SELECT department,
       COUNT(*) AS emp_count,
       ROUND(AVG(salary),2) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- WHY:
-- GROUP BY groups rows
-- Aggregate functions summarize data
