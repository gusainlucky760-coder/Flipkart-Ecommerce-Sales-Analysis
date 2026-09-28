CREATE TABLE flipkart_sales_cleaned (
    order_id VARCHAR(50),
    product_name VARCHAR(255),
    category VARCHAR(100),
    price_inr NUMERIC,
    quantity_sold INTEGER,
    total_sales_inr NUMERIC,
    order_date DATE,
    payment_method VARCHAR(100),
    customer_rating NUMERIC,
    month VARCHAR(20),
    year INTEGER,
    profit_inr NUMERIC,
    discount_percent NUMERIC,
    customer_segment VARCHAR(100),
    region VARCHAR(100),
    calculated_sales NUMERIC,
    sales_difference NUMERIC,
    profit_margin_percent VARCHAR(20),
    revenue_per_unit NUMERIC,
    profit_per_unit NUMERIC,
    month_number INTEGER,
    quarter VARCHAR(10),
    year_month VARCHAR(20),
    discount_amount NUMERIC,
    net_sales_after_discount NUMERIC,
    month_start VARCHAR(20)
);

ALTER TABLE flipkart_sales_cleaned
ALTER COLUMN order_date TYPE VARCHAR(20);

SELECT * FROM public.flipkart_sales_cleaned

/*
PROJECT NAME : Flipkart E-Commerce Sales Analysis

TOOLS USED :
- Microsoft Excel
- PostgreSQL
- Power BI

DATASET SIZE :
1000 Rows
26 Columns

AUTHOR :
Lucky Gusain

DESCRIPTION :
This project analyzes Flipkart sales data using SQL to
identify business insights related to sales, profit,
customers, products, regions and payment methods.
*/

create database Flipkart_Analytics;



-- SECTION 1: DATABASE & DATA VALIDATION

-- 1. Total Records

SELECT COUNT(*) AS total_rows
FROM flipkart_sales_cleaned;

-- 2. Sample Records

SELECT *
FROM flipkart_sales_cleaned
LIMIT 10;

-- 3. Total Columns

SELECT COUNT(*) AS Total_Columns
FROM information_schema.columns
WHERE table_schema='public'
AND table_name='flipkart_sales_cleaned';

-- SECTION 2: DATA QUALITY CHECK

-- 4. Unique Orders

SELECT COUNT(DISTINCT order_id) AS Unique_Orders
FROM flipkart_sales_cleaned;

-- 5. Duplicate Orders

SELECT
COUNT(order_id)-COUNT(DISTINCT order_id) AS Duplicate_Orders
FROM flipkart_sales_cleaned;

-- 6. Missing Values

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id,
SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS product_name,
SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category,
SUM(CASE WHEN price_inr IS NULL THEN 1 ELSE 0 END) AS price,
SUM(CASE WHEN quantity_sold IS NULL THEN 1 ELSE 0 END) AS quantity,
SUM(CASE WHEN total_sales_inr IS NULL THEN 1 ELSE 0 END) AS sales,
SUM(CASE WHEN profit_inr IS NULL THEN 1 ELSE 0 END) AS profit
FROM flipkart_sales_cleaned;

-- SECTION 3: BUSINESS PERFORMANCE ANALYSIS

-- 7. Total Sales

SELECT
SUM(total_sales_inr) AS Total_Sales
FROM flipkart_sales_cleaned;

-- 8. Total Profit

SELECT
SUM(profit_inr) AS Total_Profit
FROM flipkart_sales_cleaned;

-- 9. Total Quantity Sold

SELECT
SUM(quantity_sold) AS Total_Quantity_Sold
FROM flipkart_sales_cleaned;

-- 10. Average Order Value

SELECT
AVG(total_sales_inr) AS Average_Order_Value
FROM flipkart_sales_cleaned;

-- 11. Profit Margin

SELECT
(SUM(profit_inr) / SUM(total_sales_inr)) * 100 AS Profit_Margin_Percent
FROM flipkart_sales_cleaned;

-- SECTION 4: DATE & TIME ANALYSIS

-- 12. Order Date Range
SELECT
MIN(TO_DATE(order_date, 'DD-MM-YYYY')) AS First_Order_Date,
MAX(TO_DATE(order_date, 'DD-MM-YYYY')) AS Last_Order_Date
FROM flipkart_sales_cleaned;

-- 13. Sales by Year

SELECT
year,
SUM(total_sales_inr) AS Total_Sales,
SUM(profit_inr) AS Total_Profit,
SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY year
ORDER BY year;

-- 14. Sales by Month

SELECT
month_number,
month,
SUM(total_sales_inr) AS Total_Sales,
SUM(profit_inr) AS Total_Profit,
SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY month_number, month
ORDER BY month_number;


-- 15. Sales by Quarter

SELECT
quarter,
SUM(total_sales_inr) AS Total_Sales,
SUM(profit_inr) AS Total_Profit,
SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY quarter
ORDER BY quarter;

-- SECTION 5: CATEGORY ANALYSIS

-- 16. Sales by Category

SELECT
    category,
    SUM(total_sales_inr) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY category
ORDER BY Total_Sales DESC;

-- 17. Profit by Category

SELECT
    category,
    SUM(profit_inr) AS Total_Profit
FROM flipkart_sales_cleaned
GROUP BY category
ORDER BY Total_Profit DESC;

-- 18. Quantity Sold by Category

SELECT
    category,
    SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY category
ORDER BY Total_Quantity DESC;

-- SECTION 6: PRODUCT PERFORMANCE ANALYSIS

-- 19. Top 10 Products by Total Sales

SELECT
    product_name,
    SUM(total_sales_inr) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- 20. Top 10 Products by Profit

SELECT
    product_name,
    SUM(profit_inr) AS Total_Profit
FROM flipkart_sales_cleaned
GROUP BY product_name
ORDER BY Total_Profit DESC
LIMIT 10;

-- 21. Top 10 Products by Quantity Sold

SELECT
    product_name,
    SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY product_name
ORDER BY Total_Quantity DESC
LIMIT 10;

-- 22. Average Rating by Product

SELECT
    product_name,
    ROUND(AVG(customer_rating),2) AS Average_Rating
FROM flipkart_sales_cleaned
GROUP BY product_name
ORDER BY Average_Rating DESC;

-- 23. Top 5 Products by Revenue per Unit

SELECT
    product_name,
    ROUND(AVG(revenue_per_unit),2) AS Revenue_Per_Unit
FROM flipkart_sales_cleaned
GROUP BY product_name
ORDER BY Revenue_Per_Unit DESC
LIMIT 5;

-- SECTION 7: REGION ANALYSIS

-- 24. Total Sales by Region

SELECT
    region,
    ROUND(SUM(total_sales_inr),2) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY region
ORDER BY Total_Sales DESC;

-- 25. Total Profit by Region

SELECT
    region,
    ROUND(SUM(profit_inr),2) AS Total_Profit
FROM flipkart_sales_cleaned
GROUP BY region
ORDER BY Total_Profit DESC;

-- 26. Quantity Sold by Region

SELECT
    region,
    SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY region
ORDER BY Total_Quantity DESC;

-- 27. Average Customer Rating by Region

SELECT
    region,
    ROUND(AVG(customer_rating),2) AS Average_Rating
FROM flipkart_sales_cleaned
GROUP BY region
ORDER BY Average_Rating DESC;

-- 28. Profit Margin by Region

SELECT
    region,
    ROUND((SUM(profit_inr) / SUM(total_sales_inr)) * 100,2) AS Profit_Margin
FROM flipkart_sales_cleaned
GROUP BY region
ORDER BY Profit_Margin DESC;

-- SECTION 8: CUSTOMER SEGMENT ANALYSIS

-- 29. Total Sales by Customer Segment

SELECT
    customer_segment,
    ROUND(SUM(total_sales_inr),2) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY customer_segment
ORDER BY Total_Sales DESC;

-- 30. Total Profit by Customer Segment

SELECT
    customer_segment,
    ROUND(SUM(profit_inr),2) AS Total_Profit
FROM flipkart_sales_cleaned
GROUP BY customer_segment
ORDER BY Total_Profit DESC;

-- 31. Quantity Sold by Customer Segment

SELECT
    customer_segment,
    SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY customer_segment
ORDER BY Total_Quantity DESC;

-- 32. Average Customer Rating by Segment

SELECT
    customer_segment,
    ROUND(AVG(customer_rating),2) AS Average_Rating
FROM flipkart_sales_cleaned
GROUP BY customer_segment
ORDER BY Average_Rating DESC;

-- 33. Profit Margin by Customer Segment

SELECT
    customer_segment,
    ROUND((SUM(profit_inr) / SUM(total_sales_inr)) * 100,2) AS Profit_Margin
FROM flipkart_sales_cleaned
GROUP BY customer_segment
ORDER BY Profit_Margin DESC;

-- SECTION 9: PAYMENT METHOD ANALYSIS

-- 34. Total Sales by Payment Method

SELECT
    payment_method,
    ROUND(SUM(total_sales_inr),2) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY payment_method
ORDER BY Total_Sales DESC;

-- 35. Total Profit by Payment Method

SELECT
    payment_method,
    ROUND(SUM(profit_inr),2) AS Total_Profit
FROM flipkart_sales_cleaned
GROUP BY payment_method
ORDER BY Total_Profit DESC;

-- 36. Quantity Sold by Payment Method

SELECT
    payment_method,
    SUM(quantity_sold) AS Total_Quantity
FROM flipkart_sales_cleaned
GROUP BY payment_method
ORDER BY Total_Quantity DESC;

-- 37. Average Customer Rating by Payment Method

SELECT
    payment_method,
    ROUND(AVG(customer_rating),2) AS Average_Rating
FROM flipkart_sales_cleaned
GROUP BY payment_method
ORDER BY Average_Rating DESC;

-- 38. Profit Margin by Payment Method

SELECT
    payment_method,
    ROUND((SUM(profit_inr) / SUM(total_sales_inr)) * 100,2) AS Profit_Margin
FROM flipkart_sales_cleaned
GROUP BY payment_method
ORDER BY Profit_Margin DESC;

-- SECTION 10: ADVANCED SQL ANALYSIS

-- 39. Top 10 Highest Revenue Orders

SELECT
    order_id,
    product_name,
    total_sales_inr,
    ROW_NUMBER() OVER(ORDER BY total_sales_inr DESC) AS Sales_Rank
FROM flipkart_sales_cleaned
LIMIT 10;

-- 40. Rank Products by Total Sales

SELECT
    product_name,
    SUM(total_sales_inr) AS Total_Sales,
    RANK() OVER(ORDER BY SUM(total_sales_inr) DESC) AS Product_Rank
FROM flipkart_sales_cleaned
GROUP BY product_name;

-- 41. Dense Rank Products by Profit

SELECT
    product_name,
    SUM(profit_inr) AS Total_Profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit_inr) DESC) AS Profit_Rank
FROM flipkart_sales_cleaned
GROUP BY product_name;

-- 42. Top Performing Region using CTE

WITH RegionSales AS
(
SELECT
    region,
    SUM(total_sales_inr) AS Total_Sales
FROM flipkart_sales_cleaned
GROUP BY region
)

SELECT *
FROM RegionSales
ORDER BY Total_Sales DESC;

-- 43. Customer Rating Category

SELECT
    product_name,
    customer_rating,

CASE
WHEN customer_rating>=4.5 THEN 'Excellent'
WHEN customer_rating>=4 THEN 'Good'
WHEN customer_rating>=3 THEN 'Average'
ELSE 'Poor'
END AS Rating_Category

FROM flipkart_sales_cleaned;

-- 44. Orders Above Average Sales

SELECT
    order_id,
    product_name,
    total_sales_inr

FROM flipkart_sales_cleaned

WHERE total_sales_inr>

(
SELECT AVG(total_sales_inr)
FROM flipkart_sales_cleaned
)

ORDER BY total_sales_inr DESC;

-- 45. Top 5 Products in Every Region

SELECT *
FROM
(
SELECT
region,
product_name,
SUM(total_sales_inr) AS Total_Sales,

DENSE_RANK() OVER
(
PARTITION BY region
ORDER BY SUM(total_sales_inr) DESC
) AS Rank_No

FROM flipkart_sales_cleaned

GROUP BY region,product_name
) AS T

WHERE Rank_No<=5;

-- 46. Running Total Sales

SELECT
order_date,
total_sales_inr,

SUM(total_sales_inr)
OVER (
    ORDER BY TO_DATE(order_date, 'DD-MM-YYYY')
) AS Running_Total

FROM flipkart_sales_cleaned;

-- 47. Best Product in Each Category

SELECT *

FROM
(
SELECT

category,
product_name,
SUM(total_sales_inr) AS Total_Sales,

ROW_NUMBER() OVER
(
PARTITION BY category
ORDER BY SUM(total_sales_inr) DESC
) AS RN

FROM flipkart_sales_cleaned

GROUP BY category,product_name

) X

WHERE RN=1;

-- 48. High Profit Orders

SELECT
order_id,
product_name,
profit_inr

FROM flipkart_sales_cleaned

WHERE profit_inr>
(
SELECT AVG(profit_inr)
FROM flipkart_sales_cleaned
)

ORDER BY profit_inr DESC;

-- SECTION 11: BUSINESS INSIGHTS

-- 1. Electronics category generated the highest sales revenue.
-- 2. The West region contributed the maximum revenue.
-- 3. Premium customer segment generated the highest profit.
-- 4. UPI was the most preferred payment method.
-- 5. The top 10 products contributed a significant share of total revenue.
-- 6. Overall Profit Margin remained around 20%, indicating healthy profitability.
-- 7. Customer ratings were consistently above 4.0, showing high customer satisfaction.
-- 8. Some products generated high sales but relatively low profit, indicating lower margins.
-- 9. Revenue per Unit varied significantly across product categories.
-- 10. Category-wise analysis helps identify high-performing and low-performing product groups.

-- SECTION 12: PROJECT CONCLUSION

-- This project analyzed Flipkart sales data using SQL.
-- Data validation, business performance, category analysis,
-- product performance, regional analysis, customer segment,
-- payment method analysis, and advanced SQL techniques
-- were used to generate meaningful business insights.
--
-- SQL Concepts Used:
-- ✔ Aggregate Functions
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ✔ HAVING
-- ✔ CASE WHEN
-- ✔ Subqueries
-- ✔ Common Table Expressions (CTE)
-- ✔ Window Functions
-- ✔ ROW_NUMBER()
-- ✔ RANK()
-- ✔ DENSE_RANK()


