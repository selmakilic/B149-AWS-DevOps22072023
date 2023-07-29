CREATE TABLE employees (
	id INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	department VARCHAR (50),
	age INT CHECK (age>=18),
	salary DECIMAL(10,2),
	hire_date DATE
	);
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

SELECT * FROM employees;
SELECT id,name,department FROM employees;
SELECT name AS isim FROM employees;
ALTER TABLE employees RENAME COLUMN name TO isim;

	
INSERT INTO employees (id, isim, department, age, salary, hire_date) VALUES
(11, 'Ahmet', 'HR', 30, 5000.00, '2020-05-15');

ALTER TABLE employees RENAME COLUMN isim TO name;


--  Filtering Data with WHERE Condition
SELECT * FROM employees;
SELECT * FROM employees WHERE department='HR';
-- IT department ten name 
SELECT age,name,department FROM employees WHERE department = 'IT';
-- name, department yaslari 30 fazla

SELECT name, department FROM employees WHERE age > 30;
SELECT name, age,department FROM employees WHERE age > 30;
-- 25 ile 35 arasi olsun yaslar

SELECT * FROM employees WHERE age BETWEEN 25 AND 35;
SELECT  * FROM employees WHERE age>=25 AND age<=35;

CREATE VIEW hr_d AS
SELECT * FROM employees WHERE department='HR';

CREATE VIEW age_25_35 AS
SELECT * FROM employees WHERE age BETWEEN 25 AND 35;

-- OREDR BY siralma
-- name,hire_date, siralama tarihe gore 
SELECT name, hire_date FROM employees ORDER BY hire_date DESC;
CREATE VIEW myview AS
	SELECT name, hire_date FROM employees ORDER BY hire_date ASC;
	
SELECT name, hire_date FROM employees ORDER BY hire_date ASC, name ASC;

SELECT * FROM employees ORDER BY salary DESC;

-- HR ile Finance calisanlari ekrana yazdir
SELECT * FROM employees WHERE department IN ('HR','Finance') ORDER BY department ASC,name ASC;

-- Hr da calisanlar disinda butun verileri gosterin
SELECT * FROM employees WHERE NOT department='HR';

INSERT INTO employees (id, name, department) VALUES (13, 'Mehmet', 'IT')

SELECT * FROM employees;

INSERT INTO employees (id,name, age, department) VALUES (14,'Selma', 20 , 'IT')

-- UPDATE
UPDATE employees SET salary=65000 WHERE id=14;

-- concatination operator
SELECT name || ' '|| age AS "new_data",salary FROM employees;

ALTER TABLE employees 
ADD COLUMN name_age VARCHAR(200);

UPDATE employees
SET name_age =name || ' '|| age;

SELECT name,  name_age, age FROM employees;

-- Aggregate function
SELECT AVG(salary) FROM employees;
SELECT ROUND(AVG(salary),2) FROM employees;
SELECT MAX(salary) FROM employees;

SELECT *,
       ROUND((SELECT AVG(salary) FROM employees) - salary, 2) AS DIFFERENCE_average_salary
FROM employees;
DROP VIEW 
