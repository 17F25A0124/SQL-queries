
/*	"PROBLEM STATEMENT: Given table contains reported covid cases in 2020. 
  Calculate the percentage increase in covid cases each month versus cumulative cases 
  as of the prior month.
  Return the month number, and the percentage increase rounded to one decimal. 
  Order the result by the month."					
						
	INPUT	
---------------------------------    
| CASES_REPORTED  |    DATE     |
|-------------------------------|
|     20124	      | 10-01-2020  |
|     40133	      | 15-01-2020  |
|     65005	      | 20-01-2020  |
|     30005	      | 08-02-2020  |
|     35015	      | 19-02-2020  |
|     15015	      | 03-03-2020  |
|     35035	      | 10-03-2020  |
|     49099	      | 14-03-2020  |
|     84045	      | 20-03-2020  |
|     100106	  | 31-03-2020  |
|     17015	      | 04-04-2020  |
|     36035	      | 11-04-2020  |
|     50099	      | 13-04-2020  |
|     87045	      | 22-04-2020  |
|     101101	  | 30-04-2020  |
|     40015	      | 01-05-2020  |
|     54035	      | 09-05-2020  |
|     71099	      | 14-05-2020  |
|     82045	      | 21-05-2020  |
|     90103	      | 25-05-2020  |
|     99103	      | 31-05-2020  |
|     11015	      | 03-06-2020  |
|     28035	      | 10-06-2020  |
|     38099	      | 14-06-2020  |
|     45045	      | 20-06-2020  |
|     36033	      | 09-07-2020  |
|     40011	      | 23-07-2020  |
|     25001	      | 12-08-2020  |
|     29990	      | 26-08-2020  |
|     20112	      | 04-09-2020  |
|     43991	      | 18-09-2020  |
|     51002	      | 29-09-2020  |
|     26587	      | 25-10-2020  |
|     11000	      | 07-11-2020  |
|     35002	      | 16-11-2020  |
|     56010	      | 28-11-2020  |
|     15099	      | 02-12-2020  |
|     38042	      | 11-12-2020  |
|     73030	      | 26-12-2020  |
---------------------------------

OUTPUT
--------------------------------	
| MONTH  | PERCENTAGE_INCREASE |
|------------------------------|
|   1	 |         -           |
|   2	 |         51.9        |
|   3	 |         148.9       |
|   4	 |         61.5        |
|   5	 |         57.1        |
|   6	 |         10.2        |
|   7	 |         5.7         |
|   8	 |         3.9         |
|   9	 |         7.9         |
|   10	 |         1.7         |
|   11	 |         6.4         |
|   12	 |         7.4         |
--------------------------------
					
*/						

-- creating table


create table covid_cases
(
	cases_reported	int,
	dates			date	
);

-- inserting values

insert into covid_cases values(20124,'2020/01/10');
insert into covid_cases values(40133,'2020/01/15');
insert into covid_cases values(65005,'2020/01/20');
insert into covid_cases values(30005,'2020/02/08');
insert into covid_cases values(35015,'2020/02/19');
insert into covid_cases values(15015,'2020/03/03');
insert into covid_cases values(35035,'2020/03/10');
insert into covid_cases values(49099,'2020/03/14');
insert into covid_cases values(49099,'2020/03/20');
insert into covid_cases values(49099,'2020/03/31');
insert into covid_cases values(49099,'2020/04/04');
insert into covid_cases values(49099,'2020/04/11');
insert into covid_cases values(49099,'2020/04/13');
insert into covid_cases values(49099,'2020/04/22');
insert into covid_cases values(49099,'2020/04/30');
insert into covid_cases values(49099,'2020/05/01');
insert into covid_cases values(49099,'2020/05/09');
insert into covid_cases values(49099,'2020-05-14');
insert into covid_cases values(49099,'2020-05-21');
insert into covid_cases values(49099,'2020-05-25');
insert into covid_cases values(49099,'2020-05-31');
insert into covid_cases values(49099,'2020-06-03');
insert into covid_cases values(49099,'2020-06-10');
insert into covid_cases values(49099,'2020-06-14');
insert into covid_cases values(49099,'2020-06-20');
insert into covid_cases values(49099,'2020-07-09');
insert into covid_cases values(49099,'2020-07-23');	
insert into covid_cases values(49099,'2020-08-12');
insert into covid_cases values(49099,'2020-08-26');
insert into covid_cases values(49099,'2020-09-04');
insert into covid_cases values(49099,'2020-09-18');
insert into covid_cases values(49099,'2020-09-29');
insert into covid_cases values(49099,'2020-10-25');
insert into covid_cases values(49099,'2020-11-07');	
insert into covid_cases values(49099,'2020-11-16');
insert into covid_cases values(49099,'2020-11-28');
insert into covid_cases values(49099,'2020-12-02');	
insert into covid_cases values(49099,'2020-12-11');	
insert into covid_cases values(49099,'2020-12-26');

select * from covid_cases;

-- solution 

with cte as
(select 
  month(dates)as month,
  sum(cases_reported)as monthly_cases
  from covid_cases group by month),
cte1 as(
         select *,
          sum(monthly_cases)over(order by month)as total_cases from cte)
  select month,
   case when month>1 
        then round((monthly_cases/lag(total_cases)over(order by month))*100,1) 
        else '-' end as percentage from cte1;

