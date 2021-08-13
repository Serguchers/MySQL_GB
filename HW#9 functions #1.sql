SET GLOBAL log_bin_trust_function_creators = 1;
delimiter //
drop function if exists hello//
create function hello()
RETURNS text NOT DETERMINISTIC
begin 
	declare text_to_return varchar(100) default '';
	case hour(now())
		when hour(now()) < 6 then set text_to_return = '?????? ????';
		when hour(now()) < 12 then set text_to_return = '?????? ????';
		when hour(now()) < 18 then set text_to_return = '?????? ????';
		else set text_to_return = '?????? ?????';
	end case;
	return text_to_return;
end//

select hello();