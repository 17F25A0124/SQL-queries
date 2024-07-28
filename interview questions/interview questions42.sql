

CREATE TABLE department (
    Department_ID INT PRIMARY KEY,
    Department VARCHAR(50),
    Location_ID INT
);

-- Insert data into department table

INSERT INTO department (Department_ID, Department, Location_ID)
VALUES 
    (10, 'Accounting', 122),
    (20, 'Research', 124),
    (30, 'Sales', 123),
    (40, 'Operations', 167);


-- Create emp_fact table

DROP TABLE IF EXISTS emp_fact;
CREATE TABLE emp_fact (
    Employee_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Job_ID INT,
    Manager_ID INT,
    Hired_Date DATE,
    Salary DECIMAL(10, 2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID)
);

-- Insert data into emp_fact table

INSERT INTO emp_fact (Employee_ID, Emp_Name, Job_ID, Manager_ID, Hired_Date, Salary, Department_ID)
VALUES 
    (7369, 'John', 667, 7902, '2006-02-20', 800.00, 10),
    (7499, 'Kevin', 670, 7698, '2008-11-24', 1550.00, 20),
    (7505, 'Jean', 671, 7839, '2009-05-27', 2750.00, 30),
    (7506, 'Lynn', 671, 7839, '2007-09-27', 1550.00, 30),
    (7507, 'Chelsea', 670, 7110, '2014-09-14', 2200.00, 30),
    (7521, 'Leslie', 672, 7698, '2012-02-06', 1250.00, 30);

-- Create jobs table

DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
    Job_ID INT PRIMARY KEY,
    Job_Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Insert data into jobs table
INSERT INTO jobs (Job_ID, Job_Role, Salary)
VALUES 
    (667, 'Clerk', 800.00),
    (668, 'Staff', 1600.00),
    (669, 'Analyst', 2850.00),
    (670, 'Salesperson', 2200.00),
    (671, 'Manager', 3050.00),
    (672, 'President', 1250.00);

SELECT * FROM department;
SELECT * FROM emp_fact;
SELECT 
    *
FROM
    jobs;


-- i. List out the department wise maximum salary, minimum salary, average salary of the employees.

-- solution

 select d.department, 
        max(e.salary),
        min(e.salary),
        round(avg(e.salary),2) 
 from emp_fact e 
 join department d 
 on d.department_id=e.department_id 
 group by d.department;
 
-- ii. List out employee having the third highest salary.

-- solution

select emp_name 
from (
      select *,
             dense_rank()over(order by salary desc)as rnk 
      from emp_fact
	 )x 
where rnk=3;


-- iii. List out the department having at least four employees.

-- solution

SELECT 
    d.department, COUNT(e.emp_name) AS no_of_emp
FROM
    emp_fact e
        JOIN
    department d ON d.department_id = e.department_id
HAVING no_of_emp >= 4;

  
-- iv. Find out the employees who earn greater than the average salary for their department.

-- solution

select emp_name,department,salary,avg_sal
from (
	  select d.department,
             e.emp_name,
             e.salary,
             round(avg(e.salary)over(partition by e.department_id),2)as avg_sal 
      from emp_fact e 
      join 
           department d 
	  on d.department_id=e.department_id
	 )x 
 where salary>avg_sal;