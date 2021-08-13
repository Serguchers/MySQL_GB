create or replace view not_delete as select id from users order by created_at desc limit 5;
delete from users where id not in(select id from not_delete);
