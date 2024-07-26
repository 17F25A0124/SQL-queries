/* "PROBLEM STATEMENT: 
   Analyse the given input table and come up with output as shown."						
						
	INPUT	
---------------------------------------------------------
| STORE_ID |    PRODUCT_1     |       PRODUCT_2         |
|----------|------------------|-------------------------|
|    1	   | Apple - IPhone	  | Apple - MacBook Pro     |
|    1	   | Apple - AirPods  |	Samsung - Galaxy Phone  |
|    2	   | Apple_IPhone	  | Apple: Phone            |
|    2	   | Google Pixel	  | apple: Laptop           |
|    2	   | Sony: Camera	  | Apple Vision Pro        |
|    3	   | samsung - Galaxy | Phone	mapple notebook |
---------------------------------------------------------

EXPECTED OUTPUT
------------------------------------		
| STORE_ID | PRODUCT_1 | PRODUCT_2 |
|----------|-----------|-----------|
|    1	   |    2	   |    1      |
|    2	   |    1	   |    3      |
|    3	   |    0	   |    0      |
------------------------------------

*/

-- creating table

drop table if exists product_demo;
create table product_demo
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);

-- inserting values

insert into product_demo values (1, 'Apple - IPhone', '   Apple - MacBook Pro');
insert into product_demo values (1, 'Apple - AirPods', 'Samsung - Galaxy Phone');
insert into product_demo values (2, 'Apple_IPhone', 'Apple: Phone');
insert into product_demo values (2, 'Google Pixel', ' apple: Laptop');
insert into product_demo values (2, 'Sony: Camera', 'Apple Vision Pro');
insert into product_demo values (3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');

select * from product_demo;

-- solution 

select distinct  store_id, 
      sum(case when ltrim(lower(product_1)) like 'apple%' then 1 else 0 end) as prd_1
     ,sum(case when ltrim(lower(product_2)) like 'apple%' or 'apple%' then 1 else 0 end) as prd_2 
from product_demo
group by store_id
order by store_id;