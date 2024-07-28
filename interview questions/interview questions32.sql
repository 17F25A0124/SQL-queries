
    /* IBM Data Analyst SQL Question
Q.1
Customer Segmentation Problem:
You have two tables: customers and orders.

customers table has columns: 
  customer_id, customer_name, age, gender.
orders table has columns: 
order_id, customer_id, order_date, total_amount.


Write an SQL query to find the average order amount 
for male and female customers separately
return the results with 2 DECIMAL.
*/

CREATE TABLE customers1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE orders1 (
    order_id INT primary key,
    customer_id INT ,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers1(customer_id)
);


-- Insert values into the customers table
INSERT INTO customers1 (customer_id, customer_name, age, gender)
VALUES
    (1, 'John Doe', 30, 'Male'),
    (2, 'Jane Smith', 25, 'Female'),
    (3, 'Alice Johnson', 35, 'Female'),
    (4, 'Bob Brown', 40, 'Male');

-- Insert values into the orders table
INSERT INTO orders1 (order_id, customer_id, order_date, total_amount)
VALUES
    (101, 1, '2023-01-15', 150.50),
    (102, 2, '2022-02-20', 200.25),
    (103, 3, '2023-03-10', 180.75),
    (104, 4, '2023-04-05', 300.00),
    (105, 1, '2022-05-12', 175.80),
    (106, 2, '2021-06-18', 220.40),
    (107, 3, '2023-07-22', 190.30),
    (108, 4, '2023-08-30', 250.60),
	(109, 4, '2021-08-30', 250.60),
	(110, 4, '2024-01-30', 250.60),
	(111, 4, '2023-08-30', 250.60);
    
    
    /* IBM Data Analyst SQL Question
Q.1
Customer Segmentation Problem:
You have two tables: customers and orders.

Write an SQL query to find the average order amount 
for male and female customers separately
return the results with 2 DECIMAL.
*/

select * from customers1;
select * from orders1;


-- solution

SELECT 
    c.gender, ROUND(AVG(total_amount), 2) AS avg_amount
FROM
    orders1 o
        JOIN
    customers1 c ON o.customer_id = c.customer_id
GROUP BY c.gender;
 