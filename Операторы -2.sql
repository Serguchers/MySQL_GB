drop database if exists lesson5;
create database lesson5;
use lesson5;

-- Create table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE ,
  created_at VARCHAR(255) DEFAULT NULL,
  updated_at VARCHAR(255) DEFAULT NULL
);

insert into users(name, birthday_at, created_at, updated_at) values
	('Sergei', '1995-12-01', '18.11.2018 18:10', '20.12.2019 8:10'),
	('Anton', '1992-02-13', '11.01.2018 18:10', '20.01.2019 8:13'),
	('Olga', '2000-01-24', '01.11.2018 11:15', '12.12.2019 18:10'),
	('Svetlana', '1991-11-12', '21.02.2014 13:25', '23.12.2019 14:33'),
	('Maxim', '1992-03-30', '21.03.2015 12:22', '23.11.2020 18:10');
	
-- Copy table to compare with unmodified
DROP TABLE IF EXISTS users_fixed;
CREATE TABLE users_fixed (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE ,
  created_at VARCHAR(255) DEFAULT NULL,
  updated_at VARCHAR(255) DEFAULT NULL
);

insert into users_fixed
	select * from users;


update users_fixed set
	created_at = str_to_date(created_at, '%d.%m.%Y %H:%i'),
	updated_at = str_to_date(updated_at, '%d.%m.%Y %H:%i');

alter table users_fixed change created_at created_at datetime default now();
alter table users_fixed change updated_at updated_at datetime default now() on update now();
	