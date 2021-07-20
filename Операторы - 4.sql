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
	('Maxim', '1992-03-30', '21.03.2015 12:22', '23.11.2020 18:10'),
	('Andrey', '1992-08-30', '21.03.2015 12:22', '23.11.2020 18:10'),
	('Mikhail', '1992-05-30', '21.03.2015 12:22', '23.11.2020 18:10')
;
	
-- Nemnogo izmenil usloviya zadaniya chtobi poprobovat CASE
select name, 
	case 
		when month(birthday_at) = 5 then 'may'
		when month(birthday_at) = 8 then 'august'
	end
from users
	where 
		month(birthday_at) = 5 or 
		month(birthday_at) = 8;
		
-- Reshenie, soglasno usloviyu
select name, birthday_at from users 
	where birthday_at like '%may%' or 
		  birthday_at like '%august%';