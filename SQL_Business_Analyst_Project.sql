-- Business Analyst SQL Project --


/* This SQL project aims to demonstrate the usage of sql into the field of business analytics,
using DDL and DML procedures */



-- DDL Procedures --


create Database Business_Analyst_Project    /* Project Database Creation */



-- Creating the table of the company's employees  --


create table employee 
(
	emp_id int primary key,
	firsT_name text not null,
	last_name text not null,
	job_position text not null,        /* defining column_names, data_types and constraints */
	salary numeric(8,2),
	start_date date not null,
	birth_date date not null,
	store_id int,
	department_id int,
	manager_id int
	
)


select *          /* Select the table to ensure that everything has gone well */
from employee



-- Creation of table departments --


create table departments 
(
	department_id int primary key not null,
	department text not null,
	division text not null
)


select *
from departments     /* checking table departments */



-- Alter table employee(1) --


select *
from employee


alter table employee
alter column department_id set not null,				
alter column start_date set default current_date,      
add column end_date date,
add constraint birth_ckeck check(birth_date < current_date)


-- Alter table employee(2) --


alter table employee
rename column job_position to position_title


select *
from employee


-- Alter table employee(3)


alter table employee
rename to employees



-- DML Procedures --

-- Inserting Data to employee table --


INSERT INTO employees
VALUES
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL);


select *
from employees



-- Inserting Data to departments table --


select *
from departments


insert into departments
values
('1','Analytics','IT'),
('2','Finance','Administration'),
('3','Sales','Sales'),
('4','Website','IT'),
('5','Back Office','Administration')



-- Jack Franklin gets promoted to 'Senior SQL Analyst' and the salary raises to 7200 --


update employees
set salary = 7200, position_title = 'Senior SQL Analyst'
where emp_id = 25


select *
from employees             /* Checking the final results */
where emp_id = 25



-- Rename the position_title 'Customer Support' to 'Customer Specialist' --


update employees
set position_title = 'Customer Specialist'
where position_title = 'Customer Support'


select *
from employees



-- All employees gets an increase in their salary by 6% -- 


update employees
set salary = salary + (salary * (0.06))
where position_title like '%SQL Analyst%'



-- Find the average salary of SQL analyst (excepet for senior analysts) --


select round(avg(salary),2) as average_salary
from employees 
where position_title like 'SQL Analyst%'



/*Display an extra column wich hold first_name and last_name together
Also make a category column which categorizes the active status of employee with true-false condition */ 


select *, concat(FIRST_NAME, ' ', LAST_NAME) as Full_Name,
case
when END_date is null then 'True'
else 'False'
end is_active
FROM employees



-- View creation with data from the previous query --


create view v_employees_info
as
select *, concat(FIRST_NAME, ' ', LAST_NAME) as Full_Name,
case
when END_date is null then 'True'
else 'False'
end is_active
FROM employees


select *                         /* Check of the view creation */
from v_employees_info




-- Return the average salaries for each position with rounding (2 decimals) --


-- First Solution (with use of group by statement) --


select position_title, round(avg(salary),2) as avg_position_salary
from employees
group by position_title 
order by 2 desc



/* Filtering data to return values for postition_title ' Software Engineer' */ 
 
 
select position_title, round(avg(salary),2) as avg_position_salary
from employees
where position_title = 'Software Engineer'     
group by position_title                            
order by 2 desc



-- Second Solution (usage of windows functions) --


select distinct(position_title),
round(avg(salary) over(partition by position_title),2) as _position_average
from employees



-- Third Solution (using correlated subquery in where clause) --


select distinct(position_title),
(
	select round(avg(salary),2)
	from employees e1
	where e1.position_title = e2.position_title
)
from employees e2



-- Return the average salaries per division -- 

select *
from employees

select *
from departments

select *
from employees e inner join departments d       /* Join of the two tables we need */
	on e.department_id = d.department_id
	
	
	
-- First Solution (using the group by statement)	


select division, round(avg(salary),2)
from employees e inner join departments d
	on e.department_id = d.department_id
group by division



-- Second Solution (Using correlated Subquery in Select) --


select distinct(division),
(select round(avg(salary),2) as average_division_salary
 from employees e inner join departments d1
	on e.department_id = d1.department_id
 where d1.division = d2.division 
)
from employees e inner join departments d2
	on e.department_id = d2.department_id
order by 2 desc



-- Third Solution (Using windows function) -- 


select distinct(division),
round(avg(salary) over(partition by division),2)
from employees e inner join departments d
	on e.department_id = d.department_id



/* Return the following business informations :
emp_id, first_name, last_name, position_title, salary 
and the average salary for each job_position  */


-- First Solution (Using window function) --


select emp_id, first_name, last_name, position_title, salary,
round(avg(salary) over(partition by position_title),2) as position_average_salary
from employees 
order by 1 asc



-- Second Solution (Using Correlated Subquery in Select statement) --


select emp_id, first_name, last_name, position_title, salary,
(	
	select round(avg(salary),2) as position_average_salary
	from employees e1
	where e1.position_title = e2.position_title
)
from employees e2 
order by 1



-- Return the number of employees who receive less than the average salary of their jon position --

-- First Solution (Using window function) --


select * 
from 
(
select emp_id, first_name, last_name, position_title, salary,
round(avg(salary) over(partition by position_title),2) as average_position_salary
from employees )
where salary < average_position_salary       
order by 6 desc                                        /* more efficient query */




-- Second Solution (Using correlated subqueries) --


select emp_id, first_name, last_name, position_title, salary,
(	
	select round(avg(salary),2) as position_average_salary
	from employees e1
	where e1.position_title = e2.position_title
)
from employees e2 
where salary < (	
	select round(avg(salary),2) as position_average_salary
	from employees e1
	where e1.position_title = e2.position_title
)
order by 6 desc



-- Sum of Salary developement through the years --


select *
from employees


select start_date,
salary,
sum(salary) over(order by start_date)
from employees


select date(start_date), salary,
sum(salary) over(order by date(start_date))    /* ordering data by date ascending */
from employees
order by 1



/* Display top earners employees per position_title including the following data :
   first_name, last_name, position_title, salary */ 
   


-- First Solution (Using subquery in where clause with group by) --


select first_name, last_name, position_title, salary
from employees
where salary in (
	
	select max(salary) as position_max_salary
	from employees
	group by position_title
) 



-- Second solution (Using correlated subquery in where clause) --


select first_name, last_name, position_title, salary
from employees e1
where salary = (
	
	select max(salary) as position_max_salary
	from employees e2
	where e1.position_title = e2.position_title
) 



-- Third Solution (Using window function) --



select concat(first_name, ' ', last_name), position_title, salary
from (
	select *, 
	max(salary) over(partition by position_title) as position_max_salary
	from employees
)
where salary = position_max_salary
order by position_max_salary desc



select firsT_name, last_name, position_title, salary
from employees
where salary in
(
	select max(salary)                /* displaying top earner of position title SQL Analyst */
	from employees
	group by position_title
)
and position_title = 'SQL Analyst'





-- Display the same results from previous query plus the average salary per position title --


-- First Solution (Using correlated subquery into select statement --

select firsT_name, last_name, position_title, salary as postition_max_salary,
(
	select round(avg(salary),2) as position_avg
	from employees e1
	where e1.position_title = e2.position_title
)
from employees e2
where salary in
(
	select max(salary)
	from employees e2
	group by position_title     
)


-- Second solution (Using Window function) --



select concat(first_name, ' ',last_name) as name, position_title, salary as position_max_salary, potition_average_salary
from (
	select *,
	round(max(salary) over(partition by position_title),2) as position_max_salary ,
	round(avg(salary) over(partition by position_title),2) as potition_average_salary
	from employees
)
where salary = position_max_salary  
order by position_max_salary desc, potition_average_salary desc



-- Now remove the employees whose salary is equal to the average salary of their position   --


-- First Solution (Using one more where clause to filter employees salaries) --


select firsT_name, last_name, position_title, salary, salary as postition_max_salary,
(
	select round(avg(salary),2) as position_avg
	from employees e1
	where e1.position_title = e2.position_title
)
from employees e2
where salary in
(
	select max(salary)
	from employees e2
	group by position_title
)
and salary <> (
	select avg(salary)                         /* using one addition where clause to filter employees salaries  */
	from employees e3
	where e3.position_title = e2.position_title
)
order by salary desc



-- Second Solution (Usage of windows functions) --


select concat(first_name, ' ',last_name) as name, position_title, salary,position_max_salary, potition_average_salary
from (
	select *,
	round(max(salary) over(partition by position_title),2) as position_max_salary ,
	round(avg(salary) over(partition by position_title),2) as potition_average_salary
	from employees
)
where salary = position_max_salary  
and position_max_salary <> potition_average_salary
order by salary desc



-- Task 12 --


select *
from employees 

select *
from departments



select *
from employees e inner join departments d
	on e.department_id = d.department_id 


select concat(first_name, ' ', last_name) as name, division, department, position_title 
from employees e inner join departments d
	on e.department_id = d.department_id 
	
	
	-- First Solution for All employees --
	
	
select concat(first_name, ' ', last_name) as name, division, department, position_title, salary as employee_salary,
round(sum(salary) over(partition by division, department, position_title),2) as sum_of_salaries  ,
round(avg(salary) over(partition by division, department, position_title),2) as avg_salary,
count(emp_id) over(partition by division, department, position_title)
from employees e inner join departments d
	on e.department_id = d.department_id
order by 2,3,4



-- Second Solution (No employees) --


select distinct division, department, position_title,
round(sum(salary) over(partition by division, department, position_title),2) as sum_of_salaries  ,
round(avg(salary) over(partition by division, department, position_title),2) as avg_salary,
count(emp_id) over(partition by division, department, position_title)
from employees e inner join departments d
	on e.department_id = d.department_id
order by 1,2,3



-- Return employee personal and working info and rank their salary partitioned by department -- 


-- Solution with left join --


select emp_id, firsT_name, last_name, position_title, department, salary,
rank() over(partition by department order by salary desc)
from employees e inner join departments d
	on e.department_id = d.department_id
	
	
	
-- Solution with natural left join --


select emp_id, firsT_name, last_name, position_title, department, salary,
rank() over(partition by department order by salary desc)
from employees natural left join departments 
	
	

-- Return only the top earners of each department --

-- First Solution (Using correlated subquery in where clause) --
	
	
select emp_id, concat(first_name, ' ', last_name), position_title, department, salary
from employees e left join departments d
	on e.department_id = d.department_id 
where salary =
(
	select max(salary)
	from employees e left join departments d1
	on e.department_id = d1.department_id 
	where d1.department = d.department
)


-- Second solution (Using group by in where clause) 


select  emp_id, concat(first_name, ' ', last_name), position_title, department, salary
from employees e left join departments d
	on e.department_id = d.department_id 
where salary in (
	select max(salary)
	from employees e left join departments d
		on e.department_id = d.department_id 
	group by department
	)
order by salary desc



-- Third Solution (Using windows functions) --


select emp_id, concat(first_name, ' ', last_name) as employee_name, position_title, department, salary
from (
	select emp_id,first_name, last_name, position_title, department, salary,
max(salary) over(partition by department) as department_max_salary
from  employees e left join departments d
	on e.department_id = d.department_id )
where salary = department_max_salary                   /* using partition by window function */
order by salary desc
	


/* using rank and partition by windows functions */


select  emp_id,first_name, last_name, position_title, department, salary
from (
select emp_id,first_name, last_name, position_title, department, salary,
rank() over(partition by department order by salary desc)
from  employees e left join departments d
	on e.department_id = d.department_id 
	)
where rank = 1 
order by salary desc

