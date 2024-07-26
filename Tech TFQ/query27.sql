/*	"PROBLEM STATEMENT: 
  Given vacation_plans tables shows the vacations applied by each employee during the year 2024. 
  Leave_balance table has the available leaves for each employee.
  Write an SQL query to determine if the vacations applied by each employee can be approved 
  or not based on the available leave balance. 
  If an employee has suffecient available leaves then mention the status 
  as ""Approved"" else mention ""Insufficient Leave Balance"".
  Assume there are no public holidays during 2024. 
  weekends (sat & sun) should be excluded while calculating vacation days. "									
										
										
VACATION_PLANS
-----------------------------------------		
| ID | EMP_ID |	 FROM_DT   |   TO_DT    |
|----|--------|------------|------------| 
| 1  |	 1	  | 12-02-2024 | 16-02-2024 |
| 2	 |   2	  | 20-02-2024 | 29-02-2024 |
| 3	 |   3	  | 01-03-2024 | 31-03-2024 |
| 4	 |   1	  | 11-04-2024 | 23-04-2024 |
| 5	 |   4	  | 01-06-2024 | 30-06-2024 |
| 6	 |   3	  | 05-07-2024 | 15-07-2024 | 
| 7	 |   3	  | 28-08-2024 | 15-09-2024 |
-----------------------------------------
										

LEAVE_BALANCE
---------------------	
| EMP_ID  |	BALANCE |
|---------|---------|
|   1	  |   12    |
|   2	  |   10    |
|   3 	  |   26    |
|   4	  |   20    |
|   5	  |   14    |
---------------------

OUTPUT
---------------------------------------------------------------------------------------
| ID  |	EMP_ID |  FROM_DT   |    TO_DT   | VACATION_DAYS |         STATUS             |
|-----|--------|------------|------------|---------------|----------------------------|
| 1	  |   1	   | 12-02-2024	| 16-02-2024 |	     5	     |        Approved            |
| 2	  |   2	   | 20-02-2024	| 29-02-2024 |       8	     |        Approved            |
| 3	  |   3	   | 01-03-2024	| 31-03-2024 |	     21	     |        Approved            |
| 5	  |   4	   | 01-06-2024	| 30-06-2024 |	     20	     |        Approved            |
| 4	  |   1	   | 11-04-2024	| 23-04-2024 |	     9	     | Insufficient Leave Balance |
| 6	  |   3	   | 05-07-2024	| 15-07-2024 |	     7	     | Insufficient Leave Balance |
| 7	  |   3	   | 28-08-2024	| 15-09-2024 |	     13	     | Insufficient Leave Balance |
---------------------------------------------------------------------------------------

*/

-- creating table

drop table if exists vacation_plans;
create table vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);

-- inserting values

insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');

-- creating table

drop table if exists leave_balance;
create table leave_balance
(
	emp_id			int,
	balance			int
);

-- inserting values

insert into leave_balance values (1, 12);
insert into leave_balance values (2, 10);
insert into leave_balance values (3, 26);
insert into leave_balance values (4, 20);
insert into leave_balance values (5, 14);


-- solution

with recursive date_ranges as
(select '2024-02-12' as date
union all
select date+interval 1 day
from date_ranges
where date<'2024-09-15'),
cte1 as
(select *,dayname(date)as days
from date_ranges),
cte2 as
(select * from  cte1 cross join vacation_plans v 
where date between v.from_dt and v.to_dt and days<>'saturday' and days<>'sunday'),
cte3 as
(select  distinct id,emp_id,from_dt,to_dt,
count(days)over(partition by emp_id,id order by id)as vacation_days
from cte2  
),
cte4 as
(select  cte3.*,lb.balance
from cte3 join leave_balance lb on cte3.emp_id=lb.emp_id ),
cte5 as
(select *,row_number()over(partition by emp_id order by emp_id,id)as rn
 from cte4),
 cte6 as
 (select *,sum(vacation_days)over(partition by emp_id order by id range between unbounded preceding and unbounded following)
 as vc from cte5)
 select id,emp_id,from_dt,to_dt,vacation_days,case when rn=1 and vc>=vacation_days  then 'approved'
               when rn=2 and vc>=vacation_days and vc<=balance then 'approved'
               when rn=3 and vc>=vacation_days and vc<=balance then 'approved' 
               else 'insufficient leave balance' end as status
from cte6
order by status;

