-- Максимальная зарплата в каждом отделе
WITH ranked_salary AS (
  SELECT
    e.first_name,
    e.last_name,
    e.salary,
    d.department,
    RANK() OVER (PARTITION BY d.department ORDER BY e.salary DESC) AS rnk
  FROM employees e
  JOIN departments d ON d.dept_id = e.dept_id
)
SELECT
  department, first_name, last_name, salary
FROM ranked_salary
WHERE rnk = 1
ORDER BY salary DESC;
