drop database if exists lesson5;
create database lesson5;
use lesson5;

-- Create table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE ,
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
);

insert into users(name, birthday_at) values
('Sergei', '1995-12-01'),
('Anton', '1992-02-13'),
('Olga', '2000-01-24'),
('Svetlana', '1991-11-12');

-- Copy table to compare with unmodified
drop table if exists users_fixed;
create table users_fixed (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
);

insert into users_fixed
	select * from users;
	
update users_fixed set 
	created_at = if(created_at is null, NOW(), created_at),
	updated_at = if(updated_at is null, NOW(), updated_at);