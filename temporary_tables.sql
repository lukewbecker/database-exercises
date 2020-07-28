USE darden_1040;

-- Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments
(
	SELECT *
	FROM employees.employees_with_departments AS ewd
);

SELECT *
FROM employees.employees_with_departments;


-- determining the max length needed for the VARCHAR of the new column:
SELECT MAX(LENGTH(CONCAT(employees.first_name, ' ', last_name))) + 1 AS max_length
FROM employees.employees;
-- added 1 character for safety

-- personal testing that I know how to add a column before doing exercise:
ALTER TABLE darden_1040.employees_with_departments ADD email VARCHAR(35);


-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE darden_1040.employees_with_departments ADD full_name VARCHAR(35);

-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE darden_1040.employees_with_departments DROP COLUMN first_name;

-- And the last_name column:
ALTER TABLE darden_1040.employees_with_departments DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE employees_with_departments_2
(
	SELECT CONCAT(employees.employees_with_departments.first_name, ' ', employees.employees_with_departments.last_name) AS full_name, employees.employees_with_departments.dept_no, employees.employees_with_departments.dept_name
	FROM employees.employees_with_departments
);

SELECT *
FROM darden_1040.employees_with_departments_2;

-- 2. Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payment AS
SELECT *
FROM sakila.payment;

SELECT *
FROM payment;

ALTER TABLE darden_1040.payment ADD int_pmt INT(10);

UPDATE payment
SET int_pmt = (payment.amount * 100);

SELECT *
FROM payment;

-- Find out how the average pay in each department compares to the overall average pay.
-- In order to make the comparison easier, you should use the Z-score for salaries.
-- In terms of salary, what is the best department to work for? The worst?

CREATE TEMPORARY TABLE emps AS
SELECT 
e.*,
s.salary,
d.dept_name AS department,
d.dept_no
FROM employees.employees AS e
JOIN employees.salaries AS s USING(emp_no)
JOIN employees.dept_emp AS de USING(emp_no)
JOIN employees.departments AS d USING(dept_no);

SELECT *
FROM emps
LIMIT 50;

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;

CREATE TEMPORARY TABLE salary_agg AS
SELECT AVG(salary) AS mean, STDDEV(salary) AS sd
FROM emps;

SELECT *
FROM salary_agg;

-- Update to fill emply columns
UPDATE emps
SET mean_salary = (SELECT mean from salary_agg);

-- Update st.dev
UPDATE emps SET sd_salary = (SELECT sd from salary_agg);

-- Update zscore
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

-- Now I can do the math to compare z-scores, and group by department
SELECT department, avg(z_salary) AS z_salary
FROM emps
GROUP BY department
ORDER BY z_salary;