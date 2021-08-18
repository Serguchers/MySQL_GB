update chair set name = 'Economics and Management' where id = 1;
update chair set name = 'Media and art' where id = 2;
update chair set name = 'Foreign languages ??and linguistics' where id = 3;
update chair set name = 'Education' where id = 4;
update chair set name = 'Philosophy and Humanities' where id = 5;
update chair set name = 'Philosophy and Humanities' where id = 6;
update chair set name = 'Computer Science and Engineering' where id = 7;
update chair set name = 'Engineering and technical service' where id = 8;
update chair set name = 'Jurisprudence' where id = 9;
update chair set name = 'Physics and Materials Science' where id = 10;

update profiles set status = 'student';
update profiles set status = 'teacher' where id in(select teacher_id from stud_teachers) limit 150;



delimiter //
drop procedure if exists edit_courses//
create procedure edit_courses ()
	begin
			declare i int default 1;
			declare creator int default 0;
			while i <= 300 do
				set @creator := (select id from profiles where status = 'teacher' order by rand() limit 1);
				update courses set 
				creator_id = @creator
				where creator_id not in(select id from profiles where status ='teacher') limit 1;
				set i := i + 1;
		end  while;
	end //
call edit_courses();

delimiter //
drop procedure if exists edit_messages//
create procedure edit_messages ()
	begin
		declare i int default 1;
		while i <= 2000 do
			set @reciever := (select id from profiles order by rand() limit 1);
			update messages set
				to_user_id = @reciever
			where from_user_id = to_user_id limit 1;
			set i = i + 1;
		end while;
	end//
	
call edit_messages();

