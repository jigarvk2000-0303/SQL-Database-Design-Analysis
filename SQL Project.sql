CREATE DATABASE IF NOT EXISTS retail_sql;
USE retail_sql;



CREATE TABLE retail_data (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    city VARCHAR(50),
    transaction_date DATE
);


select * from retail_data;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);
select * from products;

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    city VARCHAR(50),
    rating INT
);

select * from suppliers;

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    stock_quantity INT,
    warehouse_city VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

select * from inventory;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    joining_date DATE
);

select * from employees;