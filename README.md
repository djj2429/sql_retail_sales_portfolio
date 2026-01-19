🛍️ Retail Sales Analysis — SQL Project
Overview

This project is a hands-on SQL analysis of retail sales data, built to demonstrate practical data analysis skills using MySQL.
It covers database setup, data cleaning, exploratory analysis, and business-driven queries that answer real retail questions.

This project reflects how SQL is actually used in analytics roles: cleaning messy data, exploring patterns, and extracting insights that matter.

Tech Stack

Database: MySQL

Language: SQL

Concepts used:

Aggregations (SUM, AVG, COUNT)

Window functions (RANK)

Date and time analysis

Data cleaning with NULL handling

CTEs

Business logic with CASE

Dataset & Schema

The database contains a single table, retail_sales, with transactional-level data:

transactions_id – unique transaction identifier

sale_date, sale_time – when the transaction occurred

customer_id, gender, age – customer attributes

category – product category

quantity, price_per_unit, cogs, total_sale – sales metrics

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT NULL,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

Data Cleaning

Before analysis, the dataset was checked for missing values across all critical columns.
Rows containing NULLs were removed to ensure clean, reliable analysis.

Key steps:

Identified incomplete records

Disabled safe update mode to allow controlled deletions

Removed invalid rows

This mirrors real-world data prep where imperfect data must be handled before analysis.

Exploratory Analysis

Initial exploration focused on understanding the structure and scale of the data:

Total number of sales

Number of unique customers

Available product categories

These checks helped validate data integrity and scope before deeper analysis.

Business Questions Answered

The analysis answers common retail and stakeholder-driven questions, including:

📅 Sales by Date

Retrieve all sales on a specific day

👕 Category Performance

Clothing transactions with high quantities in a specific month

Total revenue and order volume per category

👤 Customer Insights

Average age of customers buying Beauty products

Top 5 customers by total spend

Unique customer count per category

📈 Sales Trends

Monthly average sales

Best-selling month for each year using window functions

⏰ Time-Based Behavior

Orders segmented by time of day:

Morning

Afternoon

Evening

Example Analysis Query

Best-selling month per year (by average sale):

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
        ) AS top_rankings
    FROM retail_sales
    GROUP BY 1, 2
) AS ranked_months
WHERE top_rankings = 1;

Key Insights

Sales vary significantly by month, with clear peak periods each year

Certain categories consistently generate higher revenue per transaction

A small group of customers contributes disproportionately to total sales

Purchasing behavior changes noticeably by time of day

Why This Project Matters

This project demonstrates:

Comfort with real SQL workflows, not just theory

Ability to clean and validate data before analysis

Translating raw data into business-relevant insights

Use of advanced SQL features like window functions and CTEs

It reflects the kind of SQL work expected in junior data analyst / BI roles.
