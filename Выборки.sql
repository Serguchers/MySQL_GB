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


select 
	group_concat(users.firstname, ' ', users.lastname), 
	(select id from `group` where profiles.group_id = `group`.id) as group_id 
from profiles
join users on profiles.id = users.id
group by group_id;


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


select 
	concat(users.firstname, ' ', users.lastname) as name, 
	`group`.id as group_id, 
	speciality.name as speciality_name from profiles 
join `group` on profiles.group_id = `group`.id
join speciality on `group`.speciality_id = speciality.id
join users on users.id = profiles.id
where speciality.name = 'aut';


