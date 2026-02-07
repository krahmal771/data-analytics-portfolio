-- Пользователи по каналу привлечения
SELECT
  channel,
  COUNT(*) AS users_cnt
FROM users
GROUP BY channel
ORDER BY users_cnt DESC;
