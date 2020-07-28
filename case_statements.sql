-- case statement lesson exercises


-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT employees.emp_no, dept_emp.dept_no, employees.hire_date, dept_emp.to_date, 
	CASE WHEN dept_emp.to_date > CURDATE() THEN 1
	ELSE 0
	END AS is_current_employee										
FROM dept_emp
JOIN employees USING(emp_no); 

-- 2. Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

-- Long form solution:
SELECT first_name, last_name,
	CASE
	WHEN SUBSTR(last_name, 1, 1) IN ('A','B','C','D','E','G','H') THEN 'A-H'
	WHEN SUBSTR(last_name, 1, 1) IN ('I','J','K','L','M','N','O','P','Q') THEN 'I-Q'
	WHEN SUBSTR(last_name, 1, 1) IN ('R','S','T','U','V','W','X','Y','Z') THEN 'R-Z'	
	ELSE 0
	END AS alpha_group
FROM employees
GROUP BY last_name, first_name;

-- Using REGEXP:
SELECT first_name, last_name,
	CASE
	WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
	WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
	WHEN last_name REGEXP '^[R-Z]' THEN 'R-Z'	
	ELSE 0
	END AS alpha_group
FROM employees
GROUP BY last_name, first_name;

-- 3. How many employees were born in each decade?

SELECT COUNT(birth_date),
		CASE WHEN birth_date LIKE '195%' THEN '1950s'
		WHEN birth_date LIKE '196%' THEN '1960s'
		ELSE 'other'
		END AS birth_decade 
FROM employees
GROUP BY birth_decade;
