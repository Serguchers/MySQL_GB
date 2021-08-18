drop procedure if exists actualize_users;
delimiter //
create procedure actualize_users (in `year` int)
	begin
		delete  from users where id in(select id from profiles where year(created_at) < `year`);
	end//

	
drop procedure if exists user_creation;
delimiter //
create procedure user_creation 
(firstname varchar(50), lastname varchar(50), email varchar(100), pass_hash varchar(255),
phone int, gender enum('M', 'F'), birthday date, nationality enum('local', 'non-local', 'non-resident'),
status enum('teacher', 'student'), group_id int)
	begin
		insert into users(firstname, lastname, email, password_hash, phone_number) values
			(firstname, lastname, email, password_hash, phone);
		insert into profiles(id, gender, birthday, nationality, status, group_id) values 
			((select id from users where phone_number = phone), gender, birthday, nationality, status, group_id);
	end//

drop procedure if exists mark_update;
delimiter //
create procedure mark_update(id int, new_mark int, task int)
	begin
		update marks set value = new_mark where user_id = id AND task = task_id;
	end//


drop trigger if exists group_constraint;
delimiter //
create trigger group_constraint before insert on profiles
for each row 
	begin 
		if new.group_id is null then 
			signal sqlstate '45000' set message_text = 'group_id cannot be null';
		end if;
	end//
	
drop trigger if exists teacher_constraint;
delimiter //
create trigger teacher_constraint before insert on courses 
for each row 
	begin 
		if new.creator_id not in(select id from profiles where status='teacher') then 
			signal sqlstate '45000' set message_text = 'wrong creator_id';
		end if;
	end//
	
drop trigger if exists studies_specialities_trg;
delimiter //
create trigger studies_specialities_trg before insert on spec_stud
for each row 
	begin 
		if new.spec_id is null or new.stud_id is null then 
			signal sqlstate '45000' set message_text = 'values should not be null';
		end if;
	end//

drop trigger if exists studies_teachers_trg;
delimiter //
create trigger studies_teachers_trg before insert on stud_teachers
for each row 
	begin 
		if new.teacher_id is null or new.stud_id is null then 
			signal sqlstate '45000' set message_text = 'values should not be null';
		end if;
	end//

drop trigger if exists studies_specialities_upd_trg;
delimiter //
create trigger studies_specialities_upd_trg before update on spec_stud
for each row 
	begin 
		if new.spec_id is null or new.stud_id is null then 
			signal sqlstate '45000' set message_text = 'values should not be null';
		end if;
	end//

drop trigger if exists studies_teachers_upd_trg;
delimiter //
create trigger studies_teachers_upd_trg before update on stud_teachers
for each row 
	begin 
		if new.teacher_id is null or new.stud_id is null then 
			signal sqlstate '45000' set message_text = 'values should not be null';
		end if;
	end//


	
	

	
