-- Olist E-commerce Customer & Sales Analytics
-- 04_Referential_Integrity.sql

USE ecommerce_analytics;

-- Orders -> Customers
SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order Items -> Orders
SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order Items -> Products
SELECT COUNT(*) AS orphan_product_references
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
