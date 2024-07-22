	
    /* Problem Statement:  Derive expected output
    
    	INPUT
----------------------------		
|	ID | NAME  | LOCATION  |
---------------------------   
|	1  |	   |           |
|	2  | David |           |
|	3  |	   | London    |
|	4  |	   |           |
|	5  | David |           |
---------------------------- 

    EXPECTED OUTPUT - 1	  	  EXPECTED OUTPUT - 2	
  ------------------------     ----------------------------
  |	ID | NAME  | LOCATION |	   |  ID  |	NAME  |	LOCATION  |
  |----|-------|----------|    |------|-------|-----------|
  |	1  | David | London	  |	   |   5  |	David |	London	  |
  -------------------------    ----------------------------
*/

-- create table 

create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);

-- insert values

insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

-- solution for output1

select * from Q4_data;

select min(id),min(name),min(location) from q4_data;

-- solution for output2

select max(id),max(name),max(location) from q4_data;
