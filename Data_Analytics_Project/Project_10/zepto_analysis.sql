CREATE TABLE zepto(
	sku_id SERIAL PRIMARY KEY,
	category VARCHAR(120),
	name VARCHAR(150) NOT NULL,
	mrp NUMERIC(8, 2),
	discountPercent NUMERIC(5,2),
	availableQuantity INT,
	discountedSellingPrice NUMERIC(8, 2),
	weightInGms INT,
	outOfStock BOOL,
	quantity INT
);

SELECT * FROM zepto;


-- Data Exploration

-- Checking Null Values

SELECT
	* 
FROM
	zepto
WHERE
	category IS NULL
OR
	name IS NULL
OR
	mrp IS NULL
OR
	discountedsellingprice IS NULL
OR
	discountpercent IS NULL
OR
	availablequantity IS NULL
OR
 	weightingms IS NULL
OR
	outofstock IS NULL
OR
	quantity IS NULL;

-- Different Product Categories

SELECT
	DISTINCT category
FROM
	zepto
ORDER BY category;

-- Products IN Stock V/S Out of Stock

SELECT
	outofstock,
	COUNT(sku_id)
FROM
	zepto
GROUP BY outofstock;

-- Product names present multiple times

SELECT
	name,
	COUNT(sku_id) AS "Number of SKUs"
FROM
	zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;


-- Data Cleaning

-- Product with Price = 0

SELECT
	*
FROM
	zepto
WHERE
	mrp = 0
OR	discountedsellingprice = 0;

DELETE FROM zepto
WHERE
	mrp = 0;

-- Converting paise into rupees

UPDATE zepto
SET
	mrp = mrp / 100.0,
	discountedsellingprice = discountedsellingprice / 100.0;

SELECT * FROM zepto;


-- Business Insights / Data Analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT
	DISTINCT name,
	mrp,
	discountpercent
FROM
	zepto
ORDER BY 3 DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock.

SELECT
	DISTINCT name,
	mrp
FROM
	zepto
WHERE
	outofstock = true
AND mrp > 300
ORDER BY 2 DESC;

--Q3.Calculate Estimated Revenue for each category

SELECT
	category,
	SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM
	zepto
GROUP BY 1
ORDER BY 2;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT
	DISTINCT name,
	mrp,
	discountpercent
FROM
	zepto
WHERE
	mrp > 500
AND discountpercent < 10
ORDER BY 2 DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT 
	category,
	ROUND(AVG(discountpercent), 2) AS avg_discount
FROM
	zepto
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT
	DISTINCT name,
	weightingms,
	discountedsellingprice,
	ROUND(discountedsellingprice / weightingms, 2) AS price_per_gram
FROM
	zepto
WHERE
	weightingms >= 100
ORDER BY 4;

--Q7.Group the products into categories like Low, Medium, Bulk.

SELECT
	DISTINCT name,
	weightingms,
	CASE
		WHEN weightingms < 1000 THEN 'Low'
		WHEN weightingms < 5000 THEN 'Medium'
		ELSE 'Bulk'
		END AS weight_category
FROM
	zepto;

--Q8.What is the Total Inventory Weight Per Category

SELECT
	category,
	SUM(weightingms * availablequantity) AS total_weight
FROM
	zepto
GROUP BY category
ORDER BY 2;