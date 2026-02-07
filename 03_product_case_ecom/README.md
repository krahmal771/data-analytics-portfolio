# Продуктовый кейс: воронка + retention (e-commerce)

## Данные
Файл: events_ecom.csv

Колонки:
- user_id — идентификатор пользователя
- event_time — время события
- event_name — тип события: visit, signup, add_to_cart, purchase
- amount — сумма заказа (только для purchase, иначе пусто)
- source — источник трафика: organic, ads, referral, email

Период: 2025-10-01 … 2025-10-31

## Что считаем
1) Воронку по пользователям: visit → signup → add_to_cart → purchase  
2) Проверки корректности (нет ли покупок без предыдущих шагов, не хватает ли amount у purchase)  
3) Retention по покупкам:
   - cohort = дата первой покупки пользователя
   - retention = доля пользователей когорты, которые сделали покупку снова через N дней

