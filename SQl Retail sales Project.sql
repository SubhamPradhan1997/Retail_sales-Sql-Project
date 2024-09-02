create database Retail_sales;
use Retail_sales;
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT default 0 ,	
                cogs	FLOAT,
                total_sale FLOAT
                );

select * from retail_sales;
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

-- Data Exploration -
-- (1) How many sales  we have ?
SELECT 
    COUNT(*)
FROM
    retail_sales;

-- (2) How many customer we have ?
SELECT 
    COUNT(DISTINCT (customer_id))
FROM
    retail_sales;

-- (3) How many Category we have ?
SELECT DISTINCT
    (category)
FROM
    retail_sales;

--  Data Analysis & Business key problem & Answer
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND MONTH(Sale_date) = '11'
        AND quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category, SUM(total_sale) AS Total_sale
FROM
    retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    ROUND(AVG(age))
FROM
    retail_sales
WHERE
    category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(transaction_id) AS total_no_transaction
FROM
    retail_sales
GROUP BY gender , category
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

with Avg_Sale as 
	(select year(sale_date) as year , month(sale_date) as month , avg(total_sale) as avg_sale,  
	rank() over(partition by year(sale_date) 
	order by avg(total_sale) desc ) as rankk  
	from retail_sales 
	group by year , month order by year ,avg_sale desc)
select year,month,avg_sale from Avg_sale where rankk=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id, sum(total_sale) as total_sale
FROM
    retail_sales
group by customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
    COUNT(DISTINCT (customer_id)) AS no_unique_customer
FROM
    retail_sales
GROUP BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with Shifts as 
	(select * ,case 
	when hour(sale_time) <= 12 Then 'Morning shift'
	when hour(sale_time) between 12 and 17 Then 'Afternoon shift'
	else 'Evening shift'
	end as 'Shifts'
from retail_sales)
select  Shifts ,count(*) as total_orders from Shifts group by Shifts;

 