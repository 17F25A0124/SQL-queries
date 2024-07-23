/*	"PROBLEM STATEMENT: 
Write an sql query to merge products per customer for each day as shown in expected output."						
							
			
	INPUT
    ------------------------------------------
	|CUSTOMER_ID  |	   DATES   |  PRODUCT_ID |
    |----------------------------------------|
	|     1	      | 18-02-2024 |	101      |
	|     1	      | 18-02-2024 |	102      |
	|     1	      | 19-02-2024 |	101      |
	|     1	      | 19-02-2024 |	103      |
	|     2	      | 18-02-2024 |	104      |
	|     2 	  | 18-02-2024 |	105      |
	|     2	      | 19-02-2024 |	101      |
	|     2       |	19-02-2024 |	106      |
    ------------------------------------------
    
    
    	OUTPUT	
    ----------------------------    
	|   DATES	  |  PRODUCTS  |
    |--------------------------|
	| 18-02-2024  |	  101      |
	| 18-02-2024  |	  1,01,102 |
	| 18-02-2024  |	  102      |
	| 18-02-2024  |   104      |
	| 18-02-2024  |	  104,105 |
	| 18-02-2024  |	  105      |
	| 19-02-2024  |	  101      |
	| 19-02-2024  |	  101,103 |
	| 19-02-2024  |	  101,106 |
	| 19-02-2024  |	  103      |
	| 19-02-2024  |	  106      |
    ----------------------------

*/

-- creating table

CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);

-- inserting values

INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 


select * from orders;

-- solution

SELECT 
    dates, product_id as products
FROM
    orders
union    
    SELECT 
    dates, group_concat(product_id) as product
FROM
    orders
-- WHERE
 --   customer_id = 1 AND dates = '2024-02-18'
    group by dates,customer_id 
    order by dates,products;
