-- LTV пользователя: сумма успешных оплат + число заказов
SELECT
  u.user_id,
  u.channel,
  u.country,
  ROUND(SUM(CASE WHEN p.status = 'success' THEN p.amount ELSE 0 END), 2) AS ltv_success,
  COUNT(DISTINCT o.order_id) AS orders_cnt
FROM users u
JOIN orders o ON o.user_id = u.user_id
JOIN payments p ON p.order_id = o.order_id
GROUP BY u.user_id, u.channel, u.country
ORDER BY ltv_success DESC
LIMIT 15;
