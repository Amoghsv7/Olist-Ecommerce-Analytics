-- Olist E-commerce Customer & Sales Analytics
-- 03_Data_Quality_Checks.sql

USE ecommerce_analytics;

-- Duplicate checks
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers GROUP BY customer_id HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS duplicate_count
FROM orders GROUP BY order_id HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS duplicate_count
FROM products GROUP BY product_id HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*) AS duplicate_count
FROM sellers GROUP BY seller_id HAVING COUNT(*) > 1;

-- NULL checks
SELECT
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(customer_unique_id IS NULL) AS null_customer_unique_id,
    SUM(customer_zip_code_prefix IS NULL) AS null_zip_code,
    SUM(customer_city IS NULL) AS null_city,
    SUM(customer_state IS NULL) AS null_state
FROM customers;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(order_status IS NULL) AS null_order_status,
    SUM(order_purchase_timestamp IS NULL) AS null_purchase_timestamp
FROM orders;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(product_id IS NULL) AS null_product_id,
    SUM(seller_id IS NULL) AS null_seller_id,
    SUM(price IS NULL) AS null_price
FROM order_items;

SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(payment_type IS NULL) AS null_payment_type,
    SUM(payment_value IS NULL) AS null_payment_value
FROM order_payments;

SELECT
    SUM(review_id IS NULL) AS null_review_id,
    SUM(order_id IS NULL) AS null_order_id,
    SUM(review_score IS NULL) AS null_review_score
FROM order_reviews;

-- Important business/data-quality checks
SELECT COUNT(*) AS products_missing_category
FROM products
WHERE product_category_name IS NULL OR TRIM(product_category_name) = '';

SELECT COUNT(*) AS delivered_orders_without_payment
FROM orders o
LEFT JOIN (SELECT DISTINCT order_id FROM order_payments) p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND p.order_id IS NULL;
