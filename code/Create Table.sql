-- Create table 
CREATE TABLE coffee_shop_sales (
	transaction_id INT,
	transaction_date DATE,
	transaction_time TIME [ (P) ] WITHOUT TIME ZONE,
	transaction_qty INT,
	store_id INT,
	store_location VARCHAR(20),
	product_id INT,
	unit_price NUMERIC(2,2),
	product_category VARCHAR(20),
	product_type VARCHAR(50),
	product_detail VARCHAR(50)
)