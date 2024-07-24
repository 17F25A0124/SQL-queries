/* Find out the employees who attended all compan events

	EMPLOYEE
	----------------
	| ID |  NAME   |
    |----|---------|
	| 1	 | Lewis   |
	| 2	 | Max     |
	| 3	 | Charles |
	| 4	 | Sainz   |
    ----------------
    
    EVENTS
----------------------------------------    
|  EVENT_NAME	 | EMP_ID |   DATES    |
|----------------|--------|------------|
| Product launch |	 1	  | 01-03-2024 |
| Product launch |	 3	  | 01-03-2024 |
| Product launch |	 4	  | 01-03-2024 |
| Conference	 |   2	  | 02-03-2024 |
| Conference	 |   2	  | 03-03-2024 |
| Conference	 |   3	  | 02-03-2024 |
| Conference	 |   4	  | 02-03-2024 |
| Training		 |   3    | 04-03-2024 |
| Training		 |   2    | 04-03-2024 |
| Training		 |   4    | 04-03-2024 |
| Training		 |   4    | 05-03-2024 |
----------------------------------------

OUTPUT
--------------------------------	
| EMPLOYEE_NAME | NO_OF_EVENTS |
|---------------|--------------|
|   Charles	    |     3        |
|   Sainz	    |     3        |
--------------------------------

*/

-- creating table

create table employees
(
	id			int,
	name		varchar(50)
);

-- inserting values

insert into employees values(1, 'Lewis');
insert into employees values(2, 'Max');
insert into employees values(3, 'Charles');
insert into employees values(4, 'Sainz');

-- creating table

create table events
(
	event_name		varchar(50),
	emp_id			int,
	dates			date
);

-- inserting values

insert into events values('Product launch', 1,'2024-03-01');
insert into events values('Product launch', 3,'2024-03-01');
insert into events values('Product launch', 4,'2024-03-01');
insert into events values('Conference', 2,'2024-03-02');
insert into events values('Conference', 2,'2024-03-03');
insert into events values('Conference', 3,'2024-03-02');
insert into events values('Conference', 4,'2024-03-02');
insert into events values('Training', 3,'2024-03-04');
insert into events values('Training', 2,'2024-03-04');
insert into events values('Training', 4,'2024-03-04');
insert into events values('Training', 4,'2024-03-05');


select * from employees;
select * from events;

-- solution 
 
with cte as
         (select distinct e.*,
               ev.event_name,ev.emp_id,
			  case when event_name= 'Product launch' then 1
				   when  event_name='conference' then 1 
				   when event_name='training' then 1 else 0 end as num
		  from events ev 
          join  
          employees e on e.id=ev.emp_id
		) 
select distinct name,
 sum(num)as no_of_events 
 from cte 
 group by name, id 
 having sum(num) =3 ;


