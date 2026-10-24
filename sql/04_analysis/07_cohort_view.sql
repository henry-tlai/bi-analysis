USE olist;
GO

CREATE OR ALTER VIEW vw_cohort_retention AS 
WITH cust_orders AS (
    SELECT c.customer_unique_id,
           DATEFROMPARTS(YEAR(v.order_purchase_timestamp), MONTH(v.order_purchase_timestamp), 1) AS order_month
    FROM vw_order_revenue v
    JOIN customers c ON c.customer_id = v.customer_id
),
with_cohort AS (
    SELECT customer_unique_id,
           order_month,
           MIN(order_month) OVER (PARTITION BY customer_unique_id) AS cohort_month
    FROM cust_orders
),
cohort_counts AS (
    SELECT cohort_month,
           DATEDIFF(month, cohort_month, order_month) AS months_since_first,
           COUNT(DISTINCT customer_unique_id)         AS active_customers
    FROM with_cohort
    GROUP BY cohort_month, DATEDIFF(month, cohort_month, order_month)
)
SELECT cohort_month,
       months_since_first,
       active_customers,
       -- FIRST_VALUE(column) OVER (...): returns the value from the first row of each group, copied  onto every row in that group
       -- CAST(value AS type): converts a value from one data type to another
       CAST(100.0 * active_customers / FIRST_VALUE(active_customers) OVER (PARTITION BY cohort_month ORDER BY months_since_first)
            AS DECIMAL(5,2)) AS retention_pct
FROM cohort_counts