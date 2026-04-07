use hospital_db;
select disease,count(patient_id) from patients group by disease having count(patient_id) >2;
select treatment,sum(total_amount) from billing group by treatment having sum(total_amount)>2000;
select p.disease, avg(b.total_amount) from patients p join billing b on p.patient_id=b.patient_id group by p.disease having avg(b.total_amount)
>(select avg(total_amount) from billing);
select b.treatment,count(*) from billing b group by b.treatment having count(*)>
(select avg(cnt) from (select count(*) as cnt from billing) as t);
select disease,count(*) from patients group by disease order by count(*) desc limit 1;
select disease,count(*) from patients group by disease order by count(*) asc limit 1;
select treatment,sum(rn) over (order by rn desc) from 
(select treatment,sum(total_amount) as rn from billing group by treatment)t limit 1 ;
select treatment,sum(rn) over (order by rn asc) from 
(select treatment,sum(total_amount) as rn from billing group by treatment)t limit 1;
select patient_id ,total_amount from billing where total_amount>
(select avg(total_amount) from billing);
select patient_id ,total_amount from billing where total_amount=
(select max(total_amount) from billing);
select patient_id ,total_amount from billing where total_amount=
(select min(total_amount) from billing);
select disease,sum(total_amount) from patients p join billing b on p.patient_id=b.patient_id group by disease having sum(total_amount)=
(select max(sum_1) from
(select disease,sum(total_amount) as sum_1 from patients p join billing b on p.patient_id=b.patient_id group by disease)t);
(select min(sum_1) from
(select disease,sum(total_amount) as sum_1 from patients p join billing b on p.patient_id=b.patient_id group by disease)t);
select name,total_amount,rank() over(order by total_amount desc) from patients p join billing b on p.patient_id=b.patient_id;
select name,medicine_cost,rank() over(order by medicine_cost desc) from patients p join billing b on p.patient_id=b.patient_id;
select disease,sum(total_amount) ,rank()over(order by sum(total_amount) desc) from patients p join billing b on p.patient_id=b.patient_id group by disease ;
select treatment,sum(total_amount) ,rank()over(order by sum(total_amount) desc) from patients p join billing b on p.patient_id=b.patient_id group by treatment ;
select* from(select name,disease,total_amount,row_number() over(partition by disease order by total_amount) as rn from patients p join billing b on p.patient_id=b.patient_id) t where rn=1;
select* from(select treatment,disease,total_amount,row_number() over(partition by disease order by total_amount) as rn from patients p join billing b on p.patient_id=b.patient_id) t where rn=1;
select* from(select name,disease,total_amount,row_number() over(partition by disease order by total_amount) as rn from patients p join billing b on p.patient_id=b.patient_id) t where rn=2;
select* from(select name,disease,total_amount,row_number() over(partition by disease order by total_amount) as rn from patients p join billing b on p.patient_id=b.patient_id) t where rn=3;
select bill_id,total_amount,sum(total_amount)over(order by bill_id) as running_revenue from billing;
select treatment,total_amount,sum(total_amount)over(partition by treatment order by bill_id) as running_revenue from billing;
select disease,total_amount,sum(total_amount)over(partition by disease order by bill_id) as running_revenue from billing;
select bill_id,total_amount-avg(total_amount)over(order by bill_id ) from billing;
select bill_id,disease,total_amount-avg(total_amount)over(partition by disease ) from patients p join billing b on p.patient_id=b.patient_id order by bill_id asc;
select bill_id,total_amount*100/sum(total_amount) over()as percen from billing;
select disease,sum(total_amount)*100/sum(sum(total_amount)) over( )as percen from patients p join billing b on p.patient_id=b.patient_id group by disease;
select treatment,sum(total_amount)*100/sum(sum(total_amount)) over( )as percen from patients p join billing b on p.patient_id=b.patient_id group by treatment;
select* from(select p.name,sum(b.total_amount) ,rank()over( order by sum(b.total_amount) desc) as rn from patients p join billing b on p.patient_id=b.patient_id group by p.name) t where rn=1;
select* from(select disease,sum(b.total_amount) ,rank()over( order by sum(b.total_amount) desc) as rn from patients p join billing b on p.patient_id=b.patient_id group by disease) t where rn=1;
SELECT p.name,p.disease,b.total_amount FROM patients p JOIN billing b ON p.patient_id = b.patient_id WHERE b.total_amount >
(
SELECT AVG(b2.total_amount) FROM patients p2 JOIN billing b2 ON p2.patient_id = b2.patient_id WHERE p2.disease = p.disease
);

