select sum(cnt) from (
select count(*) as cnt from profiles 
	inner join media on media.user_id = profiles.user_id 
	inner join likes on media.id = likes.media_id  where likes.media_id = media.id 
group by profiles.user_id
order by timestampdiff(year, birthday, now()) limit 10
) as result_table;