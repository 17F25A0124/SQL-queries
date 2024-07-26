/* Flipkart Data Analyst Interview Questions
 Question: Write an SQL query to fetch user IDs that 
have only bought both 'Burger' and 'Cold Drink' items.
 Expected Output Columns: user_id
*/

DROP TABLE IF EXISTS orders;

-- Create the orders table
CREATE TABLE orders3 (
    user_id INT,
    item_ordered VARCHAR(512)
);

-- Insert sample data into the orders table
INSERT INTO orders3 VALUES 
('1', 'Pizza'),
('1', 'Burger'),
('2', 'Cold Drink'),
('2', 'Burger'),
('3', 'Burger'),
('3', 'Cold Drink'),
('4', 'Pizza'),
('4', 'Cold Drink'),
('5', 'Cold Drink'),
('6', 'Burger'),
('6', 'Cold Drink'),
('7', 'Pizza'),
('8', 'Burger');


select * from orders3;

-- solution

select user_id 
from(SELECT user_id,
            sum(case when item_ordered in('burger','cold drink') then 1 
                else 0 end
                ) as checks 
	 from orders3
group by user_id)x
where checks=2;
