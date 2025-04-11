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