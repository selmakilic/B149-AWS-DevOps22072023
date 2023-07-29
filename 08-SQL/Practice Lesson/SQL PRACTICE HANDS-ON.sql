--  Database Creation and Deletion (DDL) (Data Definition Language)

-- Create Database
CREATE DATABASE example_database;

-- Delete Database
DROP DATABASE example_database;

--  Table Creation (DDL) with Various Data Types and Constraints

-- Table Creation with Constraints
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    age INT CHECK (age >= 18),
    salary DECIMAL(10, 2),
    hire_date DATE, -- DATE - format: YYYY-MM-DD
    UNIQUE (name)
);

--  Inserting Data into Tables (DML)
-- DML (Data Manipulation Language) commands are used to insert, update, and delete data in tables.
-- Inserting Data


INSERT INTO employees (id, name, department, age, salary, hire_date) VALUES
(1, 'John Doe', 'HR', 30, 5000.00, '2020-05-15'),
(2, 'Jane Smith', 'Finance', 28, 5500.00, '2019-10-10'),
(3, 'Michael Johnson', 'Sales', 35, 6000.00, '2018-08-22'),
(4, 'Emily Adams', 'Marketing', 25, 4800.00, '2021-01-05'),
(5, 'Robert Brown', 'IT', 32, 6200.00, '2017-03-12'),
(6, 'Sarah Lee', 'HR', 29, 5300.00, '2019-06-30'),
(7, 'William Wilson', 'Finance', 26, 5800.00, '2020-09-18'),
(8, 'Linda Davis', 'Sales', 40, 6500.00, '2015-12-03'),
(9, 'James Miller', 'IT', 27, 6000.00, '2018-11-25'),
(10, 'Jennifer Taylor', 'Marketing', 31, 5100.00, '2016-07-20');

INSERT INTO employees (id, name, department, age, salary, hire_date)
VALUES (1, 'John Doe', 'HR', 30, 50000.00, '2023-01-15');

INSERT INTO employees (id, name, department, age, salary, hire_date)
VALUES (2, 'Jane Smith', 'Finance', 25, 60000.00, '2023-02-20');



--  Querying Data with SELECT

-- Querying Data
SELECT * FROM employees;

-- If you want to display the data with a different name for a column
-- without changing the original

SELECT column_name AS alias_name
FROM table_name;

--In PostgreSQL and most other SQL database systems, indentation and
-- whitespace generally do not affect the execution or performance of the SQL queries.
-- To change the name of a column in a table, you can use the
ALTER TABLE employees
RENAME COLUMN name TO isim;

SELECT 
    isim,
    age,
    salary
FROM 
    employees

--If you already have an existing table and want to alter it 
-- to add the "NOT NULL" constraint to the "name" column, you can
--  use the ALTER TABLE statement:

-- ALTER TABLE employees
-- MODIFY COLUMN name VARCHAR(50) NOT NULL;

--  Filtering Data with WHERE Condition

** Veri Manipülasyon Dili (DML) komutları: (Data Manipulation Language)
-- Filtering Data
SELECT name, age, salary FROM employees;
SELECT * FROM employees WHERE department = 'HR';
SELECT name, department FROM employees WHERE department = 'IT';
SELECT name, department FROM employees WHERE age > 30;
SELECT * FROM employees WHERE age BETWEEN 25 AND 35;

CREATE VIEW my_view AS
SELECT name, hire_date, department FROM employees WHERE department = 'Sales';


-- ORDER BY ile sıralama
SELECT name, hire_date FROM employees ORDER BY hire_date DESC;
SELECT name, hire_date FROM employees ORDER BY hire_date ASC;
SELECT name, hire_date FROM employees ORDER BY hire_date ASC, name DESC;
SELECT name, salary FROM employees ORDER BY salary DESC;
-- Using IN Operator
SELECT * FROM employees WHERE department IN ('HR', 'Finance');

-- Multiple Conditions with AND, OR, and NOT
SELECT * FROM employees WHERE department = 'HR' OR department = 'Finance';
SELECT * FROM employees WHERE age >= 30 AND department = 'Sales';
SELECT * FROM employees WHERE NOT department = 'IT';

-- INSERT
INSERT INTO employees (id, name, department) VALUES (11, 'Ahmet Kaya', 'Muhasebe');

-- UPDATE
UPDATE employees SET salary = 7000 WHERE id = 3;

-- DELETE
DELETE FROM employees WHERE id = 10;


-- Using the UNIQUE Constraint

-- UNIQUE Constraint
INSERT INTO employees (id, name, department) VALUES (3, 'John Doe', 'IT'); -- Not allowed, name must be unique.
INSERT INTO employees (id, name, department) VALUES (13, 'Jane Smith', 'IT'); -- Allowed

-- Using the NOT NULL Constraint

-- NOT NULL Constraint
INSERT INTO employees (id, name, department) VALUES (4, NULL, 'Marketing'); -- Not allowed, name cannot be null.
INSERT INTO employees (id, name, department) VALUES (4, 'Mike Johnson', NULL); -- Allowed, department can be null.

--  Using the CHECK Constraint

-- CHECK Constraint
INSERT INTO employees (id, name, department, age) VALUES (5, 'Alex Brown', 'Sales', 16); -- Not allowed, age must be >= 18.
INSERT INTO employees (id, name, department, age) VALUES (5, 'Alex Brown', 'Sales', 20); -- Allowed, age is >= 18.


--  concatenation operator || to concatenate the first name, space, and last name of every customer.
SELECT isim ||' '|| department, salary FROM EMPLOYEES;

SELECT isim ||' '|| department AS "new_data", salary FROM EMPLOYEES;

-- Add a new column to the "EMPLOYEES" table. Let's call the new column "full_name":
ALTER TABLE EMPLOYEES
ADD COLUMN full_name VARCHAR(200);

--Update the "full_name" column with the concatenated data of "isim" and "department":
UPDATE EMPLOYEES
SET full_name = isim || ' ' || department;

-- deleting a column from table
ALTER TABLE employees DROP COLUMN department;
DROP VIEW view_1;

-- Aggregate fonksiyonları
SELECT AVG(salary) FROM employees;
SELECT ROUND(AVG(salary), 2) AS average_salary FROM employees;
SELECT *, ROUND((SELECT AVG(salary) FROM employees), 2) AS average_salary FROM employees;
SELECT *,
       ROUND((SELECT AVG(salary) FROM employees) - salary, 2) AS average_salary
FROM employees;
-- ALTER TABLE employees
-- ADD COLUMN comaritive_salary DECIMAL(10, 2);
UPDATE TABLE employees SET comaritive_salary=(
	SELECT *,
       ROUND((SELECT AVG(salary) FROM employees) - salary, 2)
	);

SELECT department, COUNT(*) FROM employees GROUP BY department;
SELECT MAX(salary) AS max_salary FROM employees;
SELECT COUNT(*) AS total_employees FROM employees;


-- GROUP BY ve HAVING ile gruplama
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 5000;


--  Using Aliases

-- Using Aliases
SELECT name AS employee_name, salary * 0.9 AS discounted_salary FROM employees;

-- Deleting Data with DELETE
DELETE FROM employees WHERE department = 'IT';

-- Deleting Data with TRUNCATE TABLE
TRUNCATE TABLE employees;

-- 16. Dropping Tables from the Database with DROP TABLE

-- Dropping Tables
DROP TABLE employees;
DROP TABLE departments;

-- 17. Concatenating Columns and Strings

-- Concatenating Columns and Strings
SELECT name || ' (' || department || ')' AS employee_info FROM employees;

-- 18. Handling NULL Values in INSERT and SELECT Statements

-- Handling NULL Values
INSERT INTO employees (id, name, department) VALUES (6, NULL, 'Operations');
SELECT * FROM employees WHERE department IS NULL;


--Subquries

-- IT departmanında çalışanların ortalama maaşından daha fazla maaş alan çalışanlar
SELECT name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department = 'IT');
