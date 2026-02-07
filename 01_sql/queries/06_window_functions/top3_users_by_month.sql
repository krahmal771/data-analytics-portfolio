-- Топ-3 пользователей по выручке в каждом месяце (успешные оплаты)
WITH user_month AS (
  SELECT
    o.user_id,
    DATE_FORMAT(o.created_at, '%Y-%m') AS ym,
    SUM(CASE WHEN p.status = 'success' THEN p.amount ELSE 0 END) AS revenue
  FROM orders o
  JOIN payments p ON p.order_id = o.order_id
  GROUP BY o.user_id, DATE_FORMAT(o.created_at, '%Y-%m')
),
ranked AS (
  SELECT
    user_id, ym, revenue,
    DENSE_RANK() OVER (PARTITION BY ym ORDER BY revenue DESC) AS rnk
  FROM user_month
)
SELECT
  ym, user_id, ROUND(revenue, 2) AS revenue
FROM ranked
WHERE rnk <= 3
ORDER BY ym, revenue DESC;
