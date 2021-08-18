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
```delimiter //
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
	end //```

```delimiter //
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
	end//```

