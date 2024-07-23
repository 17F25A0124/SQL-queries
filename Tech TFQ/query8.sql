/* Add the missing values							
	"PROBLEM STATEMENT: 
In the given input table, there are rows with missing JOB_ROLE values. Write a query to fill in those blank fields with appropriate values.
Assume row_id is always in sequence and job_role field is populated only for the first skill.
Provide two different solutions to the problem."							
								
								
	INPUT		
    ----------------------------------------
	| ROW_ID  |	JOB_ROLE         |	SKILLS |
    ----------------------------------------
	|   1	  | Data Engineer    |	SQL    |
	|   2	  |	Python           |         |
	|   3	  |	AWS              |         |
	|   4	  |	Snowflake        |         |  
	|   5	  |	Apache Spark     |         |
	|   6	  | Web Developer    |	Java   |
	|   7	  |	HTML             |         |
	|   8	  |	CSS              |         |
	|   9	  | Data Scientist   |	Python |
	|   10	  |	Machine Learning |         |
	|   11	  |	Deep Learning    |         |
	|   12	  |	Tableau          |         |
    ----------------------------------------
        		
OUTPUT
----------------------------------------------		
|ROW_ID |	JOB_ROLE	  |   SKILLS          |
----------------------------------------------
|  1	|  Data Engineer  |	 SQL              |
|  2	|  Data Engineer  |	 Python           |
|  3	|  Data Engineer  |	 AWS              |
|  4	|  Data Engineer  |	 Snowflake        |
|  5	|  Data Engineer  |	 Apache Spark     |
|  6	|  Web Developer  |	 Java             |
|  7	|  Web Developer  |	 HTML             |
|  8	|  Web Developer  |	 CSS              |
|  9	|  Data Scientist |	 Python           |
|  10	|  Data Scientist |	 Machine Learning |
|  11	|  Data Scientist |	 Deep Learning    |
|  12	|  Data Scientist |	 Tableau          |
-----------------------------------------------
*/

-- creating table

create table job_skills
(
	row_id		int,
	job_role	varchar(20),
	skills		varchar(20)
);

-- inserting values

insert into job_skills values (1, 'Data Engineer', 'SQL');
insert into job_skills values (2, null, 'Python');
insert into job_skills values (3, null, 'AWS');
insert into job_skills values (4, null, 'Snowflake');
insert into job_skills values (5, null, 'Apache Spark');
insert into job_skills values (6, 'Web Developer', 'Java');
insert into job_skills values (7, null, 'HTML');
insert into job_skills values (8, null, 'CSS');
insert into job_skills values (9, 'Data Scientist', 'Python');
insert into job_skills values (10, null, 'Machine Learning');
insert into job_skills values (11, null, 'Deep Learning');
insert into job_skills values (12, null, 'Tableau');

select * from job_skills;

-- solution1

select * from job_skills;

with cte as
(select *,
       sum(case when job_role is null then 0 else 1 end ) over(order by row_id) as segment 
from  job_skills)
 select row_id,
 first_value(job_role) over(partition by segment order by row_id)as job_role,
skills
from cte;

-- solution2

with recursive cte as 
(select row_id,job_role,skills
  from job_skills where row_id=1
  union 
 select js.row_id,
 coalesce(js.job_role,cte.job_role)as job_role,js.skills from cte
 join job_skills js on js.row_id=cte.row_id+1)
 select * from cte;
