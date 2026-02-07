-- Количество заказов по статусам
SELECT
  status,
  COUNT(*) AS orders_cnt
FROM orders
GROUP BY status
ORDER BY orders_cnt DESC;
