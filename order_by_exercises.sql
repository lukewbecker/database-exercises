-- ORDER BY clause exercises

USE employees;


-- Exercise 2
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- Exercies 3
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- Exercies 4
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Last name starts with "E"
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no;

-- Exercise 5 part 1: ASC order
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
OR last_name LIKE '%e'
ORDER BY emp_no;

-- Exercise 5 part 2: ASC order
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no;

-- Exercise 5 part 3: ASC order
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY emp_no;

-- Exercise 6 part 1: DESC order
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
OR last_name LIKE '%e'
ORDER BY emp_no DESC;

-- Exercise 6 part 2: DESC order
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
OR last_name LIKE '%e'
ORDER BY emp_no DESC;

-- Exercise 6 part 3: DESC order
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY emp_no DESC;

-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;