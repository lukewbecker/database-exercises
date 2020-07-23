-- USE your employees database.

USE employees;

-- DESCRIBE each table and inspect the keys and see which columns have indexes and keys.


-- Primary key = emp_no
DESCRIBE employees;

-- Primary key = dept_no
DESCRIBE departments;

-- Primary key(s) = emp_no, dept_no
DESCRIBE dept_emp;

-- Primary key(s) = emp_no, dept_no
DESCRIBE dept_manager;

-- Primary key(s) = emp_no, title, from_date
DESCRIBE titles;

-- Primary key(s) = emp_no, title, from_date
DESCRIBE salaries;