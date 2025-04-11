# TAG-TEAM 

# SQL Window Functions Project

## Dataset Overview

For this project, we are using a fictional **Employee Salary Dataset**. The dataset includes the following columns:

- `employee_id` (INT)  
- `employee_name` (VARCHAR)  
- `department` (VARCHAR)  
- `salary` (INT)  
- `hire_date` (DATE)  

This dataset simulates employee salary data across different departments and hiring timelines.

---

##  Objectives

This project demonstrates the use of SQL **window functions** to perform various analytical queries:

1. Compare values with previous/next records.  
2. Rank data within a category.  
3. Identify top records per group.  
4. Retrieve earliest records per group.  
5. Perform aggregations with window functions.  

Each section includes queries and explanations.

---

## 1. Compare Values with Previous or Next Records

**Goal:** Compare an employee's salary with the previous and next employee in terms of salary order within each department.

### Query
![image alt](



###  Explanation

- `LAG()` and `LEAD()` allow us to access previous and next row values.
- We compare `salary` with the previous value to determine if it's higher, lower, or equal.

---

## 2. Ranking Data within a Category

**Goal:** Rank employees by salary within their departments using `RANK()` and `DENSE_RANK()`.

### Query
![image alt](



### Explanation

- `RANK()` may skip numbers if there are ties (e.g., 1, 2, 2, 4).  
- `DENSE_RANK()` does not skip numbers after ties (e.g., 1, 2, 2, 3).  
- This helps demonstrate how ties are handled in different ranking methods.

---

## 3. Identifying Top Records

**Goal:** Get the **Top 3 highest salaries** in each department.

### Query
![image alt](



###  Explanation

- The `DENSE_RANK()` function ensures that tied salaries are handled correctly.
- We filter for `rank <= 3` to get the top 3 employees per department.

---

## 4.  Finding the Earliest Records

**Goal:** Get the first **2 employees hired** in each department based on `hire_date`.

###  Query
![image alt](



###  Explanation

- `ROW_NUMBER()` is used here to give a unique position to each employee based on hiring date.
- Filtering by `row_num <= 2` retrieves the earliest two hires per department.

---

## 5.Aggregation with Window Functions

**Goal:** Display each employee along with:
- Maximum salary in their department.
- Overall maximum salary across all departments.

###  Query
![image alt](



###  Explanation

- `PARTITION BY department` gives department-level max.
- `OVER ()` without partition gives overall max across all records.

---

##  Conclusion

This project showcases the power of SQL window functions to analyze and compare records across partitions and rows. It includes practical examples for:

- Value comparison (LAG/LEAD)  
- Ranking (RANK/DENSE_RANK)  
- Top-N filtering  
- Date-based selection  
- Aggregation with partitioning  

### THANK U 

