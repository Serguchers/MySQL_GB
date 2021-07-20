drop database if exists lesson5;
create database lesson5;
use lesson5;

drop table if exists value_check;
create table values_check(
	value int);

insert into values_check values (1), (2), (3), (4), (5);
select exp(sum(log(value))) from values_check;