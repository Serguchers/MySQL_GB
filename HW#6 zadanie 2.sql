select count(*) as cnt, from_user_id from(
select from_user_id from messages m where from_user_id in (
	select target_user_id from friend_requests fr 
		where initiator_user_id = 201 and status = 'approved'
	union 
	select initiator_user_id from friend_requests fr2 
		where target_user_id = 201 and status = 'approved') and to_user_id = 201
union all
select to_user_id from messages m2 where to_user_id in (
	select target_user_id from friend_requests fr 
		where initiator_user_id = 201 and status = 'approved'
	union 
	select initiator_user_id from friend_requests fr2 
		where target_user_id = 201 and status = 'approved'
) and from_user_id = 201 order by from_user_id) as tb group by from_user_id ;
