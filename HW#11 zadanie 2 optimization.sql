drop procedure if exists data_generator;
delimiter //
create procedure data_generator(number int)
	begin
		set @counter := 1;
		while @counter < number do
			insert into users(name) values (concat('Test_user', @counter));
			set @counter = @counter + 1;
		end while;
	end //
delimiter ;
call data_generator(1000000); 