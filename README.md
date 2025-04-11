# TAG-TEAM 

# 📊 SQL Window Functions Project

## 📁 Dataset Overview

For this project, we are using a fictional **Employee Salary Dataset**. The dataset includes the following columns:

- `employee_id` (INT)  
- `employee_name` (VARCHAR)  
- `department` (VARCHAR)  
- `salary` (INT)  
- `hire_date` (DATE)  

This dataset simulates employee salary data across different departments and hiring timelines.

---

## 🔍 Objectives

This project demonstrates the use of SQL **window functions** to perform various analytical queries:

1. Compare values with previous/next records.  
2. Rank data within a category.  
3. Identify top records per group.  
4. Retrieve earliest records per group.  
5. Perform aggregations with window functions.  

Each section includes queries and explanations.

---

## 1. 📈 Compare Values with Previous or Next Records

**Goal:** Compare an employee's salary with the previous and next employee in terms of salary order within each department.

### ✅ Query

```sql
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary) AS next_salary,
    CASE
        WHEN salary > LAG(salary) OVER (PARTITION BY department ORDER BY salary) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (PARTITION BY department ORDER BY salary) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS salary_vs_previous
FROM employees;
```

### 🧠 Explanation

- `LAG()` and `LEAD()` allow us to access previous and next row values.
- We compare `salary` with the previous value to determine if it's higher, lower, or equal.

---

## 2. 🏅 Ranking Data within a Category

**Goal:** Rank employees by salary within their departments using `RANK()` and `DENSE_RANK()`.

### ✅ Query

```sql
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank
FROM employees;
```

### 🧠 Explanation

- `RANK()` may skip numbers if there are ties (e.g., 1, 2, 2, 4).  
- `DENSE_RANK()` does not skip numbers after ties (e.g., 1, 2, 2, 3).  
- This helps demonstrate how ties are handled in different ranking methods.

---

## 3. 🥇 Identifying Top Records

**Goal:** Get the **Top 3 highest salaries** in each department.

### ✅ Query

```sql
WITH Ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
    FROM employees
)
SELECT *
FROM Ranked
WHERE rank <= 3;
```

### 🧠 Explanation

- The `DENSE_RANK()` function ensures that tied salaries are handled correctly.
- We filter for `rank <= 3` to get the top 3 employees per department.

---

## 4. 🕰️ Finding the Earliest Records

**Goal:** Get the first **2 employees hired** in each department based on `hire_date`.

### ✅ Query

```sql
WITH Hired AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS row_num
    FROM employees
)
SELECT *
FROM Hired
WHERE row_num <= 2;
```

### 🧠 Explanation

- `ROW_NUMBER()` is used here to give a unique position to each employee based on hiring date.
- Filtering by `row_num <= 2` retrieves the earliest two hires per department.

---

## 5. 📊 Aggregation with Window Functions

**Goal:** Display each employee along with:
- Maximum salary in their department.
- Overall maximum salary across all departments.

### ✅ Query

```sql
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS max_in_department,
    MAX(salary) OVER () AS overall_max
FROM employees;
```

### 🧠 Explanation

- `PARTITION BY department` gives department-level max.
- `OVER ()` without partition gives overall max across all records.

---

## ✅ Conclusion

This project showcases the power of SQL window functions to analyze and compare records across partitions and rows. It includes practical examples for:

- Value comparison (LAG/LEAD)  
- Ranking (RANK/DENSE_RANK)  
- Top-N filtering  
- Date-based selection  
- Aggregation with partitioning  

Feel free to explore further with more datasets and questions!

