/* ROW COUNT */
SELECT 'category_translation' AS table_name, COUNT(*) AS row_count FROM category_translation
UNION ALL SELECT 'sellers',        COUNT(*) FROM sellers
UNION ALL SELECT 'customers',      COUNT(*) FROM customers
UNION ALL SELECT 'products',       COUNT(*) FROM products
UNION ALL SELECT 'orders',         COUNT(*) FROM orders
UNION ALL SELECT 'order_items',    COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews',  COUNT(*) FROM order_reviews;

/* ORDER STATUSES */
SELECT order_status, COUNT(*) AS Orders
FROM orders
GROUP BY order_status
ORDER BY COUNT(*) DESC

/* MISSING DELIVERY DATES */
SELECT order_status, COUNT(*) AS Missing_Data
FROM orders
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status
ORDER BY Count(*) DESC 

/* ORPHAN CHECK */
SELECT o.order_status, COUNT(o.order_id)
FROM orders o LEFT JOIN order_items oi 
ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status
/* sorts by biggest group first */
ORDER BY COUNT(o.order_id) DESC

/* DATE RANGE */
SELECT MIN(order_purchase_timestamp) AS Earliest_Order, MAX(order_purchase_timestamp) AS Latest_Order
FROM orders

/* ORDERS PER MONTH */
SELECT YEAR(order_purchase_timestamp)  AS order_year,
       MONTH(order_purchase_timestamp) AS order_month,
       COUNT(*)                        AS orders
FROM orders
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY order_year, order_month;

/* ROW COUNT */
-- Finding: All eight tables match the expected row counts, so the loads were complete.

/* ORDER STATUSES */
-- Finding: "delivered" is 97% of all orders (96478 of 99441). The next largest
-- statuses are shipped and canceled. Revenue and delivery analysis will focus on delivered orders.

/* MISSING DELIVERY DATES */
-- Finding: 8 orders marked "delivered" have no delivery date. They are fine for
-- revenue but can't be used for delivery-time or late-delivery metrics, so I will
-- exclude them from those calculations only. The remaining missing dates belong to
-- created and approved orders, which is expected since those orders were never delivered.

/* ORPHAN CHECK */
-- Finding: 775 orders have no rows in order_items, so they have no product, price,
-- or seller. "unavailable" accounts for 603 of them, which makes sense because the
-- item couldn't be fulfilled. With no price to sum, I will exclude them from
-- revenue analysis.

/* DATE RANGE */
-- Finding: The data covers orders from 2016-09 to 2018-10, roughly two years. This is the
-- period the dataset covers, not necessarily when the company started.