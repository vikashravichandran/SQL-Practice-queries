USE hospital_db;
select name,total_amount from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,treatment from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,doctor_fee from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,medicine_cost from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,payment_status from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,disease,treatment from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,age,total_amount from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,admission_date,total_amount from patients  inner join billing on patients.patient_id=billing.patient_id;
select name,total_amount from patients p inner join billing b on p.patient_id=b.patient_id where b.payment_status='pending';
select name,total_amount from patients p inner join billing b on p.patient_id=b.patient_id where b.payment_status='paid';
select name,total_amount from patients p inner join billing b on p.patient_id=b.patient_id where b.total_amount>1000;
select name,total_amount from patients p inner join billing b on p.patient_id=b.patient_id where b.total_amount<800;
select name,total_amount from patients p join billing b on p.patient_id=b.patient_id where b.total_amount=(select max(total_amount)  from  billing b );
select name,total_amount from patients p join billing b on p.patient_id=b.patient_id where b.total_amount=(select min(total_amount)  from  billing b );
select name,total_amount from patients p join billing b on p.patient_id=b.patient_id where b.total_amount>(select avg(total_amount)  from  billing b );
select disease,sum(total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease order by sum(total_amount) desc limit 1;
select disease,sum(total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease order by sum(total_amount) asc limit 1;
select p.disease,sum(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease;
select p.disease,avg(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease;
select p.disease,max(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease;
select p.disease,min(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease;
select p.disease,min(treatment) from patients p join billing b on p.patient_id=b.patient_id group by disease order by sum(total_amount) desc limit 1;
select p.disease,max(treatment) from patients p join billing b on p.patient_id=b.patient_id group by disease order by sum(total_amount) desc limit 1;
select p.name,b.treatment,p.disease from patients p join billing b on p.patient_id=b.patient_id where p.disease='heart issue';
select p.name,b.treatment,p.disease from patients p join billing b on p.patient_id=b.patient_id where p.disease='fever';
select  p.name,p.gender,b.payment_status from patients p join billing b on p.patient_id=b.patient_id where p.gender='female' and b.payment_status='pending';
select  p.name,p.gender,b.payment_status from patients p join billing b on p.patient_id=b.patient_id where p.gender='male' and b.payment_status='paid';
select p.name,sum(total_amount) from patients p join billing b on p.patient_id=b.patient_id group by p.naame;
select p.name,max(medicine_cost) from patients p join billing b on p.patient_id=b.patient_id group by p.name order by max(medicine_cost) desc limit 1;
select p.name,max(doctor_fee) from patients p join billing b on p.patient_id=b.patient_id group by p.name order by max(doctor_fee) desc limit 1;
select p.name,sum(total_amount) as high_spend from patients p join billing b on p.patient_id=b.patient_id group by p.name  order by sum(total_amount) desc limit 1 ;
select p.name,sum(total_amount) as low_spend from patients p join billing b on p.patient_id=b.patient_id group by p.name  order by sum(total_amount)  limit 1 ;
select p.name,count(b.treatment) from  patients p join billing b on p.patient_id=b.patient_id group by p.name having count(b.treatment)>1;
select b.treatment,count(p.disease) from patients p join billing b on p.patient_id=b.patient_id group by  b.treatment having count(p.disease)>1;
select b.treatment,count(p.disease) from patients p join billing b on p.patient_id=b.patient_id group by  b.treatment having count(p.disease)=1;
select p.name,b.total_amount,p.admission_date from  patients p join billing b on p.patient_id=b.patient_id where p.admission_date between '2026-01-01'and '2026-01-31' and b.total_amount>1000;
select p.name,b.total_amount,p.admission_date from  patients p join billing b on p.patient_id=b.patient_id where p.admission_date between '2026-02-01'and '2026-02-31' and b.total_amount<800;
select p.name,p.disease,b.treatment from patients p join billing b on p.patient_id=b.patient_id where b.treatment like '%treatment';
select p.name,p.disease,b.treatment from patients p join billing b on p.patient_id=b.patient_id where b.treatment  not like '%treatment';
select p.name,sum(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by p.name order by sum(b.total_amount) desc limit 1;
select p.name,b.total_amount,rank() over( order by b.total_amount desc) as rank_pat from patients p join billing b on p.patient_id=b.patient_id;
select p.name,b.medicine_cost,rank() over( order by b.medicine_cost desc) as rank_pat from patients p join billing b on p.patient_id=b.patient_id;
select p.name,b.doctor_fee,rank() over( order by b.medicine_cost desc) as rank_pat from patients p join billing b on p.patient_id=b.patient_id;
select p.name,p.disease,b.total_amount,rank() over( partition by p.disease order by b.total_amount desc) as rank_pat from patients p join billing b on p.patient_id=b.patient_id;
select p.name,b.treatment,b.total_amount,rank() over( partition by b.treatment order by b.total_amount desc) as rank_pat from patients p join billing b on p.patient_id=b.patient_id;
select p.name,p.disease,b.total_amount from patients p join billing b on p.patient_id=b.patient_id where b.total_amount=(select max(b.total_amount) from billing b) ;
select p.name,p.disease,b.total_amount from patients p join billing b on p.patient_id=b.patient_id where b.total_amount=(select min(b.total_amount) from billing b ) ;
select p.name,sum(b.total_amount) over(order by sum(b.total_amount) ) as cumm_pat from patients p join billing b on p.patient_id=b.patient_id ;









