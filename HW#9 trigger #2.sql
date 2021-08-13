drop table if exists my_products;
create table my_products (
	id serial primary key,
	name varchar(255),
	description text
);

drop trigger if exists products_filter;

delimiter //
create trigger products_filter before insert on my_products
for each row 
begin 
	if new.name is null and new.description is null then 
		signal sqlstate '45000' set message_text = 'Name and description are not allowed to be null';
	end if;
end//

drop trigger if exists products_filter_update;

delimiter //
create trigger products_filter_update before update on my_products 
for each row 
begin 
	if new.name is null and new.description is null then 
		set new.name = old.name;
		set new.description = old.description;
	end if;
end//
