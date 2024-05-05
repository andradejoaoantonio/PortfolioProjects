use employees;

SELECT * FROM employees;

SELECT
	gender,
    COUNT(gender),
    COUNT(gender)/COUNT(*)
FROM employees
GROUP BY gender;

SELECT dept_no FROM departments;
SELECT * FROM departments;

-- Select all people from the employees tables named "Elvis"

SELECT * FROM employees
WHERE first_name = 'Elvis';

-- Retrieve a list with all female employees whose first name is Kellie. 

SELECT * FROM employees
WHERE gender = 'F'
AND first_name = 'Kellie';

-- Retrieve a list with all employees whose first name is either Kellie or Aruna.

SELECT * FROM employees
WHERE first_name = 'Kellie'
OR first_name = 'Aruna';

SELECT * FROM employees
WHERE first_name IN ('Kellie', 'Aruna');

-- Retrieve a list with all female employees whose first name is either Kellie or Aruna.

SELECT * FROM employees
WHERE gender = 'F'
AND (first_name = 'Kellie' OR first_name = 'Aruna');


-- Use the IN operator to select all individuals from the “employees” table,
-- whose first name is either “Denis”, or “Elvis”.

SELECT * FROM employees
WHERE first_name IN ('Denis','Elvis');


-- Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.

SELECT * FROM employees
WHERE first_name NOT IN ('John', 'Mark','Jacob');



-- Working with the “employees” table, use the LIKE operator to select the data about all individuals,
-- whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters.
SELECT * FROM employees
WHERE first_name LIKE 'Mark%';

-- Retrieve a list with all employees who have been hired in the year 2000.
-- Version A
SELECT * FROM employees
WHERE YEAR(hire_date) = 2000;

-- Version B
SELECT * FROM employees
WHERE hire_date LIKE ('%2000%');

-- Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
-- Version A
SELECT * FROM employees
WHERE LENGTH(emp_no) = 5
AND emp_no LIKE '1000%';

-- Version B
SELECT * FROM employees
WHERE emp_no LIKE ('1000_');


-- Wildcard characters
/*
Extract all individuals from the ‘employees’ table whose first name contains “Jack”.
Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
*/

SELECT * FROM employees
WHERE first_name LIKE ('%Jack%');

SELECT * FROM employees
WHERE first_name NOT LIKE ('%Jack%');

-- Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.
SELECT * FROM salaries
WHERE salary BETWEEN 66000 AND 70000
ORDER BY salary DESC;

-- Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
SELECT * FROM employees
WHERE emp_no NOT BETWEEN 10004 AND 10012;

-- Select the names of all departments with numbers between ‘d003’ and ‘d006’.
SELECT * FROM departments
WHERE dept_no between 'd003' AND 'd006';

-- Select the names of all departments whose department number value is not null.
SELECT * FROM departments
WHERE dept_no IS NOT NULL;

/*
Retrieve a list with data about all female employees who were hired in the year 2000 or after.
Hint: If you solve the task correctly, SQL should return 7 rows.
Extract a list with all employees’ salaries higher than $150,000 per annum.
*/
-- Version A
SELECT * FROM employees
WHERE gender = 'F'
AND YEAR(hire_date) >= '2000';

-- Version B
SELECT * FROM employees
WHERE hire_date >= '2000-01-01'
AND gender = 'F';

SELECT * FROM salaries
WHERE salary > 150000;

/*
Obtain a list with all different “hire dates” from the “employees” table.
Expand this list and click on “Limit to 1000 rows”.
This way you will set the limit of output rows displayed back to the default of 1000.
*/

SELECT DISTINCT(hire_date)
FROM employees;

SELECT COUNT(DISTINCT(hire_date))
FROM employees;

/*
How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
*/
SELECT COUNT(salary) as salary_above_100000
FROM salaries
WHERE salary >= 100000;

SELECT COUNT(*)
FROM dept_manager;

-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
SELECT * FROM employees
ORDER BY hire_date DESC;


SELECT
	first_name,
    COUNT(first_name) as names_count
FROM employees
GROUP BY first_name
ORDER BY first_name;

/*
Write a query that obtains two columns.
The first column must contain annual salaries higher than 80,000 dollars.
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary.
Lastly, sort the output by the first column.
*/
SELECT
	salary,
    COUNT(emp_no) as emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

-- Select all employees whose average salary is higher than $120,000 per annum.
SELECT
	emp_no,
    ROUND(AVG(salary),1)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;


-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
-- Hint: To solve this exercise, use the “dept_emp” table.
SELECT emp_no
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;


-- Select the first 100 rows from the ‘dept_emp’ table. 
SELECT * FROM dept_emp
LIMIT 100;

-- The INSERT statement
INSERT INTO employees (
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
)
VALUES (
    999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
);

SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO employees (
	birth_date,
    emp_no,
    first_name,
    last_name,
    gender,
    hire_date
)
VALUES (
    '1973-3-26',
    999902,
    'Patricia',
    'Lawrence',
    'F',
    '2005-01-01'
);

SELECT * FROM employees;

INSERT INTO employees VALUES (
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

DELETE FROM employees
WHERE emp_no = 999902;

-- Select 10 records from the “titles” table to get a better idea about its content.
-- In the same table, insert information about employee number 999903, stating that he/she is a “Senior Engineer”,
-- who has started working in this position on October 1st, 1997.
-- At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
-- Hint: To solve this exercise, you’ll need to insert data in only 3 columns!

SELECT * FROM titles
ORDER BY emp_no DESC;

INSERT INTO titles VALUES (
	999903,
    'Senior Engineer',
    '1997-10-01',
    curdate()
);

DELETE FROM titles
WHERE emp_no = 999903;

INSERT INTO titles (emp_no, title, from_date)
VALUES (999903, 'Senior Engineer', '1997-10-01');

/*
Insert information about the individual with employee number 999903 into the “dept_emp” table.
He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.
Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period.
*/

SELECT * FROM dept_emp
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO dept_emp (
	emp_no,
    dept_no,
    from_date.
    to_date
)
VALUES (
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

-- Inserting data INTO a new table

SELECT * FROM departments
LIMIT 10;

CREATE TABLE departments_dup (
	dept_no CHAR(40) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

INSERT INTO departments_dup (
	dept_no,
    dept_name
)
SELECT * FROM departments;

SELECT * FROM departments_dup
LIMIT 10;

-- Create a new department called “Business Analysis”.
-- Register it under number ‘d010’.

SELECT * FROM departments
ORDER BY dept_no DESC;

INSERT INTO departments (
	dept_no,
    dept_name
)
VALUE (
	'd010',
    'Business Analysis'
);

-- TCL's COMMIT and ROLLBACK

/*
The COMMIT statement saves the transaction in the database
and changes cannot be undone
*/

/*
The ROLLBACK clause allows you to take a step back,
the last change(s) made will not count,
and reverts to the last non-commited state
*/

-- In sum, This means if you have already used commit ten times.
-- ROLLBACK will have an effect on the last execution you have performed.
-- After that moment, even if you run the rollback clause 20 times, you can get to the state of only the last commit.
-- You cannot restore data to a state corresponding to an earlier commit.

-- UPDATE statement used to update the values of existing records in a table

UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
	emp_no = 999901;
    
SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

-- UPDATE statement #2

SELECT * FROM departments_dup
ORDER BY dept_no;

COMMIT;

/*
What happens if we, by mistake, happen to duplicate
another table with incorrect/ducplicate data?
*/

UPDATE departments_dup
SET
	dept_no = 'd001',
    dept_name = 'Quality Control';
    
ROLLBACK;

-- If you have the "AUTOCOMMIY MODE" active,
-- MySQL will COMMIT every single time you run a query,
-- but you can only ROLLBACK to the last COMMIT

SELECT * FROM departments
ORDER BY dept_no;

UPDATE departments
SET
	dept_name = 'Data Analysis'
WHERE dept_no = 'd010';
	
-- DELETE statement
SELECT * FROM employees
WHERE emp_no = 999903;

COMMIT;

DELETE FROM employees
WHERE emp_no = 999903;

ROLLBACK;

/*
ON DELETE CASCADE clause means that if a specific value from the parent table's primary
key has been deleted, all the records form the child table referring to this value
will be removed as well
For example, if an employee ID exists in other tables in the database,
when deleting it, all records related to that employee ID will be deleted as well
*/

/*
In case we don't specify the WHERE clause in a DELETE statement,
we will delete all the data inside that specific table,
so be carefull!
*/

SELECT * FROM departments_dup
ORDER BY dept_no;

COMMIT;

DELETE FROM departments_dup;

ROLLBACK;

-- Remove the department number 10 record from the “departments” table.
SELECT * FROM departments;

DELETE FROM departments
WHERE dept_no = 'd010';


-- DROP vs TRUNCATE vs DELETE

/*
DROP statement deleted the table from the database,
while TRUNCATE is the same as DELETE but without the WHERE, it deletes all data from te table,
faster than DELETE. Using TRUNCATE, if you have assigned an AUTO_INCREMENT to a column,
it will reset the incremment to 1, while if we use the DELETE statement to delete,
the AUTO_INCREMMENT will pick up from the last increment it created. 
*/

-- How many departments are there in the “employees” database?
-- Use the ‘dept_emp’ table to answer the question.

SELECT
	COUNT(DISTINCT(dept_no)) AS total_number_departments
FROM dept_emp;


-- What is the total amount of money spent on salaries,
-- for all contracts starting after the 1st of January 1997?

SELECT
	SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';


-- Which is the lowest employee number in the database?
-- Which is the highest employee number in the database?

SELECT MIN(emp_no)
FROM employees;

SELECT MAX(emp_no)
FROM employees;


-- What is the average annual salary paid to employees who started after the 1st of January 1997?

SELECT AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';


-- Round the average amount of money spent on salaries for all contracts
-- that started after the 1st of January 1997 to a precision of cents.

SELECT ROUND(AVG(salary),2)
FROM salaries
WHERE from_date > '1997-01-01';


-- IFNULL and COALESCE

ALTER TABLE departments_dup
MODIFY dept_no VARCHAR(40) NULL,
MODIFY dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup (dept_no, dept_name)
VALUES
	('d010',NULL),
    ('d011', NULL);

SELECT * FROM departments_dup;

SELECT
	dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name
FROM departments_dup;

/*
With COALESCE, we can insert n argments in the parentheses
*/

ALTER TABLE departments_dup
ADD dept_manager VARCHAR(40) NULL;

SELECT
	dept_no,
	IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM departments_dup
ORDER BY dept_no;


/*
Select the department number and name from the ‘departments_dup’ table
and add a third column where you name the department number (‘dept_no’) as ‘dept_info’.
If ‘dept_no’ does not have a value, use ‘dept_name’.
*/

SELECT
	dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no;

/*
Modify the code obtained from the previous exercise in the following way:
Apply the IFNULL() function to the values from the first and second column,
so that ‘N/A’ is displayed whenever a department number has no value,
and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
*/

SELECT
	IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no;


-- JOINS

RENAME TABLE departments_dup TO departments_dup_old;

CREATE TABLE departments_dup (
	dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
SELECT * FROM departments;

SELECT * FROM departments_dup
ORDER BY dept_no;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');
	
DELETE FROM departments_dup
WHERE dept_no = 'd011';

INSERT INTO departments_dup(dept_no)
VALUES ('d010'), ('d011');

ROLLBACK;

SELECT * FROM departments_dup;

-- JOINS exercise #2

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (
	emp_no,
    from_date
)
VALUES
	(999904, '2017-01-01'),
    (999905, '2017-01-01'),
    (999906, '2017-01-01'),
    (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

SELECT * FROM dept_manager_dup;

/*
INNER JOIN:
Returns only the rows that have matching values in both tables.
Combines rows based on specified columns with matching values.

LEFT JOIN (LEFT OUTER JOIN):
Returns all rows from the left table and matching rows from the right table.
If there's no match, NULL values are returned for right table columns.

RIGHT JOIN (RIGHT OUTER JOIN):
Returns all rows from the right table and matching rows from the left table.
If there's no match, NULL values are returned for left table columns.

FULL JOIN (FULL OUTER JOIN):
Returns all rows from both tables and includes matching rows from each table.
If there's no match, NULL values are returned for non-matching columns.

CROSS JOIN:
Returns the Cartesian product of rows from both tables.
Combines every row from the first table with every row from the second table.

SELF JOIN:
Joins a table with itself.
Useful for comparing rows within the same table based on specific conditions.
These JOIN types allow you to efficiently combine data from different tables in a variety of ways,
enabling you to retrieve complex information that involves multiple related datasets.
*/

SELECT * FROM dept_manager_dup
ORDER BY dept_no;

SELECT * FROM departments_dup
ORDER BY dept_no;

SELECT * FROM dept_manager_dup AS dm
INNER JOIN departments_dup AS d
ON dm.dept_no = d.dept_no;


## Extract a list containing information about all managers’ employee number,
## first and last name, department number, and hire date.

SELECT * FROM employees;
SELECT * FROM dept_manager;

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM employees AS e
INNER JOIN dept_manager AS dm
ON e.emp_no = dm.emp_no
ORDER BY hire_date;


# Duplicate Records

INSERT INTO dept_manager_dup
VALUES ('110228','d003','1992-03-21','9999-01-01');

INSERT INTO departments_dup
VALUES ('d009','Customer Service');

SELECT * FROM dept_manager_dup
ORDER BY dept_no;

SELECT * FROM departments_dup
ORDER BY dept_no;


## Let's now join these tables to check for the duplicates impact on the output
## Using the GROUP BY statement to group by the field that differs most among records  

SELECT
	m.dept_no,
    m.emp_no,
    d.dept_name
FROM dept_manager_dup AS m
JOIN departments_dup AS d
ON m.dept_no = d.dept_no
ORDER BY dept_no;

SELECT
	emp_no,
    COUNT(m.emp_no) AS emp_no_count
FROM dept_manager_dup AS m
JOIN departments_dup AS d
ON m.dept_no = d.dept_no
GROUP BY emp_no;

## LEFT JOIN
-- Remove the duplicates from the two tables

DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM dept_manager_dup
WHERE dept_no = 'd009';

## Adding back the initial records...
INSERT INTO dept_manager_dup
VALUES ('110228','d003','1992-03-21','9999-01-01');

INSERT INTO departments_dup
VALUES ('d009','Customer Service');

SELECT * FROM departments_dup;
SELECT * FROM dept_manager_dup;

/*
Using the LEFT or RIGHT JOIN, the order of the tables matters
and will return different outputs based on where they are
in the query, before or after the JOIN statements
*/

SELECT
	m.dept_no,
    m.emp_no,
    d.dept_name
FROM dept_manager m
LEFT JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Changing the table order...

SELECT
	d.dept_no,
    m.emp_no,
    d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager m
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*
Now, we will have all matching values from the two tables, plus the department numbers from the department's
table that match no value from the department manager duplicate table.
*/

-- LEFT JOIN = LEFT OUTER JOIN
-- RIGHT JOIN = RIGHT OUTER JOIN

/*
Left joins can deliver a list with all records from the left table
that do not match any rows from the right table.
*/

SELECT
	m.dept_no,
    m.emp_no,
    d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d
ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY m.dept_no;

/*
Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch.
See if the output contains a manager with that name.  

Hint: Create an output containing information corresponding to the following fields:
‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
*/

SELECT * FROM employees;
SELECT * FROM dept_manager;

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    m.dept_no,
    m.from_date
FROM employees e
LEFT JOIN dept_manager m
ON e.emp_no = m.emp_no
WHERE last_name = 'Markovitch'
ORDER BY dept_no DESC;

/*
After running the above, we can see a manager, with last name 'Markovitch',
with emp_no '110022', working in dept_no 'd001', from date '1985-01-01'
*/

## RIGHT JOINS
## Identical to LEFT JOINS, except the operation is inverted

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    m.dept_no,
    m.from_date
FROM dept_manager m
RIGHT JOIN employees e
ON e.emp_no = m.emp_no
WHERE last_name = 'Markovitch'
ORDER BY dept_no DESC;


## JOIN (new join syntax) vs WHERE (old join syntax)
/*
The new way is the one that we have see previously,
while the old way is using the WHERE clause and
adding the tables in the FROM clause.
*/

SELECT
	dm.dept_no,
    dm.emp_no,
    d.dept_name
FROM 
	dept_manager_dup dm,
    departments_dup d
WHERE dm.dept_no = d.dept_no
ORDER BY dm.dept_no;

/*
Extract a list containing information about all managers’
employee number, first and last name, department number, and hire date.
Use the old type of join syntax to obtain the result.
*/

-- Old type join syntax
SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
	dept_manager dm,
    employees e
WHERE dm.emp_no = e.emp_no;

-- New type join syntax
SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM dept_manager dm
JOIN employees e
ON dm.emp_no = e.emp_no;


## JOIN and WHERE used together

/*
Let check all the employees that earn more than 145000.
For this, we need to use 2 tables: the "employees" and the "salaries" tables
and apply a WHERE clause to the "salary" column
*/

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.salary > 145000;


## Preventing Error Code 1055

/*
In MySQL, error 1055 is commonly known as the "ER_WRONG_COLUMN_NAME" error.
This error occurs when you try to refer to a column that doesn't exist in the context where you're using it
*/

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/*
Select the first and last name, the hire date, and the job title
of all employees whose first name is “Margareta” and have the last name “Markovitch”.
*/

SELECT * FROM employees;
SELECT * FROM titles;

SELECT
	CONCAT(e.first_name, ' ',e.last_name) AS full_name,
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta'
AND last_name = 'Markovitch'
ORDER BY e.emp_no;


## CROSS JOIN
/*
Also known as a Cartesian join, is a type of join that combines every row from one table
with every row from another table. While INNER, LEFT, and RIGHT JOIN typically connect only the matching values,
CROSS JOIN connects all the values, not just those that match
*/

/*
Say we want to obtain a result set with data containing all the department managers and the departments
they can be assigned to. This means that we will need all the data from the department manager table
to join all the data from the departments table.
*/

SELECT
	dm.*,
    d.*
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

-- JOIN without ON = not considered best practice
-- CROSS JOIN without ON = best practice

 -- We can substitute a CROSS JOIN with an INNER JOIN or with the old join syntax
 
 /*
We want to show more information about our department managers like their names or their hire date.
This information is in the employees table, so, we will have to connect it to our previously defined tables.
 */
 
 SELECT
	e.*,
    d.*
FROM departments d
CROSS JOIN dept_manager dm
JOIN employees e
ON dm.emp_no = e.emp_no
WHERE d.dept_no != dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

/*
Use a CROSS JOIN to return a list with all possible combinations
between managers from the dept_manager table and department number 9.
*/

SELECT * FROM departments;
SELECT * FROM dept_manager;

SELECT
	dm.*,
    d.*  
FROM departments d  
CROSS JOIN dept_manager dm  
WHERE d.dept_no = 'd009'  
ORDER BY d.dept_no;


/*
Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.
*/

SELECT
	e.*,
    d.*
FROM employees e
CROSS JOIN dept_emp d
WHERE e.emp_no < '10011'
ORDER BY e.emp_no;


## Aggregate Functions + JOINS

-- Average salaries pf men and women in the company

SELECT
	e.gender,
	ROUND(AVG(s.salary),2) AS avg_salary
FROM salaries s
JOIN employees e
ON e.emp_no = s.emp_no
GROUP BY e.gender;


## JOIN more than two tables

SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

/*
Select all managers’ first and last name, hire date, job title, start date, and department name.
*/

SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM titles;

-- Solution #1
SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS job_title,
    dm.from_date AS start_date,
    d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
JOIN titles t ON dm.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

-- Solution #2

SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no
JOIN titles t ON e.emp_no = t.emp_no
AND m.from_date = t.from_date
ORDER BY e.emp_no;


/*
Let's obtain the names of all departments and calculate the average salary
paid to the managers in each of them.
*/

SELECT * FROM salaries;
SELECT * FROM dept_manager;
SELECT * FROM departments;

SELECT
	d.dept_name,
    AVG(s.salary) AS average_salary
FROM salaries s
JOIN dept_manager dm ON s.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;
  
/*
How many male and how many female managers do we have in the ‘employees’ database?
*/

SELECT
    e.gender,
    COUNT(dm.emp_no)
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;


## UNION vs UNION ALL

/*
Go forward to the solution and execute the query.
What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)? 
*/

SELECT * FROM (
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	NULL AS dept_no,
	NULL AS from_date
FROM employees e
WHERE last_name = 'Denis'
UNION
SELECT
	NULL AS emp_no,
	NULL AS first_name,
	NULL AS last_name,
	dm.dept_no,
	dm.from_date
FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;

/*
The minus sign before a.emp_no in the ORDER BY clause indicates that the results should be sorted
in descending order based on the negated value of the emp_no column from the subquery aliased as a
*/

## Subqueries with IN nested inside WHERE
/*
Select the first and last name from the "Employees" table for the same
employee numbers that can e found in the "Department Manager" table
*/

SELECT
	e.first_name,
    e.last_name
FROM employees e
WHERE e.emp_no IN (SELECT dm.emp_no
				FROM dept_manager dm);
                

/*
Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
*/

SELECT * FROM employees e
WHERE e.emp_no IN (
	SELECT dm.emp_no
    FROM dept_manager dm)
AND e.hire_date BETWEEN '1990-01-01' AND '1995-01-01';

SELECT * FROM dept_manager dm
WHERE dm.emp_no IN (
	SELECT e.emp_no
	FROM employees e
    WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
    
    
## Subqueries with EXISTS and NOT EXISTS nested inside WHERE
/*
EXISTS and NOT EXISTS are often more efficient than using IN or NOT IN with a subquery
because they don't require retrieving the actual data from the subquery's result set, only checking for its existence.
EXISTS tests row values for existence and IN searches among values.
EXISTS is quicker in retrieving large amounts of data and IN is faster with smaller datasets
*/

SELECT
	e.first_name,
    e.last_name
FROM employees e
WHERE EXISTS (
	SELECT * FROM dept_manager dm
    WHERE dm.emp_no = e.emp_no)
ORDER BY emp_no;


/*
Select the entire information for all employees whose job title is “Assistant Engineer”. 
Hint: To solve this exercise, use the 'employees' table.
*/

SELECT * FROM employees e
WHERE EXISTS (
	SELECT * FROM titles t
    WHERE t.emp_no = e.emp_no
    AND t.title = 'Assistant Engineer')
ORDER BY e.emp_no;


## Subqueries nested in SELECT and FROM

SELECT A.*
FROM
	(SELECT
		e.emp_no AS employee_id,
        MIN(de.dept_no) AS department_code,
        (SELECT emp_no
			FROM dept_manager
            WHERE emp_no = 110022) AS manager_id
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no) AS A
UNION
SELECT B.*
FROM
	(SELECT
		e.emp_no AS employee_id,
        MIN(de.dept_no) AS department_code,
        (SELECT emp_no
			FROM dept_manager
            WHERE emp_no = 110039) AS manager_id
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE e.emp_no > 10020
GROUP BY e.emp_no
ORDER BY e.emp_no
LIMIT 20) AS B;

/*
Starting your code with “DROP TABLE”, create a table called “emp_manager” (
	emp_no – integer of 11, not null;
    dept_no – CHAR of 4, null;
    manager_no – integer of 11, not null). 
*/

DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
	emp_no INT(11) NOT NULL PRIMARY KEY,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

/*
Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Your query skeleton must be:

Insert INTO emp_manager
	SELECT U.*
	FROM (A)
	UNION
    (B)
    UNION
    (C)
    UNION
    (D) AS U;

A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM).
In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A),
and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).
Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.
Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.
Your output must contain 42 rows.
*/

INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    
SELECT * FROM emp_manager;
    
    
## SELF JOIN
/*
A MySQL self-join is a type of SQL join where a table is joined with itself.
In other words, you use the same table twice in the query and establish a relationship between its columns as if they were from two separate tables.
This technique is often used when you need to compare rows within the same table based on certain criteria.
Self-joins can be particularly useful when dealing with hierarchical data, organizational structures,
or when you need to find relationships between rows within the same dataset.

Self joins are appropriate to be used when a column in a table is referenced in the same table
*/

/*
From the emp_manager table, extract the record data only of those employees
who are managers as well 
*/

SELECT * FROM emp_manager
ORDER BY emp_manager.emp_no;

-- Solution #1
SELECT DISTINCT
	e1.emp_no,
    e1.dept_no,
    e2.manager_no
FROM emp_manager e1
JOIN emp_manager e2
ON e1.emp_no = e2.manager_no;

-- Solution #2
SELECT e1.*
FROM emp_manager e1
JOIN emp_manager e2
ON e1.emp_no = e2.manager_no
WHERE e2.emp_no IN (SELECT manager_no
					FROM emp_manager);
                    
                    
## VIEWS
## Vitual table whose contents are obtained from an existing table
## or tables, called "base tables". They act as a dynamic table because it instantly reflects
## data and structural changes in the base table

/*
Visualize only the period encompassing the last contract of each employee
*/

SELECT * FROM dept_emp;

SELECT
	emp_no,
    from_date,
    to_date,
    COUNT(emp_no) AS num
FROM dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
SELECT
	emp_no,
    MAX(from_date) AS from_date,
    MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;

SELECT * FROM v_dept_emp_latest_date;

/*
Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.
If you have worked correctly, after executing the view from the “Schemas” section in Workbench, you should obtain the value of 66924.27.
*/

-- Solution #1
CREATE VIEW v_manager_avg_salary AS
SELECT
	ROUND(AVG(salary),2)
FROM salaries
WHERE emp_no IN (SELECT emp_no FROM dept_manager);

-- Solution #2
CREATE OR REPLACE VIEW v_manager_avg_salary AS
SELECT
	ROUND(AVG(salary), 2)
FROM salaries s
JOIN dept_manager m ON s.emp_no = m.emp_no;


## Stored Routines: Procedures & Functions
## A stored routine is nothing but a SQL statement, or a select SQL statements,
## that can be stored on the database server

USE employees;

## Creating a procedure with delimiter

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
    LIMIT 1000;
END$$
DELIMITER ;

## checking if procedure has been created successfully
## there are 3 ways to invoque the procedure:

-- Number #1
CALL employees.select_employees();
CALL select_employees();

-- Number #2
/*
Click on the "lightning" icon in the schemas navigator
where the procedure is stored. A new query tab will appear.
*/

-- Number #3
/*
Click on the "wrench" icone and a new tab will appear
with the coded procedure
*/

/*
Create a procedure that will provide the average salary of all employees.
Then, call the procedure.
*/

DROP PROCEDURE IF EXISTS avg_salary_employees;

DELIMITER $$
CREATE PROCEDURE avg_salary_employees()
BEGIN
	SELECT ROUND(AVG(salary),2) AS average_salary
    FROM salaries;
END $$
DELIMITER ;

-- 4 ways to write the call:
CALL avg_salary_employees;
CALL avg_salary_employees();
CALL employees.avg_salary_employees;
CALL employees.avg_salary_employees();

## Creating a stored procedure through MySQL
## workbench's interface

/*
Right-click on the "Stored Procedures" and select "Create Stored Procedure..."
A new tab will open with the basic query to create a new procedure.
Once the procedure is created, you need to click on the "Apply" button,
located on the lower right of the tab.
*/

CALL employees.number_employees_title();

DROP PROCEDURE number_employees_title;


## Stored procedures with an input parameter

USE employees;
DROP PROCEDURE IF EXISTS emp_salary;

-- In p_emp_no, the "p" stands for Parameter
-- (IN name data_type)

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INT)
BEGIN
	SELECT
		e.first_name,
        e.last_name,
        s.salary,
        s.from_date,
        s.to_date
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

-- Click on the "lightning" icon in the recently stored procedure
-- and a window will pop-up to enter an employee number
-- call emp_no = 11300, for example

/*
In some cases, sme employees have their contracts changed and
salaries as well, so we can check the average salary of an employee
that went through a couple of contracts withing the company
*/

DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INT)
BEGIN
	SELECT
		e.first_name,
        e.last_name,
        AVG(s.salary)
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no
    GROUP BY e.first_name, e.last_name;
END $$
DELIMITER ;

CALL emp_avg_salary(11300);


## Stored procedures with an output parameter
-- CREATE PROCEDURE name (IN name data_type, OUT name data_type)

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INT, OUT p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT
		AVG(s.salary) AS avg_salary
	INTO p_avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

/*
Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual,
and returns their employee number.
*/

DROP PROCEDURE IF EXISTS emp_info;

SELECT * FROM employees;
-- first_name, last_name
## Georgi	Facello
## Bezalel	Simmel
## Parto	Bamford
## Chirstian	Koblick
## Kyoichi	Maliniak
## Anneke	Preusig
## Tzvetan	Zielinski

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN
	SELECT
	e.emp_no
	INTO p_emp_no
    FROM employees e
	WHERE e.first_name = p_first_name
	AND e.last_name = p_last_name;
END$$
DELIMITER ;

## Variables
/*
1) create a variable
2) extract a value that will be assigned to the newly created cariable, that is, call the procedure
3) ask the software to display the output of the procedure
*/
-- To call using a query, we need to
-- declare/create a variable to hold the output parameter value

SET @v_avg_salary = 0;

-- Call the stored procedure with input parameters and assign the output parameter value

CALL employees.emp_avg_salary(11300,@v_avg_salary);

-- Use the variable to fetch the value of the output parameter
SELECT @v_avg_salary;

-- So we have to run the above in order:
SET @p_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300,@p_avg_salary);
SELECT @p_avg_salary;

/*
Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.
Finally, select the obtained output.
*/

SET @v_emp_no = 0;
CALL employees.emp_info('Aruna','Journel',@v_emp_no);
SELECT @v_emp_no;


## User-defined functions in MySQL

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT
	AVG(s.salary) INTO v_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$
DELIMITER ;

-- We cannot call a functions but we can SELECT it

SELECT f_emp_avg_salary(11300);

/*
Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,
and returns the salary from the newest contract of that employee.
Hint: In the BEGIN-END block of this program, you need to declare and use two variables:
	v_max_from_date that will be of the DATE type,
    v_salary, that will be of the DECIMAL (10,2) type.
Finally, select this function.
*/

DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
READS SQL DATA

BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary decimal(10,2);

SELECT MAX(from_date) INTO v_max_from_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
AND e.last_name = p_last_name;

SELECT s.salary INTO v_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
AND e.last_name = p_last_name
AND s.from_date = v_max_from_date;
  
RETURN v_salary;
END$$
DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

## Stored routines

## Stored Procedure:
-- Doesn't return a value
-- CALL procedure
-- Can have multiple OUT parameters

## User-defined function
-- Returns a value
-- SELECT function
-- can return a single value only

SET @v_emp_no = 11300;
SELECT
	emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM employees
WHERE emp_no = @v_emp_no;

-- Including a function in a SELECT statement is impossible

## Advanced SQL Topics
-- Scope = Visibility: the region of a computer program where a phenomenon, such as
-- a variable, is considered valid

## MySQL Variables Types:
# Local
# Session
# Global

# Declare is a keyword that can be used when creating local variables only
# A local variable can be used within the body of a procedure
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

BEGIN

DECLARE v_avg_salary_2 DECIMAL(10,2);
END;

SELECT
	AVG(salary) INTO v_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;

RETURN v_avg_salary_2;
END$$

DELIMITER ;

SELECT v_avg_salary;

## Session Variables
/*
If there are 10 different connections to a server at the same time,
there will be ten different sessions
*/
-- The session variable is only available in the session it was created, if we try to run it in another session,
-- it will return a NULL, because it is beyond the scope of that variable
-- @ indicates we are creating a MySQL session variable

SET @s_var1 = 3;

SELECT @s_var1;

## Global Variables
/*
Global variables apply to all connections relaed to a specific server
SET GLOBAL var_name = value;
SET @@global.var_name = value;
A database administrator will be the one in control of setting global variables in a database
*/

SET GLOBAL max_connections = 1000;

SET @@global.max_conections = 1;


## User-Defined vs System Variables
-- user-defined: variables that can be set by the user manually, can be set as local and session
-- system: variables that are pre-defined on our system - the MySQL server, can be set as global and session

SET SESSION sql_mode = 'STRICT_TRANS_TABLES, NO_ZERO_DATE, NO_AUTO_CREATE_USER, NO_ENGINE_SUBSTITUION';

-- A user can only define a local variable or a session variable

/*
Not all system variables can be set as session!
sql_mode coud be set either as session or a global variable
and max_connections can be set as global only
*/

-- For example, a variable setting the minimum salary paid to employees registered in the database
-- is not a system variable in MySQL

##########################################################
##########################################################

-- SECTION: Advanced SQL Topics

##########################################################
##########################################################



###########
-- LECTURE: MySQL Triggers

# A MySQL trigger is a type of stored program, associated with a table, 
# that will be activated automatically once a specific event related to the table of association occurs. 

# This event must be related to one of the following three DML statements: INSERT, UPDATE, or DELETE. 
# Therefore, triggers are a powerful and handy tool that professionals love to use where database consistency 
# and integrity are concerned.

# Moreover, to any of these DML statements, one of two types of triggers can be assigned – a “before”, or an “after” trigger.

# In other words, a trigger is a MySQL object that can “trigger” a specific action or calculation ‘before’ or ‘after’ an INSERT, 
# UPDATE, or DELETE statement has been executed. For instance, a trigger can be activated before a new record is inserted into a table, 
# or after a record has been updated.

# Perfect! Let’s execute some code.  

# First, in case you are just starting Workbench, select “Employees” as your default database.

USE employees;

# Then, execute a COMMIT statement, because the triggers we are about to create will make some changes to 
# the state of the data in our database. At the end of the exercise, we will ROLLBACK up to the moment of this COMMIT.  

COMMIT;

# We said triggers are a type of stored program.
# Well, one could say the syntax resembles that of stored procedures, couldn’t they?

# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# After stating we want to CREATE a TRIGGER and then indicating its name, we must indicate its type and the name of the table 
# to which it will be applied. In this case, we devised a “before” trigger, which will be activated whenever new data is inserted 
# in the “Salaries” table. 

# Great!

# Then, an interesting phrase follows – “for each row”. It designates that before the trigger is activated, MySQL will perform a #
# check for a change of the state of the data on all rows. In our case, a change in the data of the “Salaries” table will be caused 
# by the insertion of a new record. 

# Within the BEGIN-END block, you can see a piece of code that is easier to understand if you just read it without focusing on 
# the syntax.

# The body of this block acts as the core of the “before_salaries_insert” trigger. Basically, it says that if the newly inserted 
# salary is of negative value, it will be set as 0.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF;
*/

# From a programmer’s perspective, there are three things to note about these three lines of code.

# First, especially for those of you who are familiar with some programming, this is an example of a conditional. The IF statement 
# starts the conditional block. Then, if the condition for negative salary is satisfied, one must use the keyword THEN before showing 
# what action should follow. The operation is terminated by the END IF phrase and a semi-colon. 

# The second thing to be noted here is even more interesting. That’s the use of the keyword NEW. In general, it refers to a row that 
# has just been inserted or updated. In our case, after we insert a new record, “NEW dot salary” will refer to the value that will 
# be inserted in the “Salary” column of the “Salaries” table.

# The third part of the syntax regards the SET keyword. As you already know, it is used whenever a value has to be assigned to a 
# certain variable. Here, the variable is the newly inserted salary, and the value to be assigned is 0. 

# All right! Let’s execute this query. 
# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Let’s check the values of the “Salaries” table for employee 10001.

SELECT * FROM salaries
WHERE emp_no = '10001';
    
# Now, let’s insert a new entry for employee 10001, whose salary will be a negative number.

INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

# Let’s run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.

SELECT * FROM salaries
WHERE emp_no = '10001';
    
# You can see that the “before_salaries_insert” trigger was activated automatically. It corrected the value of minus 92,891 
# we tried to insert. 

# Now, let’s look at a BEFORE UPDATE trigger. The code is similar to the one of the trigger we created above, with two 
# substantial differences.
# BEFORE UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;

# First, we indicated that this will be a BEFORE UPDATE trigger.  
/*
BEFORE UPDATE ON salaries
*/

# Second, in the IF conditional statement, instead of setting the new value to 0, we are basically telling MySQL to keep the old value. 
# Technically, this is achieved by setting the NEW value in the “Salary” column to be equal to the OLD one. This is a good example of 
# when the OLD keyword needs to be used.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF;
*/

# Create the “before_salaries_update” trigger by executing the above statement. 

# Then, run the following UPDATE statement, with which we will modify the salary value of employee 10001 with another positive value.

UPDATE salaries 
SET salary = 98765
WHERE emp_no = '10001'
AND from_date = '2010-06-22';
        
# Execute the following SELECT statement to see that the record has been successfully updated.

SELECT * FROM salaries
WHERE emp_no = '10001'
AND from_date = '2010-06-22';
        
# Now, let’s run another UPDATE statement, with which we will try to modify the salary earned by 10001 with a negative value, minus 50,000.

UPDATE salaries 
SET salary = - 50000
WHERE emp_no = '10001'
AND from_date = '2010-06-22';
        
# Let’s run the same SELECT statement to check if the salary value was adjusted.

SELECT *
FROM salaries
WHERE emp_no = '10001'
AND from_date = '2010-06-22';
        
# No, it wasn’t. Everything remained intact. So, we can conclude that only an update with a salary higher than zero dollars per year 
# would be implemented.

# All right. For the moment, you know you have created only two triggers. But how could you prove that to someone who is seeing your 
# script for the first time?

# Well, in the ‘info’ section of the “employees” database, you can find a tab related to triggers. When you click on its name, 
# MySQL will show you the name, the related event, table, timing, and other characteristics regarding each trigger currently in use.  

# Let’s introduce you to another interesting fact about MySQL. You already know there are pre-defined system variables, but system 
# functions exist too! 
# System functions can also be called built-in functions. 
# Often applied in practice, they provide data related to the moment of the execution of a certain query.

# For instance, SYSDATE() delivers the date and time of the moment at which you have invoked this function.

SELECT SYSDATE();

# Another frequently employed function, “Date Format”, assigns a specific format to a given date. For instance, the following query 
# could extract the current date, quoting the year, the month, and the day. 

SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

# Of course, there are many other ways in which you could format a date; what we showed here was just an example.
# So, using system functions seems cool, doesn’t it?

# Wonderful! You already know how to work with the syntax that allows you to create triggers. 

# As an exercise, try to understand the following query. Technically, it regards the creation of a more complex trigger. 
#It is of the size that professionals often have to deal with.

DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT
		MAX(salary)
	INTO v_curr_salary
    FROM salaries
	WHERE emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET to_date = SYSDATE()
		WHERE emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
		VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  

INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

# SELECT the record of employee number 111534 in the ‘dept_manager’ table, and then in the ‘salaries’ table to see how the output was affected. 

SELECT *
FROM dept_manager
WHERE emp_no = 111534;
    
SELECT *
FROM salaries
WHERE emp_no = 111534;

# Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee who was just promoted as a manager. 
# Moreover, it set the start date of her new contract to be the day on which you executed the insert statement.

# Finally, to restore the data in the database to the state from the beginning of this lecture, execute the following ROLLBACK statement. 

ROLLBACK;

# End.

##########################################################
##########################################################

/*
Create a trigger that checks if the hire date of an employee is higher than the current date.
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/

DROP TRIGGER IF EXISTS check_hire_date;

DELIMITER $$
CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN
    SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     
    END IF;  
END $$  
DELIMITER ;  

INSERT employees
	VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  
SELECT * FROM employees
ORDER BY emp_no DESC;


## MySQL Indexes

-- CREATE INDEX index_name
-- ON table_name (column1, column2, ...);

/*
How many people have been hired after the 1st of January 2000?
*/
SELECT * FROM employees
WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

/*
Select all employees bearing the name "Georgi Facello"?
*/

SELECT * FROM employees
WHERE concat(first_name," ",last_name) = 'Georgi Facello';

SELECT * FROM employees
WHERE first_name = 'Georgi'
AND last_name = 'Facello';

CREATE INDEX i_composite
ON employees(first_name, last_name);

/*
How to show the available indexes?
*/

SHOW INDEXES FROM employees
FROM employees;

DROP INDEX i_hire_date ON employees;

ALTER TABLE employees
DROP INDEX i_hire_date;

/*
Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table,
and check if it has sped up the search of the same SELECT statement.
*/

SELECT * FROM salaries
WHERE salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

SHOW INDEXES FROM salaries
FROM employees;


## The CASE statement
-- Example #1
SELECT
	emp_no,
    first_name,
    last_name,
    CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- Example #2
SELECT
	emp_no,
    first_name,
    last_name,
    CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- Example #3
-- IS NULL and IS NOT NULL are not values that
-- something can be compared to
SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
		WHEN NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

-- Example #4
-- IF vs CASE
-- IF we can only have one conditional expression
-- CASE we can have multiple conditional expressions
SELECT
	emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM employees;

-- Example #5
SELECT
	dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
		ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM dept_manager dm
JOIN employees e ON e.emp_no = dm.emp_no
JOIN salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

/*
Similar to the exercises done in the lecture, obtain a result set containing
the employee number, first name, and last name of all employees with a number higher than 109990.

Create a fourth column in the query, indicating whether this employee is also a manager,
according to the data provided in the dept_manager table, or a regular employee. 
*/

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990;

/*
Extract a dataset containing the following information about the managers:
employee number, first name, and last name.

Add two columns at the end
– one showing the difference between the maximum and minimum salary of that employee, and
- another one saying whether this salary raise was higher than $30,000 or NOT.
If possible, provide more than one solution.
*/

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'higher than 30000'
        ELSE 'lower than 30000'
	END AS salary_raise
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'higher than 30K','lower than 30K')AS salary_raise
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;

/*
Extract the employee number, first name, and last name of the first 100 employees,
and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company,
or “Not an employee anymore” if they aren’t.

Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
*/

-- Solution A
SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    CASE
		WHEN de.to_date <= current_date() THEN 'still employed'
        ELSE 'former employee'
	END AS employed
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
LIMIT 100;

-- Solution B
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

## Window Functions
# And advanced SQL tool performing a calculation for every record in the
# data set, using other records associated with the specified one from the table

## The ROW_NUMBER() Ranking Window Function and the Relevant MySQL Syntax

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER() AS row_num
FROM salaries;

-- Partition By
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM salaries;

/*
Exercise #1 :
Write a query that upon execution, assigns a row number to all managers we have information
for in the "employees" database (regardless of their department).
Let the numbering disregard the department the managers have worked in.
Also, let it start from the value of 1. Assign that value to the manager with the lowest employee number.
*/

SELECT
    emp_no,
    dept_no,
    ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM dept_manager;

/*
Exercise #2:
Write a query that upon execution, assigns a sequential number for each employee number registered
in the "employees" table. Partition the data by the employee's first name and order it by
their last name in ascending order (for each partition).
*/
SELECT
	emp_no,
    first_name,
    last_name,
    ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name) AS row_numbr
FROM employees;

-- A note on using several window functions in a query
-- 1) Add an ORDER BY clause in the outer query
-- 2) Use only window specifications requiring identical partitions

SELECT
	emp_no,
    salary,
    #ROW_NUMBER() OVER() AS row_number1,
	ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_number2,
	ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_number3
	#ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_number4
FROM salaries
ORDER BY emp_no, salary;

/*
Exercise #1:
Obtain a result set containing the salary values each manager has signed a contract for.
To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row number of each row from the obtained dataset, starting from 1.
- a column containing the sequential row numbers associated to the rows for each manager,
where their highest salary has been given a number equal to the number of rows in the given partition,
and their lowest - the number 1.
Finally, while presenting the output, make sure that the data has been ordered
by the values in the first of the row number columns, and then by the salary values for each partition.
*/

SELECT
	dm.emp_no,
    s.salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary) AS row_1,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_2 
FROM dept_manager dm
JOIN salaries s ON dm.emp_no = s.emp_no;


/*
Exercise #2:
Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row numbers associated to each manager, where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
- a column containing the row numbers associated to each manager, where their highest salary has been given the number of 1, and the lowest - a value equal to the number of rows in the given partition.
Let your output be ordered by the salary values associated to each manager in descending order.
Hint: Please note that you don't need to use an ORDER BY clause in your SELECT statement to retrieve the desired output.
*/

SELECT
	dm.emp_no,
    salary,
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM dept_manager dm
JOIN salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;


## Windows Functions Syntax
-- NOTE: To obtain the below result, opt for the syntax
-- that does not involve a WINDOW clause

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER w AS row_number_1
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/*
Exercise #1:
Write a query that provides row numbers for all workers from the "employees" table,
partitioning the data by their first names and ordering each partition by their employee number in ascending order.

NB! While writing the desired query, do *not* use an ORDER BY clause in the relevant SELECT statement.
At the same time, do use a WINDOW clause to provide the required window specification.
*/

SELECT
	emp_no,
    first_name,
    ROW_NUMBER() OVER w AS row_number_1
FROM employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);


## The PARTITION BY Clause VS the GROUP BY Clause
# While GROUP BY is used with aggregate functions to summarize data by grouping rows with the same values in one or more columns,
# PARTITION BY is used with window functions to perform calculations on subsets of rows (partitions) related to the current row.

-- GROUP BY
SELECT
	emp_no,
    MIN(salary) AS salary,
    MIN(from_date) AS from_date,
    MIN(to_date) AS to_date
FROM salaries
GROUP BY emp_no;

-- PARTITION BY
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM salaries;

-- Group By, Partition By and Window, using a subquery
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)
    ) AS a
GROUP BY emp_no;

SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
	FROM salaries
    ) AS a
GROUP BY emp_no;

-- Group By, aggregating using a subquery
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary
	FROM salaries
    ) AS a
GROUP BY emp_no;

-- Group By, row_number and window, using a subquery
-- The below will give us the highest, according to the row number
-- If we want the 2, 3, or 4th highest value, since we have the MAX function,
-- we then just have to update the row_num to the desired outcome
SELECT
	a.emp_no,
    a.salary AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)
    ) AS a
WHERE a.row_num = 4;

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary) AS row_num
FROM salaries;

# Exercise #1:
# Find out the lowest salary value each employee has ever signed a contract for.
# To obtain the desired output, use a subquery containing a window function,
# as well as a window specification introduced with the help of the WINDOW keyword.
# Also, to obtain the desired result set, refer only to data from the “salaries” table.

SELECT
	a.emp_no,
    MIN(salary) AS lowest_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
    ) AS a
GROUP BY emp_no;


## Exercise #2:
# Again, find out the lowest salary value each employee has ever signed a contract for.
# Once again, to obtain the desired output, use a subquery containing a window function.
# This time, however, introduce the window specification in the field list of the given subquery.
# To obtain the desired result set, refer only to data from the “salaries” table.

SELECT
	a.emp_no,
    MIN(salary) AS lowest_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num
	FROM salaries
    ) AS a
GROUP BY emp_no;


## Exercise #3:
# Once again, find out the lowest salary value each employee has ever signed a contract for.
# This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery.
# To obtain the desired result set, refer only to data from the “salaries” table.

SELECT
	a.emp_no,
    MIN(salary) AS min_salary
FROM (
	SELECT
		emp_no,
        salary
	FROM salaries
    ) AS a
GROUP BY emp_no;

## Exercise #4:
# Once more, find out the lowest salary value each employee has ever signed a contract for.
# Using a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
# Moreover, obtain the output without using a GROUP BY clause in the outer query.
# To obtain the desired result set, refer only to data from the “salaries” table.

SELECT
	a.emp_no,
    a.salary as min_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=1;

# Exercise #5:
# Find out the second-lowest salary value each employee has ever signed a contract for.
# Using a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
# Moreover, obtain the desired result set without using a GROUP BY clause in the outer query.
# To obtain the desired result set, refer only to data from the “salaries” table.

SELECT
	a.emp_no,
    a.salary AS min_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary ASC)
    ) AS a
WHERE a.row_num = 2;


## RANK() and DENSE_RANK() Window Functions

SELECT
	DISTINCT
	emp_no,
    salary,
    ROW_NUMBER() OVER w AS row_num
FROM salaries
WHERE emp_no = 10001
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- What if some of the salary values were identical?
-- What if an employee had signed two or more contracts of the same value,
-- albeit related to different periods?

SELECT
	emp_no,
    (COUNT(salary) - COUNT(DISTINCT salary)) as diff
FROM salaries
GROUP BY emp_no
HAVING diff > 0
ORDER BY emp_no;

SELECT * FROM salaries
WHERE emp_no = 11839;

-- RANK()
-- Let's see the highest salary employee number 11839 has received in the company
-- When we run the below, we will see that the 3rd and 4th records contain the same salary value
-- and will be assigned the same rank
-- When using rank, the focus is on the number of values we have in our output, for example,
-- if there were three records with same salary, the next record would have been 6th and the 
-- 3, 4 ,and 5th records would all be with rank 3, because they are the same.
SELECT
	emp_no,
    salary,
    RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- DENSE_RANK() focus is on the ranking of the values itself,
-- let's apply to the previous query and see that the ranking
-- does not skip

SELECT
	emp_no,
    salary,
    DENSE_RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/*
Exercise #1:
Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest.
*/

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER w AS row_numbr
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/*
Exercise #2:
Write a query that upon execution, displays the number of salary contracts that each manager has ever signed
while working in the company.
*/
-- Version A
SELECT
	emp_no,
    COUNT(salary) AS numbr_salary_contracts
FROM salaries
WHERE emp_no IN (SELECT
					DISTINCT emp_no
				FROM dept_manager)
GROUP BY emp_no
ORDER BY emp_no;

-- Version B
SELECT
	dm.emp_no,
    (COUNT(salary)) AS no_of_salary_contracts
FROM dept_manager dm
JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no;

/*
Exercise #3:
Write a query that upon execution retrieves a result set containing all salary values
that employee 10560 has ever signed a contract for.
Use a window function to rank all salary values from highest to lowest in a way that equal salary values
bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed.
*/

SELECT
	emp_no,
    salary,
    RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/*
Exercise #4:
Write a query that upon execution retrieves a result set containing all salary values that employee 10560
has ever signed a contract for. Use a window function to rank all salary values from highest to lowest
in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.
*/

SELECT
	emp_no,
    salary,
    DENSE_RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);


## Ranking Window Functions nad JOINS together
/*
- Obtain data only about the managers from the employee's database.
- Partition the relevant information by the department where the managers have worked in.
- Arrange the partitions by the manager's salary contract values in descending order.
- Rank the managers according to their salaries in a certain department
(Where you prefer to not lose track of the number of salary contracts signed within each department)
- Display the start and end dates of each salary contract (Calling the relevant fields
salary_from_date and salary_to_date respectively)
- Display the first and last date in which an employee has been a manager, according to the data
provided in the department manager table (call the relevant fields department_manager_from_date
and department_manager_to_date respectively.

In other words, we are aiming to have the record containing the highest salary
of a given department manager to be ranked as number one, their second to highest salary as number two, and so on.
*/

SELECT
	d.dept_no,
    d.dept_name,
    dm.emp_no,
    RANK() OVER w AS dept_salary_ranking,
    s.salary,
    s.from_date AS salary_from_date,
    s.to_date AS salary_to_date,
    dm.from_date AS dept_manager_from_date,
    dm.to_date AS dept_manager_to_date
FROM dept_manager dm
JOIN salaries s ON s.emp_no = dm.emp_no
	AND s.from_date BETWEEN dm.from_date AND dm.to_date
    AND s.to_date BETWEEN dm.from_date AND dm.to_date
JOIN departments d ON d.dept_no = dm.dept_no
WINDOW w AS (PARTITION BY dm.dept_no ORDER BY s.salary DESC);

/*
Exercise #1:
Rank the salary values in descending order of all contracts signed by employees between 10500 and 10600 inclusive.
Let equal salary values for one and the same employee bear the same rank.
Also, allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
*/

SELECT
	e.emp_no,
    s.salary,
    RANK() OVER w AS salary_rank
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);

/*
Exercise #2:
Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank.
Do not allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
*/

SELECT
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


## LAG() and LEAD() Value Window Functions
-- As oppose to ranking window functions, value window functions return
-- a value that can be found in the database

/*
Let's write a query extracting the following:
- The salary values from all contracts that employee 10001 had ever signed
while working for the company in ascending order,
- A column showing the previous salary value from our ordered list
- A column showing the next salary value from our ordered list
- A column displaying the difference between the current and previous salary of a given record from the list,
- A column displaying the difference between the next and current salary of a given record from the list.

In other words, we want to order all salary values from lowest to highest and display next to each of them
the previous and next salary values, as well as their differences from the current salary value.
*/

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    (salary - LAG(salary) OVER w) AS diff_salary_current_previous,
    (LEAD(salary) OVER w - salary) AS diff_salary_next_current
FROM salaries
WHERE emp_no = 10001
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

/*
Exercise #1:
Write a query that can extract the following information from the "employees" database:
- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
- a column showing the previous salary from the given ordered list
- a column showing the subsequent salary from the given ordered list
- a column displaying the difference between the current salary of a certain employee and their previous salary
- a column displaying the difference between the next salary of a certain employee and their current salary

Limit the output to salary values higher than $80,000 only.
Also, to obtain a meaningful result, partition the data by employee number.
*/

SELECT
	emp_no,
    salary,
    LAG(salary) OVER (PARTITION BY emp_no ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_previous_salary,
    LEAD(salary) OVER w - salary AS diff_next_salary
FROM salaries
WHERE salary > 80000
AND emp_no BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

/*
Exercise #2:
The MySQL LAG() and LEAD() value window functions can have a second argument,
designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.
With that in mind, create a query whose result set contains data arranged by the salary values associated to each employee number
(in ascending order). Let the output contain the following six columns:
- the employee number
- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)
- the employee's previous salary
- the employee's contract salary value preceding their previous salary
- the employee's next salary
- the employee's contract salary value subsequent to their next salary
Restrict the output to the first 1000 records you can obtain.
*/

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LAG(salary,2) OVER w AS 1_before_previous_salary,
    LEAD(salary) OVER w AS next_salary,
    LEAD(salary,2 ) OVER w AS 1_after_next_salary
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 1000;

##########################################################
# Aggregate Functions in the Context of Window Functions
##########################################################

# Extract the employee number, the department they are working in, the current salary,
# and the all-time average salary paid in th department the employee is currently working in 
# regarding all current employed workers registered in the dept_emp table

SELECT sysdate();

SELECT
	emp_no,
    salary,
    from_date,
    to_date
FROM salaries
WHERE to_date > sysdate();

# What if an employee had signed an indefinite duration contract on date X, and then signed a new,
# differently valued indefinite duration contract two years from X?
# We have to be specific by using the MAX() function to guarantee that we will only obtain an employee's latest contract

SELECT
	emp_no,
    salary,
    MAX(from_date),
    to_date
FROM salaries
WHERE to_date > sysdate()
GROUP BY emp_no;

# The above query returns a 1055 error
# To fix this, we should use a subquery:

SELECT
	s1.emp_no,
    s.salary,
    s.from_date,
    s.to_date
FROM salaries s
JOIN (SELECT
		emp_no,
        MAX(from_date) AS from_date
	FROM salaries
    GROUP BY emp_no) AS s1
ON s.emp_no = s1.emp_no
WHERE s.to_date > sysdate()
AND s.from_date = s1.from_date;

##############
# Exercise #1:
##############

# Create a query that upon execution returns a result set containing the employee numbers,
# contract salary values, start, and end dates of the first ever contracts that each employee signed for the company.
# To obtain the desired output, refer to the data stored in the "salaries" table.

SELECT
	s1.emp_no,
    s.salary,
    s.from_date,
    s.to_date
FROM salaries s
JOIN (
SELECT
	emp_no,
	MAX(from_date) AS from_date
FROM salaries
GROUP BY emp_no
) AS s1
ON s.emp_no = s1.emp_no
WHERE s.from_date = s1.from_date;

# An employee might have changed departments without having had their salary adjusted,
# or vice-versa, not the last department where an employee has worked in vs their latest salary

SELECT
	de.emp_no,
    de.dept_no,
    de.from_date,
    de.to_date
FROM dept_emp de
JOIN (
	SELECT
		emp_no,
        MAX(from_date) AS from_date
	FROM dept_emp
    GROUP BY emp_no) AS de1
ON de1.emp_no = de.emp_no
WHERE de.to_date > SYSDATE()
AND de.emp_no = de1.emp_no;

/*Exercise 1
Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002
(as registered in the "dept_emp" table).
Create a MySQL query that will extract the following information about these employees:
	- Their employee number
	- The salary values of the latest contracts they have signed during the suggested time period
	- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
	- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in
during the suggested time period. Name that field "average_salary_per_department".
	Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises
after the previous lecture.
	Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture;
the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.
	Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries"
and "dept_emp" tables are greater than the "from_date" values stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!
Hint: If you've worked correctly, you should obtain an output containing 200 rows.
*/

SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM dept_emp de
JOIN (
	SELECT emp_no, MAX(from_date) AS from_date
FROM dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN (
	SELECT s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s
JOIN (
	SELECT emp_no, MAX(from_date) AS from_date
FROM salaries
GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;

################################
# Common Table Expressions (CTE)
################################

# In SQL, every query-and sometimes part of a query or subquery-produces a result or a temporary dataset.
# A CTE is a tool for obtaining such temporary result sets that exist within the execution of a given query

# How many salary contracts signed by female employees have been valued above the all-time
# average contract salary value of the company?

# To answers the above, we need a dataset #1 with the list of all the contracts signed by
# female employees from the company's history, and a dataset #2 with a single all-time average value

SELECT
	AVG(salary) AS avg_salary
FROM salaries;

WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
	SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_above_avg,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN cte c;

# An alternative solution to the above task...

WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
	SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_above_avg_m_sum,
    COUNT(CASE WHEN s.salary > c.avg_salary THEN s.salary ELSE NULL END) AS no_f_salaries_above_avg_m_count,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN cte c;

###############
# Exercise #1:
###############

# Use a CTE and a SUM() function in the SELECT statement to find out
# how many male employees have never signed a contract with a salary value
# higher than or equal to the all-time company salary average.

WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
    )
SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN cte c;


###############
# Exercise #2:
###############

# Use a CTE and (at least one) COUNT() function in the SELECT statement to find out
# how many male employees have never signed a contract with a salary value
# higher than or equal to the all-time company salary average.

WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
    )
SELECT
	COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN cte c;

##############
# Exercise #3:
##############

# Use only MySQL joins in a query to find out how many male employees have never signed
# a contract with a salary value higher than or equal to the all-time company salary average
# (i.e. to obtain the same result as in the previous exercise).

SELECT
    SUM(CASE WHEN s.salary < a.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM (
	SELECT
        AVG(salary) AS avg_salary
    FROM salaries s) AS a
    JOIN salaries s
    JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M';

##############
# Exercise #4:
##############

# Use a cross join to find out how many male employees have never signed a contract
# with a salary value higher than or equal to the all-time company salary average 
# (i.e. to obtain the same result as in the previous exercise).

WITH cte AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
#	COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
	COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
AND e.gender = 'M'
CROSS JOIN cte c;

######################################################
# Using Multiple Subclauses in a WITH Clause - Part 1
######################################################

# How many female employees' highest salary contract salary values
# were higher than the all-time company salary average (across all genders)?

SELECT AVG(salary) AS avg_salary FROM salaries;

SELECT
	s.emp_no,
    MAX(s.salary) AS highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
AND e.gender = 'F'
GROUP BY s.emp_no;

SELECT
	s.emp_no,
    MAX(s.salary) AS highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
WHERE e.gender = 'F'
GROUP BY s.emp_no;

## So, we will have something like this:

WITH cte1 AS (
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
	cte2 AS (
    SELECT
		s.emp_no,
		MAX(s.salary) AS f_highest_salary
	FROM salaries s
	JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
	GROUP BY s.emp_no
)
SELECT
	SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte1 c1;

######################################################
# Using Multiple Subclauses in a WITH Clause - Part 2
######################################################

WITH cte1 AS (
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
	cte2 AS (
    SELECT
		s.emp_no,
		MAX(s.salary) AS f_highest_salary
	FROM salaries s
	JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
	GROUP BY s.emp_no
)
SELECT
	SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts,
    CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END)/COUNT(e.emp_no))*100,2),'%') AS percentage
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte1 c1;

## Exercise #1:
## Use two common table expressions and a SUM() function in the SELECT statement 
## to obtain the number of male employees whose highest salaries have been below the all-time average.

WITH cte1 AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
	),
cte2 AS (
	SELECT
		s.emp_no,
        MAX(s.salary) AS max_salary
	FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
	SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
JOIN cte1 c1;

## Exercise #2:
## Use two common table expressions and a COUNT() function in the SELECT statement 
## to obtain the number of male employees whose highest salaries have been below the all-time average.

WITH cte_avg_salary AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
	SELECT
		s.emp_no,
        MAX(s.salary) AS max_salary
FROM salaries s JOIN employees e ON e.emp_no = s.emp_no
AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT
	COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM employees e
JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no
JOIN cte_avg_salary c1;

## Exercise #3:
## Does the result from the previous exercise change if you used the CTE
## for the male employees' highest salaries in a FROM clause, as opposed to in a join?

WITH cte_avg_salary AS (
	SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
	SELECT
    s.emp_no,
    MAX(s.salary) AS max_salary
	FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
	GROUP BY s.emp_no
)
SELECT
	COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM cte_m_highest_salary c2
JOIN cte_avg_salary c1;

## What is the highest contract salary values of all employees hired in 2000 or later?

SELECT * FROM employees
WHERE hire_date > '2000-01-01';

WITH emp_hired_from_jan_2000 AS (
	SELECT * FROM employees WHERE hire_date > '2000-01-01'
),
highest_contract_salary_values AS (
	SELECT
		e.emp_no,
        MAX(s.salary)
	FROM salaries s
	JOIN emp_hired_from_jan_2000 e ON e.emp_no = s.emp_no
    GROUP BY e.emp_no
    )
    SELECT * FROM highest_contract_salary_values;

####################
# Temporary tables
####################

## List containing the highest contract salary values signed by all
## female employees who have worked in the company

CREATE TEMPORARY TABLE f_highest_salaries
SELECT
	s.emp_no,
    MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
GROUP BY s.emp_no;

SELECT * FROM f_highest_salaries;

SELECT * FROM f_highest_salaries
WHERE emp_no <= '10010';

DROP TABLE IF EXISTS f_highest_salaries;
## Or
DROP TEMPORARY TABLE IF EXISTS f_highest_salaries;

##############
# Exercise #1:
##############

# Store the highest contract salary values of all male employees in a temporary table called male_max_salaries.

CREATE TEMPORARY TABLE male_max_salaries
SELECT
	s.emp_no,
    MAX(salary) AS max_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
AND e.gender = 'M'
GROUP BY s.emp_no;

##############
# Exercise #2:
##############

# Write a query that, upon execution, allows you to check the result set contained in the
# male_max_salaries temporary table you created in the previous exercise.

SELECT *
FROM male_max_salaries;

##############
# Exercise #1:
##############
# Create a temporary table called "dates" containing the following three columns:
# - one displaying the current date and time,
# - another one displaying two months earlier than the current date and time, and a
# - third column displaying two years later than the current date and time.

CREATE TEMPORARY TABLE dates
SELECT
	NOW() AS current_date_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;

##############
# Exercise #2:
##############
# Write a query that, upon execution, allows you to check the result set contained in the
# "dates" temporary table you created in the previous exercise.

SELECT * FROM dates;

##############
# Exercise #3:
##############
# Create a query joining the result sets from the dates temporary table you created
# during the previous lecture with a new CTE containing the same columns.
# Let all columns in the result set appear on the same row.

WITH dates2 AS (
	SELECT
	NOW() AS current_date_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later
    )
SELECT * FROM dates
JOIN dates2;

##############
# Exercise #4:
##############
# Again, create a query joining the result sets from the dates temporary table you created
# during the previous lecture with a new CTE containing the same columns.
# This time, combine the two sets vertically.

WITH dates2 AS (
	SELECT
	NOW() AS current_date_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later
    )
SELECT * FROM dates
UNION
SELECT * FROM dates2;

##############
# Exercise #5:
##############
# Drop the male_max_salaries and dates temporary tables you recently created.

DROP TEMPORARY TABLE IF EXISTS male_max_salaries;
DROP TEMPORARY TABLE IF EXISTS dates;

##############################
## Combining SQL and Tableau
##############################

## Task 1
## Create a visualization that provides a breakdown between the male and female employees
## working in the company each year, starting from 1980

SELECT 
    YEAR(d.from_date) AS calendar_year,
    e.gender,    
    COUNT(e.emp_no) AS num_of_employees
FROM t_employees e
JOIN t_dept_emp d ON d.emp_no = e.emp_no
GROUP BY calendar_year , e.gender 
HAVING calendar_year >= 1990;

## Task 2
## Compare the number of male managers to the number of female managers
## from different departments for each year, starting from 1990

SELECT * FROM t_employees;
SELECT * FROM t_departments;
SELECT * FROM t_dept_emp;

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM t_employees
    GROUP BY calendar_year) e
	CROSS JOIN t_dept_manager dm
	JOIN t_departments d ON dm.dept_no = d.dept_no
	JOIN t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;

## Task 3
## Compare the average salary of F vs M employees in the entire company until 2002,
## adding a filter allowing you to see that per each department.

SELECT 
    YEAR(tde.to_date) AS calendar_year,
    td.dept_name,
    te.gender,
    ROUND(AVG(salary),2) AS avg_salary
FROM t_salaries ts
JOIN t_employees te ON ts.emp_no = te.emp_no
JOIN t_dept_emp tde ON ts.emp_no = tde.emp_no
JOIN t_departments td ON tde.dept_no = td.dept_no
GROUP BY calendar_year, te.gender,tde.dept_no
HAVING calendar_year <= 2002
ORDER BY calendar_year, tde.dept_no, te.gender;

## SOLUTION ##
SELECT
	e.gender,
    d.dept_name,
    ROUND(AVG(s.salary),2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM t_salaries AS s
JOIN t_employees AS e ON s.emp_no = e.emp_no
JOIN t_dept_emp AS de ON de.emp_no = e.emp_no
JOIN t_departments AS d ON d.dept_no = de.dept_no
GROUP BY d.dept_no, e.gender, calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

## Task 4
## Create an SQL stored procedure that will allow you to obtain the average mae and female salary per department
## within a certain salary range. Let this range be defined by two values the user can insert when cancelling
## the procedure. Finally, visualize the obtained result-set in Tableau as a double bar chart.

-- Imagine your boss told you that "There have not been many people who have earned less than $50,000 or more than $90,000."
-- So, we need to exclude <$50,000 and >$90,000
-- You won't need an OUT parameter

SELECT MIN(salary) FROM t_salaries;
SELECT MAX(salary) FROM t_salaries;

/*
DROP PROCEDURE IF EXISTS procedure_name;

DELIMITER $$
CREATE PROCEDURE procedure_name (IN param_1, IN param_2)
BEGIN
SELECT

FROM
JOIN ON
JOIN ON
JOIN ON
WHERE... BETWEEN... AND...
GROUP BY..
*/

## Solution

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT
	e.gender,
    d.dept_name,
    AVG(s.salary) AS salary
FROM t_salaries s
JOIN t_employees e ON s.emp_no = e.emp_no
JOIN t_dept_emp de ON de.emp_no = e.emp_no
JOIN t_departments d ON d.dept_no = de.dept_no 
WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END $$
DELIMITER ;

CALL filter_salary(50000, 90000);

## Task 5
## Multiple Questions to Practice Querying

## Exercise 1
## Find the avg salary of the male and female employees in each department

SELECT
    d.dept_name,
	e.gender,
	AVG(salary) AS avg_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY de.dept_no , e.gender
ORDER BY de.dept_no;


## Exercise 2
## Find the lowest department number encountered in the 'dept_emp' table.
## Then, find the highest department number.

SELECT
	MIN(dept_no) AS lowest_dept_no,
    MAX(dept_no) AS highest_dept_no
FROM dept_emp;


##Exercise 3
## Obtain a table containing the following three fields for all individuals
## whose employee number is not greater than 10040:
-- employee number
-- the lowest department number among the departments where the employee has worked in (Hint:
-- use a subquery to retrieve this value from the 'dept_emp' table)
-- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020, and '110039' to those whose number is between 10021 and 10040 inclusive.
## Use a CASE statement to create the third field.
## If done correctly, the output should return 40 rows.

SELECT
    emp_no,
    (SELECT
		MIN(dept_no)
	FROM dept_emp de
	WHERE e.emp_no = de.emp_no
    ) AS dept_no,
    CASE
        WHEN emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM employees e
WHERE emp_no <= 10040;

## Exercise 4
## Retrieve a list of all employees that have been hired in 2000.

SELECT
	CONCAT(first_name," ",last_name) AS employee_name
FROM employees
WHERE YEAR(hire_date) = 2000
ORDER BY employee_name;
