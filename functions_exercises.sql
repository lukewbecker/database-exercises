-- FUNCTIONS exercises

USE employees;

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE first_name LIKE 'e%e';

-- Convert the names produced in your last query to all uppercase.
SELECT CONCAT(UPPER(first_name), " ", UPPER(last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY emp_no DESC;

-- Convert the names produced in your last query to all uppercase.
SELECT CONCAT(UPPER(first_name), " ", UPPER(last_name)) AS full_name
FROM employees
WHERE first_name LIKE 'e%'
AND first_name LIKE '%e'
ORDER BY emp_no DESC;

-- Didn't think it was necessary to include all the different ORDER BY sorting variations (ASC, DESC) in this. I can update if needed.


-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT *, DATEDIFF(CURDATE(), hire_date) AS days_since_hired
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';

-- Find the smallest and largest salary from the salaries table.
SELECT MIN(salary) FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees.
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),SUBSTR(last_name, 1, 4),'_',SUBSTR(birth_date, 6, 2),SUBSTR(birth_date, 3, 2))) AS username, first_name, last_name, birth_date
FROM employees;
-- Set these columns up specifically to match the lesson example, which have these four columns, in this order.
-- Personally my 'style', (if I can have one this early in my learning) is to show all columns :)

----------------

-- SHOWING MY WORK: Broke down the parts of Exercise 6 seperately, then put them together once I figured out how each component worked.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- Testing out the LOWER function to make sure I know how it works.
SELECT LOWER(SUBSTR(first_name, 1, 1))
FROM employees;

-- Testing out SUBSTR
SELECT SUBSTR(last_name, 2, 1)
FROM employees;

-- Figuring out wether SUBSTR position argument is inclusive or not - documentation is clear it is, but wanted to test it for myself.
-- Addtionally, this test proved that for this particular exercise I would not need to CAST the DATE data type into a string for SUBSTR to work.
-- Thus, hopefully saving some computing power...
SELECT SUBSTR(birth_date, 3, 4)
FROM employees;	   

-- Creating new column name
SELECT *, LOWER(CONCAT(first_name)) AS lower_first_name
FROM employees;

-- QA test to make sure I understood the SUBSTR function properly.
SELECT birth_date, SUBSTR(birth_date, 3, 10)
FROM employees;
