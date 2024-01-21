show databases;
create database Bus_Booking_System;
use Bus_Booking_System;

CREATE TABLE user(
user_id int,
user_name varchar(50) not null,
user_email varchar(50) not null,
user_phn_nos char(11) not null,
user_gender char(1),
user_dob date,
PRIMARY KEY(user_id)
);

CREATE TABLE address_info(
address_pin int(6),
district varchar(30),
city varchar(30) not null,
state varchar(30) not null,
PRIMARY KEY(address_pin)
);

CREATE TABLE credit_info(
credits_id int,
credits_left int,
credits_purchase_date date,
credits_expiry_date date,
user_id int,
PRIMARY KEY(credits_id),
CONSTRAINT fk_credit_user FOREIGN KEY(user_id)
REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE driver_info(
driver_id int,
driver_name varchar(50) not null,
driver_email varchar(30),
driver_phn_nos char(11) not null,
driver_license_id char(13) not null,
driver_DOB date not null,
driver_gender char(1) not null,
address_pin int(6),
PRIMARY KEY(driver_id),
CONSTRAINT fk_driver_address FOREIGN KEY(address_pin)
REFERENCES address_info(address_pin) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE tracking_info(
tracking_id int,
passenger_count int not null default 0,
bus_speed float not null default 0,
bus_current_location varchar(50) not null,
bus_op_id int,
trip_id int,
PRIMARY KEY(tracking_id),
CONSTRAINT fk_tracking_operator FOREIGN KEY(bus_op_id)
REFERENCES bus_operator_info(bus_op_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_tracking_trip FOREIGN KEY(trip_id)
REFERENCES trip_info(trip_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bus_operator_info(
bus_op_id int,
bus_op_type char(10) not null,
bus_op_name varchar(50) not null,
bus_helpine_nos int(11) not null,
PRIMARY KEY(bus_op_id)
);

CREATE TABLE bus_info(
bus_id int,
bus_passenger_capacity int not null,
bus_type varchar(20),
bus_wifi_speed float,
bus_op_id int,
PRIMARY KEY(bus_id),
CONSTRAINT fk_bus_operator FOREIGN KEY(bus_op_id)
REFERENCES bus_operator_info(bus_op_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE conductor_info(
conductor_id int,
conductor_name varchar(50) not null,
conductor_email varchar(30),
conductor_phn_nos char(11) not null,
conductor_DOB date not null,
conductor_gender char(1) not null,
address_pin int(6),
PRIMARY KEY(conductor_id),
CONSTRAINT fk_conductor_address FOREIGN KEY(address_pin)
REFERENCES address_info(address_pin) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE trip_info(
trip_id int,
trip_start_date date,
trip_from_location varchar(70),
trip_to_location varchar(70),
trip_duration time,
trip_status varchar(15),
driver_id int,
conductor_id int,
bus_id int,
PRIMARY KEY(trip_id),
CONSTRAINT fk_trip_driver FOREIGN KEY(driver_id)
REFERENCES driver_info(driver_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_trip_conductor FOREIGN KEY(conductor_id)
REFERENCES conductor_info(conductor_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_trip_bus FOREIGN KEY(bus_id)
REFERENCES bus_info(bus_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ticket_info(
ticket_no int,
ticket_price float,
user_id int,
credits_id int,
trip_id int,
PRIMARY KEY(ticket_no),
CONSTRAINT fk_ticket_user FOREIGN KEY(user_id) 
REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_ticket_credits FOREIGN KEY(credits_id)
REFERENCES credit_info(credits_id) ON UPDATE CASCADE,
CONSTRAINT fk_ticket_trip FOREIGN KEY(trip_id)
REFERENCES trip_info(trip_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- inserting sample data into the tables



