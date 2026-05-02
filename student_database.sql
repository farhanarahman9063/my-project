-- ================================================
--   Student Database Management System
--   Built by: Farhana Akter Mim
--   Language: SQL
-- ================================================


-- ================================================
--   STEP 1: CREATE TABLES
-- ================================================

-- Students table
CREATE TABLE students (
    student_id    INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    gender        ENUM('Male', 'Female', 'Other'),
    phone         VARCHAR(20),
    address       VARCHAR(200),
    enroll_date   DATE DEFAULT (CURRENT_DATE),
    status        ENUM('Active', 'Inactive', 'Graduated') DEFAULT 'Active'
);

-- Courses table
CREATE TABLE courses (
    course_id     INT PRIMARY KEY AUTO_INCREMENT,
    course_code   VARCHAR(10) UNIQUE NOT NULL,
    course_name   VARCHAR(100) NOT NULL,
    credits       INT NOT NULL,
    department    VARCHAR(50),
    instructor    VARCHAR(100),
    max_students  INT DEFAULT 30
);

-- Enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id    INT,
    course_id     INT,
    enroll_date   DATE DEFAULT (CURRENT_DATE),
    grade         DECIMAL(4,2),
    grade_letter  VARCHAR(2),
    semester      VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

-- Attendance table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id    INT,
    course_id     INT,
    attend_date   DATE,
    status        ENUM('Present', 'Absent', 'Late') DEFAULT 'Present',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);


-- ================================================
--   STEP 2: INSERT SAMPLE DATA
-- ================================================

-- Insert Students
INSERT INTO students (first_name, last_name, email, date_of_birth, gender, phone, enroll_date, status) VALUES
('Farhana',  'Akter',    'farhana@email.com',  '2000-03-15', 'Female', '01711-111111', '2023-01-10', 'Active'),
('Rahim',    'Uddin',    'rahim@email.com',    '1999-07-22', 'Male',   '01722-222222', '2023-01-10', 'Active'),
('Priya',    'Sen',      'priya@email.com',    '2001-11-05', 'Female', '01733-333333', '2023-02-01', 'Active'),
('Karim',    'Hossain',  'karim@email.com',    '2000-05-18', 'Male',   '01744-444444', '2023-02-01', 'Active'),
('Nadia',    'Islam',    'nadia@email.com',    '2001-09-30', 'Female', '01755-555555', '2023-03-05', 'Active'),
('Arif',     'Khan',     'arif@email.com',     '1998-12-12', 'Male',   '01766-666666', '2022-09-01', 'Graduated'),
('Sadia',    'Rahman',   'sadia@email.com',    '2002-04-25', 'Female', '01777-777777', '2023-06-01', 'Active'),
('Tanvir',   'Ahmed',    'tanvir@email.com',   '2000-08-14', 'Male',   '01788-888888', '2023-06-01', 'Active'),
('Mim',      'Begum',    'mim@email.com',      '2001-02-28', 'Female', '01799-999999', '2023-09-01', 'Active'),
('Rafi',     'Abdullah', 'rafi@email.com',     '1999-06-10', 'Male',   '01700-000000', '2022-09-01', 'Inactive');

-- Insert Courses
INSERT INTO courses (course_code, course_name, credits, department, instructor, max_students) VALUES
('CS101', 'Introduction to Programming',  3, 'Computer Science', 'Dr. Hassan',   40),
('CS201', 'Data Structures',              3, 'Computer Science', 'Dr. Akter',    35),
('CS301', 'Database Management',          3, 'Computer Science', 'Dr. Rahman',   30),
('MA101', 'Mathematics for CS',           3, 'Mathematics',      'Dr. Islam',    45),
('DA101', 'Introduction to Data Analysis',3, 'Data Science',     'Dr. Begum',    35),
('WD101', 'Web Development Basics',       3, 'Computer Science', 'Dr. Khan',     40),
('PY101', 'Python Programming',           3, 'Computer Science', 'Dr. Ahmed',    35),
('EN101', 'English Communication',        2, 'English',          'Dr. Hossain',  50);

-- Insert Enrollments
INSERT INTO enrollments (student_id, course_id, enroll_date, grade, grade_letter, semester) VALUES
(1, 1, '2023-01-15', 92.5, 'A+', 'Spring 2023'),
(1, 4, '2023-01-15', 88.0, 'A',  'Spring 2023'),
(1, 6, '2023-01-15', 95.0, 'A+', 'Spring 2023'),
(2, 1, '2023-01-15', 78.0, 'B+', 'Spring 2023'),
(2, 2, '2023-01-15', 82.5, 'A-', 'Spring 2023'),
(3, 1, '2023-02-05', 91.0, 'A+', 'Spring 2023'),
(3, 5, '2023-02-05', 87.5, 'A',  'Spring 2023'),
(4, 3, '2023-02-05', 74.0, 'B',  'Spring 2023'),
(4, 7, '2023-02-05', 85.0, 'A',  'Spring 2023'),
(5, 1, '2023-03-10', 96.0, 'A+', 'Spring 2023'),
(5, 4, '2023-03-10', 90.0, 'A+', 'Spring 2023'),
(7, 6, '2023-06-05', 88.0, 'A',  'Summer 2023'),
(7, 7, '2023-06-05', 92.0, 'A+', 'Summer 2023'),
(8, 2, '2023-06-05', 70.0, 'B-', 'Summer 2023'),
(8, 5, '2023-06-05', 83.0, 'A-', 'Summer 2023'),
(9, 1, '2023-09-05', 89.0, 'A',  'Fall 2023'),
(9, 8, '2023-09-05', 94.0, 'A+', 'Fall 2023');


-- ================================================
--   STEP 3: USEFUL QUERIES
-- ================================================

-- 1. View all students
SELECT * FROM students;

-- 2. View all active students
SELECT student_id, first_name, last_name, email, phone
FROM students
WHERE status = 'Active'
ORDER BY first_name;

-- 3. View all courses
SELECT * FROM courses ORDER BY department;

-- 4. View all enrollments with student and course names
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_name,
    e.grade,
    e.grade_letter,
    e.semester
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses  c ON e.course_id  = c.course_id
ORDER BY s.first_name;

-- 5. Top 5 students by average grade
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    ROUND(AVG(e.grade), 2) AS average_grade,
    COUNT(e.course_id)     AS courses_taken
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.student_id, student_name
ORDER BY average_grade DESC
LIMIT 5;

-- 6. Count students per course
SELECT
    c.course_code,
    c.course_name,
    COUNT(e.student_id) AS enrolled_students,
    c.max_students,
    ROUND((COUNT(e.student_id) / c.max_students) * 100, 1) AS fill_percentage
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
ORDER BY enrolled_students DESC;

-- 7. Students with A+ grades
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.grade,
    e.semester
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses  c ON e.course_id  = c.course_id
WHERE e.grade_letter = 'A+'
ORDER BY e.grade DESC;

-- 8. Students enrolled in more than 2 courses
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.course_id) AS total_courses
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
GROUP BY s.student_id, student_name
HAVING total_courses > 2
ORDER BY total_courses DESC;

-- 9. Department summary
SELECT
    department,
    COUNT(*) AS total_courses,
    SUM(credits) AS total_credits
FROM courses
GROUP BY department
ORDER BY total_courses DESC;

-- 10. Search student by name (example: search 'Farhana')
SELECT
    student_id, first_name, last_name,
    email, phone, status, enroll_date
FROM students
WHERE first_name LIKE '%Farhana%'
   OR last_name  LIKE '%Farhana%';


-- ================================================
--   STEP 4: UPDATE & DELETE EXAMPLES
-- ================================================

-- Update a student's status to Graduated
UPDATE students
SET status = 'Graduated'
WHERE student_id = 1;

-- Update a grade
UPDATE enrollments
SET grade = 95.0, grade_letter = 'A+'
WHERE enrollment_id = 1;

-- Delete an enrollment
DELETE FROM enrollments
WHERE enrollment_id = 17;

-- ================================================
--   END OF SCRIPT
--   Built by: Farhana Akter Mim
-- ================================================
