USE olist;
GO

-- Top 10 categories by revenue
WITH category_revenue AS (
    -- COALESCE returns the first value in its list that isn't NULL
    SELECT COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
           SUM(oi.price)               AS revenue,
           COUNT(*)                    AS items_sold,
           COUNT(DISTINCT oi.order_id) AS orders
    FROM order_items oi
    JOIN vw_order_revenue v ON v.order_id = oi.order_id
    JOIN products p         ON p.product_id = oi.product_id
    LEFT JOIN category_translation t ON t.product_category_name = p.product_category_name
    GROUP BY COALESCE(t.product_category_name_english, p.product_category_name, 'unknown')
)
SELECT TOP 10
       category, revenue, items_sold, orders,
       ROUND(100.0 * revenue / SUM(revenue) OVER (), 1) AS pct_of_revenue,
       ROUND(100.0 * SUM(revenue) OVER (ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING)
             / SUM(revenue) OVER (), 1)                 AS cumulative_pct
FROM category_revenue
ORDER BY revenue DESC;
-- Findings: Health_beauty is the most popular category that generated $1,217,191 in revenue while the least popular category are toys generating nearly a third at $462,611 

-- Top categories by growth
WITH cat_period AS (
    SELECT COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
           SUM(CASE WHEN YEAR(v.order_purchase_timestamp) = 2017 THEN oi.price END) AS rev_2017,
           SUM(CASE WHEN YEAR(v.order_purchase_timestamp) = 2018 THEN oi.price END) AS rev_2018
    FROM order_items oi
    JOIN vw_order_revenue v ON v.order_id = oi.order_id
    JOIN products p         ON p.product_id = oi.product_id
    LEFT JOIN category_translation t ON t.product_category_name = p.product_category_name
    WHERE MONTH(v.order_purchase_timestamp) BETWEEN 2 AND 8
    GROUP BY COALESCE(t.product_category_name_english, p.product_category_name, 'unknown')
)
SELECT TOP 10
       category, rev_2017, rev_2018,
       ROUND(100.0 * (rev_2018 - rev_2017) / NULLIF(rev_2017, 0), 1) AS growth_pct
FROM cat_period
ORDER BY rev_2018 DESC;
-- Findings: Although health_beauty generated the most amount of revenue, it's runner up watches_gifts grew the most at nearly 218%. 