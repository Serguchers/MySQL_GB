start transaction;
insert into sample.users select * from gb_lesson_9.users where id = 1;
commit;