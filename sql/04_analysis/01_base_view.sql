/* Analysis rules baked into this view:
   - Status: delivered orders only
   - Window: Feb 2017 through Aug 2018 (months with real volume, last complete month)
   - Orders with no items are excluded automatically by the join
   - Revenue = price only; freight is reported separately */

CREATE VIEW vw_order_revenue AS
WITH item_summary AS (
    SELECT order_id,
           SUM(price)         AS items_revenue,
           SUM(freight_value) AS freight_total,
           COUNT(*)           AS item_count
    FROM order_items
    GROUP BY order_id
)
SELECT o.order_id,
       o.customer_id,
       o.order_purchase_timestamp,
       i.items_revenue,
       i.freight_total,
       i.item_count
FROM orders o
JOIN item_summary i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-02-01'
  AND o.order_purchase_timestamp <  '2018-09-01';