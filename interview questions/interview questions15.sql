
-- -------------------------------

/*
Advanced Walmart Sales Analysis Question
Question:
Walmart wants to identify seasonal sales trends and understand customer purchasing behavior during different times of the year. You have the following tables: Sales, Products, and Customers.
*/

DROP TABLE IF EXISTS products;
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 799.99),
(3, 'Headphones', 'Electronics', 199.99),
(4, 'Refrigerator', 'Appliances', 1499.99),
(5, 'Microwave', 'Appliances', 299.99),
(6, 'T-shirt', 'Clothing', 19.99),
(7, 'Jeans', 'Clothing', 49.99),
(8, 'Blender', 'Appliances', 99.99),
(9, 'Coffee Maker', 'Appliances', 79.99),
(10, 'Shoes', 'Clothing', 89.99);




DROP TABLE IF EXISTS sales;
CREATE TABLE Sales4 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sales4 (sale_id, product_id, customer_id, sale_date, quantity, amount) VALUES
(1, 1, 101, '2023-01-15', 1, 999.99),
(2, 2, 102, '2023-02-16', 2, 1599.98),
(3, 3, 103, '2023-03-17', 3, 599.97),
(4, 4, 104, '2023-04-18', 1, 1499.99),
(5, 5, 105, '2023-05-19', 2, 599.98),
(6, 6, 101, '2023-06-20', 5, 99.95),
(7, 7, 102, '2023-07-21', 3, 149.97),
(8, 8, 103, '2023-08-22', 1, 99.99),
(9, 9, 104, '2023-09-23', 2, 159.98),
(10, 10, 105, '2023-10-24', 1, 89.99),
(11, 1, 101, '2023-11-24', 1, 999.99),
(12, 2, 102, '2023-11-25', 2, 1599.98),
(13, 3, 103, '2023-11-26', 3, 599.97),
(14, 4, 104, '2023-11-27', 1, 1499.99),
(15, 5, 105, '2023-11-28', 2, 599.98);


/*
Interview Question
Tasks:

1. Write a query to find the top 3 products with the 
highest sales volume (total quantity sold) for each quarter of the year 2023.

*/

/* Walmart wants to identify seasonal sales trends and understand customer purchasing
 behavior during different times of the year. Y
 ou have the following tables: Sales, Products, and Customers.
*/
select * from sales4;
select * from products;

select product_name,volume,qrter as quarter from(select p.product_name,s.quantity as volume,quarter(s.sale_date)as qrter 
,dense_rank()over(partition by quarter(sale_date) order by quantity desc)as rnk
from sales4 s join products p on s.product_id=p.product_id)x
where rnk<=3; 
