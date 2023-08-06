
-- Querying Data


-- SELECT Clause to retrive data

-- Selecting all columns using * which is callled star or astrisk
SELECT * 
FROM customers;

-- Selecting first_name and country column from customers table
SELECT
	first_name,
    country
FROM customers;       

-- Selecting unique values from table using DISTINCT Keyword
SELECT DISTINCT
	country
FROM customers;
    
-- ORDER BY clause for sorting the data by score (smallest first)
SELECT *
FROM customers
ORDER BY score;

-- Sorting by score (highest first)
SELECT *
FROM customers
ORDER BY score DESC;

-- Sorting the result by country (alphbetically) and then by score (highest first)
SELECT *
FROM customers
ORDER BY country ASC, score DESC;





-- Filtering Data


-- WHERE keyword used to filter rows based on specified conditions
-- WHERE keyword use Comparison and Logical operators

-- Comparison operators

-- filter only german customers using equal to operator
SELECT *
FROM customers
WHERE country = 'Germany';

-- filter only customers whose score more than 500 using greater-than operator
SELECT * 
FROM customers
WHERE score > 500;


-- filter only customers whose score more than 500 using less-than operator
SELECT *
FROM customers
WHERE score < 500;

-- filter only customers whose scorew is less than or equal to 500
SELECT *
FROM customers
WHERE score <= 500;

-- filter only customers whose scorew is greater than or equal to 500
SELECT *
FROM customers
WHERE score >= 500;

-- find all non-german customers using not equal to operator(=! or <>)
SELECT * 
FROM customers
WHERE country != 'Germany';


-- Logical operator
   -- AND -- Returns True if both conditions are true
   -- OR -- Returns True if one of condition is true
   -- NOT  Reverse the result of any Boolean operator 

-- select customers who come from Germany and whose score is less than 400
SELECT *
FROM customers
WHERE country = 'Germany' AND score < 400;

-- select customers who come from Germany or whose score is less than 400
SELECT *
FROM customers
WHERE country = 'Germany' OR score < 400;

-- select customers  whose score is not less than 400
SELECT * 
FROM customers
WHERE NOT score < 400;

-- BETWEEN operator -- Return True if a value falls within a specific range
-- select customers  whose score is the range between 100 and 500
SELECT * 
FROM customers
WHERE score BETWEEN 100 AND 500;

-- IN operator -- Return True if a value in list of values
-- select customers whose ID is equal to 1,2 or 5
SELECT * 
FROM customers
WHERE customer_id IN (1,2,5);

-- LIKE operator Return True if a value matches the pattern
-- here wildcard (%) is used to match characters and works only on text data
-- find all customers whose name start with M
SELECT * 
FROM customers
WHERE first_name LIKE 'M%';

-- find all customers whose name start end with n
SELECT *
FROM customers
WHERE first_name LIKE '%n';

-- find all customers whose name contains r
SELECT * 
FROM customers
WHERE first_name LIKE '%r%';

-- find all customers whose name contains r at 3rd position
-- here underscore wildcard is used which matches exact character
SELECT *
FROM customers 
WHERE first_name like '__r%';

/* Wildcards take longer time to run
in complex queries, it's beter to use another operator if possible.
Second thing is that statements with wildcards take longer if used at end of search pattern,
placement of wildcards is important */


/*   Joins 
A join is an operation that combines rows from two or more tables based on a related column between them. 
The primary purpose of a join is to retrieve data from multiple tables that have a common field. 
Joins are essential when you need to create more meaningful
 and comprehensive result sets by combining information from different tables. */

-- SQL Aliases - Alias specifies a short name for a table or column.
-- AS keyword used to alias
-- for example: aliasing a table used with joins
SELECT 
C.customer_id
FROM customers AS c;

-- For example: aliasing a column
SELECT 
customer_id AS C_id
FROM customers;
 
-- INNER JOIN 
-- Return all matching rows from left and right table.

-- list customer id ,first name, order id ,quantity. exclude the customers who have not placed any orders
SELECT 
	c.customer_id,  # here c. before customer tells the database to choose col from which table
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c  # Left table in the Join is put first with FROM keyword
INNER JOIN orders AS o  # Right table is written with Join type
ON c.customer_id = o.customer_id;  # Here Joining key is defined


-- LEFT JOIN
-- Return all rows from left table and matching rows from right table
-- list customer id ,first name, order id ,quantity. Include the customers who have not placed any orders
SELECT 
	c.customer_id,  # here c. before customer tells the database to choose col from which table
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c  # Left table in the Join is put first with FROM keyword
LEFT JOIN orders AS o  # Right table is followed with Join type
ON c.customer_id = o.customer_id;  # Joining key 


-- RIGHT JOIN
-- Returns matching rows from left table and all rows from right table
SELECT 
	c.customer_id,  # here c. before customer tells the database to choose col from which table
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c  # Left table in the Join is put first with FROM keyword
RIGHT JOIN orders AS o  # Right table is followed  with Join type
ON c.customer_id = o.customer_id;   # Joining key


-- FULL JOIN
-- Returns all rows from both tables
-- FULL JOIN is not supportedby MySQL but we will work around that try to use it without FULL keyword as not present in MySQL.

-- FULL JOIN is combination of LEFT and RIGHT JOIN
-- Here in MySQL we will use UNION keyword to Stack data from LEFT and RIGHT JOIN which gives result of FULL JOIN.alter
SELECT 
	c.customer_id,  # here c. before customer tells the database to choose col from which table
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c  # Left table in the Join is put first with FROM keyword
LEFT JOIN orders AS o  # Right table is followed  with Join type
ON c.customer_id = o.customer_id;   # Joining key
UNION 
SELECT 
	c.customer_id,  # here c. before customer tells the database to choose col from which table
    c.first_name,
    o.order_id,
    o.quantity
FROM customers AS c  # Left table in the Join is put first with FROM keyword
RIGHT JOIN orders AS o  # Right table is followed  with Join type
ON c.customer_id = o.customer_id;   # Joining key


-- UNION
/*A union is an operation that combines the results of two or more SELECT queries into a single result set. 
The primary purpose of a union is to merge rows from different queries with compatible column structures. 
The column data types and the number of columns in each query must match for a union to work.*/

-- List first anme, last name and country of all persons from customers and employees
SELECT 
	first_name, # Here col names from first query will be shown in results.
    last_name,
    country
FROM customers
UNION  ALL # Here UNION gives DISTINCT rows and DISTINCT ALL gives all rows even if they .have duplicates
SELECT 
	first_name,
    last_name,
    emp_country
FROM employees;
-- NOTE : Here database care about that columns should have same data type and number of cols should be same.
		


-- SQL AGGREGATE Functions

-- COUNT Function
-- FInd the total numbers of customers
-- COUNT function do not count NULLs
-- Work on any data type

SELECT 
	COUNT(*) AS Total_Customers
FROM customers;


-- SUM Function
-- Works only with numeric columns
-- NULLs are treated as zero

SELECT SUM(quantity) AS sum_quantity
FROM orders;


-- AVERAGE Function
-- Works only with numeric cols
-- NULLs are ignored
SELECT 
	AVG(SCORE) AS avg_score
FROM customers;

-- MAX Function
-- Find the highest score in customers table
SELECT 
	MAX(score) as max_score
FROM customers;

-- Min Function
-- Find the lowest score in customers table
SELECT 
	MIN(score) AS min_score
FROM customers;



-- STRING Functions
-- Used to manipulate string values

-- CONCAT Function
-- Find full name of all customers
SELECT
	CONCAT(first_name,'-', last_name) AS Full_Name
FROM customers;

-- UPPERCASE  AND LOWERCASE Function 
-- List the first name of customers in uppercase and last name in lowercase
SELECT 
	UPPER(first_name) AS UPPER_First_Name,
	LOWER(first_name) AS LOWER_first_name
FROM customers; 


-- TRIM Functions
-- Use LTRIM to remove space frm left and RTRIM to remove space from right
-- And TRIM to remove from both side if u have on both sides
SELECT 
	TRIM(last_name) AS clean_last_name
FROM customers;


-- LENGTH Function
-- Used to find number of charaters in a string
SELECT
	LENGTH(TRIM(last_name)) AS string_length
FROM customers;


-- SUBSTRING Function
-- Syntax: SUBSTRING(Column,Start,Length)
-- Indexing start with 1

-- Subtract 3 character from the last name of all customers , starting from 2nd poition
SELECT 
	last_name,
    SUBSTRING(last_name,2,3)
FROM customers;




-- GROUP BY CLAUSE

-- Group rows based on cols values
-- Find the total number of customers for each country
SELECT 
	COUNT(*) AS total_customers,
    country
FROM customers
GROUP BY country  # Here customers are counted by their country
ORDER BY total_customers;

-- Find thehighest score of customers for each country
SELECT 
	MAX(score) AS max_score,
    country
FROM customers
GROUP BY country
ORDER BY max_score; 

-- IMPORTANT NOTE: Column used for grouping must be selected in query otherwise it will throw error
 
 
-- HAVING CLAUSE

-- Filter the groups returned from GROUP BY
-- Having filter the data after grouping
-- Rows eliminated by WHERE clause will not be included in GROUP BY

-- Find the total number of customers for each country and only include countries that have more than 1 customer
SELECT
	COUNT(*) AS total_customers,
    country
FROM customers
WHERE country != 'USA' # filtering the group by column
GROUP BY country
HAVING  COUNT(*) > 1;
/*	Here new generated column in filtered using HAVING clause 
	as WHERE works on columns that exists only in table not on 
    generated column*/
       


-- SUBQUERIES
/* Subqueries are the queries embedded into other queries */






-- Data Manipulation Language
-- INSERT
INSERT INTO customers
VALUE(DEFAULT, 'Anna', 'Nixon','UK',550);

-- Here DEFAULT means get the value from table defination

-- insert one more customers in customer table
INSERT INTO customers
(first_name,last_name)
Values('Max', 'lang'); 

-- Here we have defined that in which columns we want to put the values 



-- UPDATE Command
-- Modify the values of existing rows

-- update without where changes the values of every row
-- use primary key of the row which you wanna update
UPDATE customers
SET country = 'Germany'
WHERE customer_id = 7;

-- updating multiple cols in same row
UPDATE customers
SET country = 'USA',
	score = 700
WHERE customer_id = 6;

SELECT
COUNT(*)
FROM customers;

DESCRIBE customers;

-- DELETE Command
-- Remove both new customers

DELETE FROM customers; # DELETE Without WHERE DELETES all rows from table

DELETE FROM customers
WHERE customer_id IN (6,7);

SELECT * 
FROM customers;

-- If u wish delete a large table then DELETE command gonna take long time 
-- BEST PRACTICE: then you should use TRUNCATE command to delete
 
TRUNCATE customers;



-- DATA DEFINATION LANGUAGE(DDL)

-- CREATE  Command
-- to create a table u have to define the struture of table
-- three things to deifne in structure
-- Column name , Data Type , Constraints

-- Constraints : Primary Key, Not Null, Unique, Default
 
 -- Create new table called Perrsons with 4 columns: ID, person_name, birth_date, and phone
 
 CREATE TABLE DB_sql_tutorial.persons(
 id INT PRIMARY KEY AUTO_INCREMENT,  # AUTO INCREMENT will automatically gives a unique consecutive number to column 
 person_name VARCHAR(50) NOT NULL,
 birth_date DATE,
 phone VARCHAR(50) NOT NULL UNIQUE   # Two constraints are used to strictly manage data quality issues 
 );
 

-- ALTER Command
-- Modify an existing database table using ALTER statement

-- Add new column called email to table persons
ALTER TABLE persons
ADD email VARCHAR(15) NOT NULL;

-- u can also add multiple columns to table




-- DROP Command
-- Delete an existing table using DELETE Commmand


DROP TABLE persons

