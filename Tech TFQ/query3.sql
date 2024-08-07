/* PROBLEM STATEMENT: Write a sql query to return 
  the footer values from input table, meaning all the last non 
  null values from each field as shown in expected output. */									
										
-- creating table 										

CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

-- inserting values 

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;


-- solution 1

SELECT 
    *
FROM
    (SELECT 
        car
    FROM
        footer
    WHERE
        car IS NOT NULL
    ORDER BY id DESC
    LIMIT 1) car
        CROSS JOIN
    (SELECT 
        length
    FROM
        footer
    WHERE
        length IS NOT NULL
    ORDER BY id DESC
    LIMIT 1) length
        CROSS JOIN
    (SELECT 
        width
    FROM
        footer
    WHERE
        width IS NOT NULL
    ORDER BY id DESC
    LIMIT 1) width
        CROSS JOIN
    (SELECT 
        height
    FROM
        footer
    WHERE
        height IS NOT NULL
    ORDER BY id DESC
    LIMIT 1) height;


-- soution 2

with cte as
(select *,
sum(case when car is not null then 1 else 0 end) over(order by id)as car_segment,
sum(case when length is not null then 1 else 0 end) over(order by id)as len_segment,
sum(case when width is not null then 1 else 0 end) over(order by id)as width_segment,
sum(case when height is not null then 1 else 0 end) over(order by id)as height_segment
from footer)
select 
first_value(car) over(partition by car_segment order by id) as new_car,
first_value(length) over(partition by len_segment order by id) as new_length,
first_value(width) over(partition by width_segment order by id) as new_width,
first_value(height) over(partition by len_segment order by id) as new_height
from cte
order by id desc
limit 1;