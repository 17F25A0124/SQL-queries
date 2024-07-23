
/* "PROBLEM STATEMENT:
   Find out the no of employees managed by each manager."					
					
		INPUT
	------------------------------	
	| ID  |	  NAME     |  MANAGER |
    |-----------------------------|
	| 1	  |  Sundar    |	      |
	| 2	  |  Kent      |	1     |
	| 3	  |  Ruth      |	1     |
	| 4	  |  Alison    |	1     |
	| 5	  |  Clay      |	2     |
	| 6	  |  Ana	   |    2     |
	| 7	  |  Philipp   |	3     |
	| 8	  |  Prabhakar |	4     |
	| 9	  |  Hiroshi   |    4     |
	| 10  |	 Jeff	   |    4     |
	| 11  |	 Thomas	   |    1     |
	| 12  |	 John	   |    15    |
	| 13  |	 Susan	   |    15    |
	| 14  |	 Lorraine  | 	15    |
	| 15  |	 Larry	   |    1     |
    -------------------------------
				
		
	OUTPUT
	--------------------------------
	| MANAGER |	NO_OF_EMPLOYEES |
    |---------------------------|
	| Sundar  |       5         |
	| Alison  |	      3         |
	| Larry	  |       3         |
	| Kent	  |       2         |
	| Ruth	  |       1         |
    -----------------------------
*/

-- creating table

create table employee_managers
(
	id			int,
	name		varchar(20),
	manager 	int
);

-- inserting values

insert into employee_managers values (1, 'Sundar', null);
insert into employee_managers values (2, 'Kent', 1);
insert into employee_managers values (3, 'Ruth', 1);
insert into employee_managers values (4, 'Alison', 1);
insert into employee_managers values (5, 'Clay', 2);
insert into employee_managers values (6, 'Ana', 2);
insert into employee_managers values (7, 'Philipp', 3);
insert into employee_managers values (8, 'Prabhakar', 4);
insert into employee_managers values (9, 'Hiroshi', 4);
insert into employee_managers values (10, 'Jeff', 4);
insert into employee_managers values (11, 'Thomas', 1);
insert into employee_managers values (12, 'John', 15);
insert into employee_managers values (13, 'Susan', 15);
insert into employee_managers values (14, 'Lorraine', 15);
insert into employee_managers values (15, 'Larry', 1);

select * from employee_managers;

-- solution

select m.name as manager,count(emp.name) as no_of_employees from employee_managers emp
join employee_managers m on emp.manager=m.id 
group by manager
order by no_of_employees desc;
