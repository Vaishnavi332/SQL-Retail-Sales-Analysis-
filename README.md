# 🛍️ Retail Sales Analysis - SQL Project

## 📖 Overview
This project involves an in-depth analysis of a retail company's sales data using SQL. The goal was to clean, explore, and analyze the dataset to uncover key business insights, such as sales performance, customer behavior, and product category trends. This analysis can help stakeholders make data-driven decisions regarding inventory, marketing, and sales strategies.

##  Dataset
The dataset contains over 2000 sales transactions with the following attributes:
- transactions_id: Unique ID for each transaction.
- sale_date: Date of the sale.
- sale_time: Time of the sale.
- customer_id: Unique ID for each customer.
- gender: Gender of the customer (M/F).
- age: Age of the customer.
- category: Product category (e.g., Clothing, Electronics, Beauty).
- quantity: Quantity of items purchased.
- price_per_unit: Price per unit of item.
- cogs: Cost of Goods Sold.
- total_sale: Total sale amount (quantity * price_per_unit).

## 🛠️ Tech Stack
- **SQL:** PostgreSQL (Can be adapted for MySQL, SQL Server, etc.)
- **Database:** PostgreSQL
- **Tools:** pgAdmin / DBeaver

## 📊 Analysis Highlights
The SQL queries were designed to answer complex business questions, including:

1.  Data Quality: Performed initial data cleaning to handle missing values.
2.  Sales Trends: Identified the best-selling month for each year.
3.  Customer Analysis: Found the top 5 highest-spending customers and the average age of customers by category.
4.  Product Performance: Analyzed total sales and unique customer count per product category.
5.  Time-based Analysis: Categorized order volume into shifts (Morning, Afternoon, Evening) to understand peak sales times.
6.  Demographic Insights: Explored purchasing patterns across different genders and categories.

## 🔍 Key Insights
- The Electronics category generated the highest total revenue, contributing to 34.42% of all sales.
- The average customer in the Beauty  category is 40 years old.
- Sales peak during the Evening shift is 1062.
- The top customer ID: 3 spent a total of 38440.
- The month of July consistently had the highest average sales value in 2022.
