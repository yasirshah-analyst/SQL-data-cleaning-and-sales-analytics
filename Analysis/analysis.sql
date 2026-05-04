-- total number of orders
SELECT COUNT(*) AS total_orders
FROM clean_sales;

-- total revenue
SELECT SUM(price) AS total_revenue
FROM clean_sales;

-- average order value
SELECT AVG(price) AS avg_order_value
FROM clean_sales;

-- total revenue by product
SELECT product, SUM(price) AS revenue
FROM clean_sales
GROUP BY product
ORDER BY revenue DESC;

-- total quantity sold per product
SELECT product, SUM(quantity) AS total_quantity
FROM clean_sales
GROUP BY product
ORDER BY total_quantity DESC;

-- revenue by city
SELECT city, SUM(price) AS revenue
FROM clean_sales
GROUP BY city
ORDER BY revenue DESC;

-- number of orders per city
SELECT city, COUNT(*) AS total_orders
FROM clean_sales
GROUP BY city
ORDER BY total_orders DESC;

-- monthly revenue
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(price) AS revenue
FROM clean_sales
GROUP BY month
ORDER BY month;

-- top 5 customers by spending
SELECT customer_name, SUM(price) AS total_spent
FROM clean_sales
GROUP BY customer_name
HAVING SUM(price) is not Null
ORDER BY total_spent DESC
LIMIT 5;

