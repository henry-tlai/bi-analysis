USE olist;
GO

-- Top 10 sellers by revenue
WITH seller_revenue AS (
    SELECT oi.seller_id,
           SUM(oi.price)               AS revenue,
           COUNT(DISTINCT oi.order_id) AS orders
    FROM order_items oi
    JOIN vw_order_revenue v ON v.order_id = oi.order_id
    GROUP BY oi.seller_id
)
SELECT TOP 10
       seller_id, revenue, orders,
       CAST(100.0 * revenue / SUM(revenue) OVER () AS DECIMAL(5,2)) AS pct_of_revenue,
       -- ROWS UNBOUNDED PRECEDING: frame, set of rows the SUM looks at for each row (no lower limit)
       CAST(100.0 * SUM(revenue) OVER (ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING) / SUM(revenue) OVER () AS DECIMAL(5,2))
       AS cumulative_pct
FROM seller_revenue
ORDER BY revenue DESC;
-- Findings: the top 10 sellers generate at least 131,000+ in revenue.
-- An outlier is #2 seller as they generated the second most while only processing 300 orders. So, the orders must've been much more expensive

-- Revenue Concentration
WITH seller_revenue AS (
    SELECT oi.seller_id, SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN vw_order_revenue v ON v.order_id = oi.order_id
    GROUP BY oi.seller_id
),
running AS (
    SELECT seller_id, revenue,
           SUM(revenue) OVER (ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING) AS running_total,
           SUM(revenue) OVER ()                                               AS grand_total
    FROM seller_revenue
)
SELECT COUNT(*)                                  AS sellers_for_80pct,
       (SELECT COUNT(*) FROM seller_revenue)     AS total_sellers
FROM running
WHERE running_total - revenue < 0.8 * grand_total;
-- Findings: To reach 80% of revenue, it takes 2,925 sellers. 

-- Customer Payment Method
SELECT p.payment_type,
       COUNT(DISTINCT p.order_id)                                  AS orders,
       SUM(p.payment_value)                                        AS total_paid,
       CAST(100.0 * SUM(p.payment_value) / SUM(SUM(p.payment_value)) OVER () AS DECIMAL(5,2)) AS pct_of_payments,
       CAST(AVG(1.0 * p.payment_installments) AS DECIMAL(4,1))     AS avg_installments
FROM order_payments p
JOIN vw_order_revenue v ON v.order_id = p.order_id
GROUP BY p.payment_type
ORDER BY total_paid DESC;
-- Findings: The primary source of payment is through credit_card. 

-- Freight
SELECT SUM(items_revenue)                                                AS item_revenue,
       SUM(freight_total)                                                AS freight,
       CAST(100.0 * SUM(freight_total) / SUM(items_revenue) AS DECIMAL(5,1)) AS freight_pct_of_revenue,
       CAST(AVG(freight_total) AS DECIMAL(6,2))                          AS avg_freight_per_order
FROM vw_order_revenue;
-- Findings: the overall freight share of revenue ended up being 16.7%