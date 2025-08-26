-- Retail Sales Analysis SQL Project

-- Database Creation
CREATE DATABASE sql_project_p1;

-- Create table 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,        
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(11),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT, -- Cost of Goods Sold
    total_sale INT
);

-- Sample Data View
SELECT * FROM retail_sales LIMIT 10;

-- Count of all records
SELECT COUNT(*) AS total_records FROM retail_sales;

-- 1. DATA CLEANING & QUALITY CHECKS
-- Check for any missing values in critical columns
SELECT
    COUNT(*) FILTER (WHERE transactions_id IS NULL) AS missing_transaction_id,
    COUNT(*) FILTER (WHERE sale_date IS NULL) AS missing_date,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE category IS NULL) AS missing_category,
    COUNT(*) FILTER (WHERE total_sale IS NULL) AS missing_sale
FROM retail_sales;

-- Delete records with any critical missing data
DELETE FROM retail_sales     
WHERE 
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL 
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- 2. DATA EXPLORATION (Basic Metrics)

-- How many total sales transactions?
SELECT COUNT(*) AS total_sales FROM retail_sales;    

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- List of unique categories
SELECT DISTINCT category FROM retail_sales;



-- 3. BUSINESS ANALYSIS QUERIES

-- Q.1: Sales made on a specific date
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

-- Q.2: High-quantity Clothing sales in Nov-2022
SELECT *
FROM retail_sales 
WHERE 
    category = 'Clothing' 
    AND quantity > 4
    AND EXTRACT(YEAR FROM sale_date) = 2022 
    AND EXTRACT(MONTH FROM sale_date) = 11;

-- Q.3: Total sales per category
SELECT 
    category,
    SUM(total_sale) AS net_sales,
    ROUND(SUM(total_sale) * 100.0 / (SELECT SUM(total_sale) FROM retail_sales), 2) AS sales_percentage
FROM retail_sales
GROUP BY category
ORDER BY net_sales DESC;

-- Q.4: Average age of customers in the 'Beauty' category.
SELECT 
    ROUND(AVG(age), 2) AS average_age_beauty_customers
FROM retail_sales 
WHERE category = 'Beauty';

-- Q.5: High-value transactions (sale > 1000)
SELECT 
    * 
FROM retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;

-- Q.6: Transaction count by gender and category
SELECT 
    category,
    gender,
    COUNT(*) AS number_of_transactions
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY
    category,
    number_of_transactions DESC;

-- Q.7: Best selling month for each year (by average sale)
WITH monthly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
),
ranked_months AS (
    SELECT 
        year,
        month,
        avg_sale,
        RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) as rank
    FROM monthly_sales
)
SELECT 
    year,
    month,
    avg_sale
FROM ranked_months
WHERE rank = 1;

-- Q.8: Top 5 customers by total sales volume
SELECT 
    customer_id, 
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Q.9: Number of unique customers per category (Penetration)
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales 
GROUP BY category
ORDER BY unique_customers DESC;

-- Q.10: Order volume by time of day (Shift)
WITH shift_cte AS (
    SELECT 
        *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM shift_cte
GROUP BY shift
ORDER BY total_orders DESC;

--END OF PROJECT