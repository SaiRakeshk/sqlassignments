CREATE database SIS;
CREATE TABLE Students (
    student_id INT PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES
(1, 'Suresh', 'Patel', '1998-05-20', 'suresh.patel@email.com', '9876543210'),
(2, 'Priya', 'Singh', '1997-08-12', 'priya.singh@email.com', '8765432109'),
(3, 'Manoj', 'Kumar', '1996-11-25', 'manoj.kumar@email.com', '7654321098'),
(4, 'Divya', 'Shah', '1999-03-15', 'divya.shah@email.com', '6543210987'),
(5, 'Ananya', 'Verma', '1995-09-08', 'ananya.verma@email.com', '5432109876'),
(6, 'Rajesh', 'Gupta', '1997-12-10', 'rajesh.gupta@email.com', '4321098765'),
(7, 'Asha', 'Malhotra', '1998-06-18', 'asha.malhotra@email.com', '3210987654'),
(8, 'Vishnu', 'Sharma', '1994-04-22', 'vishnu.sharma@email.com', '2109876543'),
(9, 'Meera', 'Joshi', '1993-07-30', 'meera.joshi@email.com', '1098765432'),
(10, 'Arjun', 'Goyal', '1996-02-14', 'arjun.goyal@email.com', '0987654321');

INSERT INTO Courses (course_id, course_name, credits, teacher_id)
VALUES
(1, 'Computer Science', 3, 101),
(2, 'Mathematics', 4, 102),
(3, 'Physics', 3, 103),
(4, 'Chemistry', 3, 104),
(5, 'Biology', 4, 105),
(6, 'History', 3, 106),
(7, 'Literature', 3, 107),
(8, 'Economics', 4, 108),
(9, 'Geography', 3, 109),
(10, 'Political Science', 4, 110);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
(1, 1, 1, '2024-04-01'),
(2, 2, 2, '2024-04-03'),
(3, 3, 3, '2024-04-05'),
(4, 4, 4, '2024-04-07'),
(5, 5, 5, '2024-04-09'),
(6, 6, 6, '2024-04-11'),
(7, 7, 7, '2024-04-13'),
(8, 8, 8, '2024-04-15'),
(9, 9, 9, '2024-04-17'),
(10, 10, 10, '2024-04-19');

INSERT INTO Teacher (teacher_id, first_name, last_name, email)
VALUES
(101, 'Karthik', 'Gupta', 'karthik.gupta@email.com'),
(102, 'Shalini', 'Verma', 'shalini.verma@email.com'),
(103, 'Manoj', 'Singh', 'manoj.singh@email.com'),
(104, 'Priya', 'Shah', 'priya.shah@email.com'),
(105, 'Suresh', 'Malhotra', 'suresh.malhotra@email.com'),
(106, 'Divya', 'Joshi', 'divya.joshi@email.com'),
(107, 'Rajesh', 'Sharma', 'rajesh.sharma@email.com'),
(108, 'Asha', 'Kumar', 'asha.kumar@email.com'),
(109, 'Vishnu', 'Patel', 'vishnu.patel@email.com'),
(110, 'Meera', 'Singh', 'meera.singh@email.com');

INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES
(1, 1, 500.00, '2024-04-02'),
(2, 2, 600.00, '2024-04-04'),
(3, 3, 700.00, '2024-04-06'),
(4, 4, 800.00, '2024-04-08'),
(5, 5, 900.00, '2024-04-10'),
(6, 6, 1000.00, '2024-04-12'),
(7, 7, 1100.00, '2024-04-14'),
(8, 8, 1200.00, '2024-04-16'),
(9, 9, 1300.00, '2024-04-18'),
(10, 10, 1400.00, '2024-04-20');

INSERT INTO Students (STUDENT_ID,first_name, last_name, date_of_birth, email, phone_number)
VALUES (11,'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');
INSERT INTO Enrollments (ENROLLMENT_ID,student_id, course_id, enrollment_date)
VALUES (11,1, 1, '2024-04-01');
UPDATE Teacher
SET email = 'new_email@example.com'
WHERE teacher_id = 1;
UPDATE Courses
SET teacher_id = 101
WHERE course_id = 3;
DELETE FROM Students
WHERE student_id = 4;

DELETE FROM Enrollments WHERE student_id = 4;
DELETE FROM Payments WHERE student_id = 4;

DELETE FROM Students WHERE student_id = 4;

UPDATE Payments
SET amount = 300.00
WHERE payment_id = 2;

-- TASK 3

SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payments
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 3;
SELECT C.COURSE_NAME , COUNT(E.STUDENT_ID)AS STUDENTENROLLED FROM COURSES C 
JOIN ENROLLMENTS E ON C.COURSE_ID=E.COURSE_ID GROUP BY C.COURSE_NAME;

SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
SELECT s.FIRST_NAME, s.LAST_NAME , c.COURSE_NAME FROM STUDENTS s 
INNER JOIN ENROLLMENTS e ON e.STUDENT_ID=s.STUDENT_ID 
INNER JOIN COURSES c  ON e.COURSE_ID = e.COURSE_ID;

SELECT TEACHER.FIRST_NAME,TEACHER.LAST_NAME, TEACHER.TEACHER_ID FROM TEACHER JOIN Courses ON COURSES.TEACHER_ID=TEACHER.TEACHER_ID;
SELECT STUDENTS.STUDENT_ID,STUDENTS.FIRST_NAME,STUDENTS.LAST_NAME FROM STUDENTS LEFT JOIN  PAYMENTS ON PAYMENTS.STUDENT_ID=STUDENTS.STUDENT_ID WHERE PAYMENTS.STUDENT_ID IS NULL;
SELECT COURSES.COURSE_NAME FROM COURSES JOIN ENROLLMENTS ON ENROLLMENTS.COURSE_ID=COURSES.COURSE_ID WHERE COURSES.COURSE_ID IS NULL;
SELECT one.student_id 
FROM enrollments AS one 
JOIN enrollments AS two ON one.student_id = two.enrollment_id 
GROUP BY  one.student_id 
HAVING COUNT(two.student_id)>1;
SELECT TEACHER.FIRST_NAME,TEACHER.LAST_NAME FROM TEACHER 
LEFT JOIN COURSES ON COURSES.TEACHER_ID=TEACHER.TEACHER_ID 
WHERE COURSES.TEACHER_ID IS NULL;

-- TASK 4

SELECT AVG(student_count) AS average_students_per_course
FROM (
    SELECT COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS course_enrollments;
SELECT S.FIRST_NAME,S.LAST_NAME,P.AMOUNT FROM STUDENTS S 
JOIN PAYMENTS P ON S.STUDENT_ID=P.STUDENT_ID 
WHERE P.AMOUNT = (SELECT MAX(AMOUNT) FROM PAYMENTS);
SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING enrollment_count = (SELECT MAX(enrollment_count) FROM (SELECT COUNT(student_id) AS enrollment_count FROM Enrollments GROUP BY course_id) AS max_enrollments);
SELECT t.first_name, t.last_name, SUM(p.amount) AS total_payments
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.first_name, t.last_name;
SELECT s.first_name, s.last_name
FROM Students s
WHERE (SELECT COUNT(DISTINCT course_id) FROM Courses) = (SELECT COUNT(DISTINCT course_id) FROM Enrollments WHERE student_id = s.student_id);
SELECT t.first_name, t.last_name
FROM Teacher t
WHERE t.teacher_id NOT IN (SELECT teacher_id FROM Courses);
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS average_age
FROM Students;
SELECT c.course_name
FROM Courses c
WHERE c.course_id NOT IN (SELECT course_id FROM Enrollments);
SELECT s.first_name, s.last_name, c.course_name, SUM(p.amount) AS total_payments
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.first_name, s.last_name, c.course_name;
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payments
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name, s.last_name;
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
SELECT AVG(amount) AS average_payment_amount
FROM Payments;


