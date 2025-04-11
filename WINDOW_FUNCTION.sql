CREATE TABLE employees (
    emp_id     NUMBER PRIMARY KEY,
    emp_name   VARCHAR2(100),
    department VARCHAR2(50),
    salary     NUMBER,
    hire_date  DATE
);
--INSERT THE DATA--
INSERT INTO employees VALUES (1, 'Moses', 'HR', 60000, TO_DATE('2019-05-21', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (2, 'Kelly', 'IT', 75000, TO_DATE('2020-03-15', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (3, 'Bosco', 'IT', 70000, TO_DATE('2021-07-01', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (4, 'Kamanzi', 'HR', 65000, TO_DATE('2022-01-10', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (5, 'Kalisa', 'Finance', 80000, TO_DATE('2018-11-12', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (6, 'Kamikazi', 'IT', 72000, TO_DATE('2023-02-20', 'YYYY-MM-DD'));

SELECT table_name FROM user_tables;
SELECT emp_id, emp_name, department, salary, hire_date,

       -- Previous salary in the same department (by hire date)
       LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) AS prev_salary,

       -- Next salary in the same department (by hire date)
       LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) AS next_salary,
       SELECT emp_id, emp_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_salary_rank
FROM employees;

       -- Comparison with previous employee
       CASE 
         WHEN salary > LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'HIGHER'
         WHEN salary < LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'LOWER'
         WHEN salary = LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'EQUAL'
         ELSE 'N/A'
       END AS comparison_with_previous,

       -- Comparison with next employee
       CASE 
         WHEN salary > LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'HIGHER'
         WHEN salary < LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'LOWER'
         WHEN salary = LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) THEN 'EQUAL'
         ELSE 'N/A'
       END AS comparison_with_next

FROM employees;

SELECT emp_id, emp_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_salary_rank
FROM employees;

SELECT * FROM (
  SELECT emp_id, emp_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) ranked
WHERE rnk <= 3;

SELECT * FROM (
  SELECT emp_id, emp_name, department, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS row_num
  FROM employees
) e
WHERE row_num <= 2;

SELECT emp_id, emp_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) AS dept_max_salary,
       MAX(salary) OVER () AS overall_max_salary
FROM employees;