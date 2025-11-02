-- ==========================================================
-- SCHOOL MANAGEMENT DATABASE SCHEMA (DBMS PROJECT)
-- MySQL Syntax
-- Focused on ONE Class (B.Tech CSE - 1st Year) with 20 Students
-- ==========================================================
DROP DATABASE IF EXISTS SchoolManagementDB;
-- Create the new database
CREATE DATABASE SchoolManagementDB;

-- Select the database for use
USE SchoolManagementDB;



-- 2.1. CLASSES Table: Holds different grades/classes
CREATE TABLE Classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL UNIQUE,
    class_teacher_id INT NULL
);

-- 2.2. STUDENTS Table: Holds student personal information
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    admission_date DATE NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- 2.3. TEACHERS Table: Holds teacher personal information
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_join DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15)
);

ALTER TABLE Classes
ADD FOREIGN KEY (class_teacher_id) REFERENCES Teachers(teacher_id);


-- 2.4. SUBJECTS Table: List of all subjects taught (CSE focused)
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2.5. CLASS_SUBJECTS Table: Links which subjects belong to which class
CREATE TABLE ClassSubjects (
    class_subject_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    UNIQUE KEY uk_class_subject (class_id, subject_id)
);

-- 2.6. TEACHER_ASSIGNMENTS Table: Who teaches which subject to which class
CREATE TABLE TeacherAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT NOT NULL,
    class_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    UNIQUE KEY uk_teacher_class_subject (teacher_id, class_id, subject_id)
);

-- 2.7. ATTENDANCE Table: Records student attendance for a specific date
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    UNIQUE KEY uk_student_date (student_id, attendance_date)
);

-- 2.8. EXAMS Table: Defines different exam types and dates
CREATE TABLE Exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_name VARCHAR(100) NOT NULL,
    exam_date DATE NOT NULL
);

-- 2.9. RESULTS Table: Stores the marks obtained by a student in a specific exam and subject
CREATE TABLE Results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks_obtained DECIMAL(5, 2) NOT NULL,
    max_marks INT NOT NULL DEFAULT 100,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    UNIQUE KEY uk_student_exam_subject (student_id, exam_id, subject_id)
);

-- ==========================================================
-- 3. DML (DATA MANIPULATION LANGUAGE) - SAMPLE DATA INSERTION
-- All data centralized for the single B.Tech CSE - 1st Year class.
-- ==========================================================

-- 3.1. Insert Teachers (6 Teachers)
INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Aarav', 'Mehta', '2015-07-20', 'aarav.mehta@school.edu', '9812011001'); -- teacher_id 1

INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Priya', 'Sharma', '2018-08-15', 'priya.sharma@school.edu', '9812011002'); -- teacher_id 2

INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Rajesh', 'Kumar', '2019-01-10', 'rajesh.kumar@school.edu', '9812011003'); -- teacher_id 3

INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Sonia', 'Verma', '2021-03-01', 'sonia.verma@school.edu', '9812011004'); -- teacher_id 4

INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Vikram', 'Singh', '2017-11-25', 'vikram.singh@school.edu', '9812011005'); -- teacher_id 5

INSERT INTO Teachers (first_name, last_name, date_of_join, email, phone_number)
VALUES ('Neelam', 'Yadav', '2022-06-10', 'neelam.yadav@school.edu', '9812011006'); -- teacher_id 6


-- 3.2. Insert Classes (1 Class)
INSERT INTO Classes (class_name)
VALUES ('B.Tech CSE - 1st Year'); -- class_id 1 (The only class)

-- Update the Class with its Class Teacher
UPDATE Classes SET class_teacher_id = 1 WHERE class_name = 'B.Tech CSE - 1st Year'; -- Aarav Mehta (1)


-- 3.3. Insert Subjects (4 Core CSE Subjects)
INSERT INTO Subjects (subject_name) VALUES ('Data Structures');       -- subject_id 1
INSERT INTO Subjects (subject_name) VALUES ('Discrete Mathematics');  -- subject_id 2
INSERT INTO Subjects (subject_name) VALUES ('Programming in Python'); -- subject_id 3
INSERT INTO Subjects (subject_name) VALUES ('English Communication'); -- subject_id 4

-- Keeping unused subjects for future expansion if needed, but not linked to class:
INSERT INTO Subjects (subject_name) VALUES ('Accountancy'); -- subject_id 5 (Unused in Class 1)
INSERT INTO Subjects (subject_name) VALUES ('Economics');   -- subject_id 6 (Unused in Class 1)
INSERT INTO Subjects (subject_name) VALUES ('History');     -- subject_id 7 (Unused in Class 1)
INSERT INTO Subjects (subject_name) VALUES ('Computer Science Theory'); -- subject_id 8 (Unused in Class 1)


-- 3.4. Insert ClassSubjects (4 Mappings for Class 1)
-- B.Tech CSE - 1st Year (ID 1) subjects: 1, 2, 3, 4
INSERT INTO ClassSubjects (class_id, subject_id) VALUES (1, 1); -- Data Structures
INSERT INTO ClassSubjects (class_id, subject_id) VALUES (1, 2); -- Discrete Mathematics
INSERT INTO ClassSubjects (class_id, subject_id) VALUES (1, 3); -- Programming in Python
INSERT INTO ClassSubjects (class_id, subject_id) VALUES (1, 4); -- English Communication


-- 3.5. Insert Teacher Assignments (4 Assignments for Class 1)
INSERT INTO TeacherAssignments (teacher_id, class_id, subject_id) VALUES (2, 1, 1); -- Priya Sharma (Data Structures)
INSERT INTO TeacherAssignments (teacher_id, class_id, subject_id) VALUES (5, 1, 2); -- Vikram Singh (Discrete Math)
INSERT INTO TeacherAssignments (teacher_id, class_id, subject_id) VALUES (1, 1, 3); -- Aarav Mehta (Python)
INSERT INTO TeacherAssignments (teacher_id, class_id, subject_id) VALUES (4, 1, 4); -- Sonia Verma (English)


-- 3.6. Insert Students (20 Students, all in Class 1)
-- Student IDs 1-20. All class_id = 1.
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Rohan', 'Gupta', '2004-03-10', 'Male', '2023-07-15', 1); -- id 1
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Anjali', 'Verma', '2004-08-25', 'Female', '2023-07-15', 1); -- id 2
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Kunal', 'Jain', '2003-11-01', 'Male', '2023-08-01', 1); -- id 3
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Neha', 'Singh', '2004-01-12', 'Female', '2023-07-15', 1); -- id 4
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Vivek', 'Reddy', '2003-05-30', 'Male', '2023-07-16', 1); -- id 5
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Shruti', 'Patel', '2004-04-18', 'Female', '2023-07-15', 1); -- id 6
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Manish', 'Tiwari', '2003-12-05', 'Male', '2023-07-15', 1); -- id 7
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Deepika', 'Yadav', '2004-02-28', 'Female', '2023-08-01', 1); -- id 8
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Gaurav', 'Das', '2003-10-10', 'Male', '2023-07-15', 1); -- id 9
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Sanya', 'Malik', '2004-06-03', 'Female', '2023-07-16', 1); -- id 10
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Akash', 'Choudhary', '2003-07-01', 'Male', '2022-07-20', 1); -- id 11
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Diya', 'Saxena', '2003-10-14', 'Female', '2022-07-20', 1); -- id 12
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Harman', 'Kaur', '2003-09-09', 'Female', '2022-07-25', 1); -- id 13
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Ishaan', 'Walia', '2004-01-20', 'Male', '2022-07-20', 1); -- id 14
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Jiya', 'Bhatia', '2003-12-04', 'Female', '2022-08-01', 1); -- id 15
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Aryan', 'Dutt', '2002-06-16', 'Male', '2021-07-10', 1); -- id 16
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Palak', 'Goel', '2002-09-29', 'Female', '2021-07-10', 1); -- id 17
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Samar', 'Khanna', '2003-02-05', 'Male', '2021-07-15', 1); -- id 18
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Tanya', 'Sood', '2002-11-19', 'Female', '2021-07-10', 1); -- id 19
INSERT INTO Students (first_name, last_name, date_of_birth, gender, admission_date, class_id) VALUES ('Zafar', 'Khan', '2003-01-01', 'Male', '2021-08-01', 1); -- id 20
select * FROM Students;

-- 3.7. Insert Exams (2 Exams)
INSERT INTO Exams (exam_name, exam_date)
VALUES ('Semester 1 Mid-Term 2025', '2025-10-15'); -- exam_id 1

INSERT INTO Exams (exam_name, exam_date)
VALUES ('Semester 1 Final 2026', '2026-03-01'); -- exam_id 2


-- 3.8. Insert Attendance (30 Attendance Records)
-- Data for all 20 students on at least one day
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (1, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (2, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (3, '2025-09-01', 'Absent');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (4, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (5, '2025-09-01', 'Late');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (6, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (7, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (8, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (9, '2025-09-01', 'Absent');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (10, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (11, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (12, '2025-09-01', 'Late');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (13, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (14, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (15, '2025-09-01', 'Absent');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (16, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (17, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (18, '2025-09-01', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (19, '2025-09-01', 'Late');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (20, '2025-09-01', 'Present');

-- Attendance for a second day (to allow for querying changes)
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (1, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (3, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (5, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (7, '2025-09-02', 'Absent');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (9, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (11, '2025-09-02', 'Late');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (13, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (15, '2025-09-02', 'Present');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (17, '2025-09-02', 'Absent');
INSERT INTO Attendance (student_id, attendance_date, status) VALUES (19, '2025-09-02', 'Present');


-- 3.9. Insert Results (80 Results for Exam 1 - 20 students * 4 subjects)
-- Subjects: 1-Data Structures, 2-Discrete Math, 3-Python, 4-English
-- Student 1 (Rohan Gupta)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (1, 1, 1, 75.5, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (1, 1, 2, 88.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (1, 1, 3, 91.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (1, 1, 4, 82.0, 100);

-- Student 2 (Anjali Verma)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (2, 1, 1, 85.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (2, 1, 2, 79.5, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (2, 1, 3, 94.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (2, 1, 4, 90.0, 100);

-- Student 3 (Kunal Jain)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (3, 1, 1, 65.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (3, 1, 2, 70.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (3, 1, 3, 62.5, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (3, 1, 4, 71.0, 100);

-- Student 4 (Neha Singh)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (4, 1, 1, 80.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (4, 1, 2, 85.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (4, 1, 3, 78.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (4, 1, 4, 88.0, 100);

-- Student 5 (Vivek Reddy)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (5, 1, 1, 78.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (5, 1, 2, 74.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (5, 1, 3, 75.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (5, 1, 4, 69.0, 100);

-- Student 6 (Shruti Patel)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (6, 1, 1, 89.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (6, 1, 2, 85.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (6, 1, 3, 87.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (6, 1, 4, 80.0, 100);

-- Student 7 (Manish Tiwari)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (7, 1, 1, 68.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (7, 1, 2, 75.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (7, 1, 3, 78.5, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (7, 1, 4, 65.0, 100);

-- Student 8 (Deepika Yadav)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (8, 1, 1, 95.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (8, 1, 2, 91.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (8, 1, 3, 92.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (8, 1, 4, 98.0, 100);

-- Student 9 (Gaurav Das)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (9, 1, 1, 70.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (9, 1, 2, 68.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (9, 1, 3, 65.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (9, 1, 4, 72.0, 100);

-- Student 10 (Sanya Malik)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (10, 1, 1, 85.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (10, 1, 2, 90.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (10, 1, 3, 88.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (10, 1, 4, 85.0, 100);

-- Student 11 (Akash Choudhary)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (11, 1, 1, 80.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (11, 1, 2, 75.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (11, 1, 3, 72.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (11, 1, 4, 81.0, 100);

-- Student 12 (Diya Saxena)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (12, 1, 1, 89.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (12, 1, 2, 95.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (12, 1, 3, 91.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (12, 1, 4, 88.0, 100);

-- Student 13 (Harman Kaur)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (13, 1, 1, 65.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (13, 1, 2, 78.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (13, 1, 3, 70.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (13, 1, 4, 75.0, 100);

-- Student 14 (Ishaan Walia)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (14, 1, 1, 60.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (14, 1, 2, 62.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (14, 1, 3, 58.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (14, 1, 4, 65.0, 100);

-- Student 15 (Jiya Bhatia)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (15, 1, 1, 82.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (15, 1, 2, 80.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (15, 1, 3, 85.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (15, 1, 4, 89.0, 100);

-- Student 16 (Aryan Dutt)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (16, 1, 1, 84.5, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (16, 1, 2, 79.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (16, 1, 3, 88.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (16, 1, 4, 91.0, 100);

-- Student 17 (Palak Goel)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (17, 1, 1, 75.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (17, 1, 2, 80.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (17, 1, 3, 78.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (17, 1, 4, 82.0, 100);

-- Student 18 (Samar Khanna)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (18, 1, 1, 90.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (18, 1, 2, 93.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (18, 1, 3, 88.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (18, 1, 4, 95.0, 100);

-- Student 19 (Tanya Sood)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (19, 1, 1, 68.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (19, 1, 2, 72.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (19, 1, 3, 65.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (19, 1, 4, 70.0, 100);

-- Student 20 (Zafar Khan)
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (20, 1, 1, 75.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (20, 1, 2, 80.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (20, 1, 3, 78.0, 100);
INSERT INTO Results (student_id, exam_id, subject_id, marks_obtained, max_marks) VALUES (20, 1, 4, 85.0, 100);

-- ==========================================================
-- 4. EXAMPLE REPORT GENERATION QUERY (For your project presentation)
-- Calculates the Semester GPA/Percentage for all 20 students.
-- ==========================================================
SELECT * FROM Teachers;

-- 3. View the single class record
SELECT * FROM Classes;


-- ===============================================
-- II. CURRICULUM DEFINITION TABLES
-- ===============================================

-- 4. View all subjects available
SELECT * FROM Subjects;

-- 5. View which subjects are assigned to the class
SELECT * FROM ClassSubjects;


-- ===============================================
-- III. RECORDS AND PERFORMANCE TABLES
-- ===============================================

-- 6. View all teacher assignments (Who teaches What to Whom)
SELECT * FROM TeacherAssignments;

-- 7. View all exam definitions (e.g., Mid-Term, Final)
SELECT * FROM Exams;

-- 8. View all attendance records
SELECT * FROM Attendance;

-- 9. View all individual result entries (marks for specific student/exam/subject)
SELECT * FROM Results;

SELECT
    S.student_id,
    S.first_name,
    S.last_name,
    C.class_name,
    E.exam_name,
    SUM(R.marks_obtained) AS total_marks_obtained,
    SUM(R.max_marks) AS total_max_marks,
    -- Calculate overall percentage for the exam
    CONCAT(ROUND((SUM(R.marks_obtained) / SUM(R.max_marks)) * 100, 2), '%') AS overall_percentage
FROM
    Results R
JOIN
    Students S ON R.student_id = S.student_id
JOIN
    Classes C ON S.class_id = C.class_id
JOIN
    Exams E ON R.exam_id = E.exam_id
WHERE
    E.exam_id = 1 -- Focusing on the Semester 1 Mid-Term
GROUP BY
    S.student_id, S.first_name, S.last_name, C.class_name, E.exam_name
ORDER BY
    overall_percentage DESC;
