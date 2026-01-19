create database sales_retail
;


-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
						(
							transactions_id	INT PRIMARY KEY,
							sale_date DATE,
							sale_time TIME,
							customer_id	INT,
                            gender VARCHAR(15),
							age	INT NULL,
                            category VARCHAR(15),
							quantity INT,
                            price_per_unit FLOAT,
							cogs FLOAT,
							total_sale FLOAT
						);
                        
SELECT * FROM retail_sales;

-- DATA CLEANING
SELECT * FROM retail_sales
WHERE
	transactions_id	IS NULL
    OR
    sale_date IS NULL
	OR
	sale_time IS NULL
	OR
    customer_id IS NULL
	OR
    gender IS NULL	
    OR
    age IS NULL	
    OR 
    category IS NULL	
    OR 
    quantity IS NULL	
    OR 
    price_per_unit IS NULL
	OR 
    cogs IS NULL	
    OR
    total_sale IS NULL;
    
SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail_sales
WHERE
	transactions_id	IS NULL
    OR
    sale_date IS NULL
	OR
	sale_time IS NULL
	OR
    customer_id IS NULL
	OR
    gender IS NULL	
    OR
    age IS NULL	
    OR 
    category IS NULL	
    OR 
    quantity IS NULL	
    OR 
    price_per_unit IS NULL
	OR 
    cogs IS NULL	
    OR
    total_sale IS NULL;
    
-- DATA EXPLORATION

-- How many sales do we have?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales;

-- How many unique categories do we have?
SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date <  '2022-12-01'
  AND quantity >=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, 
	SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) AS avg_age 
FROM retail_sales
    WHERE category = 'Beauty';
    
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
	WHERE total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.
SELECT category, gender,
	COUNT(*) as total_transactions
FROM retail_sales
	GROUP BY category, gender
	ORDER BY 2;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	year,
	month,
	avg_sale
FROM
(
	SELECT 
	YEAR(sale_date) AS year,
	MONTH(sale_date) AS month,
		ROUND(AVG(total_sale), 2) AS avg_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS top_rankings
	FROM retail_sales
		GROUP BY 1,2
) AS table_1
WHERE top_rankings =1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
	COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales
GROUP BY category
ORDER BY 2;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- End of the project