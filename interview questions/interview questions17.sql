-- Write SQL Query to Find Employees with at Least 3 Year-over-Year Salary Increases


DROP TABLE IF EXISTS employee_salary;

-- Create the table with employee name

CREATE TABLE employee_salary (
    employee_id INTEGER,
    name VARCHAR(255),
    year INTEGER,
    salary INTEGER,
    department VARCHAR(255)
);

-- Insert sample data with employee names

INSERT INTO employee_salary (employee_id, name, year, salary, department) VALUES
(125, 'John Doe', 2021, 50000, 'Sales'),
(125, 'John Doe', 2022, 52000, 'Sales'),
(125, 'John Doe', 2023, 54000, 'Sales'),
(125, 'John Doe', 2024, 56000, 'Sales'),
(102, 'Jane Smith', 2020, 45000, 'Marketing'),
(102, 'Jane Smith', 2021, 47000, 'Marketing'),
(102, 'Jane Smith', 2022, 49000, 'Marketing'),
(102, 'Jane Smith', 2023, 51000, 'Marketing'),
(165, 'Alice Johnson', 2021, 60000, 'Engineering'),
(165, 'Alice Johnson', 2022, 62000, 'Engineering'),
(165, 'Alice Johnson', 2023, 64000, 'Engineering'),
(200, 'Bob Brown', 2021, 55000, 'HR'),
(200, 'Bob Brown', 2022, 57000, 'HR'),
(200, 'Bob Brown', 2023, 58000, 'HR');

/*
-- Identify the employee who received at least 
 3 year over year increase in salaries!
*/

select * from employee_salary;

-- solution

with cte as
           (select *,
			lag(salary,1,0)over(partition by employee_id order by year)as prev_salary,
            lead(salary,1,0)over(partition by employee_id order by year)as for_salary,
            lead(salary,2,0)over(partition by employee_id order by year)as for1_salary
            from employee_salary
            ),
            cte1 as 
(select 
       case when prev_salary<salary<for_salary<for1_salary then name end as name from cte) 
       select distinct name  from cte1 where name is not null;