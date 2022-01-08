-- Представление таблицы пользоваетлей достигших 18 лет

create view adult as select user_id, birthday from profiles
where (year(now()) - year(birthday) > 18)
order by user_id;


-- Представление товара определенной категории

create view nemo as select id, name, catalog_id from products
where catalog_id = 2
order by id;