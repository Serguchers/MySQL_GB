drop table if exists logs;
create table logs(
	entry bigint unsigned not null,
	table_name varchar(50),
	created_at datetime default now(),
	name varchar(100)	
) ENGINE=Archive;

drop trigger if exists logging_users;
delimiter //
create trigger logging_users after insert on users
for each row	
	begin 
		insert into logs(entry, table_name, name) values (new.id, 'users', new.name);
	end//

drop trigger if exists logging_catalogs;
delimiter //
create trigger logging_catalogs after insert on catalogs
for each row	
	begin 
		insert into logs(entry, table_name, name) values (new.id, 'catalogs', new.name);
	end//

	drop trigger if exists logging_products;
delimiter //
create trigger logging_products after insert on products
for each row	
	begin 
		insert into logs(entry, table_name, name) values (new.id, 'products', new.name);
	end//

