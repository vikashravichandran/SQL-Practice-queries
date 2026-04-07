use hospital_db;
CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    treatment VARCHAR(100),
    doctor_fee DECIMAL(10,2),
    medicine_cost DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
INSERT INTO billing VALUES
(1,1,'General Checkup',500,300,800,'Paid'),
(2,2,'Diabetes Test',700,400,1100,'Paid'),
(3,3,'Heart Scan',2000,800,2800,'Pending'),
(4,4,'Migraine Treatment',600,200,800,'Paid'),
(5,5,'BP Check',500,150,650,'Paid'),
(6,6,'Fever Treatment',400,200,600,'Paid'),
(7,7,'Asthma Treatment',900,350,1250,'Pending'),
(8,8,'Allergy Test',800,300,1100,'Paid'),
(9,9,'Diabetes Check',700,300,1000,'Pending'),
(10,10,'Cold Treatment',300,150,450,'Paid'),
(11,11,'Fever Check',400,200,600,'Paid'),
(12,12,'Skin Treatment',800,250,1050,'Pending'),
(13,13,'Heart Consultation',1500,500,2000,'Paid'),
(14,14,'BP Treatment',600,200,800,'Paid'),
(15,15,'Diabetes Treatment',900,300,1200,'Pending');
## SECTION 2
select sum(total_amount) from billing;
select avg(total_amount) from billing;
select max(total_amount) from billing;
select min(total_amount) from billing;
select count(*) from billing;
select treatment ,sum(total_amount) from billing group by treatment ;
select treatment,max(total_amount) from billing group by treatment order by max(total_amount) desc limit 1;
select treatment,min(total_amount) from billing group by treatment order by min(total_amount) limit 1;
select treatment,count(*) from billing group by treatment order by count(*) desc limit 1;
select treatment,count(*) from billing group by treatment order by count(*) asc limit 1;
select treatment,avg(total_amount) as avg_amt from billing group by treatment having avg_amt>1000 order by avg_amt ;
select treatment,sum(total_amount) as tot_amt from billing group by treatment having tot_amt>2000 order by tot_amt ;
select treatment,count(*) as bill_coun from billing group by treatment having bill_coun>2;
select treatment,min(total_amount) from billing group by treatment having min(total_amount)<600;
select treatment,max(total_amount) from billing group by treatment having max(total_amount)>1500;
select patient_id,total_amount from billing where total_amount>(select avg(total_amount) from billing);
select patient_id,total_amount from billing where total_amount<(select avg(total_amount) from billing);
select bill_id,total_amount from billing where total_amount=(select avg(total_amount) from billing);
select bill_id,total_amount from billing where total_amount>(select max(medicine_cost) from billing);
select * from billing where doctor_fee>medicine_cost;
select *from billing where payment_status='pending';
select count(*)from billing where payment_status='pending';
select count(*)from billing where payment_status='paid';
select treatment from billing where payment_status='pending';
select treatment from billing where payment_status='paid';
select treatment,avg(medicine_cost) from billing group by treatment ;
select treatment,max(medicine_cost) from billing group by treatment ;
select treatment,min(medicine_cost) from billing group by treatment ;
select treatment,medicine_cost from billing where medicine_cost>(select avg(total_amount) from billing);
select treatment,medicine_cost from billing where medicine_cost<(select avg(total_amount) from billing);
select total_amount from billing order by total_amount desc limit  1 offset 1;
select total_amount from billing order by total_amount desc limit  1 offset 2;
select total_amount from billing  limit 3;
select medicine_cost from billing   limit 5;
select count(*),treatment from billing group by treatment;
select sum(total_amount),treatment from billing group by treatment;
select avg(total_amount),treatment from billing group by treatment;
select sum(doctor_fee),treatment from billing group by treatment;
select sum(medicine_cost),treatment from billing group by treatment;
select treatment,sum(doctor_fee) from billing group by treatment order by sum(doctor_fee) desc limit 1;
select treatment,sum(medicine_cost) from billing group by treatment order by sum(medicine_cost) desc limit 1;
select treatment,sum(total_amount)*100 /sum(sum(total_amount))over() as per_bill from billing group by treatment ;
select bill_id,treatment,total_amount,sum(total_amount) over(order by bill_id) as revenue_amt from billing ;
select bill_id,treatment,total_amount,sum(total_amount) over(order by bill_id) as cum_bill from billing;
select treatment,sum(total_amount),rank() over( order by sum(total_amount)) as rank_treat from billing group by treatment;
select treatment,count(*),rank() over( order by count(*)) as rank_treat from billing group by treatment;
select bill_id,total_amount,rank() over(order by total_amount) from billing;
select bill_id,medicine_cost,rank() over(order by medicine_cost) from billing;
select bill_id,doctor_fee,rank() over(order by doctor_fee) from billing;
select treatment,count(*) as coun_pat from billing group by treatment having coun_pat>1;
select patient_id,count(*) from billing group by patient_id having count(*)>1;
select treatment,count(*) from billing group by treatment having count(*)>2;
select treatment,count(*) from billing group by treatment having count(*)=1;
select treatment,count(*) from billing group by treatment having count(*)=2;
select bill_id,doctor_fee+medicine_cost as total_amount from billing;
select *from billing where total_amount<>doctor_fee+medicine_cost;
 select *from billing where total_amount=(select max(total_amount) from billing);
 select *from billing where total_amount=(select min(total_amount) from billing);
select*from billing b where total_amount >(select avg(total_amount) from billing where treatment=b.treatment);
select*from billing b where total_amount<(select avg(total_amount) from billing where treatment=b.treatment);
select patient_id,total_amount,treatment,rank() over(partition by treatment order by total_amount) as rank_pat from billing;
select treatment,max(total_amount) from billing  group by treatment order by max(total_amount) desc;
select treatment from billing where total_amount=(select min(total_amount) from billing);
select treatment,max(total_amount) from billing  group by treatment order by max(total_amount) desc limit 1 offset 1;
select treatment,total_amount,sum(total_amount) over(partition by treatment order by bill_id) as total_rev from billing ; 
select patient_id,total_amount,total_amount-avg(total_amount) over() as diff_amt from billing;
select bill_id,total_amount*100/sum(total_amount) over() as per_bill from billing ;
select bill_id,medicine_cost,sum(medicine_cost) over(order by bill_id)as cumm_med from billing;
select bill_id,doctor_fee,sum(doctor_fee) over(order by bill_id) as cumm_doc from billing;




















