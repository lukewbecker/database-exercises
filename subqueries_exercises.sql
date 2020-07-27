USE employees;

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager	
)
LIMIT 10;

-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query. 69 rows

SELECT *
FROM employees
WHERE hire_date = (
		SELECT hire_date
		FROM employees
		WHERE emp_no = '101010'

);

-- Find all the titles held by all employees with the first name Aamod.
-- Remember, all employees - not just current employees

SELECT title, first_name, employees.emp_no
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
WHERE first_name = 'Aamod';

SELECT COUNT(DISTINCT title)
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
WHERE first_name = 'Aamod';

SELECT COUNT(titles.emp_no) AS total_titles
FROM titles
JOIN employees ON employees.emp_no = titles.emp_no
WHERE employees.first_name = 'Aamod';

-- Starting to combine

SELECT COUNT(titles.emp_no) AS total_titles, COUNT(
		SELECT DISTINCT titles.emp_no
		FROM titles
		JOIN employees ON employees.emp_no = titles.emp_no
		WHERE employees.first_name = 'Aamod'
)
FROM titles
JOIN employees ON employees.emp_no = titles.emp_no
WHERE employees.first_name = 'Aamod';

-- Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles
-- Step 1: find * = 'Aamod'
-- 

SELECT *
FROM employees
WHERE first_name = 'Aamod';

SELECT *
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
);

SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
);


-- 3. How many people in the employees table are no longer working for the company?

SELECT *
FROM dept_emp
WHERE to_date > CURDATE();

SELECT emp_no
FROM employees
WHERE emp_no != '101010';

SELECT emp_no
FROM employees
WHERE emp_no != '101010' AND emp_no != '202020';

SELECT emp_no
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > CURDATE());

-- 4. Find all the current department managers that are female.

SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
	)
AND gender = 'F';

-- 5. Find all the employees that currently have a higher than average salary. 154543 rows in total.
-- exercise 5 solved:
SELECT employees.first_name, employees.last_name, salaries.salary
FROM salaries
JOIN employees ON employees.emp_no = salaries.emp_no
WHERE salary > (
				SELECT AVG(salary) 
				FROM salaries
				)
AND to_date > CURDATE();

-- 6. How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT COUNT(emp_no) AS number_of_salaries
FROM salaries
WHERE salary >= (
				SELECT (MAX(salary) - STDDEV(salary))
				FROM salaries
				)
AND to_date > CURDATE();

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT COUNT(emp_no) AS count_above_avg
FROM salaries
WHERE salary >= (
				SELECT (MAX(salary) - STDDEV(salary))
				FROM salaries
				)
AND to_date > CURDATE();

-- Finding salary percentage of all salaries:
SELECT CONCAT ((SELECT COUNT(salary) AS count_above_avg
    FROM salaries
    WHERE salary >= (
    	(SELECT MAX(salary) FROM salaries) - 
    	(SELECT STDDEV(salary) FROM salaries)
    	)
    AND to_date> curdate()) 
    / (SELECT COUNT(salary) FROM salaries WHERE to_date > CURDATE()) * 100, '%') AS salary_percentage;


-- BONUS questions

-- Bonus question 1

-- Finding the 4 managers that identify as female:
SELECT *
FROM dept_manager AS dm
JOIN employees AS e ON e.emp_no = dm.emp_no
WHERE e.emp_no IN (
	SELECT dm.emp_no
	FROM dept_manager
	WHERE dm.to_date > CURDATE()
)
AND e.gender = 'F';

-- Then SELECT for only dept_no, which is the index used in both dept_manager table and the departments table:
SELECT dm.dept_no
FROM dept_manager AS dm
JOIN employees AS e ON e.emp_no = dm.emp_no
WHERE e.emp_no IN (
	SELECT dm.emp_no
	FROM dept_manager
	WHERE dm.to_date > CURDATE()
)
AND e.gender = 'F';

-- Combined final solution for bonus question 1:
SELECT d.dept_name
FROM dept_manager AS dm
JOIN employees AS e ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE e.emp_no IN (
	SELECT dm.emp_no
	FROM dept_manager
	WHERE dm.to_date > CURDATE()
)
AND e.gender = 'F';


-- Bonus question 2. INCOMPLETE

SELECT *
FROM salaries
WHERE to_date > CURDATE();


SELECT *
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE (
	SELECT MAX(salary)
	FROM salaries

);

SELECT MAX(salary)
FROM salaries
WHERE to_date > CURDATE();