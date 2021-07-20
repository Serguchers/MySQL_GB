drop database if exists lesson5;
create database lesson5;
use lesson5;

drop table if exists storehouses_products;
create table storehouses_products (
	id SERIAL primary key,
	value INT unsigned not null default 0
);

insert into storehouses_products(value) values 
	(1),
	(0),
	(30),
	(2500),
	(0),
	(500),
	(1230),
	(1000),
	(250);

select value, if(value > 0, 0, 1) as `inner` from storehouses_products
	order by `inner`, value;