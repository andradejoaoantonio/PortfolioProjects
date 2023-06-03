'SELECT'

SELECT * FROM customer;

SELECT first_name, last_name, email FROM customer;

SELECT first_name, last_name, email FROM customer
ORDER BY first_name ASC;

'DISTINCT shows how many distinct values in a table/column'

SELECT * FROM film;

SELECT DISTINCT release_year FROM film;

SELECT DISTINCT rental_rate FROM film;

'An Australian visitor is not familiar with MPAA movie ratings (e.g. PG, PG-13, R, etc...)
How can we show the types of ratings we have available?'

SELECT DISTINCT rating FROM film;

'COUNT returns the number of input rows that match a specific condition of a query'

SELECT COUNT(*) FROM payment;

SELECT COUNT(amount) FROM payment;

SELECT COUNT (DISTINCT amount) FROM payment;

/* We need to call parentheses and specify that distinct amount should happen first,
because we want to count the distinct values in the "amount" column */

'SELECT WHERE'

SELECT * FROM customer
WHERE first_name = 'Jared';

SELECT * FROM film
WHERE rental_rate > 4 
AND replacement_cost >= 19.99
AND rating = 'R';

SELECT COUNT (*) FROM film
WHERE rating = 'R';

SELECT COUNT (*) FROM film
WHERE rating != 'R';
/* the "!=" means 'not equal'*/

SELECT COUNT(*) FROM customer
WHERE first_name = 'Jared';

/* Challenge Nº1
A customer forgot their wallet at our store! We need to track down their email to inform them.
What is the email for the customer with the name Nancy Thomas?*/

SELECT * FROM customer;

SELECT email FROM customer
WHERE first_name = 'Nancy'
AND last_name = 'Thomas';

/* Challenge Nº2
A customer wants to know what the movie "Outlaw Hanky" is about.
Could you give them the description of the movie "Outlaw Hanky"?*/

SELECT * FROM film;

SELECT description FROM film
WHERE title = 'Outlaw Hanky';

/* Challenge Nº3
A customer is late on their movie return, and we've mailed them a letter to their address at
"259 Ipoh Drive". We should also call them on the phone to let them know.
Can you get the phone number for the customer who lives at "259 Ipoh Drive"?*/

SELECT * FROM address;

SELECT phone FROM address
WHERE address = '259 Ipoh Drive';

'ORDER BY'

SELECT * FROM address;

SELECT district, address, address2 FROM address
Order BY district ASC;

SELECT * FROM customer
ORDER BY first_name DESC;

SELECT * FROM customer
ORDER BY store_id;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;

/*You can order by a column which is not in SELECT but is part of the table*/

SELECT first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;

'LIMIT'

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC
LIMIT 5;

/* We can use LIMIT 1 just to see how the table looks like*/

SELECT * FROM payment
LIMIT 1;

'Challenge ORDER BY'
/*We want to reward our first 10 paying customers. What are the customers ids of
the first 10 customers who created a payment?*/

SELECT * FROM payment;

SELECT customer_id FROM payment
ORDER BY payment_date ASC
LIMIT 10;

/*A customer wants to quickly rent a video to watch over their short lunch break.
What are the titles of the 5 shortest (in lenght of runtime) movies?*/

SELECT * FROM film;

SELECT title FROM film
ORDER BY length ASC
LIMIT 5;

SELECT title, length FROM film
ORDER BY length ASC
LIMIT 5;

/*If the previous customer can watch any movie that is 50 minutes or less in run
time, how many options does she have?*/

SELECT COUNT (title) FROM film
WHERE length <= 50;

'Between'

SELECT * FROM payment
LIMIT 2;

SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9;

'total number of transactions'

SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 8 AND 9;

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

/*When dealing with a timestamp information, be aware that timestamp information includes
both the dates and our minutes, etc. So that means PostgreSQL essentially must
decide does a day start at zero hundred hours or at 2400 hours?
And if you're dealing with exclusivity versus inclusivity, that actually might affect your logic.*/

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-14';

'IN'
SELECT * FROM payment
LIMIT 2;

SELECT DISTINCT(amount) FROM payment
ORDER BY amount;

SELECT * FROM payment
WHERE amount IN (0.99,1.98,1.99);

SELECT * FROM payment
WHERE amount NOT IN (0.99,1.98,1.99);
SELECT * FROM customer
WHERE first_name IN ('John','Jake','Julie');

SELECT * FROM customer
WHERE first_name NOT IN ('John','Jake','Julie');

'LIKE & ILIKE'
'If you place a % after a letter/number, ir will pick up every row that start with that letter/number,
no matter what it comes next in that'

SELECT * FROM customer
WHERE first_name LIKE 'J%';

SELECT COUNT(*) FROM customer
WHERE first_name LIKE 'J%';

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

'If we were to lower case these, it would return nothing so, we need to use ILIKE.
ILIKE is case sensitive, it picks up regardless upper or lowercase input'

SELECT * FROM customer
WHERE first_name LIKE 'j%'
AND last_name LIKE 's%';

SELECT * FROM customer
WHERE first_name ILIKE 'j%'
AND last_name ILIKE 's%';

'if you put something between %, it will pick up rows that contains that something in between the %'

SELECT * FROM customer
WHERE first_name LIKE '%er%'

SELECT * FROM customer
WHERE first_name LIKE '%her%'

'If you place an underscore (_), it means that only one character is allowed in that space
where the underscore was placed'

SELECT * FROM customer
WHERE first_name LIKE '%_her%'

SELECT * FROM customer
WHERE first_name NOT LIKE '%_her%'

SELECT * FROM customer
WHERE first_name LIKE 'A%'
AND last_name NOT LIKE 'B%'
ORDER BY last_name;

'Aggregation Functions'

SELECT * FROM film;

SELECT MIN(replacement_cost) FROM film;

SELECT MAX(replacement_cost) FROM film;

SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film;

SELECT COUNT(*) FROM film;

SELECT AVG(replacement_cost) FROM film;

'If we want to get the average and round it to 2 decimal places'

SELECT ROUND(AVG(replacement_cost),2) FROM film;

SELECT SUM(replacement_cost) FROM film;

'GROUP BY'

SELECT customer_id FROM payment
GROUP BY customer_id;

'The following is real SQL query used to answer a real question'

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

'The following query tells me the total amount spent per staff per customer'

SELECT customer_id,staff_id,SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY staff_id,customer_id;

SELECT customer_id,staff_id,SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY SUM(amount);

'removing the time stamp information'

SELECT DATE(payment_date) FROM payment;

SELECT DATE(payment_date),SUM(amount) FROM payment
GROUP BY DATE (payment_date)
ORDER BY SUM (amount) DESC;

'GROUP BY - Challenge'
'We have 2 staff members, with staff IDs 1 and 2. We want to give a bonus to the
staff member that handled the most payments (Most in terms of number of payments processed,
not total dollar amount). How many payments did each staff member handle and who gets the bonus?'

SELECT * FROM payment;

SELECT staff_id, COUNT(amount) FROM payment
GROUP BY staff_id;
 

'Corporate HQ is conducting a study on the relationship between replacement cost and
a movie MPAA rating (e.g. G, PG, R, etc...).
What is the average replacement cost per MPAA rating?
NOTE: we may need to expand the AVG column to view correct results'

SELECT rating, ROUND(AVG(replacement_cost),2) AS average FROM film
GROUP BY rating ORDER BY rating DESC;
 

'We are running a promotion to reward our top 5 customers with coupons.
What are the customer ids of the top 5 customers by total spend?'

SELECT * FROM payment;

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;
 
'HAVING'

SELECT * FROM payment;

SELECT customer_id, SUM(amount) FROM payment
WHERE customer_id NOT IN (184,87,477)
GROUP BY customer_id;

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100;

SELECT * FROM customer;

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id;

SELECT store_id, COUNT(*) FROM customer
GROUP BY store_id;

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT(customer_id)>300;

'HAVING - Challenge tasks'
'We are launching a platinum service for our most loyal customers.
We will assign platinum status to customers that have had 40 or more transaction payments.
What customer_ids are eligible for platinum status?'

SELECT * FROM payment;

SELECT customer_id,COUNT(payment_date) FROM payment
GROUP BY customer_id
HAVING COUNT(payment_date)>=40;
 

'What are the customer ids of customers who have spent more than $100 in payment
transactions with our staff_id member 2?'

SELECT * FROM payment;

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2 GROUP BY customer_id
HAVING SUM(amount)>100
 
'ASSESSMENT TEST 1'
'COMPLETE THE FOLLOWING TASKS!'
'1. Return the customer IDs of customers who have spent at least $110 with the staff
member who has an ID of 2. The answer should be customers 187 and 148.'

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2 GROUP BY customer_id
HAVING SUM(amount)>=110

'2. How many films begin with the letter J? The answer should be 20.'

SELECT COUNT(title) FROM film
WHERE title LIKE 'J%'
 
'3. What customer has the highest customer ID number whose name starts with an
'E' and has an address ID lower than 500? The answer is Eddie Tomlin'

SELECT * FROM customer;

SELECT first_name, last_name FROM customer
WHERE first_name LIKE 'E%' AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;
 
'AS statement'

SELECT amount AS renta_pricel FROM payment;

SELECT SUM(amount) AS net_revenue FROM payment;

SELECT COUNT(amount) FROM payment;

SELECT COUNT(amount) AS num_transactions FROM payment;

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount) AS total_spent FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100;

'Because the AS statement is used in the very end, we cannot use the new column name
in the HAVING statement, we must always use the original column name.
The below will not run. We cannot use them on the WHERE nor on the HAVING clauses'

SELECT customer_id, SUM(amount) AS total_spent FROM payment
GROUP BY customer_id
HAVING total_spent>100;

SELECT customer_id, amount AS new_name FROM payment
WHERE new_name > 2;

SELECT customer_id, amount AS new_name FROM payment
WHERE amount > 2;

/* Introduction to JOINS
JOINS will allow us to combine information from multiple tables together.
The main reason for the different JOIN types is to decide how to deal with information
only present in one of the joined tables.

•	INNER JOINS
o	Inner join returns the rows that match in both tables
 
•	OUTER JOINS
•	FULL JOINS
o	Full join returns whole rows from both tables
 
•	UNIONS
•	LEFT JOINS
o	Left join returns all rows from the left table
 
•	RIGHT JOINS
o	Right join returns all rows from the right table*/
 

/*‘INNER JOINS’
'Let us imagine a simple example. Our company is holding a conference for people
in the movie rental industry. We will have people register online beforehand and then
login the day of the conference'*/
 
SELECT * FROM TableA
INNER JOIN TableB
ON TableA.col_match = TableB.col_match

SELECT * FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

/* If we use the SELECT statement to get the columns from both tables,
then we can specify which column from which table should appear.
As follow, you can see that we are using the payment.customer_id to get
the column “customer_id” from table “payment”.*/

SELECT payment_id,payment.customer_id,first_name FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

/*The following syntax is the same as the above, even if we change the FROM and INNER JOIN tables,
because the intersection of data between them is the same:*/

SELECT payment_id,payment.customer_id,first_name FROM customer
INNER JOIN payment
ON payment.customer_id = customer.customer_id

/* INNER JOIN will only join customers that are found in both “payment” and the “customer” table.*/

-- ‘FULL OUTER JOIN’

SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match

/*This will grab everything whether it is present in one table or all tables*/

-- FULL OUTER JOIN with WHERE’
/* Get rows unique to either table (rows not found in both tables). The following will grab
everything in TableA and TableB except the data that matches!*/

SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableA.id IS null OR TableB.id IS null

 
-- FULL OUTER JOIN
-- LEFT OUTER JOIN -> Opposite of RIGHT OUTER JOIN
-- RIGHT OUTER JOIN -> Opposite of LEFT OUTER JOIN

/*'Let us get every single row found in every single table'*/

SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id=payment.customer_id;

/* 'We are going to fully join the customer table and the payment table where those
customer ids join up and we are going to filter it to find rows that are either
unique to the customer table or to the payment table. This will return empty results,
which means that we do not have any payment information not associated with some customer
and we do not have any customer email information who has never made a payment'*/

SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null OR payment.payment_id IS null;

SELECT COUNT(DISTINCT customer_id) FROM customer;

-- LEFT OUTER JOIN

SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.col_match=TableB.col_match
 
/*Order matters for LEFT OUTER JOIN! So, beware where you are typing the table on which statement.*/

SELECT * FROM inventory;

/*Next, the following statement shows all the films that we do not have in inventory:*/

SELECT film.film_id, title, inventory_id FROM film
LEFT OUTER JOIN inventory ON inventory.film_id=film.film_id
WHERE inventory.film_id IS null;

-- RIGHT JOINS
/*A RIGHT JOIN is essentially the same as a LEFT JOIN, except the tables are switched.
This would be the same as switching the table order in a LEFT OUTER JOIN.*/

SELECT * FROM TableA
RIGHT OUTER JOIN TableB
ON TableA.col_match=TableB.col_match

 
SELECT * FROM TableA
RIGHT OUTER JOIN TableB
ON TableA.col_match=TableB.col_match
WHERE TableA.id IS null

/* It’s up to you and how you have the tables organized “in your mind”
when it comes to choosing a LEFT vs RIGHT join, since depending on the table order you specify
in the JOIN, you can perform duplicate JOINs with either method.*/

-- UNIONS
/*The UNION operator is used to combine the result-set of two or more SELECT statements.
It basically serves to directly concatenate two results together, essentially “pasting” them together.*/
 
SELECT * FROM Sales2021_Q1

--UNION
SELECT * FROM Sales2021_Q2;

/*The above will grab the results from the first query Q1 and paste them
on top of the second query Q2.*/

-- JOIN Challenges
/*Problem 1
California sales tax laws have changed and we need to alert our customers to this through email.
What are the emails of the customers who live in California?*/

SELECT district, email FROM address
INNER JOIN customer
ON address.address_id=customer.address_id
WHERE district='California';

/*which, due to the fact that we are doing an INNER JOIN, is the same thing as saying*/

SELECT district, email FROM customer
INNER JOIN address
ON address.address_id=customer.address_id
WHERE district='California';
 

/*Problem 2
A customer walks in and is a huge fan of the actor “Nick Wahlberg” and wants to know
which movies he is in. Get a list of all the movies “Nick Wahlberg” has been in.
NOTE: In this case, we will have to use two joins, so, for that, we need to create an indentation,
as shown below. We will also need to use 3 tables:*/

SELECT * FROM film;

SELECT * FROM film_actor;

SELECT * FROM actor;

SELECT title, first_name, last_name FROM actor
	INNER JOIN film_actor
		ON actor.actor_id=film_actor.actor_id
	INNER JOIN film
		ON film_actor.film_id=film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'
ORDER BY title ASC;

/*We can also us “AS” function to rename the columns:*/

SELECT title AS “Title”, first_name AS “First Name”, last_name AS “Last Name” FROM actor
	INNER JOIN film_actor
		ON actor.actor_id=film_actor.actor_id
	INNER JOIN film
		ON film_actor.film_id=film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'
ORDER BY title ASC;

-- Advanced SQL Commands
-- Timestamps and Extract
/*In this section, we will go over a few commands that report back time and date information.
These will be more useful when creating our own tables and databases,
rather than when querying a database. PostgreSQL can hold date and time information:
•	TIME: Contains only time
•	DATE: Contains only date
•	TIMESTAMP: Contains date and time
•	TIMESTAMPTZ: Contains time, date, and time zone

Careful considerations should be made when designing a table and database and choosing a time data type. Depending on the situation you may or may not need the full level of TIMESTAMPTZ. Remember, you can always remove historical information, but you cannot add it!
o	TIMEZONE
o	NOW
o	TIMEOFDAY
o	CURRENT_TIME
o	CURRENT_DATE

SHOW: shows the value of a run-time parameter. SHOW will display the current setting of run-time parameters. These variables can be set using the SET statement, by editing the postgresql.conf configuration file, through the PGOPTIONS environmental variable (when using libpq or a libpq-based application), or through command-line flags when starting the postgres server.
If you type SHOW ALL, it will show you all the names of the parameters and their respective description:
 
If we run the following, we will get the current timestamp of the zone our machine is:*/

SELECT NOW ();

SELECT TIMEOFDAY ();
 
SELECT CURRENT_TIME;
 
SELECT CURRENT_DATE;
 
/*Let’s explore extracting information from a time-based data type using:*/

EXTRACT()

AGE()

TO_CHAR()

-- EXTRACT()
/*Allows you to “extract” or obtain a sub-component of a date value
•	YEAR
o	EXTRACT(YEAR FROM date_col)
•	MONTH
•	DAY
•	WEEK
•	QUARTER

NOTE: to check the tables that are in the database we are working, we can write and execute the following:
SELECT datname FROM pg_database;*/
 
SELECT EXTRACT(YEAR FROM payment_date) FROM payment;
 
SELECT EXTRACT(YEAR FROM payment_date) AS "Year" FROM payment;
 
SELECT EXTRACT(MONTH FROM payment_date) AS "pay_month" FROM payment;
 
/* For example, what quarter did the payment happened?*/

SELECT EXTRACT(QUARTER FROM payment_date) AS "pay_month" FROM payment;
 
-- AGE()
/* Calculates and returns the current age given a timestamp
•	Usage
o	AGE(date_col)
•	Returns
o	13 year 1 mon 5 days 01:34:13.003423*/

SELECT AGE(payment_date) FROM payment;

/* TO_CHAR()
General function to convert data types to text. Useful for timestamp formatting.
•	Usage
o	TO_CHAR(date_col,’mm-dd-yyyy’)*/

SELECT TO_CHAR(payment_date, 'text') FROM payment;
 
SELECT TO_CHAR(payment_date, 'mon/dd/yyyy') FROM payment;
 
SELECT TO_CHAR(payment_date, 'mm/dd/yyyy') FROM payment;
 
SELECT TO_CHAR(payment_date, 'mm.dd.yyyy') FROM payment;
 
SELECT TO_CHAR(payment_date, 'dd-mm-yyyy') FROM payment;
 
-- Formatting Functions
/*Pattern	Description
HH	hour of day (01–12)
HH12	hour of day (01–12)
HH24	hour of day (00–23)
MI	minute (00–59)
SS	second (00–59)
MS	millisecond (000–999)
US	microsecond (000000–999999)
FF1	tenth of second (0–9)
FF2	hundredth of second (00–99)
FF3	millisecond (000–999)
FF4	tenth of a millisecond (0000–9999)
FF5	hundredth of a millisecond (00000–99999)
FF6	microsecond (000000–999999)
SSSS, SSSSS	seconds past midnight (0–86399)
AM, am, PM or pm	meridiem indicator (without periods)
A.M., a.m., P.M. or p.m.	meridiem indicator (with periods)
Y,YYY	year (4 or more digits) with comma
YYYY	year (4 or more digits)
YYY	last 3 digits of year
YY	last 2 digits of year
Y	last digit of year
IYYY	ISO 8601 week-numbering year (4 or more digits)
IYY	last 3 digits of ISO 8601 week-numbering year
IY	last 2 digits of ISO 8601 week-numbering year
I	last digit of ISO 8601 week-numbering year
BC, bc, AD or ad	era indicator (without periods)
B.C., b.c., A.D. or a.d.	era indicator (with periods)
MONTH	full upper case month name (blank-padded to 9 chars)
Month	full capitalized month name (blank-padded to 9 chars)
month	full lower case month name (blank-padded to 9 chars)
MON	abbreviated upper case month name (3 chars in English, localized lengths vary)
Mon	abbreviated capitalized month name (3 chars in English, localized lengths vary)
mon	abbreviated lower case month name (3 chars in English, localized lengths vary)
MM	month number (01–12)
DAY	full upper case day name (blank-padded to 9 chars)
Day	full capitalized day name (blank-padded to 9 chars)
day	full lower case day name (blank-padded to 9 chars)
DY	abbreviated upper case day name (3 chars in English, localized lengths vary)
Dy	abbreviated capitalized day name (3 chars in English, localized lengths vary)
dy	abbreviated lower case day name (3 chars in English, localized lengths vary)
DDD	day of year (001–366)
IDDD	day of ISO 8601 week-numbering year (001–371; day 1 of the year is Monday of the first ISO week)
DD	day of month (01–31)
D	day of the week, Sunday (1) to Saturday (7)
ID	ISO 8601 day of the week, Monday (1) to Sunday (7)
W	week of month (1–5) (the first week starts on the first day of the month)
WW	week number of year (1–53) (the first week starts on the first day of the year)
IW	week number of ISO 8601 week-numbering year (01–53; the first Thursday of the year is in week 1)
CC	century (2 digits) (the twenty-first century starts on 2001-01-01)
J	Julian Date (integer days since November 24, 4714 BC at local midnight; see Section B.7)

Q	quarter
RM	month in upper case Roman numerals (I–XII; I=January)
rm	month in lower case Roman numerals (i–xii; i=January)
TZ	upper case time-zone abbreviation (only supported in to_char)
tz	lower case time-zone abbreviation (only supported in to_char)
TZH	time-zone hours
TZM	time-zone minutes
OF	time-zone offset from UTC (only supported in to_char)

Modifier	Description	Example
FM prefix	fill mode (suppress leading zeroes and padding blanks)	FMMonth
TH suffix	upper case ordinal number suffix	DDTH, e.g., 12TH
th suffix	lower case ordinal number suffix	DDth, e.g., 12th
FX prefix	fixed format global option (see usage notes)	FX Month DD Day
TM prefix	translation mode (use localized day and month names based on lc_time)
TMMonth
SP suffix	spell mode (not implemented)	DDSP*/

-- Timestamps and Extract
-- Challenge Tasks

/*During which month did the payments occur?
Format your answer to return back the full month name.*/

SELECT DISTINCT(TO_CHAR(PAYMENT_DATE,'MONTH'))
FROM PAYMENT;

-- How many payments occured on a Monday?
/*"Day of Week" (DOW) keyword returns a numeric value (1 to 7) representing
the day of the week for a specified date or datetime.
PostgreSQL considers Sunday the start of a week (indexed at 0)*/

SELECT COUNT(*) FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1;

SELECT * FROM film;

SELECT rental_rate/replacement_cost FROM film

SELECT ROUND(rental_rate/replacement_cost,4)*100 AS percent_cost FROM film

-- Let's imagine for some reason you wanted to just put small deposits down of 10% of the replacement cost:
SELECT 0.1 * replacement_cost AS deposit FROM film

SELECT * FROM customer

-- Length
SELECT LENGTH(first_name) FROM customer

-- Concatenate
SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name FROM customer

-- Well, often if you work at a company, you may realize this, but there's an email method where you
-- just take the first letter of the first name and then add in their last name and then add in something
-- like @companyname.com
SELECT first_name || last_name || '@gmail.com' FROM customer
SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com' AS custom_email FROM customer
SELECT LOWER(first_name) || '.' || LOWER(last_name) || '@gmail.com' AS custom_email FROM customer

-- A subquery allows you to construct more complex queries, essentially performing a query on the results
-- of another query or using the results of another query.
-- The syntax is relatively straightforward and involves the use of to select statements.

SELECT student,grade FROM test_scores
SELECT AVG(grade) FROM test_scores

-- How can we get a list of students who scored better than the average grade?

SELECT student,grade FROM test_scores
WHERE grade > (SELECT AVG(grade) FROM test_scores)

-- Note that the subquery is performed first since it is inside the paranthesis
-- We can also use the IN operator in conjunction with a subquery to check against multiple results returned

SELECT * FROM film
SELECT AVG(rental_rate) FROM film

-- Let's put them together now:

SELECT title,rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)

-- Now, what if we what to get data from another table and use it as a subquery?

SELECT * FROM inventory
SELECT * FROM rental

SELECT * FROM rental
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'

SELECT inventory.film_id FROM rental
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'

SELECT film_id,title FROM film
WHERE film_id IN
(SELECT inventory.film_id FROM rental
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')

-- Let's now check an example with the EXIST statement
-- So let's check the first and last names of people who have at least one payment whose amount > $11.

SELECT first_name, last_name FROM customer AS c
WHERE EXISTS
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11)

-- A self-join is a query in which a table is joined to itself.
-- Self-joins are useful for comparing values in a column of rows within the same table.
-- The self-join can be viewed as a join of two copies of the same table

SELECT * FROM film

SELECT title, length FROM film
WHERE length = 117

SELECT f1.title, f2.title, f1.length FROM film AS f1
INNER JOIN film AS f2
ON f1.film_id != f2.film_id
AND f1.length = f2.length

-- Assessment Test #2

SELECT * FROM cd.bookings;
SELECT * FROM cd.facilities;
SELECT * FROM cd.members;

-- 1. How can you retrieve all the information from the cd.facilities table?

SELECT * FROM cd.facilities

-- 2. You want to print out a list of all the facilities and their cost to members.
-- How would you retrieve a list of only facility names and costs?

SELECT name, membercost FROM cd.facilities

-- 3. How can you produce a list of facilities that charge a fee to members?

SELECT * FROM cd.facilities
WHERE membercost != 0

SELECT * FROM cd.facilities
WHERE membercost > 0

-- 4. How can you produce a list of facilities that charge a fee to members,
-- and that fee is less than 1/50th of the monthly maintenance cost?
-- Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.

SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost != 0
AND membercost < (monthlymaintenance/50.0)

SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost != 0
AND membercost < (1/50.0)*monthlymaintenance

SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost != 0
AND membercost < monthlymaintenance*(1/50.0)

-- 5. How can you produce a list of all facilities with the word 'Tennis' in their name?

SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%'

SELECT * FROM cd.facilities
WHERE name ILIKE '%Tennis%'

-- 6. How can you retrieve the details of facilities with ID 1 and 5?
-- Try to do it without using the OR operator.

SELECT * FROM cd.facilities
WHERE facid = 1 or facid = 5

SELECT * FROM cd.facilities
WHERE facid IN ('1','5')

-- 7. How can you produce a list of members who joined after the start of September 2012?
-- Return the memid, surname, firstname, and joindate of the members in question.

SELECT memid, surname, firstname, joindate FROM cd.members
WHERE joindate >'2012-08-31'

-- 8. How can you produce an ordered list of the first 10 surnames in the members table?
-- The list must not contain duplicates.

SELECT DISTINCT (surname) FROM cd.members
ORDER BY surname ASC LIMIT 10

-- 9. You'd like to get the signup date of your last member.
-- How can you retrieve this information?

SELECT joindate FROM cd.members
ORDER BY joindate DESC LIMIT 1

SELECT MAX(joindate) FROM cd.members

-- 10. Produce a count of the number of facilities that have a cost to guests of 10 or more.

SELECT COUNT(*) FROM cd.facilities
WHERE guestcost >= 10

SELECT * FROM cd.facilities
WHERE guestcost >= 10

SELECT COUNT(facid) FROM cd.facilities
WHERE guestcost >= 10

-- 11. Produce a list of the total number of slots booked per facility in the month of September 2012.
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.

SELECT * FROM cd.bookings

SELECT facid, SUM(slots) AS Total_Slots FROM cd.bookings
WHERE starttime >= '2012-09-01' AND starttime <= '2012-10-01'
GROUP BY facid
ORDER BY SUM(slots)

SELECT facid, SUM(slots) AS Total_Slots FROM cd.bookings
WHERE EXTRACT (MONTH FROM starttime) = 09
GROUP BY facid
ORDER BY Total_Slots

-- 12. Produce a list of facilities with more than 1000 slots booked.
-- Produce an output table consisting of facility id and total slots, sorted by facility id.

SELECT facid, SUM(slots) AS total_slots FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid

-- 13. How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'?
-- Return a list of start time and facility name pairings, ordered by the time.

SELECT * FROM cd.bookings
SELECT * FROM cd.facilities

SELECT cd.bookings.starttime, cd.facilities.name FROM cd.facilities
INNER JOIN cd.bookings
ON cd.facilities.facid = cd.bookings.facid
WHERE cd.facilities.facid IN (0,1)
	AND cd.bookings.starttime >= '2012-09-21'
	AND cd.bookings.starttime < '2012-09-22'

SELECT starttime, facilities.name FROM cd.bookings AS bookings
INNER JOIN cd.facilities AS facilities
ON bookings.facid = facilities.facid
WHERE
	EXTRACT (MONTH FROM starttime) = 09
	AND EXTRACT (DAY FROM starttime) = 21
	AND facilities.name LIKE 'Tennis Court%'
ORDER BY starttime

-- 14. How can you produce a list of the start times for bookings by members named 'David Farrell'?

SELECT * FROM cd.bookings;
SELECT * FROM cd.members;

SELECT cd.bookings.starttime FROM cd.bookings
INNER JOIN cd.members
	ON cd.members.memid = cd.bookings.memid
WHERE cd.members.firstname = 'David'
	AND cd.members.surname = 'Farrell'

SELECT starttime FROM cd.bookings AS bookings
INNER JOIN cd.members AS members
ON bookings.memid = members.memid
WHERE members.surname = 'Farrell' AND members.firstname = 'David'

SELECT DISTINCT(COUNT(starttime)) FROM cd.bookings AS bookings
INNER JOIN cd.members AS members
ON bookings.memid = members.memid
WHERE members.surname = 'Farrell' AND members.firstname = 'David'

SELECT starttime FROM cd.bookings AS bookings
INNER JOIN cd.members AS members
ON bookings.memid = members.memid
WHERE members.firstname || ' ' || members.surname = 'David Farrell'

-- Creating DATABASES and TABLES
/* Based on the limitations, you may think it makes sense to store it as a BIGINT data type,
but we should really be thinking what is best for the situation. Why bother with numeric at all?
We don't perform arithmetic with numbers, so it probably makes more sense as a VARCHAR data type instead

Searching for best practices online, the general consense is that
it's usually recommended to store as a text based data type due to a variety of issues, such as,
no arithmetic performed, and leading zeros could cause issues, for example, 7 and 07 treated as
same numerically, but are not the same phone number.
Let's create the table "account"*/

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR (50) UNIQUE NOT NULL,
	password VARCHAR (50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	create_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
)

-- Let's create a table called "job"

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR (200) UNIQUE NOT NULL
)

-- Let's create the table "account_job", a table that has references to the "account" and the "job" tables:

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)

-- Now, we are going to insert data into our tables:

INSERT INTO account (username, password, email, create_on)
VALUES ('Jose','password','jose@mail.com',CURRENT_TIMESTAMP)

SELECT * FROM account

INSERT INTO job(job_name)
VALUES ('Astronaut')

SELECT * FROM job

-- When adding another job title, the data will populate the next row:

INSERT INTO job(job_name)
VALUES ('President')

SELECT * FROM job

-- Let's go ahead and do one connection for an account job, essentially assigning the account.
-- I've made myself to a job that's going to be a little different because we have that foreign key set for us.

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
	(1,1,CURRENT_TIMESTAMP)
	
SELECT * FROM account_job

-- What happens if we try to add information for a user that is still not available?
-- Basically, adding a FKEY related to a PKEY row that has not been created yet? 

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
	(10,10,CURRENT_TIMESTAMP)

-- Let's now UPDATE the values
-- If we check the "last_login" column, the value is null, let's fix that

SELECT * FROM account

UPDATE account
SET last_login = CURRENT_TIMESTAMP

UPDATE account
SET last_login = create_on

-- Let's go ahead and change the hire_dates based off another table.

SELECT * FROM account_job
SELECT * FROM account

UPDATE account_job
SET hire_date = account.create_on
FROM account
WHERE account_job.user_id = account.user_id

-- What if we what to checl whatever columns we are interested in updating?
-- Using the statement RETURNING to clarify or double check our results went through.
-- The RETURNING statement returns the immediate action, if you run it again, it will be different,
-- based on what that action is (check DELETE example further below)

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, create_on, last_login

-- Let's have a look at the DELETE statement

SELECT * FROM job

INSERT INTO job(job_name)
VALUES
	('Cowboy')
	
DELETE FROM job
WHERE job_name = 'Cowboy'
RETURNING job_id,job_name

-- In PostgreSQL, the ALTER TABLE command performs different functionalities on a table.
-- For example, the ALTER TABLE statement can ADD, DROP, or UPDATE the table columns.
-- Moreover, it allows us to add or remove constraints to a table.
-- So, all in all, we can say that the ALTER TABLE command is used to change/modify the table structure.

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
)

SELECT * FROM information

ALTER TABLE information
RENAME TO new_info

SELECT * FROM new_info

ALTER TABLE new_info
RENAME COLUMN person TO people

-- let's remove a constraint...

INSERT INTO new_info(title)
VALUES
	('some new title')
	
ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL

-- How to DROP Table?
-- The DROP allows for a complete removal of a column in a table

ALTER TABLE new_info
DROP COLUMN people

ALTER TABLE new_info
DROP COLUMN IF EXISTS people

-- A CHECK constraint is a kind of constraint that allows you to specify if values in a column must meet a specific requirement.
-- The CHECK constraint uses a Boolean expression to evaluate the values before they are inserted or updated to the column.
-- If the values pass the check, PostgreSQL will insert or update these values to the column.
-- Otherwise, PostgreSQL will reject the changes and issue a constraint violation error.

CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birthdate),
	salary INTEGER CHECK (salary > 0)
)

INSERT INTO employees (first_name, last_name, birthdate, hire_date, salary)
VALUES
	('Joao', 'Andrade','1900-11-03','2010-01-01',100)

INSERT INTO employees (first_name, last_name, birthdate, hire_date, salary)
VALUES
	('Sammy', 'Smith','1900-11-03','2010-01-01',100)
	
SELECT * FROM employees

-- Assessment Test #3
/*Let's create a new database called "School" with two tables: "teachers" and "students".
The students table should have columns for student_id, first_name,last_name, homeroom_number, phone,email, and graduation year.
The teachers table should have columns for teacher_id, first_name, last_name, homeroom_number, department, email, and phone.
The table constraints do have to consider the following:
- We must have a phone number to contact students in case of an emergency.
- We must have ids as the primary key of the tables
- Phone numbers and emails must be unique to the individual.
Once the tables are ready, insert a student named Mark Watney (student_id=1) who has a phone number of 777-555-1234 and doesn't have an email. He graduates in 2035 and has 5 as a homeroom number.
Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number of 5 and is from the Biology department. His email is jsalk@school.org and phone number 777-555-4321.*/

--Table "students"

CREATE TABLE students(
	student_id INTEGER PRIMARY KEY NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number INTEGER,
	phone INTEGER NOT NULL UNIQUE,
	email VARCHAR(50) UNIQUE,
	graduation_year DATE NOT NULL
)

INSERT INTO students
	(student_id, first_name,last_name, homeroom_number, phone, graduation_year)
VALUES (
	1, 'Mark','Watney', 5, 777-555-1234, '2035'
)

ALTER TABLE students
ALTER COLUMN graduation_year DROP NOT NULL

ALTER TABLE students
ALTER COLUMN graduation_year TYPE INTEGER
USING graduation_year::INTEGER

-- I cannot alter the graduation_year column, so I'm going to DROP the column and add
-- the column again as a INTEGER

ALTER TABLE students
DROP COLUMN graduation_year 

SELECT * FROM students

ALTER TABLE students
ADD COLUMN graduation_year INTEGER NOT NULL

-- The phone number does not come up correct
-- Let's fix that

ALTER TABLE students
ALTER COLUMN phone TYPE TEXT

UPDATE students
SET phone = '777-555-1234'
WHERE student_id = 1

-- Table "teachers"

CREATE TABLE teachers(
	teacher_id INTEGER PRIMARY KEY NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number INTEGER,
	department VARCHAR (50),
	email VARCHAR(50) UNIQUE,
	phone INTEGER NOT NULL UNIQUE
)

ALTER TABLE teachers
ALTER COLUMN phone TYPE TEXT

INSERT INTO teachers
	(teacher_id, first_name,last_name, homeroom_number, department, email, phone)
VALUES (
	1, 'Jonas','Salk', 5, 'Biology', 'jsalk@school.org','777-555-4321'
)

SELECT * FROM teachers

-- Another way to resolve Assessment #3

CREATE TABLE students(
	student_id serial PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL, 
	homeroom_number integer,
	phone VARCHAR(20) UNIQUE NOT NULL,
	email VARCHAR(115) UNIQUE,
	grad_year integer
);

CREATE TABLE teachers(
	teacher_id serial PRIMARY KEY,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL, 
	homeroom_number integer,
	department VARCHAR(45),
	email VARCHAR(20) UNIQUE,
	phone VARCHAR(20) UNIQUE
);

INSERT INTO students(first_name,last_name, homeroom_number,phone,grad_year)
VALUES ('Mark','Watney',5,'7755551234',2035);

INSERT INTO teachers(first_name,last_name, homeroom_number,department,email,phone)
VALUES ('Jonas','Salk',5,'Biology','jsalk@school.org','7755554321');

-- Conditional Expressions & Procedures
-- CASE statement

SELECT customer_id,
CASE
	WHEN (customer_id <= 100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
	ELSE 'Normal'
END AS customer_class
FROM customer

/* In the following example, if we place the column "customer_id" in front of the CASE statement,
the WHEN statements will always refer to it, so no need to type it. Obviously, this case is not as
flexible as the general case but it's faster to type out*/

SELECT customer_id,
CASE customer_id
	WHEN 2 THEN 'Winner'
	WHEN 5 THEN 'Second Place'
	ELSE 'Normal'
END AS raffle_results
FROM customer

/* Let's make some categories for rental_rate*/

SELECT * FROM film

SELECT rental_rate,
CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END
FROM film

/* Let's now use the SUM statement to check how many of the 0.99 cents movies we have.
IF we take the sum of the previous CASE statement, then it's going to sum all the ones for every
time there's a $0.99, essentially counting how many 99 cent movies we have.*/

SELECT
SUM(CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END) AS number_of_bargains
FROM film

/*What what if we want to now do this for different categories, such as bargains and regular prices?
We can keep doing this as if there were more columns.*/

SELECT
SUM(CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END) AS bargains,
SUM(CASE rental_rate
   	WHEN 2.99 THEN 1
   ELSE 0
END) AS regular,
SUM(CASE rental_rate
   	WHEN 4.99 THEN 1
   ELSE 0
END) AS premium,
COUNT(rental_rate) AS total_movies
FROM film

-- CASE: Challenge Task
/*We want to know and compare the various amounts of films we have per movie rating
Use the CASE and the dvdrental database to achieve this*/

/*My solution*/

SELECT * FROM film

SELECT rating FROM film
GROUP BY rating

SELECT
COUNT(CASE
	WHEN (rating = 'R') THEN 1
END) AS R,
COUNT(CASE
	WHEN (rating = 'PG') THEN 1
END) AS PG,
COUNT(CASE
	WHEN (rating = 'PG-13') THEN 1
END) AS "PG-13"
FROM film

/*Instructor's solution*/

SELECT
SUM(
CASE rating
	WHEN 'R' THEN 1 ELSE 0
END) AS r,
SUM(
CASE rating
	WHEN 'PG' THEN 1 ELSE 0
END) AS pg,
SUM(
CASE rating
	WHEN 'PG-13' THEN 1 ELSE 0
END) AS pg13
FROM film

-- COALESCE
/*The COALESCE function accepts an unlimited number of arguments. It returns the first argument that is not null.
If all arguments are null, the COALESCE function will return null.
The COALESCE function evaluates arguments from left to right until it finds the first non-null argument.
All the remaining arguments from the first non-null argument are not evaluated.
The COALESCE function provides the same functionality as NVL or IFNULL function provided by SQL-standard.
MySQL has IFNULL function, while Oracle provides NVL function.*/

/* For the COASLESCE example, we are going to create a simple table with item, price and discount*/

DROP TABLE IF EXISTS cd.coalesce_example

CREATE TABLE cd.coalesce_example (
	item TEXT,
	price INT,
	discount INT
)

INSERT INTO cd.coalesce_example (item, price, discount)
VALUES
	('A',100,20),
	('B',300,null),
	('C',200,10)
	
SELECT * FROM cd.coalesce_example

/*What's the final price?*/

SELECT item,(price - discount) AS final_price FROM cd.coalesce_example

/*Since the discount was null from item B, the result will result as null as well.
How to overcomer this? This is where COALESCE comes into play*/

SELECT item,(price - COALESCE(discount,0)) AS final_price FROM cd.coalesce_example

-- CAST
/*PostgreSQL CAST operator allows you to convert a value of one data type into another.*/

SELECT CAST('5' AS INTEGER) AS new_integer
SELECT CAST('five' AS INTEGER) AS new_integer

/*In PostgreSQL, we can also write it as follow:*/

SELECT '5'::INTEGER
SELECT 'five'::INTEGER

SELECT * FROM rental

SELECT CAST(inventory_id AS VARCHAR) FROM rental

SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) FROM rental

-- NULLIF
/*The NULLIF function returns a null value if argument_1 equals to argument_2, otherwise it returns argument_1.*/

/*Given this table calculate the ratio of Department A to Department B
We can see that the ratio of A to B is 2:1 or 200%.
We can use SQL to solve this with CASE*/

CREATE TABLE depts(
first_name VARCHAR(50),
department VARCHAR(50)
)

INSERT INTO depts (first_name, department)
VALUES
	('Lauren','A'),
	('Vinton','B'),
	('Claire','B')

/*I made a mistake and need to update Vinton's department = A*/

UPDATE depts
SET department = 'A'
WHERE first_name = 'Vinton'
	
SELECT * FROM depts
ORDER BY department

/*Let's calculate the ratio between male and female members*/

SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END)
) AS department_ratio
FROM depts

/*Now, what happens if there are no more people in department B?*/

DELETE FROM depts
WHERE department = 'B'

/*If you now run the code again, you'll notice that we will get an error because
we are now dividing by zero, which is impossible to divide something by nothing.
In this case, we should use a NULLIF in the second argument*/

SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END)
) AS department_ratio
FROM depts

SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
NULLIF(SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END),0)
) AS department_ratio
FROM depts

-- VIEWS
/*Often there are specific combinations of tables and conditions that you find yourself using quite often for a project.
Instead of having to perform the same query over and over again as a starting point,
you can create a VIEW to quickly see this query with a simple call*/

SELECT * FROM customer

SELECT * FROM address

SELECT first_name, last_name, address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

/*To create a VIEW for the above INNER JOIN, we need to wrap it around
a VIEW statement and give it a name*/

CREATE VIEW customer_info AS
SELECT first_name, last_name, address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

SELECT * FROM customer_info

/*What if we need to replace a VIEW?
We can do this by simply using the CREATE OR REPLACE VIEW.
NOTE: you can also create a view using the following syntax*/

CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district FROM customer
INNER JOIN address
ON customer.address_id = address.address_id

/*We can also ALTER VIEW or DROP VIEW*/

DROP VIEW customer_info

ALTER VIEW customer_info RENAME TO c_info

SELECT * FROM c_info

DROP VIEW c_info

-- IMPORT & EXPORT
/*VERY IMPORTANTE NOTE: The Import command DOES NOT create a table for you.
It assumes a table is already created.
Currently there is no automated way within pgAdmin to create a table directly from a .csv file*/

CREATE TABLE simple(
a int,
b int,
c int
)

SELECT * FROM simple