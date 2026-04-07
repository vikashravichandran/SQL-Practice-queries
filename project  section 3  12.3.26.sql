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
select* from
(select p.name,sum(b.total_amount) ,rank()over( order by sum(b.total_amount) desc) as rn from patients p join billing b on p.patient_id=b.patient_id group by p.name) t where rn=1;
select* from
(select treatment,sum(b.total_amount) ,rank()over( order by sum(b.total_amount) desc) as rn from patients p join billing b on p.patient_id=b.patient_id group by treatment) t where rn=1;
select* from
(select disease,sum(b.total_amount) ,rank()over( order by sum(b.total_amount) desc) as rn from patients p join billing b on p.patient_id=b.patient_id group by disease) t where rn=1;
SELECT p.name,p.disease,b.total_amount FROM patients p JOIN billing b ON p.patient_id = b.patient_id WHERE b.total_amount >
(
SELECT AVG(b2.total_amount) FROM patients p2 JOIN billing b2 ON p2.patient_id = b2.patient_id WHERE p2.disease = p.disease
);
select * from(select p.name,b.total_amount,avg(b.total_amount) over(partition by p.disease) as average  from patients p join billing b on
b.patient_id=p.patient_id) as j where total_amount>average;

select * from(select p.name,b.total_amount,avg(b.total_amount) over(partition by p.disease) as average  from patients p join billing b on
b.patient_id=p.patient_id) as j where total_amount<average;

select * from(select treatment,sum(total_amount) as total from billing group by treatment) as j where total>(select avg(total_amount) from billing);

select * from(select p.disease,sum(b.total_amount) as total from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j
where total>(select avg(total_amount) from billing);

select *  from(select p.name,b.total_amount as total,b.treatment,avg(b.total_amount) over(partition by b.treatment) as average from billing b join patients p on
b.patient_id=p.patient_id) as j where total>average;

select *  from(select p.name,b.total_amount as total,b.treatment,avg(b.total_amount) over(partition by b.treatment) as average from billing b join patients p on
b.patient_id=p.patient_id) as j where total<average;

select * from(select p.disease,count(b.total_amount) as total from billing b join patients p on p.patient_id=b.patient_id group by p.disease) as j 
where total>(select avg(bill) from (select count(b.total_amount) as bill from billing b join patients p on p.patient_id=b.patient_id group by p.disease) as s);
select * from(select treatment,count(total_amount) as total from billing group by treatment) as j
where total>(select avg(bill) from(select count(total_amount) as bill from billing group by treatment) as s);

select * from(select p.disease,sum(b.total_amount) as total from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j
where total>(select sum(total_amount) as bill from billing where treatment='fever');
select * from(select treatment,sum(total_amount) as total from billing group by treatment) as j  
where total>(select sum(total_amount) from billing where treatment='cold' group by treatment);
 
with med_no as(select disease,count(name) as patient_count from patients group by disease),
med_noo as (select avg(patient_count) as median from(select patient_count,row_number() over(order by patient_count) as asc_no,
row_number() over(order by patient_count desc) as des_no from med_no) as j where asc_no=des_no or asc_no + 1=des_no)
select * from med_no where patient_count > (select median from med_noo);

with treat as(select treatment,sum(total_amount) as total from billing group by treatment),
treat_no as (select avg(total) as treat_noo from (select total,row_number() over(order by total) as asc_no,
row_number() over(order by total desc) as des_no from treat) as j where asc_no=des_no or asc_no + 1=des_no) 
select * from treat where total>(select treat_noo from treat_no);

select p.disease,b.treatment, rank() over(partition by disease order by total_amount) as rank_no from billing b join patients p on 
b.patient_id=p.patient_id;
select name,disease,total,rank() over(partition by disease order by total) as rank_no from(select p.disease,p.name,sum(b.total_amount) as total 
from patients p join billing b on b.patient_id=p.patient_id group by p.name,p.disease) as s;

select disease,gender,total from(select p.gender,p.disease,sum(b.total_amount) as total 
from patients p join billing b on b.patient_id=p.patient_id group by p.gender,p.disease) as j;

select disease,total, rank() over(order by total desc) as rank_no from(select disease,count(name) as total from patients group by disease) as j;

select disease,total,rank() over(order by total desc) as rank_no from(select p.disease,sum(b.total_amount) as total
from patients p join billing b on b.patient_id=p.patient_id group by p.disease) as   j;

select treatment,total,rank() over(order by total desc) as rank_no from(select treatment,sum(total_amount) as total from billing group by treatment) as j;
select total_amount,avg(total_amount) over(order by total_amount,patient_id) as rank_no from billing;

select medicine_cost,avg(medicine_cost) over(order by medicine_cost,patient_id) as rank_no from billing;

select doctor_fee,avg(doctor_fee) over(order by doctor_fee,patient_id) as rank_no from billing;

select * from(select p.name,b.total_amount,avg(b.total_amount) over(order by total_amount) as total from billing b join patients p on
b.patient_id=p.patient_id) as j where total_amount>total;

select * from(select treatment,sum(total_amount) as total from billing group by treatment) as s where 
total>(select avg(bill) from(select sum(total_amount) as bill from billing group by treatment) as j);

select * from(select p.disease,sum(b.total_amount) as total from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as s
where total>(select avg(bill) from(select sum(b.total_amount) as bill from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j);

select total_amount,lag_no,total_amount-lag_no as difference from(select total_amount,lag(total_amount) over(order by total_amount) as lag_no from billing) as j;

select total_amount,lead_no,total_amount-lead_no as difference from(select total_amount,lead(total_amount) over(order by total_amount) as lead_no from billing) as j;

select total_amount,lag_no,total_amount-lag_no as difference from
(select b.total_amount,lag(b.total_amount) over(order by p.admission_date) as lag_no from billing b join patients p on b.patient_id=p.patient_id) as j;

select treatment,total,total-lag(total) over(order by treatment) as difference from(select treatment,sum(total_amount) as total
from billing group by treatment) as j;

select treatment,total,total-lag(total) over(order by treatment) as difference from(select treatment,sum(total_amount) as total
from billing group by treatment) as j;

select patient_id,total,total-lag(total) over(order by patient_id) as difference from(select patient_id,sum(total_amount) as total from billing group by patient_id) as j;

select disease,total,total-lag(total) over(order by total) as difference from(select p.disease,sum(b.total_amount) as total 
from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j;

select treatment,total,total>lag(total) over(order by total) as difference from(select treatment,sum(total_amount) as total
from billing group by treatment) as j;

select treatment,total,total<lag(total) over(order by total) as difference from(select treatment,sum(total_amount) as total
from billing group by treatment) as j;

select patient_id,total,total>lag(total) over(order by total) as difference from(select patient_id,sum(total_amount) as total
from billing group by patient_id) as j;

select patient_id,total,total<lag(total) over(order by total) as difference from(select patient_id,sum(total_amount) as total
from billing group by patient_id) as j;

with total as (select patient_id,sum(total_amount) as total from billing group by patient_id),
total_no as (select patient_id,total,row_number() over(order by total desc) as rank_no from total)
select patient_id,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as (select treatment,sum(total_amount) as total from billing group by treatment),
total_no as (select treatment,total,row_number() over(order by total desc) as rank_no from total)
select treatment,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as (select p.disease,sum(b.total_amount) as total from billing b join patients p on b.patient_id=p.patient_id group by p.disease),
total_no as (select disease,total,row_number() over(order by total desc) as rank_no from total)
select disease,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as (select patient_id,sum(total_amount) as total from billing group by patient_id),
total_no as (select patient_id,total,row_number() over(order by total) as rank_no from total)
select patient_id,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as (select treatment,sum(total_amount) as total from billing group by treatment),
total_no as (select treatment,total,row_number() over(order by total) as rank_no from total)
select treatment,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as (select p.disease,sum(b.total_amount) as total from billing b join patients p on b.patient_id=p.patient_id group by p.disease),
total_no as (select disease,total,row_number() over(order by total) as rank_no from total)
select disease,total from total_no where rank_no <= (select ceil((0.1)*count(*)) from total);

with total as(select treatment,total_amount as total from billing),
total_no as (select treatment,total,row_number() over(partition by treatment order by total) as asc_no,
row_number() over(partition by treatment order by total desc) as des_no from total) 
select treatment,avg(total) as median from total_no where abs(asc_no-des_no) <=1 group by treatment;

with total as(select p.disease,b.total_amount as total from billing b join patients p on b.patient_id=p.patient_id),
total_no as (select disease,total,cast(row_number() over(partition by disease order by total) as signed) as asc_no,
cast(row_number() over(partition by disease order by total desc) as signed) as des_no from total)
select disease,avg(total) as median from total_no where abs(asc_no-des_no) <=1 group by disease;

with total as(select patient_id,total_amount as total from billing),
total_no as (select patient_id,total,cast(row_number() over(partition by patient_id order by total) as signed) as asc_no,
cast(row_number() over(partition by patient_id order by total desc) as signed) as des_no from total)
select patient_id,avg(total) as median from total_no where abs(asc_no-des_no) <=1 group by patient_id;

with total as(select total_amount as total from billing),
total_no as (select total,cast(row_number() over(order by total) as signed) as asc_no,
cast(row_number() over(order by total desc) as signed) as des_no from total)
select avg(total) as median from total_no where abs(asc_no-des_no) <=1;

with total as(select treatment,total_amount as total from billing),
total_no as (select treatment,total,row_number() over(partition by treatment order by total) as asc_no,
row_number() over(partition by treatment order by total desc) as des_no from total),
total_noo as(select treatment,avg(total) as median from total_no where abs(asc_no-des_no) <= 1 group by treatment)
select t.treatment,t.total from total t join total_noo t1 on t.treatment=t1.treatment where t.total>t1.median;

with total as(select p.disease,b.total_amount as total from billing b join patients p on b.patient_id=p.patient_id),
total_no as (select disease,total,cast(row_number() over(partition by disease order by total) as signed) as asc_no,
cast(row_number() over(partition by disease order by total desc) as signed) as des_no from total),
total_noo as(select disease,avg(total) as median from total_no where abs(asc_no-des_no) <= 1 group by disease)
select t.disease,t.total from total t join total_noo t1 on t.disease=t1.disease where t.total>t1.median;

with total as(select patient_id,total_amount as total from billing),
total_no as (select patient_id,total,cast(row_number() over(partition by patient_id order by total) as signed) as asc_no,
cast(row_number() over(partition by patient_id order by total desc) as signed) as des_no from total),
total_noo as(select patient_id,avg(total) as median from total_no where abs(asc_no-des_no) <= 1 group by patient_id)
select t.patient_id,t.total from total t join total_noo t1 on t.patient_id=t1.patient_id where t.total>t1.median;

with total as(select treatment,total_amount as total from billing),
total_no as (select treatment,total,row_number() over(partition by treatment order by total) as asc_no,
row_number() over(partition by treatment order by total desc) as des_no from total),
total_noo as(select treatment,avg(total) as median from total_no where abs(asc_no-des_no) <= 1 group by treatment)
select t.treatment,t.total from total t join total_noo t1 on t.treatment=t1.treatment where t.total<t1.median;

with total as(select p.disease,b.total_amount as total from billing b join patients p on b.patient_id=p.patient_id),
total_no as (select disease,total,cast(row_number() over(partition by disease order by total) as signed) as asc_no,
cast(row_number() over(partition by disease order by total desc) as signed) as des_no from total),
total_noo as(select disease,avg(total) as median from total_no where abs(asc_no-des_no) <= 1 group by disease)
select t.disease,t.total from total t join total_noo t1 on t.disease=t1.disease where t.total<t1.median;

select * from(select treatment,sum(total_amount) as total,sum(total_amount)*100/(select sum(total_amount) from billing) as percentage from billing 
group by treatment) as j where percentage<=10 order by total desc;

select * from(select patient_id,sum(total_amount) as total,sum(total_amount)*100/(select sum(total_amount) from billing) as percentage from billing 
group by patient_id) as j where percentage<=10 order by total desc;

select * from(select p.disease,sum(b.total_amount) as total,sum(b.total_amount)*100/(select sum(total_amount) from billing) as percentage 
from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j where percentage<=10 order by total desc;

select * from(select treatment,sum(total_amount) as total,sum(total_amount)*100/(select sum(total_amount) from billing) as percentage from billing 
group by treatment) as j where percentage<=10 order by total;

select * from(select patient_id,sum(total_amount) as total,sum(total_amount)*100/(select sum(total_amount) from billing) as percentage from billing 
group by patient_id) as j where percentage<=10 order by total;

select * from(select p.disease,sum(b.total_amount) as total,sum(b.total_amount)*100/(select sum(total_amount) from billing) as percentage 
from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j where percentage<=10 order by total;

select patient_id,sum(total_amount) as total,rank() over(order by sum(total_amount)) as rank_no from billing group by patient_id;

select treatment,sum(total_amount) as total,rank() over(order by sum(total_amount)) as rank_no from billing group by treatment;

select p.disease,sum(b.total_amount) as total,rank() over(order by sum(b.total_amount)) as rank_no from billing b
join patients p on b.patient_id=p.patient_id group by p.disease;
select case  when total<1000 then "low" when total between 1000 and 5000 then 'med'
when total>1000 then 'high' end as distribution,count(*),sum(total) as total from
(select patient_id,sum(total_amount) as total from billing group by patient_id) as j group by distribution;
with patient_total as (select patient_id,sum(total_amount) as total from billing group by patient_id) 
select patient_id,total, ntile(4) over(order by total) as ntile_no from patient_total order by total;

select *,total-lag_no from(select treatment,sum(total_amount) as total, lag(sum(total_amount)) 
over(order by sum(total_amount)) as lag_no from billing group by treatment) as j;
select *,total-lag_no from(select p.disease,sum(b.total_amount) as total, lag(sum(b.total_amount)) over(order by sum(total_amount)) as lag_no 
from billing b join patients p on b.patient_id=p.patient_id group by p.disease) as j;

select *,total-lag_no from(select patient_id,sum(total_amount) as total, lag(sum(total_amount)) 
over(order by sum(total_amount)) as lag_no from billing group by patient_id) as j;
select patient_id,sum(total_amount) as total,rank() over(order by sum(total_amount)) as rank_no from billing group by patient_id;




