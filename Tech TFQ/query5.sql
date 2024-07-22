/* PROBLEM STATEMENT: Using the given Salary, Income and Deduction tables, 
first write an sql query to populate the Emp_Transaction table as shown 
below and then generate a salary report as shown.


	SALARY
   ----------------------------------
   | EMP_ID | EMP_NAME | BASE_SALARY |
   ----------------------------------
   |	1	| Rohan	   |  5000       |
   |    2  	| Alex	   |  6000       |
   |	3	| Maryam   |  7000       |
   -----------------------------------
			
	INCOME	
	---------------------------------
	| ID  | INCOME    | PERCENTAGE  |
    ---------------------------------
	|  1  |	Basic	  |    100      |
	|  2  | Allowance |	    4       |
	|  3  | Others	  |     6       |
	---------------------------------		
			
	DEDUCTION
    ----------------------------------
	| ID  |	DEDUCTION	PERCENTAGE    |
    -----------------------------------
	| 1	  | Insurance  |	5         |
	| 2	  | Health	   |    6         |
	| 3	  | House	   |    4         |
    -----------------------------------
    
    
	EXPECTED OUTPUT - EMP_TRANSACTION
    ------------------------------------------------
	| EMP_ID  |	EMP_NAME  |	TRNS_TYPE  |   AMOUNT  |
    ------------------------------------------------
	|   1	  |  Rohan	  | Insurance  |    250    |
	|   2	  |  Alex	  | Insurance  |	300    |
	|   3	  |  Maryam	  | Insurance  |	350    |
	|   1	  |  Rohan	  | House	   |    200    | 
	|   2	  |  Alex	  | House	   |    240    |
	|   3	  |  Maryam	  | House	   |    280    |
	|   1	  |  Rohan	  | Basic	   |    5000   |
	|   2	  |  Alex	  | Basic      |	6000   |
	|   3	  |  Maryam	  | Basic	   |    7000   |
	|   1	  |  Rohan	  | Health	   |    300    |
	|   2	  |  Alex	  | Health	   |    360    |
	|   3	  |  Maryam	  | Health	   |    420    |
	|   1	  |  Rohan	  | Allowance  | 	200    |
	|   2	  |  Alex	  | Allowance  |	240    |
	|   3 	  |  Maryam	  | Allowance  |	280    |
	|   1	  |  Rohan	  | Others	   |    300    |
	|   2     |  Alex	  | Others	   |    360    |
	|   3	  |  Maryam	  | Others	   |    420    |
    ------------------------------------------------
    
    EXPECTED OUTPUT - SALARY REPORT		
------------------------------------------------------------------------------------------------------------    
| EMPLOYEE  | BASIC | ALLOWANCE | OTHERS | GROSS | INSURANCE | HEALTH |	HOUSE |	TOTAL_DEDUCTIONS |	NET_PAY |
-------------------------------------------------------------------------------------------------------------
|  Alex	    | 6000	|   240	    |  360	 | 6600  |	 300	 |  360   |	 240  |	     900	     |  5700    |
|  Maryam   | 7000	|   280	    |  420	 | 7700	 |   350	 |  420	  |  280  |	     1050	     |  6650    |
|  Rohan    | 5000	|   200	    |  300	 | 5500	 |   250	 |  300	  |  200  |	     750	     |  4750    |
-------------------------------------------------------------------------------------------------------------

*/

-- create table

create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);

-- inserting values

insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);

-- creating table income

create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);

-- inserting values into income

insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);

-- creating table deduction

create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);

-- inserting values into deduction

insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


-- solution 
-- creating table emp_transaction

create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);


insert into emp_transaction
  select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) 
       end as amount	   
from salary s
cross join (select income as trns_type, percentage from income
			union
			select deduction as trns_type, percentage from deduction) x;


select * from salary;
select * from income;
select * from deduction;
select * from emp_transaction;


with cte as
(select emp_name,
sum(case when trns_type='allowance' then amount else 0 end) as allowance
,sum(case when trns_type='basic' then amount else 0 end) as basic
,sum(case when trns_type='others' then amount else 0 end) as others
,sum(case when trns_type='insurance' then amount else 0 end) as insurance
,sum(case when trns_type='health' then amount else 0 end) as health
,sum(case when trns_type='house'then amount else 0 end) as house
 from emp_transaction
group by emp_name)
select *,
(basic+allowance+others) as gross,
(insurance+health+house) as total_deductions,
(basic+allowance+others)-(insurance+health+house) as net_pay
from cte;

