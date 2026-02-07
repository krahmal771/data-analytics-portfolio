-- Выручка по категориям товаров
SELECT
  pr.category,
  ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products pr ON pr.product_id = oi.product_id
WHERE o.status IN ('paid','shipped')
GROUP BY pr.category
ORDER BY revenue DESC;
