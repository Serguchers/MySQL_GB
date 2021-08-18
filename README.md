# Проект базы данных для LMS #

---

##  Общее описание базы данных ##
База данных состоит из 15 таблиц. Она позволяет организовать работу системы управления обучением.
База содержит в себе описание пользователей, учебных групп, дисциплин, специальностей, оценок, заданий и прикрепленных файлов.
При помощи этих данных можно отслеживать успеваемость, фильтровать пользователей, структуру специальностей и групп.

---

## Создание структуры БД ##
Как уже было отмечено ранее, база данных состоит из 15 таблиц. Сперва я прописал структуру вручную, задав отношения между таблицами и индексы.

[Создание структуры базы данных](https://github.com/Serguchers/MySQL_GB/blob/Final_course_project/Создание%20базы.sql)

После чего я воспользовался сервисом для наполнения данными - http://filldb.info. В результате получился [скрипт](https://github.com/Serguchers/MySQL_GB/blob/Final_course_project/Наполнение%20данными.sql), включающий создание структуры и наполнение данными.

При помощи автоматической генерации в DBeaver была создана ERD-диаграмма.

![ERD-диаграмма DBeaver](https://github.com/Serguchers/MySQL_GB/blob/Final_course_project/erd_with_dbeaver.png?raw=true)

Также я воспользовался сторонним сервисом для создания [ERD-диаграммы](https://github.com/Serguchers/MySQL_GB/blob/Final_course_project/erd_with_web.pdf).

---

## Работа с данными ##
После заполнения данными, чтобы избежать некоторых нелогичных моментов(студент не может быть создателем курсов и пользователи не отправляют сообщения сами себе)
я написал 2 процедуры.
~~~sql
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
~~~

~~~sql
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
~~~

Следующим шагом стало написание скриптов для выборок. 

Первой выборкой мы можем найти студентов, имеющих неудовлетворительную успеваемость.
~~~sql
select * from(
select 
	users.firstname, 
	users.lastname, 
	avg(marks.value) as avg_mark, 
	case 
	when avg(marks.value) = 5 then 'excellent'
	when avg(marks.value) >= 4 then 'good'
	when avg(marks.value) >= 3 then 'satisfactory'
	when avg(marks.value) < 3 then 'unsatisfactory'
	end as comment
from marks 
join profiles on marks.user_id = profiles.id 
join users on users.id = profiles.id 
group by marks.user_id) as tbl where avg_mark < 3 order by avg_mark;
~~~
Вторая выборка позволяет нам просмотреть студентов, принадлежащих конкретной группе.
~~~sql
select 
	group_concat(users.firstname, ' ', users.lastname), 
	(select id from `group` where profiles.group_id = `group`.id) as group_id 
from profiles
join users on profiles.id = users.id
group by group_id;
~~~
Третья выборка позволяет отфильтровать студентов по кафедре и уровню образования.
~~~sql
select 
	s.name as study, 
	s2.name as speciality, 
	c.name as chair, 
	el.name as education_level 
from spec_stud ss 
join studies s on ss.stud_id = s.id 
join speciality s2 on ss.spec_id = s2.id
join chair c on s2.chair_id = c.id 
join education_level el on el.id = s2.education_level_id where el.name  = 'bachelor' and c.name = 'Media and art';
~~~
И последняя выборка позволяет отфильтровать студентов по специальности.
~~~sql
select 
	concat(users.firstname, ' ', users.lastname) as name, 
	`group`.id as group_id, 
	speciality.name as speciality_name from profiles 
join `group` on profiles.group_id = `group`.id
join speciality on `group`.speciality_id = speciality.id
join users on users.id = profiles.id
where speciality.name = 'aut';
~~~



