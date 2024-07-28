-- Question No --2
-- in this question we need to find  how to write the left join  and full join
CREATE TABLE t1(c1 INT);

CREATE TABLE t2(c2 VARCHAR(5));

INSERT INTO t1
VALUES
(4),
(6),
(7),
(9),
(3),
(9);

INSERT INTO t2
VALUES
(1),
(5),
(9),
(2),
(2),
(11);

select * from t1;
select * from t2;

select t1.c1 from t1 left join t2 on t1.c1=t2.c2;
select c1 from t1 full join t2 ;
