drop database if exists bike_shop;
create database bike_shop;
use bike_shop;


DROP table if exists catalogs;
create table catalogs (
  id BIGINT unsigned not null auto_increment primary key,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет магазина';

create table if not exists users (
	id BIGINT unsigned not null auto_increment primary key,
	firstname VARCHAR(50) COMMENT 'Имя',
	lastname VARCHAR(50) COMMENT 'Фамилия',
	email VARCHAR(255) unique COMMENT 'Электронная почта',
	password_hash VARCHAR(255) COMMENT 'Хэш пароля',
	phone INT unsigned unique COMMENT 'Номер телефона',
	
	index users_firstname_lastname_idx (firstname, lastname)
) COMMENT 'Пользователи';

create table if not exists profiles (
	user_id BIGINT unsigned not null,
	sex VARCHAR(1) COMMENT 'Пол',
	birthday DATE COMMENT 'День рождения',
	photo_id BIGINT unsigned COMMENT 'Фото',
	created_at DATETIME on update current_timestamp COMMENT 'Дата создания',
	hometown VARCHAR(255) COMMENT 'Домашний адрес',
	`index` INT unsigned unique COMMENT 'Индекс',
	
	foreign key (user_id) references users(id)
) COMMENT 'Информация о пользователе';

DROP table if exists products;
create table products (
  id SERIAL,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL(11, 2) COMMENT 'Цена',
  catalog_id BIGINT unsigned not null,
  
  foreign key (catalog_id) references catalogs(id)
) COMMENT = 'Товарные позиции';

DROP table if exists orders;
create table orders (
  id SERIAL,
  user_id BIGINT unsigned not null,
  
  foreign key (user_id) references users(id)
) COMMENT = 'Заказы';

DROP table if exists orders_products;
create table orders_products (
  id SERIAL,
  order_id BIGINT unsigned not null,
  product_id BIGINT unsigned not null,
  total INT unsigned default 1 COMMENT 'Количество заказанных товарных позиций',
  
  foreign key (order_id) references orders(id),
  foreign key (product_id) references products(id)
) COMMENT = 'Состав заказа';

DROP table if exists discounts;
create table discounts (
  id SERIAL,
  user_id BIGINT unsigned not null,
  product_id BIGINT unsigned not null,
  discount FLOAT COMMENT 'Величина скидки от 0.0 до 1.0',
  
  foreign key (user_id) references users(id),
  foreign key (product_id) references products(id)
) COMMENT = 'Скидки';

DROP table if exists storehouses_products;
create table storehouses_products (
  id SERIAL,
  storehouse_id INT unsigned,
  product_id BIGINT unsigned,
  value INT unsigned COMMENT 'Запас товарных позиций на складе',
  
  foreign key (product_id) references products(id)
) COMMENT = 'Запасы на складе';

create table if not exists media_types (
	id SERIAL,
	name VARCHAR(255),
	created_at DATETIME on update current_timestamp,
	updated_at DATETIME on update current_timestamp
) COMMENT 'Тип медиа';

create table if not exists media(
	id SERIAL,
	media_type_id BIGINT unsigned not null,
	user_id BIGINT unsigned not null,
	body TEXT,
	filename VARCHAR(255),
	`size` INT unsigned,
	metadata json,
	created_at DATETIME on update current_timestamp,
	updated_at DATETIME on update current_timestamp,
	
	foreign key (user_id) references users(id),
	foreign key (media_type_id) references media_types(id)
) COMMENT 'Медиа';

alter table profiles add constraint fk_user_id
foreign key (photo_id) references media(id)