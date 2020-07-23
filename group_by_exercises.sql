-- GROUP BY exercises

-- Create a new file named group_by_exercises.sql

USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table.
SELECT DISTINCT title FROM titles;

-- Find your query for employees whose last names start and end with 'E'.
SELECT last_name
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT DISTINCT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e';

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT CONCAT(first_name, ' ', last_name) AS unique_names
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, COUNT(last_name) AS name_count
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY name_count DESC;

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
SELECT COUNT(*) AS number_by_gender, gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),
					SUBSTR(last_name, 1, 4),'_',
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2))) AS username, first_name, last_name, birth_date
FROM employees;

-- Running with GROUP BY - there are fewer results than before, meaning there are duplicate usernames
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),
							SUBSTR(last_name, 1, 4),'_',
							SUBSTR(birth_date, 6, 2),
							SUBSTR(birth_date, 3, 2))) AS username
FROM employees
GROUP BY username;

-- Bonus: how many duplicate usernames are there?
SELECT sum(temp.username_count) AS total_users_with_duplicated_usernames,
		COUNT(temp.username_count) AS duplicated_distinct_usernames,
		SUM(temp.username_count) - COUNT(temp.username_count) AS number_of_users_needing_new_usernames
FROM (SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),
						LOWER(SUBSTR(last_name,1,4)), '_',
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)) AS username,
						COUNT(*) AS username_count			
			FROM employees
			GROUP BY username
			ORDER BY username_count DESC
) AS temp
WHERE username_count > 1;