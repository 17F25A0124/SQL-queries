/*
-- Walmart Data Analyst Interview Question

Write a solution to select the product id, year, quantity, 
and price for the first year of every product sold.
*/

-- creating table, in my database i already have sales table so i created sales3 table

CREATE TABLE Sales3 (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

-- Insert sample records into Sales table

INSERT INTO Sales3 (sale_id, product_id, year, quantity, price) 
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000),
(3, 100, 2010, 8, 5500),
(4, 100, 2011, 15, 4800),
(5, 200, 2013, 20, 8500),
(6, 200, 2006, 18, 9200),
(8, 300, 2012, 25, 7500),
(9, 300, 2009, 30, 7200),
(10, 300, 2013, 22, 6800);



 select * from sales3;

-- solution

 select 
 product_id,year,quantity,price 
 from 
 (select *,rank()over(partition by product_id order by year asc)as rk from sales3)x
 where rk=1;
