-- Working with the SQL portion of the advanced dataframe exercises

SHOW databases;

USE employees;

SELECT title, count(title) AS "emp_count"
FROM titles
WHERE to_date > CURDATE()
GROUP BY title;

SELECT title, hire_date AS "latest_hire"
FROM employees as e
JOIN titles as t on e.emp_no = t.emp_no
GROUP BY title, hire_date;


SELECT d.dept_name, title, count(title)
FROM dept_emp as de
JOIN titles as t on de.emp_no = t.emp_no
JOIN departments as d on de.dept_no = d.dept_no
WHERE t.to_date > CURDATE()
GROUP BY d.dept_name, title;

USE chipotle;


SELECT *
FROM orders;