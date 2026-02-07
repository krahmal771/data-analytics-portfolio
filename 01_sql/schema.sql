-- =========================================================
-- Тема: Интернет-магазин (e-commerce)
-- База: sql_portfolio_shop
-- =========================================================

CREATE DATABASE IF NOT EXISTS sql_portfolio_shop;
USE sql_portfolio_shop;

DROP TABLE IF EXISTS web_events;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE users (
  user_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  registration_date DATETIME NOT NULL,
  channel VARCHAR(30) NOT NULL,
  country CHAR(2) NOT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB;

CREATE TABLE products (
  product_id INT NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (product_id)
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (order_id),
  KEY idx_orders_user (user_id),
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_item_id INT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_item_id),
  KEY idx_items_order (order_id),
  KEY idx_items_product (product_id),
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

CREATE TABLE payments (
  payment_id INT NOT NULL,
  order_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  paid_at DATETIME NULL,
  method VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (payment_id),
  KEY idx_payments_order (order_id),
  CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
) ENGINE=InnoDB;

CREATE TABLE web_events (
  event_id INT NOT NULL,
  user_id INT NOT NULL,
  session_id VARCHAR(40) NOT NULL,
  event_time DATETIME NOT NULL,
  event_name VARCHAR(30) NOT NULL,
  product_id INT NULL,
  PRIMARY KEY (event_id),
  KEY idx_events_user_time (user_id, event_time),
  KEY idx_events_product (product_id),
  CONSTRAINT fk_events_user FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT fk_events_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

CREATE TABLE departments (
  dept_id INT NOT NULL,
  department VARCHAR(50) NOT NULL,
  PRIMARY KEY (dept_id),
  UNIQUE KEY uq_departments_department (department)
) ENGINE=InnoDB;

CREATE TABLE employees (
  emp_no INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  salary INT NOT NULL,
  dept_id INT NOT NULL,
  PRIMARY KEY (emp_no),
  KEY idx_employees_dept (dept_id),
  CONSTRAINT fk_employees_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;
