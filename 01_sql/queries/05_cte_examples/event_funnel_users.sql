-- Воронка по событиям (по пользователям): visit → view_product → add_to_cart → checkout → purchase
WITH step_users AS (
  SELECT
    user_id,
    MAX(event_name = 'visit') AS s_visit,
    MAX(event_name = 'view_product') AS s_view,
    MAX(event_name = 'add_to_cart') AS s_cart,
    MAX(event_name = 'checkout') AS s_checkout,
    MAX(event_name = 'purchase') AS s_purchase
  FROM web_events
  GROUP BY user_id
),
counts AS (
  SELECT
    SUM(s_visit) AS visit_users,
    SUM(s_view) AS view_users,
    SUM(s_cart) AS cart_users,
    SUM(s_checkout) AS checkout_users,
    SUM(s_purchase) AS purchase_users
  FROM step_users
)
SELECT 'visit' AS step, visit_users AS users FROM counts
UNION ALL SELECT 'view_product', view_users FROM counts
UNION ALL SELECT 'add_to_cart', cart_users FROM counts
UNION ALL SELECT 'checkout', checkout_users FROM counts
UNION ALL SELECT 'purchase', purchase_users FROM counts;
