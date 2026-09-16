-- Olist E-commerce Customer & Sales Analytics
-- 05_Business_Analysis.sql

USE ecommerce_analytics;

-- 1. Core KPIs
SELECT
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT oi.product_id) AS total_products,
    COUNT(DISTINCT oi.seller_id) AS total_sellers,
    ROUND(SUM(oi.price), 2) AS total_sales,
    ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2) AS aov
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id;

-- Payment-based revenue and AOV
SELECT
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS payment_based_aov
FROM order_payments;

-- 2. Monthly sales trend
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
    ROUND(SUM(oi.price), 2) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY sales_month;

-- 3. Category performance
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS category_sales,
    COUNT(DISTINCT oi.order_id) AS orders,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY category_sales DESC;

-- Top 10 products
SELECT
    oi.product_id,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM order_items oi
GROUP BY oi.product_id
ORDER BY product_sales DESC
LIMIT 10;

-- 4. One-time vs repeat customers
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE WHEN order_count = 1 THEN 'One-time' ELSE 'Repeat' END AS customer_type,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY CASE WHEN order_count = 1 THEN 'One-time' ELSE 'Repeat' END;

-- Repeat customer rate
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT ROUND(100.0 * SUM(order_count > 1) / COUNT(*), 2) AS repeat_customer_rate_pct
FROM customer_orders;

-- 5. Customer geography
SELECT customer_state, COUNT(DISTINCT customer_unique_id) AS customers
FROM customers
GROUP BY customer_state
ORDER BY customers DESC;

SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- 6. Seller performance
SELECT
    s.seller_id,
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS seller_sales
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_state
ORDER BY seller_sales DESC
LIMIT 10;

-- 7. Delivery performance
SELECT ROUND(AVG(DATEDIFF(
    DATE(o.order_delivered_customer_date),
    DATE(o.order_purchase_timestamp)
)), 2) AS avg_delivery_days
FROM orders o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;

SELECT ROUND(100.0 * SUM(
    o.order_delivered_customer_date > o.order_estimated_delivery_date
) / COUNT(*), 2) AS late_delivery_rate_pct
FROM orders o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL;

SELECT
    order_status,
    COUNT(*) AS orders
FROM orders
GROUP BY order_status
ORDER BY orders DESC;

-- 8. Payment analysis
SELECT
    payment_type,
    COUNT(*) AS payment_records,
    ROUND(SUM(payment_value), 2) AS payment_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY payment_revenue DESC;

-- 9. Review analysis
SELECT ROUND(AVG(review_score), 2) AS average_review_score
FROM order_reviews;

SELECT review_score, COUNT(*) AS review_count
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Late vs on-time delivery review score
SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'Late' ELSE 'On-time'
    END AS delivery_status,
    COUNT(*) AS reviewed_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY CASE
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
    THEN 'Late' ELSE 'On-time'
END;
