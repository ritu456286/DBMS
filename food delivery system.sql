show databases;
create database food_delivery_system;
use food_delivery_system;

-- creating tables
CREATE TABLE customer_info(
login_id int,
customer_pswd varchar(20) not null check (char_length(customer_pswd) >= 8), 
customer_email varchar(30) not null, -- can be multiple so converted to 2nf
customer_name varchar(50) not null,
customer_DOB date,
customer_gender char(1),
customer_phn_nos int(11),
PRIMARY KEY(login_id)
);

ALTER TABLE customer_info
MODIFY COLUMN customer_phn_nos varchar(11);

CREATE TABLE feedback_info(
feedback_id int,
feedback_msg varchar(255),
feedback_ratings int not null,
login_id int,
shop_id int,
PRIMARY KEY(feedback_id),
CONSTRAINT fk_feedback_login FOREIGN KEY(login_id)
REFERENCES customer_info(login_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_feedback_shop FOREIGN KEY(shop_id)
REFERENCES shop_restaurant_info(shop_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE address_info(
address_pin int(6),
h_no int,
district varchar(30),
city varchar(30) not null,
state varchar(30) not null,
PRIMARY KEY(address_pin)
);

CREATE TABLE order_info(
order_id int,
order_amount float not null default 0,
order_tax_percent float default 0,
coupon_id int,
shop_id int,
PRIMARY KEY(order_id),
CONSTRAINT fk_order_coupon FOREIGN KEY(coupon_id)
REFERENCES coupon_info(coupon_id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_order_shop FOREIGN KEY(shop_id)
REFERENCES shop_restaurant_info(shop_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE payment_info(
payment_no int,
order_id int,
payment_mode varchar(20) not null,
amount_paid float not null,
payment_status varchar(15) not null,
bank_acc_no int(14) not null,
PRIMARY KEY(payment_no, order_id),
CONSTRAINT fk_payment_order FOREIGN KEY(order_id)
REFERENCES order_info(order_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE coupon_info(
coupon_id int,
coupon_expiry_date date not null,
discount_percent float not null,
PRIMARY KEY(coupon_id)
);

CREATE TABLE delivery_person_info(
person_id int,
order_id int,
person_name varchar(50) not null,
person_email varchar(20) not null,
person_DOB date not null,
person_gender char(1),
address_pin int(6),
PRIMARY KEY(person_id),
CONSTRAINT fk_person_address FOREIGN KEY(address_pin)
REFERENCES address_info(address_pin) ON DELETE SET NULL,
CONSTRAINT fk_person_order FOREIGN KEY(order_id)
REFERENCES order_info(order_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE order_tracking_info(
tracking_id int,
order_id int,
current_location varchar(100) not null,
time_to_reach time not null,
order_status varchar(15) not null,
PRIMARY KEY(tracking_id),
CONSTRAINT fk_tracking_order FOREIGN KEY(order_id)
REFERENCES order_info(order_id) ON DELETE CASCADE
);

CREATE TABLE shop_restaurant_info(
shop_id int,
shop_ratings int not null default 0,
address_pin int(6),
shop_phone_nos int(11) not null,
shop_email varchar(20) not null,
offer_id int,
PRIMARY KEY(shop_id),
CONSTRAINT fk_shop_address FOREIGN KEY(address_pin)
REFERENCES address_info(address_pin) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_shop_offer FOREIGN KEY(offer_id)
REFERENCES discount_offer_info(offer_id) ON DELETE SET NULL ON UPDATE CASCADE
);

ALTER TABLE shop_restaurant_info
MODIFY COLUMN shop_phone_nos varchar(11);

CREATE TABLE worker_info(
worker_id int,
worker_name varchar(50),
worker_ratings int default 0,
worker_DOB date not null,
worker_gender char(1),
worker_phn_nos int(11) not null,
worker_email varchar(20),
worker_role varchar(20) not null,
worker_salary float not null,
worker_hire_date date not null,
address_pin int(6),
shop_id int,
PRIMARY KEY(worker_id),
CONSTRAINT fk_worker_address FOREIGN KEY(address_pin)
REFERENCES address_info(address_pin) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT fk_worker_shop FOREIGN KEY(shop_id)
REFERENCES shop_restaurant_info(shop_id) ON DELETE SET NULL ON UPDATE CASCADE
);

ALTER TABLE worker_info
MODIFY COLUMN worker_phn_nos varchar(11);

CREATE TABLE menu_info(
menu_id int,
menu_description varchar(200),
menu_speciality varchar(200),
shop_id int,
PRIMARY KEY(menu_id),
CONSTRAINT fk_menu_shop FOREIGN KEY(shop_id)
REFERENCES shop_restaurant_info(shop_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE food_info(
food_id int,
food_name varchar(30),
veg_nonVeg char(1) not null, -- veg = V non veg = N
food_ratings int,
food_price float,
offer_id int,
menu_id int,
PRIMARY KEY(food_id),
CONSTRAINT fk_food_menu FOREIGN KEY(menu_id)
REFERENCES menu_info(menu_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_food_offer FOREIGN KEY(offer_id)
REFERENCES discount_offer_info(offer_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE discount_offer_info(
offer_id int,
offer_percent float not null,
offer_description varchar(200) not null,
PRIMARY KEY(offer_id)
);

CREATE TABLE add_ons_info(
add_item_id int,
add_item_name varchar(30),
add_item_price float not null,
add_item_availaibility char(1), -- available = y not available = n
food_id int,
PRIMARY KEY(add_item_id),
CONSTRAINT fk_add_food FOREIGN KEY(food_id)
REFERENCES food_info(food_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- inserting data

INSERT INTO customer_info VALUES
(2, 'mypsswd456', 'rahul.kansal456@gmail.com', 'Rahul', '2005-11-14', 'M', 9375023522),
(3, 'donttellanyone56', 'rahul.kansal456@gmail.com', 'Rahul', '2005-11-14', 'M', 9375235223),
(4, '%desisProject', 'rahul.sharam4353@gmail.com', 'Rahul', '2001-12-18', 'M', 8750235323),
(5, '#deshawIndia99', 'ritika.bansal5343@yahoo.com', 'ritika', '1997-09-14', 'M', 9075023500),
(6, '$$GoogleHiall', 'mohan.kumar4324@gmail.com', 'mohan', '2005-01-07', 'M', 88850235223),
(7, 'DoingGood542', 'preeti.garg00986@gmail.com', 'preeti', '2000-10-11', 'M', 99950235223);

INSERT INTO discount_offer_info VALUES
(200, 2.54, 'applied on non-vegetarian food; get Flat 2.54 % off'),
(300, 50, 'Diwali offer! Get flat 50% off on all food items'),
(400, 20, 'Refer the restaurant or shop to your friends and get 20% off'),
(500, 10, 'First serving 10% off');

INSERT INTO coupon_info VALUES
(50, '2023-02-02', 5),
(20, '2024-03-06', 20),
(30, '2026-07-10', 55.5),
(40, '2025-12-11', 60);

INSERT INTO address_info VALUES
(110032, 511, 'shahdara', 'delhi', 'delhi'),
(110030, 611, 'bhatinda', 'bhatinda', 'punjab');

INSERT INTO shop_restaurant_info VALUES
(5, 5, 110032, '8649293959', 'bikaner456@gmail.com', 300),
(2, 3, 110030, '5765294929', 'haldi446@gmail.com', 200),
(3, 4, 110030, '5555294929', 'kahta490@gmail.com', 400),
(6, 2, 110032, '7779274929', 'sona499@gmail.com', 400);

INSERT INTO feedback_info VALUES
(1, 'Very good services!Loved the food!', 5, 2, 3),
(2, 'Awful services, Will not recommend at all', 1, 3, 5),
(3, 'Nice place to visit with friends and families', 4, 1, 2),
(4, 'Decent Place', 4, 7, 6);

INSERT INTO order_info VALUES
(1, 400, 3, 50, 6),
(2, 400, 3, 20, 2),
(3, 800.56, 3.6, 50, 3),
(4, 400, 3.2, 30, 5),
(5, 400, 1.2, 40, 5);

INSERT INTO worker_info VALUES
(1, 'raj', 5, '1997-08-08', 'M', '9876492999', 'rah.kum566@gmail.com', 'head chef', 50,000, '2001-01-01', 110032, 5); 
