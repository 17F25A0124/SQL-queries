/*find the buyer id who bought only s8 and not iphone  */

-- creating table
create table product(product_id int,
product_name varchar(20),
unit_price int);

-- inserting values

insert into product values(1,'S8',1000),
(2,'G4',800),(3,'Iphone',1400);

-- creating table 

create table sales2(seller_id int,
product_id int,buyer_id int,sale_date date,quantity int,price int);

-- inserting values

insert into sales2 values(1,1,1,'2019-01-21',2,2000),
(1,2,2,'2019-02-17',1,800),
(2,1,3,'2019-06-02',1,800),
(3,3,3,'2019-05-13',2,2800);

select * from product;
select * from sales2;

-- solution

with cte as
          (select p.product_name,
				  s.* 
		   from product p 
           join sales2 s 
           on p.product_id=s.product_id 
           )
    select buyer_id 
    from  cte 
    where product_name='s8' 
    and buyer_id not in(
                        select buyer_id 
                        from cte 
                        where product_name='iphone');
