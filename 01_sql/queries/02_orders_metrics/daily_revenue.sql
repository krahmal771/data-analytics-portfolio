-- Выручка по дням (только оплаченные/отгруженные)
SELECT
  DATE(o.created_at) AS day,
  ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY DATE(o.created_at)
ORDER BY day;
