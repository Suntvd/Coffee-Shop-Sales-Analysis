-- Check the data quantity
SELECT COUNT(*) AS total_rows
FROM coffee_shop_sales;

-- Check null values
SELECT COUNT(*) AS null_values
FROM coffee_shop_sales
WHERE transaction_date IS NULL
		OR transaction_time IS NULL
		OR transaction_qty IS NULL
		OR store_location IS NULL
		OR unit_price IS NULL
		OR product_category IS NULL
		OR product_type IS NULL;

-- Check duplicate values
WITH numbered_rows AS (
    SELECT *, 
	ROW_NUMBER() 
		OVER(PARTITION BY transaction_id, transaction_date, transaction_time, 
									transaction_qty, store_id, store_location,
									product_id, unit_price, product_category, 
									product_type, product_detail 
									ORDER BY transaction_id) AS row_num
    FROM coffee_shop_sales
)
SELECT *
FROM numbered_rows
WHERE row_num > 1;

-- Check "bad" data
SELECT *
FROM coffee_shop_sales
WHERE unit_price < 0 OR transaction_qty < 0;

--------------------------------------------------------------------
-- Remove unnecessary space
UPDATE coffee_shop_sales
SET product_category = TRIM(product_category);

UPDATE coffee_shop_sales
SET product_type = TRIM(product_type);

----------------------------------------------------
-- Create a column to calculate revenue
ALTER TABLE coffee_shop_sales
ADD revenue NUMERIC;

UPDATE coffee_shop_sales
SET revenue = unit_price * transaction_qty;

-- Create column month
ALTER TABLE coffee_shop_sales
ADD month VARCHAR(10)

UPDATE coffee_shop_sales
SET month = TO_CHAR(transaction_date::date, 'Month');

-- day_of_week
ALTER TABLE coffee_shop_sales
ADD day_of_week VARCHAR(10)

UPDATE coffee_shop_sales
SET day_of_week = TO_CHAR(transaction_date::date, 'Day');

--time_of_day
ALTER TABLE coffee_shop_sales
ADD time_of_day INT

UPDATE coffee_shop_sales
SET time_of_day = EXTRACT(HOUR FROM transaction_time)

