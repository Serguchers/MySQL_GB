select * from users where id in (select user_id from orders o);

select distinct name from users inner join orders on users.id = orders.user_id ;