
/*	PROBLEM STATEMENT: Find the median ages of countries						
	
    INPUT
-------------------------    
| ID | COUNTRY  |  AGE  |
|----|----------|-------|
| 1	 | Poland   |  10   |
| 2	 | Poland   |  5    |
| 3	 | Poland   |  34   |
| 4	 | Poland   |  56   |
| 5	 | Poland   |  45   |
| 6	 | Poland   |  60   |
| 7  | India    |  18   |
| 8	 | India    |  15   |
| 9  | India    |  33   |
| 10 | India    |  38   |
| 11 | India    |  40   |
| 12 | India    |  50   |
| 13 | USA	    |  20   |
| 14 | USA	    |  23   |
| 15 | USA	    |  32   |
| 16 | USA	    |  54   |
| 17 | USA	    |  55   |
| 18 | Japan    |  65   |
| 19 | Japan    |  6    |
| 20 | Japan    |  58   |
| 21 | Germany  |  54   |
| 22 | Germany  |  6    |
| 23 | Malaysia |  44   |
-------------------------

OUTPUT	
--------------------
| COUNTRY  |  AGE  |
|----------|-------|
| Germany  |  6    |
| Germany  |  54   |
| India	   |  33   |
| India	   |  38   |
| Japan	   |  58   |
| Malaysia |  44   |
| Poland   |  34   |
| Poland   |  45   |
| USA	   |  32   |
--------------------
*/

-- creating table

create table people
(
	id			int,
	country		varchar(20),
	age			int
);

-- inserting values

insert into people values(1 ,'Poland',10 );
insert into people values(2 ,'Poland',5  );
insert into people values(3 ,'Poland',34   );
insert into people values(4 ,'Poland',56);
insert into people values(5 ,'Poland',45  );
insert into people values(6 ,'Poland',60  );
insert into people values(7 ,'India',18   );
insert into people values(8 ,'India',15   );
insert into people values(9 ,'India',33 );
insert into people values(10,'India',38 );
insert into people values(11,'India',40 );
insert into people values(12,'India',50  );
insert into people values(13,'USA',20 );
insert into people values(14,'USA',23 );
insert into people values(15,'USA',32 );
insert into people values(16,'USA',54 );
insert into people values(17,'USA',55  );
insert into people values(18,'Japan',65  );
insert into people values(19,'Japan',6  );
insert into people values(20,'Japan',58  );
insert into people values(21,'Germany',54  );
insert into people values(22,'Germany',6  );
insert into people values(23,'Malaysia',44  );

select * from people;

-- solution

with cte as
(select *,
         row_number() over(partition by country order by age) as age_rnk ,
         count(id)over(
                       partition by country order by age 
                       range between unbounded preceding and unbounded following
                       ) as ttl_ppl
from 
people)
select country,
       age 
from cte 
where age_rnk>=ttl_ppl/2 and age_rnk<=(ttl_ppl/2)+1;

