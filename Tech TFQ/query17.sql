
/* Problem Statement:
   User login table shows the date when each user logged in to the system.
   Identify the users who logged in for 5 or more consecutive days. 
   Return the user id, start date, end date and no of consecutive days.
   Please remember a user can login multiple times during a day but only consider 
   users whose consecutive logins spanned 5 days or more.


Table: user_login
------------------------
| USER_ID |	LOGIN_DATE |
|----------------------|
|    1    |	2024-03-01 |
|    1	  | 2024-03-02 |
|    1	  | 2024-03-03 |
|    1	  | 2024-03-04 |
|    1	  | 2024-03-06 |
|    1	  | 2024-03-10 | 
|    1	  | 2024-03-11 |
|    1	  | 2024-03-12 |
|    1	  | 2024-03-13 |
|    1	  | 2024-03-14 | 
|    1	  | 2024-03-20 |
|    1	  | 2024-03-25 |
|    1	  | 2024-03-26 |
|    1	  | 2024-03-27 |
|    1	  | 2024-03-28 |
|    1	  | 2024-03-29 |
|    1	  | 2024-03-30 |
|    2	  | 2024-03-01 |
|    2	  | 2024-03-03 |
|    2	  | 2024-03-04 |
|    3	  | 2024-03-01 |
|    3	  | 2024-03-02 |
|    3	  | 2024-03-03 |
|    3	  | 2024-03-04 |
|    3	  | 2024-03-04 |
|    3	  | 2024-03-04 |
|    3	  | 2024-03-05 |
|    4	  | 2024-03-01 |
|    4	  | 2024-03-02 |
|    4	  | 2024-03-03 |
|    4	  | 2024-03-04 |
|    4	  | 2024-03-04 |
------------------------


Expected Output:
--------------------------------------------------------
| USER_ID |	START_DATE |  END_DATE  | CONSECUTIVE_DAYS |
|------------------------------------------------------|
|    1	  | 2024-03-10 | 2024-03-14	|       5          |
|    1	  | 2024-03-24 | 2024-03-30	|       7          |
|    3	  | 2024-03-01 | 2024-03-05	|       5          |
--------------------------------------------------------
*/

-- creating table

create table user_login
(
	user_id		int,
	login_date	date
);

-- inserting values

insert into user_login values(1, '2024/03/01');
insert into user_login values(1, '2024/03/02');
insert into user_login values(1, '2024/03/03');
insert into user_login values(1, '2024/03/04');
insert into user_login values(1, '2024/03/06');
insert into user_login values(1, '2024/03/10');
insert into user_login values(1, '2024/03/11');
insert into user_login values(1, '2024/03/02');
insert into user_login values(1, '2024/03/13');
insert into user_login values(1, '2024/03/14');

insert into user_login values(1, '2024/03/20');
insert into user_login values(1, '2024/03/25');
insert into user_login values(1, '2024/03/26');
insert into user_login values(1, '2024/03/27');
insert into user_login values(1, '2024/03/28');
insert into user_login values(1, '2024/03/29');
insert into user_login values(1, '2024/03/30');

insert into user_login values(2,'2024/03/01');
insert into user_login values(2,'2024/03/02');
insert into user_login values(2,'2024/03/03');
insert into user_login values(2,'2024/03/04');

insert into user_login values(3,'2024/03/01');
insert into user_login values(3,'2024/03/02');
insert into user_login values(3,'2024/03/03');
insert into user_login values(3,'2024/03/04');
insert into user_login values(3,'2024/03/04');
insert into user_login values(3,'2024/03/04');
insert into user_login values(3,'2024/03/05');

insert into user_login values(4,'2024/03/01');
insert into user_login values(4,'2024/03/02');
insert into user_login values(4,'2024/03/03');
insert into user_login values(4,'2024/03/04');
insert into user_login values(4,'2024/03/04');


select * from user_login;


-- solution

with cte as 
	(select * 
	, login_date -dense_rank() 
						over(partition by user_id order by user_id,login_date)
	  as date_group
	from user_login)
select user_id
, min(login_date) as start_date
, max(login_date) as end_date
, count(1) as consecutive_days
, (max(login_date) - min(login_date)) + 1 as consecutive_days
from cte
group by user_id, date_group
having count(1) >= 5 
	and (max(login_date) - min(login_date)) >= 4
order by user_id, date_group;
