-- Write a SQL query to find the top 2 restaurants in each city with the highest average rating. If two restaurants have the same average rating, they should have the same rank.

DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;

-- Create cities table

CREATE TABLE cities (
    city_id SERIAL,
    city_name VARCHAR(50)
);

-- Create restaurants table

CREATE TABLE restaurants (
    restaurant_id SERIAL ,
    restaurant_name VARCHAR(100),
    city_id int
);

-- Create orders table with rating column

CREATE TABLE orders5 (
    order_id SERIAL ,
    restaurant_id INT,
    order_value DECIMAL(10, 2),
    order_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5)
);

-- Insert data into cities table

INSERT INTO cities (city_name) VALUES
('Mumbai'),
('Delhi'),
('Bengaluru');

-- Insert data into restaurants table

INSERT INTO restaurants (restaurant_name, city_id) VALUES
('Bademiya', 1),
('Bombay Canteen', 1),
('Trishna', 1),
('Karims', 2),
('Indian Accent', 2),
('Bukhara', 2),
('Toit', 3),
('Koshys', 3),
('MTR', 3);

-- Insert data into orders table with rating

INSERT INTO orders5 (restaurant_id, order_value, order_date, rating) VALUES
(1, 500.00, '2024-01-01', 4),
(1, 450.00, '2024-01-02', 5),
(1, 550.00, '2024-01-03', 4),
(2, 300.00, '2024-01-01', 3),
(2, 350.00, '2024-01-02', 4),
(2, 250.00, '2024-01-03', 3),
(3, 700.00, '2024-01-01', 5),
(3, 750.00, '2024-01-02', 4),
(3, 800.00, '2024-01-03', 5),
(4, 400.00, '2024-01-01', 4),
(4, 500.00, '2024-01-02', 5),
(4, 450.00, '2024-01-03', 4),
(5, 600.00, '2024-01-01', 5),
(5, 550.00, '2024-01-02', 4),
(5, 650.00, '2024-01-03', 5),
(6, 900.00, '2024-01-01', 5),
(6, 850.00, '2024-01-02', 5),
(6, 950.00, '2024-01-03', 4),
(7, 400.00, '2024-01-01', 3),
(7, 450.00, '2024-01-02', 4),
(7, 500.00, '2024-01-03', 3),
(8, 1000.00, '2024-01-01', 5),
(8, 1050.00, '2024-01-02', 4),
(8, 1100.00, '2024-01-03', 5),
(9, 800.00, '2024-01-01', 5),
(9, 850.00, '2024-01-02', 4),
(9, 900.00, '2024-01-03', 5);

SELECT * FROM cities;
SELECT * FROM restaurants;
SELECT * FROM orders5;

-- question once again
-- Write a SQL query to find the top 2 restaurants in each city with the highest average rating.
-- If two restaurants have the same average rating, they should have the same rank.

with cte as (
             select o.restaurant_id,avg(rating)as rtng,
					dense_rank()over(partition by c.city_name order by avg(rating) desc)as rnk,
                    r.restaurant_name,c.city_name
             from orders5 o 
             join restaurants r 
             on o.restaurant_id=r.restaurant_id
             join cities c 
             on r.city_id=c.city_id
             group by o.restaurant_id
			)
select restaurant_name,
       city_name 
from cte 
where rnk<=2;