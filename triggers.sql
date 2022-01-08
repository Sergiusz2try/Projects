-- ������� ������� ��� ���������� ������

create trigger count_orders after insert on orders
for each row 
begin 
	select count(*) into @total from orders;
end


-- ������� id �������� ���� �� ���� ������� ��� insert

create trigger check_catalog_id_insert before insert on products
for each row 
begin 
	declare cat_id INT;
	select id into cat_id from catalogs order by id limit 1;
	set new.catalog_id = coalesce(new.catalog_id, cat_id);
end