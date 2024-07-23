
/* PROBLEM STATEMENT: 
Given graph shows the hierarchy of employees in a company. 
Write an SQL query to split the hierarchy and show the employees corresponding to their team.

 


EXPECTED OUTPUT:
------------------------------------------
| TEAMS	  |      MEMBERS                 |
|----------------------------------------|
| Team 1  |	Elon, Bret, Mark, Phil, Jon  |
| Team 2  |	Elon, Earl, Omid             |
| Team 3  |	Elon, Ira, James, Drew       |
------------------------------------------

*/

-- creating table 

CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

-- inserting values

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;

-- solution 1

with recursive cte as (
	 select manager,employee,row_number() over (order by employee) as rn from company 
	where manager=(select employee from company where manager is null)
	union
	 select b.manager,b.employee, rn from cte join company b on cte.employee=b.manager
	
 )select concat ('Team ', rn) as teams,
 concat((select employee from company where manager is null),',',group_concat(employee))as memebers 
 from cte group by 1
order by 1;

-- solution 2

with recursive cte as
(select employee, manager, 
concat("Team ", row_number() over (order by employee) ) as team from company
where manager in (select employee from company where manager is null)
union all
select c.employee, c.manager, cte.team from cte join company c
where cte.employee = c.manager),
cte2 as (select team,(select employee from company where manager is null) as manager, 
group_concat(employee) as people from cte
group by team)
select Team,concat(manager,",",people) as members from cte2;


