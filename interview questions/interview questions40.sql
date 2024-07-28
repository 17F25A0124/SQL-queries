

/*
Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.

Return the result table in in below order.RANGE


Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/



CREATE TABLE Transactions1 (
    id INT PRIMARY KEY,
    country VARCHAR(255),
    state VARCHAR(30),
    amount INT,
    trans_date DATE
);


INSERT INTO Transactions1 (id, country, state, amount, trans_date) VALUES
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');


/*
Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.

Return the result table in in below order.RANGE
*/

select * from transactions1;
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(trans_date) AS trans_count,
    SUM(CASE
        WHEN state = 'approved' THEN 1
        ELSE 0
    END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE
        WHEN state = 'approved' THEN amount
    END) AS approved_total_amount
FROM
    transactions1
GROUP BY 1 , 2;
