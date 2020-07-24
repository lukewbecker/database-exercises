-- join_exercises

USE join_example_db;


-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM roles AS roles
JOIN users AS users ON roles.id = users.id;


-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(users.role_id) AS role_count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;


-- Use the employees database.

USE employees;

-- Use the employees database.

USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT d.dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > CURDATE()
ORDER BY d.dept_name;

-- 3. Find the name of all departments currently managed by women.

SELECT *
FROM employees
WHERE gender = 'F';

SELECT d.dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > CURDATE() AND e.gender = 'F'
ORDER BY d.dept_name;

-- I guess I don't understand why gender still worked - probably because after the join all the tables are now practically one table
SELECT d.dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM dept_manager AS dm
JOIN employees AS e ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > CURDATE() AND gender = 'F'
ORDER BY d.dept_name;

-- 4 Find the current titles of employees currently working in the Customer Service department.

SELECT title as 'Title', COUNT(title) AS 'Count'
FROM dept_emp AS de
JOIN titles AS t ON t.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE() AND t.to_date > CURDATE() AND d.dept_no = 'd009'
GROUP BY title;

-- 5. Find the current salary of all current managers
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS 'Name', salary
FROM dept_manager AS dm
JOIN salaries AS sal ON sal.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN employees AS em ON dm.emp_no = em.emp_no
WHERE dm.to_date > CURDATE() AND sal.to_date > CURDATE()
ORDER BY dept_name;


-- 6. Find the number of employees in each department.

SELECT de.dept_no, d.dept_name, COUNT(e.emp_no)
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_no;

-- 7. Which department has the highest average salary?

SELECT d.dept_name, AVG(salary) AS avg_sal
FROM salaries AS sal
JOIN dept_emp AS dm ON dm.emp_no = sal.emp_no
JOIN departments AS d on d.dept_no = dm.dept_no
WHERE sal.to_date > CURDATE() AND dm.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY avg_sal DESC
LIMIT 1;


-- 8 Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
FROM employees AS e
JOIN salaries AS sal on sal.emp_no = e.emp_no
JOIN dept_emp AS dm on dm.emp_no = e.emp_no
WHERE sal.to_date > CURDATE() AND dm.to_date > CURDATE() AND dm.dept_no = 'd001'
GROUP BY sal.salary DESC, sal.emp_no
LIMIT 1;

-- 9 Which current department manager has the highest salary?
-- dept_manager, employees, salaries, departments

SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE() AND salaries.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

-- 10. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', CONCAT(ee.first_name, ' ', ee.last_name) AS 'Manager Name'
FROM dept_emp AS de
JOIN employees AS e ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN dept_manager AS dm ON dm.dept_no = de.dept_no
JOIN employees AS ee ON dm.emp_no = ee.emp_no
WHERE de.to_date > CURDATE() AND dm.to_date > CURDATE()
ORDER BY de.dept_no;


-- 11. Bonus Find the highest paid employee in each department.
-- Working on this one still

