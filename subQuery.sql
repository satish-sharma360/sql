CREATE DATABASE IF NOT EXISTS subQuery;

USE subQuery;

CREATE TABLE students (
    rollno INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

INSERT INTO
TABLE (rollno, name, marks)
VALUES (101, 'anil', 78),
    (102, 'bhumika', 93),
    (103, 'chetan', 85),
    (104, 'dhruv', 96),
    (105, 'emanuel', 92),
    (106, 'farah', 82);

#--get names of all student who scored more then class average;

SELECT name
FROM students
WHERE marks > (SELECT AVG(marks) FROM students)

-- using join
SELECT s.name
FROM students s
    JOIN (
        SELECT AVG(marks) AS avg_marks
        FROM students
    ) a ON s.marks > a.avg_marks;

-- Find the names of all student with even roll numbers.
SELECT rollno FROM students WHERE rollno % 2 = 0

-- USING SUBQUERY
SELECT name, rollno
FROM students
WHERE
    rollno IN (
        SELECT rollno
        FROM students
        WHERE
            rollno % 2 = 0
    )

--Find the max marks from the students of delhi
CREATE TABLE anotherStudent (
    rollno INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    marks INT,
    city VARCHAR(50)
);

INSERT INTO
anotherStudent (rollno, name, marks, city)
VALUES 
    (101, 'anil', 78, 'Pune'),
    (102, 'bhumika', 93, 'Mumbai'),
    (103, 'chetan', 85, 'Mumbai'),
    (104, 'dhruv', 96, 'Delhi'),
    (105, 'emanuel', 92, 'Delhi'),
    (106, 'farah', 82, 'Delhi');

SELECT MAX(marks) AS max_marks
FROM anotherStudent
WHERE city = 'Delhi'

--using SUBQUERY

SELECT MAX(marks)
FROM anotherStudent
WHERE city IN (
    SELECT city
    FROM anotherStudent
    WHERE city = 'Delhi'
)