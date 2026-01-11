-- Monday Coffee -- Data Analysis

SELECT * FROM city;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales;

-- Reports & Data Analysis


-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

SELECT
    city_name,
    CONCAT(ROUND((population * 0.25) / 1000000, 2), 'M') AS coffee_consumers_in_millions,
    city_rank
FROM
    city
-- Top 5 Most Coffee Consumer Cities
ORDER BY 2 DESC LIMIT 5;


-- Q.2 Total Revenue from Coffee Sales
-- 1) What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

SELECT
    SUM(total) AS total_revenue
FROM
    sales
WHERE
    EXTRACT(YEAR FROM sale_date) = 2023
    AND
    EXTRACT(QUARTER FROM sale_date) = 4;

-- 2) What is the total revenue generated from coffee sales across each city in the last quarter of 2023?

SELECT
    ci.city_name,
    SUM(s.total) AS total_revenue
FROM
    sales AS s
JOIN customers AS c
    ON c.customer_id = s.customer_id
JOIN city as ci
    ON ci.city_id = c.city_id
WHERE
    EXTRACT(YEAR FROM s.sale_date) = 2023
    AND
    EXTRACT(QUARTER FROM s.sale_date) = 4
-- Top 5 Revenue Generated Cities
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;


-- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?

SELECT
    p.product_name,
    COUNT(s.product_id) AS total_orders
FROM
    products AS p
LEFT JOIN sales AS s
    ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q.4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?

-- 2 things we have to find:
-- 1) City and Total Sales, 2) No. of customers in each city

SELECT
    ci.city_name,
    SUM(s.total) AS total_revenue,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(
        SUM(s.total)::numeric / COUNT(DISTINCT c.customer_id)::numeric -- :: <- This is a typecasting symbol
        ,2) AS average_sale_per_cust
FROM
    sales AS s
JOIN customers AS c
    ON c.customer_id = s.customer_id
JOIN city as ci
    ON ci.city_id = c.city_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q.5 City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.

SELECT
    ci.city_name,
    CONCAT(ROUND((ci.population * 0.25) / 1000000, 2), 'M') AS coffee_consumers_in_millions,
    COUNT(DISTINCT c.customer_id) AS estimated_coffee_consumer
FROM
    city AS ci
JOIN customers AS c
    ON c.city_id = ci.city_id
GROUP BY 1, 2
ORDER BY 3 DESC;


-- Q6 Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?

SELECT *
FROM
    (
    SELECT
        ci.city_name,
        p.product_name,
        COUNT(DISTINCT s.sale_id) AS total_sales,
        DENSE_RANK() OVER(PARTITION BY ci.city_name ORDER BY COUNT(DISTINCT s.sale_id) DESC) AS Rank
    FROM 
        sales AS s
    JOIN products AS p
        ON p.product_id = s.product_id
    JOIN customers AS c
        ON c.customer_id = s.customer_id
    JOIN city AS ci
        ON ci.city_id = c.city_id
    GROUP BY 1, 2
    ) AS most_selling_products_table -- Sub Table or Query
WHERE Rank <= 3;


-- Q.7 Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

SELECT
    ci.city_name,
    COUNT(DISTINCT c.customer_id) AS unique_customer
FROM
    city AS ci
JOIN customers AS c
    ON c.city_id = ci.city_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q.8 Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer

SELECT
    ci.city_name,
    ROUND(
        SUM(s.total)::numeric / COUNT(DISTINCT c.customer_id)::numeric
        ,2) AS average_sale_per_cust,
    ROUND(
        AVG(ci.estimated_rent::numeric) / COUNT(DISTINCT c.customer_id)::numeric
        ,2) AS average_rent_per_cust
FROM
    city AS ci
JOIN customers AS c
    ON c.city_id = ci.city_id
JOIN sales AS s
    ON s.customer_id = c.customer_id
GROUP BY 1
ORDER BY 2 DESC;


-- Q.9 Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly) by each city

WITH
monthly_sales
AS (
    SELECT 
        ci.city_name,
        EXTRACT(MONTH FROM s.sale_date) AS sale_month,
        EXTRACT(YEAR FROM s.sale_date) AS sale_year,
        SUM(s.total) AS total_sales
    FROM
        sales AS s
    JOIN customers AS c
    ON
        c.customer_id = s.customer_id
    JOIN city AS ci
    ON
        ci.city_id = c.city_id
    GROUP BY 1, 2, 3
    ORDER BY 1, 3, 2
),

growth_ratio
AS (
    SELECT
        city_name,
        sale_month,
        sale_year,
        total_sales AS current_month_sale,
        LAG(total_sales, 1) OVER(PARTITION BY city_name ORDER BY sale_year, sale_month) AS last_month_sale
    FROM
        monthly_sales
)

SELECT
    city_name,
    sale_month,
    sale_year,
    current_month_sale,
    last_month_sale,
    CONCAT
        (ROUND(
            (current_month_sale - last_month_sale)::numeric / last_month_sale::numeric * 100, 1), '%') AS growth_perc
FROM 
    growth_ratio
WHERE
    last_month_sale IS NOT NULL;


-- Q.10 Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

SELECT
    ci.city_name,
    SUM(s.total) AS total_sales,
    ci.estimated_rent AS total_rent,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    
    CONCAT(
        ROUND(
            (ci.population * 0.25) / 1000000, 2),'M') AS estimated_coffee_consumer,
    ROUND(
        SUM(s.total)::numeric / COUNT(DISTINCT c.customer_id)::numeric
        ,2) AS average_sale_per_cust,
    ROUND(
        AVG(ci.estimated_rent::numeric) / COUNT(DISTINCT c.customer_id)::numeric
        ,2) AS average_rent_per_cust
FROM
    city AS ci
JOIN customers AS c
    ON c.city_id = ci.city_id
JOIN sales AS s
    ON s.customer_id = c.customer_id
GROUP BY 1, 3, 5
ORDER BY 2 DESC;