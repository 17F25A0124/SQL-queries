/*	"PROBLEM STATEMENT:
You are given a table having the marks of one student in every test. 
You have to output the tests in which the student has improved his performance. 
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, one including the first test score and second excluding it."								
									
									
			
	INPUT
	-------------------
	|TEST_ID  |	MARKS |
    -------------------
	|  100	  |  55   |
	|  101	  |  55   |
	|  102	  |  60   |
	|  103	  |  58   |
	|  104	  |  40   |
	|  105	  |  50   |
    -------------------
    
OUTPUT - 1                              
------------------	
|TEST_ID  |	MARKS |
------------------
|  100	  |   55  |
|  102	  |   60  |
|  105	  |   50  |
-------------------

	OUTPUT - 2
	-------------------
	|TEST_ID  |	MARKS |
    -------------------
	|  102	  |   60  |
	|  105	  |   50  |
    -------------------
		*/

-- create table

create table student_tests
(
	test_id		int,
	marks		int
);

-- inserting values 

insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;
 
 -- solution
 
-- output1

select test_id,marks from
(select *,lag(marks,1,0) over(order by test_id) as prev_test_marks
from student_tests) x
where x.marks> x.prev_test_marks;

-- output2

select test_id,marks from
(select *,lag(marks,1,marks) over(order by test_id) as prev_test_marks
from student_tests) x
where x.marks> x.prev_test_marks;

