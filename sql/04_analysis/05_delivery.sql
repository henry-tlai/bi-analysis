USE olist;
GO

-- Delivery Duration (Late Count)
WITH delivery AS (
    SELECT v.order_id,
           DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS days_to_deliver,
           CASE WHEN CAST(o.order_delivered_customer_date AS DATE)
                   > CAST(o.order_estimated_delivery_date AS DATE)
                THEN 1 ELSE 0 END AS is_late
    FROM vw_order_revenue v
    JOIN orders o ON o.order_id = v.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL
)
SELECT COUNT(*)                                          AS orders,
       CAST(AVG(1.0 * days_to_deliver) AS DECIMAL(5,1))  AS avg_days_to_deliver,
       SUM(is_late)                                      AS late_orders,
       CAST(100.0 * SUM(is_late) / COUNT(*) AS DECIMAL(5,1)) AS late_rate_pct
FROM delivery;
-- Findings: Out of the 95,453 orders, it takes roughly 12-13 days for them to be delivered
-- However, nearly 6500 orders were late causing  a  6.8% late rate, which isn't ideal

-- Score impacted by lateness
WITH delivery AS (
    SELECT v.order_id,
           CASE WHEN CAST(o.order_delivered_customer_date AS DATE)
                   > CAST(o.order_estimated_delivery_date AS DATE)
                THEN 1 ELSE 0 END AS is_late
    FROM vw_order_revenue v
    JOIN orders o ON o.order_id = v.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL
),
review_per_order AS (
    SELECT order_id, AVG(1.0 * review_score) AS avg_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT d.is_late,
       COUNT(*)                                     AS orders,
       CAST(AVG(r.avg_score) AS DECIMAL(3,2))       AS avg_review_score
FROM delivery d
JOIN review_per_order r ON r.order_id = d.order_id
GROUP BY d.is_late;
-- Findings: On average, when orders are late, the customer reviews decreases by nearly 2.00