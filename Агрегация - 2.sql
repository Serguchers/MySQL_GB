drop database if exists lesson5;
create database lesson5;
use lesson5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE 
);

insert into users(name, birthday_at) values
('Sergei', '1995-12-01'),
('Sergei1', '1995-12-01'),
('Sergei2', '1995-12-01'),
('Anton', '1992-02-13'),
('Olga', '2000-01-24'),
('Svetlana', '1991-11-12'),
('Svetlana12', '1991-11-12');

select group_concat(name), 
	date_format(concat(year(now()),'.', date_format(birthday_at, '%m.%d')), '%W') as day_of_birth, 
	count(*) 
from users
group by day_of_birth
; 