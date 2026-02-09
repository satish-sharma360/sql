#-- INNER JOIN

CREATE DATABASE IF NOT EXISTS learjoin;

USE learjoin;

CREATE TABLE student(
	id 		INT,
    name	VARCHAR(50)
);

INSERT INTO student(id , name) VALUES
(101 , 'adam'),
(102 , 'bob'),
(103 , 'cassey');


CREATE TABLE courses(
	idCourse 	INT,
    course	VARCHAR(50)
);

INSERT INTO courses(idCourse , course) VALUES
(102 , 'english'),
(105 , 'Math'),
(103 , 'Science'),
(107 , 'Computer Science');

#--Inner Join

SELECT *
FROM student
INNER JOIN courses
ON student.id = courses.idCourse;

SELECT s.id, s.name, c.course
FROM student AS s
INNER JOIN courses AS c
ON s.id = c.idCourse;



CREATE TABLE Students(
    StudentId   INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Courses(
    CourseID    INT PRIMARY KEY,
    CourseName  VARCHAR(50)
);
CREATE TABLE Enrollments(
    CourseID    INT,
    StudentId  INT
);

INSERT INTO Students VALUES
(1, 'Rahul'),
(2, 'Amit'),
(3, 'Neha');

INSERT INTO Courses VALUES
(101, 'SQL'),
(102, 'Java');

INSERT INTO Enrollments VALUES
(1, 101),
(1, 102),
(2, 101);

#-- INNER JOIN

SELECT s.StudentName , c.CourseName
FROM students s
INNER JOIN Enrollments e 
ON s.StudentId = e.StudentId
INNER JOIN Courses c
ON e.CourseID = c.CourseID