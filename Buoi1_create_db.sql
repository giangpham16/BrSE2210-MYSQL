DROP DATABASE IF EXISTS dbecommercer;

CREATE DATABASE IF NOT EXISTS dbecommercer;

USE dbecommercer;
-- Mỗi hàng là một record

-- PRIMARY KEY : khóa chính
-- (trong một bảng thì chỉ có duy nhất một primarykey)

-- string: chuỗi ký tự

-- unique: không được giống nhau

CREATE TABLE customers( 
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(50) NOT NULL UNIQUE,
    number_of_complaints INT DEFAULT 0
);

CREATE TABLE sales( 
	purchase_number INT PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code CHAR(3) NOT NULL UNIQUE
);


























