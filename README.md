# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `retail_sales`

The objectives of this project is to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- Data Exploration -
-- (1) How many sales  we have ?
SELECT 
    COUNT(*)
FROM
    retail_sales;

-- (2) How many unique customer we have ?
SELECT 
    COUNT(DISTINCT (customer_id))
FROM
    retail_sales;

-- (3) How many Category we have ?
SELECT DISTINCT
    (category)
FROM
    retail_sales;
    
-- Checking for the null values --
select * from retail_sales
where transaction_id is null or
                sale_date is null or
                sale_time is null or
                customer_id is null or
                gender	is null or
                age	is null or
                category is null or
                quantity is null or
                price_per_unit is null or
                cogs is null or
                total_sale is null ;
-- So As we found here there is no Null Values in our dataset --
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equals to 4 in the month of Nov-2022**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND MONTH(Sale_date) = '11'
        And year(Sale_date) = '2022'
        AND quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category, SUM(total_sale) AS Total_sale
FROM
    retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
    ROUND(AVG(age))
FROM
    retail_sales
WHERE
    category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(transaction_id) AS total_no_transaction
FROM
    retail_sales
GROUP BY gender , category
ORDER BY category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
with Avg_Sale as 
	(select year(sale_date) as year , month(sale_date) as month , avg(total_sale) as avg_sale,  
	rank() over(partition by year(sale_date) 
	order by avg(total_sale) desc ) as rankk  
	from retail_sales 
	group by year , month order by year ,avg_sale desc)
select year,month,avg_sale from Avg_sale where rankk=1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id, sum(total_sale) as total_sale
FROM
    retail_sales
group by customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,
    COUNT(DISTINCT (customer_id)) AS no_unique_customer
FROM
    retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with Shifts as 
	(select * ,case 
	when hour(sale_time) <= 12 Then 'Morning shift'
	when hour(sale_time) between 12 and 17 Then 'Afternoon shift'
	else 'Evening shift'
	end as 'Shifts'
from retail_sales)
select  Shifts ,count(*) as total_orders from Shifts group by Shifts;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing ,Electronics and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

