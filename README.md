# Retail Sales Analysis (SQL)

A hands-on SQL project analyzing retail sales data using **MySQL**.  
This project focuses on real-world data cleaning, exploratory analysis, and business-driven queries.

---

## Tech Stack
- MySQL
- SQL

---

## Database Schema

**Table:** `retail_sales`

| Column | Type |
|------|------|
| transactions_id | INT (Primary Key) |
| sale_date | DATE |
| sale_time | TIME |
| customer_id | INT |
| gender | VARCHAR |
| age | INT |
| category | VARCHAR |
| quantity | INT |
| price_per_unit | FLOAT |
| cogs | FLOAT |
| total_sale | FLOAT |

---

## Data Cleaning
- Checked for NULL values across critical columns
- Removed incomplete records to ensure analysis accuracy
- Disabled safe update mode for controlled deletions

---

## Exploratory Analysis
- Total number of sales
- Number of unique customers
- Available product categories

---

## Business Questions Answered

- Sales on a specific date  
- High-volume Clothing transactions in Nov 2022  
- Total revenue and order count per category  
- Average age of Beauty-category customers  
- High-value transactions (> 1000)  
- Transactions by gender and category  
- Best-selling month per year (average sale)  
- Top 5 customers by total spend  
- Unique customers per category  
- Order distribution by time of day  

---

## Example Query

**Best-selling month per year**

```sql
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS ranking
    FROM retail_sales
    GROUP BY 1, 2
) ranked
WHERE ranking = 1;


## Key Insights
- Sales vary significantly by month, with clear peak periods each year
- Certain categories consistently generate higher revenue per transaction
- A small group of customers contributes disproportionately to total sales
- Purchasing behavior changes noticeably by time of day
- Why This Project Matters

## This project demonstrates:
- Comfort with real SQL workflows, not just theory
- Ability to clean and validate data before analysis
-Translating raw data into business-relevant insights
- Use of advanced SQL features like window functions and CTEs
- It reflects the kind of SQL work expected in junior data analyst / BI roles.
