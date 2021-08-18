create or replace view students_marks as 
select 
	users.firstname, 
	users.lastname, avg(marks.value) as avg_mark, 
	case 
	when avg(marks.value) = 5 then 'excellent'
	when avg(marks.value) >= 4 then 'good'
	when avg(marks.value) >= 3 then 'satisfactory'
	when avg(marks.value) < 3 then 'unsatisfactory'
	end as comment
from marks 
join profiles on marks.user_id = profiles.id 
join users on users.id = profiles.id 
group by marks.user_id ;

select * from students_marks order by avg_mark;

create or replace view tasks_by_teachers as
select 
	concat(users.firstname, ' ', users.lastname) as creator,
	tasks.name as task_name,
	studies.name as study_name
from tasks join courses on tasks.course_id = courses.id 
join users on users.id = courses.creator_id 
join studies on courses.study_id = studies.id
join marks on tasks.id = marks.task_id ;

select * from tasks_by_teachers;

create or replace view avg_mark_per_task as
select 
	round(avg(marks.value), 2) as task_avg_mark, 
	tasks.name as task_name,
	concat(users.firstname, ' ', users.lastname) as creator
from marks
join tasks on marks.task_id = tasks.id
join courses on tasks.course_id = courses.id
join users on courses.creator_id = users.id group by tasks.name order by task_avg_mark;

select * from avg_mark_per_task;


create or replace view specialities_structure as
select 
	s.name as study, 
	s2.name as speciality, 
	c.name as chair, 
	el.name as education_level 
from spec_stud ss 
join studies s on ss.stud_id = s.id 
join speciality s2 on ss.spec_id = s2.id
join chair c on s2.chair_id = c.id 
join education_level el on el.id = s2.education_level_id;

select * from specialities_structure;

