CREATE DATABASE	Management;
USE Management;
CREATE TABLE customers(
	customer_id					INT,
    first_name					VARCHAR(255),
    last_name					VARCHAR(255),
    email_address				VARCHAR(255),
    number_of_complaint			INT
    );
CREATE TABLE sales(
	purchase_number				INT,
	date_of_purchase			DATETIME,
	cutomer_id					INT,
	item_code					VARCHAR(255)
	);
CREATE TABLE items(
	item_code					VARCHAR(255),
	item						VARCHAR(255),
    unit_price_usd				INT,
    company_id					VARCHAR(255),
    headquarters_phone_number	INT
);