
/*	"PROBLEM STATEMENT: 
  For the given friends, find the no of mutual friends"					
						
		
INPUT	
---------------------
| FRIEND1 |	FRIEND2 |
|-------------------|
|  Jason  |  Mary   |
|  Mike	  |  Mary   |
|  Mike	  |  Jason  |
|  Susan  |	 Jason  |
|  John	  |  Mary   |
|  Susan  |	 Mary   |
---------------------
					
		OUTPUT
-------------------------------------		
| FRIEND1 |	FRIEND2 | MUTAL_FRIENDS |
|-----------------------------------|
|  Jason  |  Mary	|      2        |
|  John	  |  Mary	|      0        |
|  Mike	  |  Jason	|      1        |
|  Mike	  |  Mary	|      1        |
|  Susan  |	 Jason	|      1        |
|  Susan  |	 Mary	|      1        |
-------------------------------------

*/

-- creating table 

CREATE TABLE Friends
(
	Friend1 	VARCHAR(10),
	Friend2 	VARCHAR(10)
);

-- inserting values

INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;

-- solution 

with cte as(select friend1,friend2 from friends
union all
select friend2,friend1 from friends)
select distinct f.*,-- a.Friend2 as mutual_friends,
count(a.Friend2)over(partition by f.Friend1,f.Friend2 order by a.friend2
range between unbounded preceding and unbounded following) as mutual_frnds
from friends f 
left join cte a on f.friend1=a.friend1 and a.Friend2 in (select b.friend2 
                                       from cte b 
                                     where b.friend1=f.friend2)
-- where f.friend1='jason';

