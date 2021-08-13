drop table if exists temp_dates;
create temporary table temp_dates (
	day INT);
insert into temp_dates values (1), (2), (3), (4), (5), (6), (7),
    (8), (9), (10), (11), (12), (13), (14), (15),
    (16), (17), (18), (19), (20), (21), (22), (23),
    (24), (25), (26), (27), (28), (29), (31);

select day, if(day in (select day(created_at) from users),1,0) from temp_dates;
select day(created_at) from users;