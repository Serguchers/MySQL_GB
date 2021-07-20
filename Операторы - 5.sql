drop database if exists lesson5;
create database lesson5;
use lesson5;

drop table if exists catalogs;
create table catalogs (
	id int unsigned not null,
	name varchar(255)
);

insert into catalogs values
	(1, 'Test'),
	(2, 'Test1'),
	(3, 'Test2'),
	(4, 'Test3'),
	(5, 'Test4'),
	(6, 'Test5'),
	(7, 'Test6'),
	(8, 'Test7'),
	(9, 'Test8'),
	(10, 'Test9'),
	(11, 'Test10');

select * from catalogs where id in (5, 1, 2) order by field(id, 5, 1, 2);
	
