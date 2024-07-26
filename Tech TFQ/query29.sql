
/* "PROBLEM STATEMENT: Given table provides login and logoff details of one user.
   Generate a report to represents the different periods (in mins) when user was logged in."							
							
	INPUT
---------------------
|  TIMES   | STATUS |
|----------|--------|
| 10:00:00 |   on   |
| 10:01:00 |   on   |
| 10:02:00 |   on   |
| 10:03:00 |   off  |
| 10:04:00 |   on   |
| 10:05:00 |   on   |
| 10:06:00 |   off  |
| 10:07:00 |   off  |
| 10:08:00 |   off  |
| 10:09:00 |   on   |
| 10:10:00 |   on   |
| 10:11:00 |   on   |
| 10:12:00 |   on   |
| 10:13:00 |   off  |
| 10:14:00 |   off  |
| 10:15:00 |   on   |
| 10:16:00 |   off  |
| 10:17:00 |   off  |
---------------------
						
*/

-- creating table

drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);

-- inserting values

insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select * from login_details;

-- solution

with cte as 
          (select distinct first_value(times)over(partition by grp order by grp,times)as log_on,
           last_value(times)over(partition by grp order by grp,times 
           range between unbounded preceding and unbounded following
           ) as last_log_on 
           from
               (select *, 
                rn-row_number()over(order by times)as grp 
                from 
                   (select *,
					row_number() over(order by times) as rn
					from login_details) x where status='on')y),
cte1 as
       (select log_on,lead(times)over(order by times)as log_off
        from login_details l
        left join cte on cte.last_log_on=l.times)
    select *,minute(log_on-log_off)as duration 
    from cte1 
    where log_on is not null;
