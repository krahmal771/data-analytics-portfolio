-- Успешность оплат по методам
SELECT
  method,
  COUNT(*) AS payments_total,
  SUM(status = 'success') AS payments_success,
  ROUND(SUM(status = 'success') / COUNT(*), 4) AS success_rate
FROM payments
GROUP BY method
ORDER BY success_rate DESC;
