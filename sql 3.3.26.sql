create database empl1_data;
use empl1_data;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10),
    department VARCHAR(30),
    designation VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    experience_years INT
);
INSERT INTO employees VALUES
(1,  'Amit',   'Male',   'HR',        'Manager',       75000, 'Delhi',      8),
(2,  'Sneha',  'Female', 'HR',        'Executive',     55000, 'Delhi',      3),
(3,  'Divya',  'Female', 'HR',        'Executive',     54000, 'Delhi',      2),
(4,  'Neha',   'Female', 'Finance',   'Analyst',       62000, 'Mumbai',     4),
(5,  'Karan',  'Male',   'Finance',   'Accountant',    58000, 'Mumbai',     3),
(6,  'Rahul',  'Male',   'Finance',   'Manager',       90000, 'Mumbai',    10),
(7,  'Meena',  'Female', 'Finance',   'Analyst',       61000, 'Mumbai',     5),
(8,  'Ravi',   'Male',   'IT',        'Developer',     85000, 'Bangalore',  6),
(9,  'Vikram', 'Male',   'IT',        'Developer',     88000, 'Hyderabad',  7),
(10, 'Rajesh', 'Male',   'IT',        'Manager',       95000, 'Hyderabad', 10),
(11, 'Pooja',  'Female', 'IT',        'Developer',     83000, 'Bangalore',  5),
(12, 'Manoj',  'Male',   'IT',        'Tester',        60000, 'Pune',       3),
(13, 'Priya',  'Female', 'Marketing', 'Manager',       72000, 'Chennai',    8),
(14, 'Anjali', 'Female', 'Marketing', 'Executive',     51000, 'Kolkata',    2),
(15, 'Suresh', 'Male',   'Marketing', 'Executive',     50000, 'Kolkata',    1);
## find the emp who earn the same salary as the highest paid hr emp
select max(salary) from employees where department='hr';
## find emp who work in same city as highest paid emp
select max(salary) from employees ;
select city from employees where salary=
(select max(salary) from employees );
 select emp_name ,department,salary,city from employees where city in (select city from employees where salary=(select max(salary) from employees ));
 ## find the emp who works in same depart as those located in mumbai
 ## emp whose salary is greater than any hr emp
 select salary from employees where department='hr';
 select emp_name,department,salary from employees where salary >any( select salary from employees where department='hr');
 ## emp whose salary is greater than the all hr emp 
  select emp_name,department,salary from employees where salary >all( select salary from employees where department='hr');
  ##emp who earn less than all it emp
  select salary from employees where department='it';
  select emp_name,department,salary from employees where salary < all (  select salary from employees where department='it');
  ## find emp whose is equal to any avg salary of each department
  select emp_name,department,salary from employees where salary= any(select avg(salary) from employees group by department );
  













