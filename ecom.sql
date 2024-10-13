-- To create a database we use this 
CREATE DATABASE ecommerce;

-- TO use the database we use this
use ecommerce;

-- To create a table use this
CREATE TABLE customers( 
id INT NOT NULL auto_increment,
customer_name VARCHAR(20) NOT NULL,
email VARCHAR(25) NOT NULL,
adress VARCHAR(30) NOT NULL,
PRIMARY KEY (`id`)
)ENGINE = InnoDB;

-- To insert values in the table 
INSERT INTO customers (id, customer_name , email , adress) 
VALUES
(NULL , "arsath", "arsath@.com" ,  "dpi" ),
(NULL , "ali", "al@i.com" , "salem" ),
(NULL , "aliboy", "aliboy@.com" ,  "moon" );

-- Creatng a table for orders
CREATE TABLE orders( 
id INT NOT NULL auto_increment,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY (customer_id) REFERENCES customers(id)
)ENGINE = InnoDB;

-- Inserting values in the orders table
INSERT INTO orders (id, customer_id , order_date , total_amount) 
VALUES
(NULL ,1, "2024-10-1" ,  143.00 ),
(NULL ,2, "2024-11-15" , 420.00 ),
(NULL , 3, "2024-12-25" ,  320.00 );

-- creating a table for products
CREATE TABLE products( 
id INT NOT NULL auto_increment,
product_name VARCHAR(25) NOT NULL,
price DECIMAL(10,2)  NOT NULL,
decription TEXT NOT NULL,
PRIMARY KEY (`id`))ENGINE = InnoDB;

-- inserting values in the products table
INSERT INTO products (id,product_name,price,decription)
VALUES
(NULL, "pen",10.00,"pen it is used for write"),
(NULL, "box",10.00,"box it is used to brush our store"),
(NULL, "t-shirt",100.00,"t-shirt it is used to wear for party ");

SELECT customer_name FROM customers a 
JOIN orders b ON a.id = b.customer_id
WHERE b.order_date >= CURDATE() - INTERVAL 30 DAY;

SELECT c.customer_name, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;

UPDATE products
SET price = 45.00
WHERE id = 3;

ALTER TABLE products 
ADD COLUMN discount INT NOT NULL;

SELECT product_name , price FROM products 
ORDER BY price  DESC LIMIT 3;

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),  
(2, 2, 1),  
(3, 3, 1); 

SELECT DISTINCT c.customer_name,p.product_name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.product_name = 'brush';

SELECT DISTINCT c.customer_name , o.order_date FROM customers c
JOIN orders o ON c.id = o.customer_id;

SELECT total_amount FROM  orders o 
WHERE total_amount >150;

SELECT oi.order_id, p.product_name, oi.quantity
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

SELECT AVG(total_amount) AS average_order_amount 
FROM orders;
