
-- find the managers for employees

CREATE TABLE employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Manager_ID INT
);


INSERT INTO employees (Emp_ID, Emp_Name, Manager_ID) VALUES
(1, 'John', 3),
(2, 'Philip', 3),
(3, 'Keith', 7),
(4, 'Quinton', 6),
(5, 'Steve', 7),
(6, 'Harry', 5),
(7, 'Gill', 8),
(8, 'Rock', NULL);

select * from employees;

-- solution

SELECT 
    e.*, e1.emp_name AS manager_name
FROM
    employees e
        JOIN
    employees e1 ON e.manager_id = e1.emp_id;