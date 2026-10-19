USE olist;

CREATE TABLE customers(
	customer_id VARCHAR(32) NOT NULL PRIMARY KEY,
	customer_unique_id VARCHAR(32),
	customer_zip_code_prefix VARCHAR(5),
	customer_city VARCHAR(100),
	customer_state CHAR(2)
);

CREATE TABLE sellers(
	seller_id VARCHAR(32) NOT NULL PRIMARY KEY,
	seller_zip_code_prefix VARCHAR(5),
	seller_city VARCHAR(100),
	seller_state CHAR(2)
);

CREATE TABLE orders(
	order_id VARCHAR(32) NOT NULL PRIMARY KEY,
	customer_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES customers(customer_id),
	order_status VARCHAR(32),
	order_purchase_timestamp DATETIME2,
	order_approved_at DATETIME2,
	order_delivered_carrier_date DATETIME2,
	order_delivered_customer_date DATETIME2,
	order_estimated_delivery_date DATETIME2
);

CREATE TABLE products(
	product_id VARCHAR(32) NOT NULL PRIMARY KEY,
	product_category_name VARCHAR(100),
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);

CREATE TABLE order_items(
	order_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES orders(order_id),
	order_item_id INT NOT NULL,
	product_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES products(product_id),
	seller_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES sellers(seller_id),
	shipping_limit_date DATETIME2, 
	price DECIMAL(10,2),
	freight_value DECIMAL(10,2),
	PRIMARY KEY(order_id, order_item_id)
);

CREATE TABLE order_payments(
	order_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES orders(order_id),
	payment_sequential INT NOT NULL,
	payment_type VARCHAR(32),
	payment_installments INT,
	payment_value DECIMAL(10,2),
	PRIMARY KEY(order_id, payment_sequential)
);

CREATE TABLE category_translation(
	product_category_name VARCHAR(100) NOT NULL PRIMARY KEY,
	product_category_name_english VARCHAR(100)
);

CREATE TABLE order_reviews(
	review_id VARCHAR(32) NOT NULL,
	order_id VARCHAR(32) NOT NULL FOREIGN KEY REFERENCES orders(order_id),
	review_score INT,
    /* NVARCHAR is for national characters*/
	review_comment_title NVARCHAR(100),
	review_comment_message NVARCHAR(500),
	review_creation_date DATETIME2,
	review_answer_timestamp DATETIME2
);