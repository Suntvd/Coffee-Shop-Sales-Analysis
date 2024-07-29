-- Overview
SELECT
	EXTRACT(YEAR FROM transaction_date) AS "Year",
	month
FROM coffee_shop_sales
GROUP BY 1, 2

-- Summary
SELECT 
    MIN(transaction_qty) AS min_qty, 
    MAX(transaction_qty) AS max_qty, 
    ROUND(AVG(transaction_qty), 2) AS avg_qty,
    MIN(unit_price) AS min_price,
    MAX(unit_price) AS max_price,
    ROUND(AVG(unit_price), 2) AS avg_price
FROM coffee_shop_sales;

-- Distribution of transaction quantity
SELECT
	transaction_qty,
	COUNT(transaction_id)
FROM coffee_shop_sales
GROUP BY transaction_qty
ORDER BY 2 DESC

-- Distribution of unit price
SELECT
	unit_price,
	count(transaction_id)
FROM coffee_shop_sales
GROUP BY unit_price
ORDER BY 2 DESC

-- Revenue analysis by area
SELECT
	store_location,
	SUM(unit_price * transaction_qty) AS "Total_Revenue"
FROM coffee_shop_sales
GROUP BY 1

-- Half-year revenue performance 
SELECT
	month,
	SUM(revenue) AS "Total_Revenue"
FROM coffee_shop_sales
GROUP BY 1
ORDER BY 2 DESC

-- Identifying the Busiest Transaction Days of the Week
SELECT
	day_of_week,
	COUNT(transaction_id) AS "Total_Transaction"
FROM coffee_shop_sales
GROUP BY 1
ORDER BY 2

-- Peak transaction analysis by hour
SELECT
	time_of_day,
	COUNT(transaction_id) AS "Total_Transaction"
FROM coffee_shop_sales
GROUP BY 1
ORDER BY 1

-- Best-selling products by category
SELECT
	product_category,
	sum(transaction_qty) AS "Product_Quantity"
FROM coffee_shop_sales
GROUP BY 1
ORDER BY 2 DESC

-- Best-selling items by category
WITH CTE AS (SELECT
	product_category,
	product_type,
	sum(transaction_qty) AS total_quantity,
	row_number() OVER(PARTITION BY product_category ORDER BY sum(transaction_qty) DESC) AS Row_num
FROM coffee_shop_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC)

SELECT
	product_category,
	product_type,
	total_quantity
FROM CTE
WHERE Row_num = 1
ORDER BY 1

-- Export data
SELECT
	month,
	day_of_week,
	time_of_day,
	store_location,
	product_category,
	product_type,
	SUM(revenue) AS "Total_Revenue",
	COUNT(transaction_id) AS "Total_Transaction"
FROM coffee_shop_sales
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY 1, 2
