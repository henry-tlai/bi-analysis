USE olist;
GO

-- Monthly revenue, order, and average order value
SELECT COUNT(*) AS orders, SUM(items_revenue) AS revenue
FROM vw_order_revenue;

SELECT DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1) AS order_month,
       COUNT(*)                                  AS orders,
       SUM(items_revenue)                        AS revenue,
       ROUND(SUM(items_revenue) / COUNT(*), 2)   AS avg_order_value
FROM vw_order_revenue
GROUP BY DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1)
ORDER BY order_month;

-- Month-over-Month Growth with LAG
WITH monthly AS (
    SELECT DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1) AS order_month,
           COUNT(*)           AS orders,
           SUM(items_revenue) AS revenue
    FROM vw_order_revenue
    GROUP BY DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1)
)
SELECT order_month,
       orders,
       revenue,
       LAG(revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY order_month))
             / LAG(revenue) OVER (ORDER BY order_month), 1) AS mom_growth_pct
FROM monthly
ORDER BY order_month;
-- Findings: Disregarding the first month, revenue grew gradually and peaked in November 2017