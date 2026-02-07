-- Регистрации по неделям
SELECT
  WEEKOFYEAR(registration_date) AS week,
  COUNT(*) AS registrations
FROM users
GROUP BY WEEKOFYEAR(registration_date)
ORDER BY week;
