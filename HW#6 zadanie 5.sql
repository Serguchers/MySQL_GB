select count(*) as cnt, user_id from(
select user_id  from media
union all
select user_id from likes
union all
select user_id from posts
union all
select to_user_id as user_id from messages m4 
union all
select from_user_id as user_id from messages m
union all
select user_id from users_communities uc) as tb  
	group by user_id order by cnt limit 10;