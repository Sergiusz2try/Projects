-- Процедура версии mysql

create procedure my_version ()
begin
	select version(); 
end


-- Процедура привилегий текущего пользователя

create procedure privilege ()
begin
	show privileges;
end


-- Процедура времени

create procedure format_now (format CHAR(4))
begin
	if (format = 'data') then
		select date_format(now(), '%d.%m.%Y') as format_now;
	elseif (format = 'time') then
		select date_format(now(), '%H:%i:%s') as format_now;
	else
		select unix_timestamp(now()) as format_now;
	end if;
end