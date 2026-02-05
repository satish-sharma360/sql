
CREATE DATABASE bookstore;
-- ✅ Creates database named 'bookstore'


USE bookstore;
-- ✅ Switches to bookstore database


CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    price DECIMAL(10,2),
    publication_date DATE,
    category VARCHAR(30),
    in_stock INT
);
-- ✅ Table 'books' created


INSERT INTO books VALUES
(1, 'The MySQL Guide', 'John Smith', 29.99, '2023-01-15', 'Technology', 50),
(2, 'Data Science Basics', 'Sarah Johnson', 34.99, '2023-03-20', 'Technology', 30),
(3, 'Mystery at Midnight', 'Michael Brown', 19.99, '2023-02-10', 'Mystery', 100),
(4, 'Cooking Essentials', 'Lisa Anderson', 24.99, '2023-04-05', 'Cooking', 75);
-- ✅ 4 rows inserted


INSERT INTO books VALUES
(5, 'Cook Book', null, 24.99, '2023-04-05', 'Cooking', 75);
-- ✅ Book inserted with NULL author


INSERT INTO books VALUES
(6, 'Mini Cook Book', 'Gohn Smith', 24.99, '2023-04-05', 'Cooking', 75);
-- ✅ Another cooking book inserted


select * from books where category='Technology' ;
-- ✅ FIND WHERE CATEGORY IS Technology
-- ✅ Shows 2 Technology books (MySQL Guide, Data Science Basics)

SELECT title, price FROM books WHERE price < 30.00;
-- ✅ SHOW ONLY TITLE AND PRICE WHERE PRICE < 30
-- ✅ Books cheaper than 30 (MySQL Guide, Mystery, Cooking books)

SELECT title, publication_date FROM books 
WHERE publication_date >= '2023-03-01';
-- ✅ Books published from March 2023 onwards


-- Logical Operators

select * from books where category = 'Technology' and price < 30;
-- ✅ Books category = 'Technology' AND price < 30 BOTH SHOULD BE TRUE


select * from books where category = 'Technology' or price < 30;
-- ✅ Books category = 'Technology' AND price < 30 BANY ONE BE TRUE

select * from books where (category = 'Technology' or category = 'Mystery') and price < 25; 
-- ✅ Books category = 'Technology' OR category = 'Mystery' FIND ALL THESE category book then price filter applied
-- AND price < 30 BOTH SHOULD BE TRUE

select * from books where not category = 'Technology';
-- ✅ All non-Technology books


-- Finding NULL values

select * from books where author is null;
-- ✅ Shows "Cook Book" (author missing)

select * from books where author is not null;
-- ✅ Shows books having author names


-- Pattern matching

select * from books where title like '%SqL%'; -- ✅ Matches "The MySQL Guide" (case-insensitive)
select * from books where title like 'the%';  -- ✅ Titles starting with "the" (MySQL Guide)
select * from books where title like binary '%SQL%';  -- ✅ Case-sensitive match (MySQL Guide only)
select * from books where author like '_ohn%';  -- ✅ Matches "John Smith" and "Gohn Smith"

-- RANGE OPERATORS 

select * from books where price between 20 and 30;
-- ✅ Books priced between 20 and 30 (inclusive)

select * from books where category in (
'Technology', 'MysterY', 'Science');
-- ✅ Technology + Mystery books (Science not found)

SELECT * FROM books 
WHERE price BETWEEN 20.00 AND 40.00 
    AND publication_date >= '2023-01-01';
    -- ✅ Most books (valid price + 2023)

-- SUBQUERIES

select * from books where price > ( select avg(price) from books );
-- ✅ Books costing more than average price

select * from books where category in (
select category from books where in_stock > 20);
-- ✅ All books (every category has stock > 20)


 -- Find all books published in 2023 that cost less than the average book price
 
SELECT title, price, publication_date
FROM books
WHERE YEAR(publication_date) = 2023
AND price < (SELECT AVG(price) FROM books);
-- ✅ 2023 books cheaper than average

 -- List all technology books with "data" in the title that have more than 50 copies in stock
 
SELECT title, category, in_stock
FROM books
WHERE category = 'Technology'
AND title LIKE '%data%'
AND in_stock > 50;
-- ❌ No output (Data Science Basics stock = 30)


 -- Find books that are either in the Technology category with price > $30 or in the Mystery category with price < $20

SELECT title, category, price
FROM books
WHERE (category = 'Technology' AND price > 30.00)
OR (category = 'Mystery' AND price < 20.00);
-- ✅ Data Science Basics + Mystery at Midnight


 -- List all books where the author's name contains either 'son' or 'th' and were published after March 2023

SELECT title, author, publication_date
FROM books
WHERE (author LIKE '%son%' OR author LIKE '%th%')
AND publication_date > '2023-03-31';
-- ✅ Cooking Essentials (Lisa Anderson)