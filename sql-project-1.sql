CREATE TABLE retail_sales
             (transactions_id INT,
			  sale_date  DATE,
			  sale_time  TIME,
			  customer_id INT,
			  gender VARCHAR(15),
			  age  INT,
			  category VARCHAR(15),
			  quantiy INT,
			  price_per_unit FLOAT,
			  cogs FLOAT,
			  total_sale FLOAT,
);

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales
WHERE transcation_id IS NULL

SELECT * FROM retail_sales
WHERE 
transactions_id IS NULL
OR
Sale_date IS NULL
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

DELETE FROM retail_sales
WHERE 
transactions_id IS NULL
OR
Sale_date IS NULL
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
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

SELECT COUNT(*) as total_sales FROM retail_sales;

SELECT COUNT(*) as customer_id FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales;

SELECT COUNT(DISTINCT category) as total_sales FROM retail_sales;

SELECT DISTINCT category  FROM retail_sales;

---DATA EXPLORATION AND BUSINESS QUESTIONS
--Q1-Write a SQL query to retrieve all columns for sales made on '2022-11-05?
--Q2-Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?
--Q3-Write a SQL query to calculate the total sales (total_sale) for each category?
--Q4-Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category?
--Q5-Write a SQL query to find all transactions where the total_sale is greater than 1000?
--Q6-Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?
--Q7-Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?
--Q8-Write a SQL query to find the top 5 customers based on the highest total sales?
--Q9-Write a SQL query to find the number of unique customers who purchased items from each category?
--Q10-Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?

--SOLUTIONS--

--ANS-1-
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--ANS-2-
SELECT * FROM retail_sales
WHERE category ='Clothing'
AND
TO_CHAR(sale_date,'YYYY,MM')='2022,11'
AND
quantiy >= 4

--ANS-3
SELECT category, 
SUM(total_sale) as net_sale,
COUNT (*)  as total_orders
FROM retail_sales
GROUP BY 1

--ANS-4
SELECT ROUND(AVG (age),2) as avg_age 
FROM retail_sales
WHERE category ='Beauty'

--ANS-5-
SELECT * FROM retail_Sales
WHERE total_sale > 1000;

--ANS-6-
SELECT
      category,
	  gender,
COUNT(*) as total_sales
FROM retail_sales
GROUP BY
      category,
	  gender

--ANS-7-(SOLVE THIS)
	rank and over are windows function(nested select) statements means what all comes under select statement)
SELECT 
EXTRACT (YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
ROUND(AVG(total_sale),2) as avg_total_Sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,2

--ANS-8-
SELECT 
      customer_id,
      SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1   (1,2 we should use column names for better understanding and readability )
ORDER BY 2 DESC
LIMIT 5

--ANS-9-
SELECT 
      category,
	  COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales
GROUP BY
        category

--ANS-10-(need to discuss)
SELECT total_sale,
CASE
WHEN EXTRACT(HOUR FROM sale_time) > 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM retail_sales

with(common table expression-helps enhance query)(LEARN FOR INTERVIEW ALSO)
---END OF PROJECT---
