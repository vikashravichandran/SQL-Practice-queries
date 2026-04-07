CREATE DATABASE hospital_db;
USE hospital_db;
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    disease VARCHAR(100),
    admission_date DATE
);

INSERT INTO patients VALUES
(1,'Arun Kumar',34,'Male','9876543210','Fever','2026-01-10'),
(2,'Priya Sharma',28,'Female','9876543211','Diabetes','2026-01-12'),
(3,'Rahul Das',45,'Male','9876543212','Heart Issue','2026-01-15'),
(4,'Meena Devi',30,'Female','9876543213','Migraine','2026-01-18'),
(5,'Suresh Patel',52,'Male','9876543214','BP','2026-01-20'),
(6,'Anita Roy',26,'Female','9876543215','Fever','2026-01-22'),
(7,'Karan Singh',40,'Male','9876543216','Asthma','2026-01-25'),
(8,'Neha Gupta',33,'Female','9876543217','Allergy','2026-01-26'),
(9,'Ravi Verma',60,'Male','9876543218','Diabetes','2026-01-27'),
(10,'Pooja Mehta',22,'Female','9876543219','Cold','2026-01-28'),
(11,'Ajay Kumar',36,'Male','9876543220','Fever','2026-02-01'),
(12,'Sneha Reddy',29,'Female','9876543221','Skin Infection','2026-02-02'),
(13,'Vikram Rao',50,'Male','9876543222','Heart Issue','2026-02-03'),
(14,'Deepa Iyer',41,'Female','9876543223','BP','2026-02-05'),
(15,'Ramesh Gupta',55,'Male','9876543224','Diabetes','2026-02-07'),
(16,'Kavita Joshi',31,'Female','9876543225','Migraine','2026-02-09'),
(17,'Manoj Sharma',48,'Male','9876543226','Asthma','2026-02-11'),
(18,'Sunita Nair',38,'Female','9876543227','Fever','2026-02-12'),
(19,'Harish Patel',44,'Male','9876543228','Allergy','2026-02-13'),
(20,'Lakshmi Devi',35,'Female','9876543229','Cold','2026-02-14');
##  SECTION 1
select sum(patient_id) from patients;
select avg(age) from patients;
select max(age)from patients;
select min(age) from patients;
select count(patient_id),disease from patients group by disease;
select disease from patients group by disease having count(patient_id)>2;
select disease from patients group by disease having count(patient_id)=1;
select disease from patients group by disease order by count(patient_id)desc limit 1;
select disease from patients group by disease order by count(patient_id)asc limit 1;
select disease from patients group by disease having avg(age)>40;
select disease from patients group by disease having max(age)>50;
select disease from patients group by disease having min(age)<30;
select admission_date from patients group by admission_date having count(*)>1;
select count(patient_id),(admission_date) from patients group by (admission_date);
select count(patient_id),month (admission_date) from patients group by month(admission_date);
select admission_date from patients order by admission_date asc limit 1;
select admission_date from patients order by admission_date desc limit 1;
select patient_id,name,admission_date from patients where admission_date<'2026-02-01';
select patient_id,name,admission_date from patients where admission_date>'2026-01-25';
select patient_id,name,admission_date from patients where admission_date between '2026-1-15' and '2026-2-5';
select disease,sum(age) from patients group by disease having sum(age)>100;
select disease,avg(age) from patients group by disease having avg(age)>(select avg(age) from patients);
select *from patients where age>(select avg(age) from patients);
select *from patients where age<(select avg(age) from patients);
select *from patients where age=(select avg(age) from patients);
select disease,count(patient_id) as tol_pat from patients group by disease having tol_pat>1;
select patient_id,name from patients where disease like '%Heart%';
select patient_id,name from patients where disease like '%allergy%';
select disease from patients where disease like 'a%'; 
select disease from patients where disease like '%s'; 
select disease from patients group by disease having count(patient_id)=2;
select disease,sum(gender='male') as male,sum(gender='female') as female from patients group by disease having male>female;
select disease,sum(gender='male') as male,sum(gender='female') as female from patients group by disease having female>male;
select disease,sum(gender='male') as male,sum(gender='female') as female from patients group by disease having male=female;
select disease from patients group by disease having avg(age)>35;
select disease,count(patient_id),rank()over (order by count(patient_id) desc) as dis_rank  from patients group by disease ; 
select disease,count(patient_id) from patients group by disease order by count(patient_id) desc limit 3 ;
select disease,count(patient_id) from patients group by disease order by count(patient_id) asc limit 3 ;
select disease from patients group by disease having count(disease)>1;
select distinct disease from patients;
select patient_id,length(name) from patients where length(name)=(select max(length(name)) from patients);
select patient_id,length(name) from patients where length(name)=(select min(length(name)) from patients);
select patient_id,name from patients where admission_date=(select admission_date from patients group by admission_date having count(patient_id)>1);
select disease,count(disease) as one_dise from patients group by disease having one_dise=1;
select disease,count(disease) as one_dise from patients group by disease having one_dise>1;
select patient_id,name,age from patients where age=(select max(age) from patients);
select patient_id,name,age from patients where age=(select min(age) from patients);
select name,patient_id from patients where admission_date=(select min(admission_date) from patients);
select name,patient_id from patients where admission_date=(select max(admission_date) from patients);
select name,patient_id,age,rank() over ( order by age desc) as rank_pat from patients;
select name,patient_id,age from patients order by age limit 5;
select name,patient_id,age from patients order by age desc limit 5;
select admission_date,count(patient_id)  over( order by  admission_date ) from patients;
select name,count(patient_id) over(order by patient_id )as cummulative_pat  from patients;
select age,name from patients where age=(select avg(age) from patients);
select name,patient_id,age,age-avg(age) over() as diff_age from patients;
select disease,count(patient_id)*100/sum(count(patient_id)) over () as per_pat from patients group by disease;
select disease,patient_id,age,rank() over(partition by disease order by age) as rank_pat from patients ;
select* from(select name,disease,admission_date,rank() over( partition by disease,name order by admission_date ) as rn from patients) as t where rn=1  ;
select name,disease,admission_date,rank() over( partition by disease,name order by admission_date ) as rn from patients;
select disease,avg(age) from patients group by disease order by avg(age) desc limit 1;
