drop database if exists proyecto;
create database proyecto;
use proyecto;

DROP TABLE IF EXISTS `variables_sistemas`;
CREATE TABLE IF NOT EXISTS `variables_sistemas`(
	id int primary key auto_increment,
	const float(8,2),
	k float (8,2)
); 

DROP TABLE IF EXISTS `sucursals` ;
CREATE TABLE IF NOT EXISTS `sucursals`(
	id int primary key auto_increment,
	name varchar(255) not null,
	address varchar(255) not null,
	phone_number varchar(255) not null
);

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users`(
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	age int,
	id int(11) primary key auto_increment,
	cedula int,
	phone varchar(255),
	email varchar(255) not null,
	password varchar(255) not null,
	user_type int not null,
	sucursal_id int,
	constraint sucursal_fk foreign key (sucursal_id) references sucursals(id),
	constraint check_user_type check (user_type in (0,1,2))
);

DROP TABLE IF EXISTS `senders`;
CREATE TABLE IF NOT EXISTS `senders`(
	id int primary key auto_increment,
	sender_user int(11),
	reciever_user int(11),
	sender_sucursal int,
	reciever_sucursal int,
	fecha_envio date,
	fecha_entrega date,
	constraint sender_user_fk foreign key (sender_user) references users(id),
	constraint reciever_user_fk foreign key (reciever_user) references users(id),
	constraint sender_sucursal_fk foreign key (sender_sucursal) references sucursals(id),
	constraint reciever_sucursal_fk foreign key (reciever_sucursal) references sucursals(id)
);



DROP TABLE IF EXISTS `packages`;
CREATE TABLE IF NOT EXISTS `packages`(
	id int primary key auto_increment,
	weight decimal(5,2) not null,
	status varchar(255),
	height decimal(5,2) not null,
	width decimal(5,2) not null,
	large decimal(5,2) not null,
	valor decimal(8,2) not null,
	sender_id int,
	descripcion varchar(255),
	foreign key (sender_id) references senders(id)
);
