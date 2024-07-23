/* "PROBLEM STATEMENT: 
  In the given input table, some of the invoice are missing, 
  write a sql query to identify the missing serial no. 
  As an assumption, consider the serial no with the lowest value
  to be the first generated invoice and the highest serial no value to be the last generated invoice"				
			
            		
	INPUT
	----------------------------
	| SERIAL_NO | INVOICE_DATE |
    |--------------------------|
	|  330115	|  01-03-2024  |
	|  330120	|  01-03-2024  |
	|  330121	|  01-03-2024  |
	|  330122	|  02-03-2024  |
	|  330125	|  02-03-2024  |
    ----------------------------


OUTPUT
---------------------
| MISSING_SERIAL_NO |
|-------------------|
|     330116        |
|     330117        |
|     330118        |
|     330119        |
|     330123        |
|     330124        |
---------------------
*/

-- creating table

create table invoice
(
	serial_no		int,
	invoice_date	date
);

-- inserting values

insert into invoice values (330115, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330120, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330121, to_date('01-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330122, to_date('02-Mar-2024','DD-MON-YYYY'));
insert into invoice values (330125, to_date('02-Mar-2024','DD-MON-YYYY'));

select * from invoice;


-- solution

select * from invoice;
select generate_series(1,10);
with recursive cte as 
(select min(serial_no) as n from invoice
union
select (n+1)as n 
from cte
where n<(select max(serial_no) from invoice))
select * from cte
where n not in (  -- we can use execpt function here 
select serial_no from invoice);

