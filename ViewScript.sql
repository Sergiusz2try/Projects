-- ������������� ������� ������������� ��������� 18 ���

create view adult as select user_id, birthday from profiles
where (year(now()) - year(birthday) > 18)
order by user_id;


-- ������������� ������ ������������ ���������

create view nemo as select id, name, catalog_id from products
where catalog_id = 2
order by id;