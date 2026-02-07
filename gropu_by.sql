-- =============================================================
-- SQL GROUP BY – COMPLETE EXPLAINED SCRIPT
-- =============================================================
-- This script demonstrates how GROUP BY works in SQL
-- with multiple real-world examples.
-- Each query is heavily commented so you can understand:
-- 1. WHY it is used
-- 2. HOW it works internally
-- 3. WHERE it is used in interviews & real projects
----------------------------------------------------

-- =============================================================
-- DATABASE SETUP
-- =============================================================
-- Create a new database dedicated for GROUP BY examples
CREATE DATABASE db_for_group_by;

-- Switch to the newly created database
USE db_for_group_by;

-- =============================================================
-- TABLE CREATION
-- =============================================================
-- employees table stores basic employee information
-- id            : unique identifier (auto increment)
-- name          : employee name
-- department    : department name (HR, IT, Finance, etc.)
-- salary        : employee salary
-- joining_date  : date when employee joined the company
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    joining_date DATE
);

-- =============================================================
-- INITIAL DATA INSERTION
-- =============================================================
-- Insert sample employee records into the table
INSERT INTO
    employees (
        name,
        department,
        salary,
        joining_date
    )
VALUES (
        'Alice',
        'HR',
        50000,
        '2020-06-15'
    ),
    (
        'Bob',
        'HR',
        55000,
        '2019-08-20'
    ),
    (
        'Charlie',
        'IT',
        70000,
        '2018-03-25'
    ),
    (
        'David',
        'IT',
        72000,
        '2017-07-10'
    ),
    (
        'Eve',
        'IT',
        73000,
        '2021-02-15'
    ),
    (
        'Frank',
        'Finance',
        60000,
        '2020-11-05'
    ),
    (
        'Grace',
        'Finance',
        65000,
        '2019-05-30'
    ),
    (
        'Hannah',
        'Finance',
        62000,
        '2021-01-12'
    );

-- =============================================================
-- ADDITIONAL DATA INSERTION
-- =============================================================
-- Adding more employees to increase dataset size
INSERT INTO
    employees (
        name,
        department,
        salary,
        joining_date
    )
VALUES (
        'Tim',
        'HR',
        65000,
        '2019-05-30'
    ),
    (
        'Tom',
        'IT',
        62000,
        '2021-01-12'
    );

-- =============================================================
-- VIEW ALL EMPLOYEE DATA
-- =============================================================
-- This query helps verify inserted data
SELECT * FROM employees;

-- =============================================================
-- EXAMPLE 1: COUNT EMPLOYEES IN EACH DEPARTMENT
-- =============================================================
-- GROUP BY department groups rows by department name
-- COUNT(*) counts number of rows in each group
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY
    department;

-- Interview Tip:
-- Whenever aggregate functions (COUNT, SUM, AVG, etc.) are used,
-- GROUP BY is required (except COUNT(*) alone).

-- =============================================================
-- EXAMPLE 2: AVERAGE SALARY PER DEPARTMENT
-- =============================================================
-- AVG(salary) calculates average salary within each department
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY
    department;

-- Real-world Use:
-- Used in payroll analysis and budgeting reports

-- =============================================================
-- EXAMPLE 3: HIGHEST & LOWEST SALARY PER DEPARTMENT
-- =============================================================
-- MIN(salary) finds lowest salary
-- MAX(salary) finds highest salary
SELECT
    department,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY
    department;

-- =============================================================
-- EXAMPLE 4: COUNT EMPLOYEES BY DEPARTMENT & JOINING YEAR
-- =============================================================
-- YEAR(joining_date) extracts year from date
-- GROUP BY multiple columns creates sub-groups
SELECT
    department,
    YEAR(joining_date) AS joining_year,
    COUNT(*) AS employee_count
FROM employees
GROUP BY
    department,
    joining_year;

-- =============================================================
-- EXAMPLE 5: ORDER DEPARTMENTS BY AVERAGE SALARY
-- =============================================================
-- ORDER BY works AFTER GROUP BY
-- DESC sorts from highest to lowest
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY
    department
ORDER BY avg_salary DESC;

-- =============================================================
-- EXAMPLE 6: GROUP BY CALCULATED SALARY RANGE
-- =============================================================
-- CASE expression creates virtual groups
-- GROUP BY can use aliases in MySQL
SELECT
    CASE
        WHEN salary < 60000 THEN 'Low Salary'
        WHEN salary BETWEEN 60000 AND 70000  THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS salary_range,
    COUNT(*) AS employee_count
FROM employees
GROUP BY
    salary_range;

-- Real-world Use:
-- Salary bands, performance categories, age groups

-- =============================================================
-- EXAMPLE 7: DEPARTMENT WITH MAXIMUM EMPLOYEES
-- =============================================================
-- ORDER BY + LIMIT used to find top result
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY
    department
ORDER BY total_employees DESC
LIMIT 1;

-- =============================================================
-- EXAMPLE 8: GROUP BY WITH WHERE & HAVING
-- =============================================================
-- WHERE filters rows BEFORE grouping
-- HAVING filters groups AFTER grouping
SELECT
    department,
    AVG(salary) AS average_salary,
    COUNT(*) AS total_employees
FROM employees
WHERE
    joining_date > '2017-07-10'
GROUP BY
    department
HAVING
    total_employees > 2
    AND average_salary > 55000;

-- WHERE → filters rows
-- GROUP BY → creates groups
-- HAVING → filters groups

-- =============================================================
-- END OF GROUP BY DEMO SCRIPT
-- =============================================================