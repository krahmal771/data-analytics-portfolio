-- Сегментация пользователей по spend (успешные оплаты)
WITH user_spend AS (
  SELECT
    u.user_id,
    u.channel,
    ROUND(SUM(CASE WHEN p.status = 'success' THEN p.amount ELSE 0 END), 2) AS spend
  FROM users u
  LEFT JOIN orders o ON o.user_id = u.user_id
  LEFT JOIN payments p ON p.order_id = o.order_id
  GROUP BY u.user_id, u.channel
)
SELECT
  user_id,
  channel,
  spend,
  CASE
    WHEN spend = 0 THEN 'No purchases'
    WHEN spend < 50 THEN 'Low'
    WHEN spend BETWEEN 50 AND 150 THEN 'Medium'
    ELSE 'High'
  END AS spend_segment
FROM user_spend
ORDER BY spend DESC;
