-- Мужчины или женщины сделали больше заказов

select case(sex)
		when 'm' then 'мужчин'
		when 'f' then 'женщин'
	   end as 'The most', count(*) as 'Кол-во'
from profiles
where user_id in (select user_id from orders)
group by sex
having count(*) > 1
limit 1;


-- Сколько заказов сделали пользователи до 15 лет

select count(*) as 'Кол-во', user_id from orders 
where user_id in (select user_id from profiles where ((year(now()) - year(birthday)) < 15))
group by user_id 
order by 1 desc;


-- Количество мужчин и женщин сделавших заказы на сайте

SELECT p.sex, COUNT(p.sex) as total FROM orders as o 
	JOIN profiles as p ON (p.user_id = o.user_id and p.sex IN ('f','m'))
GROUP by p.sex
ORDER BY total desc;