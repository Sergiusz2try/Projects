-- ������� ��� ������� ������� ������ �������

select case(sex)
		when 'm' then '������'
		when 'f' then '������'
	   end as 'The most', count(*) as '���-��'
from profiles
where user_id in (select user_id from orders)
group by sex
having count(*) > 1
limit 1;


-- ������� ������� ������� ������������ �� 15 ���

select count(*) as '���-��', user_id from orders 
where user_id in (select user_id from profiles where ((year(now()) - year(birthday)) < 15))
group by user_id 
order by 1 desc;


-- ���������� ������ � ������ ��������� ������ �� �����

SELECT p.sex, COUNT(p.sex) as total FROM orders as o 
	JOIN profiles as p ON (p.user_id = o.user_id and p.sex IN ('f','m'))
GROUP by p.sex
ORDER BY total desc;