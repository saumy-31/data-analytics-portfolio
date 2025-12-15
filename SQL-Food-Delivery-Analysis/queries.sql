-- Food Delivery Platform Analysis (MySQL)

-- 1. Total Orders and Revenue
SELECT 
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders;

-- 2. Top 10 Cities by Revenue
SELECT customer_city, SUM(total_amount) AS revenue
FROM orders
GROUP BY customer_city
ORDER BY revenue DESC
LIMIT 10;

-- 3. Top Restaurants by Revenue
SELECT r.restaurant_name, SUM(o.total_amount) AS revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY revenue DESC
LIMIT 10;

-- 4. Most Popular Cuisines
SELECT r.cuisine_type, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_orders DESC;

-- 5. Average Delivery Time by City
SELECT customer_city, AVG(delivery_time_min) AS avg_delivery_time
FROM orders
GROUP BY customer_city;

-- 6. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(order_datetime, '%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 7. Rank Restaurants by Revenue (Window Function)
SELECT 
    r.city,
    r.restaurant_name,
    SUM(o.total_amount) AS revenue,
    RANK() OVER (PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) AS city_rank
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name, r.city;
