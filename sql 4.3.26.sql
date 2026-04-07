create database stu_details;
use stu_details;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);
INSERT INTO students (student_id, student_name)
VALUES 
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50)
);
INSERT INTO courses (course_id, student_id, course_name)
VALUES
(101, 1, 'Math'),
(102, 2, 'Science'),
(103, 5, 'English');
select *from students;
select*from courses;
select*from students inner join courses on students.student_id=courses.student_id;		
select*from students left join courses on students.student_id=courses.student_id;
select*from students right join courses on students.student_id=courses.student_id;
select*from students left join courses on students.student_id=courses.student_id
union
select*from students right join courses on students.student_id=courses.student_id;


