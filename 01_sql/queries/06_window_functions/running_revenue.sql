-- Накопительная выручка по дням (running total)
WITH daily_rev AS (
  SELECT
    DATE(o.created_at) AS day,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY DATE(o.created_at)
)
SELECT
  day,
  ROUND(revenue, 2) AS revenue,
  ROUND(SUM(revenue) OVER (ORDER BY day), 2) AS running_revenue
FROM daily_rev
ORDER BY day;
