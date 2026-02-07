-- Сколько денег "не дошло" из-за failed
SELECT
  ROUND(SUM(amount), 2) AS failed_amount_total,
  COUNT(*) AS failed_payments_cnt
FROM payments
WHERE status = 'failed';
