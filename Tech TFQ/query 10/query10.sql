
-- creating table

create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);

-- inserting values

insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');

select * from auto_repair;

-- solution 1

select * from auto_repair where indicator='level';
select * from auto_repair where indicator='velocity';


with cte as 
(select v.value as velocity,l.value as level , count(1) as value
from auto_repair l
join auto_repair v on l.client=v.client and l.auto=v.auto and l.repair_date=v.repair_date
where l.indicator='level'
and v.indicator ='velocity'
group by v.value,l.value
order by v.value,l.value)
select velocity ,
sum(case when level='good' then value else 0 end) as good,
sum(case when level='wrong' then value else 0 end) as wrong,
sum(case when level='regular' then value else 0 end) as regular
from cte
group by velocity
;


