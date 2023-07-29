***Cheat Sheet for PostgreSql***
**Concepts Covered in Days 1,2,3**

List of all the SQL concepts covered in Day 1,2,3:

1. Database creation and deletion (DDL) - CREATE DATABASE and DROP DATABASE.
2. Table creation (DDL) with various data types and constraints - CREATE TABLE.
3. Inserting data into tables (DML) - INSERT INTO.
4. Querying data with SELECT - SELECT * FROM table_name.
5. Filtering data with WHERE condition - SELECT * FROM table_name WHERE condition.
6. Using the UNIQUE constraint for ensuring unique values in a column.
7. Using the NOT NULL constraint for ensuring non-null values in a column.
8. Using the CHECK constraint for defining specific conditions for column values.
9. Creating primary keys (PK) for uniquely identifying records in a table - PRIMARY KEY.
10. Creating foreign keys (FK) to establish relationships between tables - FOREIGN KEY.
11. Using ON DELETE CASCADE to manage parent-child relationships.
12. Using the IN and BETWEEN..AND operators for filtering data.
13. Using aggregate functions like MAX, MIN, SUM, AVG, and COUNT for calculations.
14. Using aliases to give temporary names to tables or columns.
15. Deleting data with DELETE and TRUNCATE TABLE.
16. Dropping tables from the database with DROP TABLE.
17. Concatenating columns and strings using the || operator.
18. Handling NULL values in INSERT and SELECT statements.
19. Multiple conditions with AND, OR, and NOT in WHERE clauses.

Explanations:

### 1. Database Creation and Deletion (DDL)

#### Explanation:
- Databases are containers that hold related tables and data.
- We use DDL (Data Definition Language) commands to create and delete databases.

#### Hands-on Example:
1. **Creating a Database (CREATE DATABASE):**
   ```sql
   CREATE DATABASE my_database;
   ```
   This command creates a new database called "my_database".

2. **Deleting a Database (DROP DATABASE):**
   ```sql
   DROP DATABASE IF EXISTS my_database;
   ```
   This command deletes the "my_database" if it exists. The `IF EXISTS` clause ensures it won't throw an error if the database doesn't exist.

### 2. Table Creation (DDL) with Data Types and Constraints

#### Explanation:
- Tables are used to organize data into rows and columns.
- We use DDL commands to create tables, define data types, and apply constraints.

#### Hands-on Example:
```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE
);
```
In this example:
- We create a table called "students".
- The "id" column is the primary key, ensuring each record has a unique identifier.
- The "name" column cannot be NULL.
- The "age" column can contain NULL values.
- The "email" column must have unique values.

### 3. Inserting Data into Tables (DML)

#### Explanation:
- DML (Data Manipulation Language) commands are used to insert, update, and delete data in tables.

#### Hands-on Example:
```sql
INSERT INTO students (id, name, age, email)
VALUES (1, 'John', 25, 'john@example.com');
```
This command inserts a new record into the "students" table with the specified values for each column.

### 4. Querying Data with SELECT

#### Explanation:
- SELECT statement is used to retrieve data from one or more tables.

#### Hands-on Example:
```sql
SELECT * FROM students;
```
This query retrieves all columns and records from the "students" table.

### 5. Filtering Data with WHERE Condition

#### Explanation:
- The WHERE clause filters the data based on specified conditions.

#### Hands-on Example:
```sql
SELECT name, age FROM students WHERE age > 20;
```
This query selects the "name" and "age" columns from the "students" table where the "age" is greater than 20.

### 6. Using the UNIQUE Constraint

#### Explanation:
- The UNIQUE constraint ensures that each value in a column is unique.

#### Hands-on Example:
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    price DECIMAL(10, 2)
);
```
In this example, the "name" column must have unique values for each record.

### 7. Using the NOT NULL Constraint

#### Explanation:
- The NOT NULL constraint ensures that a column cannot contain NULL values.

#### Hands-on Example:
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50)
);
```
In this example, the "name" column must have a value for each record, but the "department" column can be NULL.

### 8. Using the CHECK Constraint

#### Explanation:
- The CHECK constraint defines specific conditions that values in a column must meet.

#### Hands-on Example:
```sql
CREATE TABLE orders (
    id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    discount DECIMAL(5, 2) CHECK (discount >= 0 AND discount <= 100)
);
```
In this example, the "discount" column must have a value between 0 and 100 (inclusive).

### 9. Creating Primary Keys (PK)

#### Explanation:
- Primary keys uniquely identify records in a table.

#### Hands-on Example:
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
```
In this example, the "customer_id" column is the primary key for the "customers" table.

### 10. Creating Foreign Keys (FK)

#### Explanation:
- Foreign keys establish relationships between tables, ensuring data integrity.

#### Hands-on Example:
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);
```
In this example, the "customer_id" in the "orders" table references the "customer_id" in the "customers" table.

### 11. Using ON DELETE CASCADE

#### Explanation:
- ON DELETE CASCADE ensures that when a parent record is deleted, its related child records are also deleted.

#### Hands-on Example:
```sql
CREATE TABLE parent (
    parent_id INT PRIMARY KEY
);

CREATE TABLE child (
    child_id INT PRIMARY KEY,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES parent (parent_id) ON DELETE CASCADE
);
```
In this example, when a record is deleted from the "parent" table, all related records in the "child" table will also be deleted.

(Note: To practice this, you can insert some data into the tables and try deleting a parent record to see the cascade effect.)


### 12. Using the IN and BETWEEN..AND Operators for Filtering Data

#### Explanation:
- The IN operator is used to match a value against a list of specified values.
- The BETWEEN..AND operator is used to match a value within a range of values.

#### Hands-on Example:
```sql
SELECT * FROM employees WHERE department IN ('HR', 'Finance', 'Marketing');
```
This query selects all employees whose department is either 'HR', 'Finance', or 'Marketing'.

```sql
SELECT * FROM orders WHERE order_date BETWEEN '2023-01-01' AND '2023-06-30';
```
This query selects all orders with an order date between January 1, 2023, and June 30, 2023.

### 13. Using Aggregate Functions

#### Explanation:
- Aggregate functions perform calculations on a set of values and return a single value.

#### Hands-on Example:
```sql
SELECT MAX(price) AS max_price FROM products;
```
This query calculates the maximum value of the "price" column from the "products" table and gives it an alias "max_price".

```sql
SELECT COUNT(*) AS total_customers FROM customers;
```
This query counts the total number of records in the "customers" table and gives it an alias "total_customers".

### 14. Using Aliases

#### Explanation:
- Aliases provide temporary names to tables or columns in a query.

#### Hands-on Example:
```sql
SELECT name AS product_name, price * 0.9 AS discounted_price FROM products;
```
This query retrieves the "name" column from the "products" table and renames it as "product_name". It also calculates a discounted price by multiplying the "price" by 0.9 and assigns it the alias "discounted_price".

### 15. Deleting Data with DELETE and TRUNCATE TABLE

#### Explanation:
- DELETE statement removes specific records from a table based on the condition in the WHERE clause.
- TRUNCATE TABLE removes all records from a table.

#### Hands-on Example:
```sql
DELETE FROM employees WHERE department = 'IT';
```
This command deletes all records from the "employees" table where the department is 'IT'.

```sql
TRUNCATE TABLE orders;
```
This command removes all records from the "orders" table.

### 16. Dropping Tables from the Database with DROP TABLE

#### Explanation:
- DROP TABLE command deletes an entire table from the database.

#### Hands-on Example:
```sql
DROP TABLE customers;
```
This command deletes the "customers" table and all its data.

### 17. Concatenating Columns and Strings

#### Explanation:
- The || operator is used to concatenate columns and strings together.

#### Hands-on Example:
```sql
SELECT first_name || ' ' || last_name AS full_name FROM employees;
```
This query concatenates the "first_name" and "last_name" columns with a space in between and gives it an alias "full_name".

### 18. Handling NULL Values in INSERT and SELECT Statements

#### Explanation:
- To insert NULL values into a table, we can use the keyword NULL or omit the column value.
- To filter NULL values in SELECT, we can use the IS NULL or IS NOT NULL operators.

#### Hands-on Example:
```sql
INSERT INTO employees (id, name, department) VALUES (1, 'John Doe', NULL);
```
This query inserts a record into the "employees" table with NULL value for the "department" column.

```sql
SELECT * FROM employees WHERE department IS NULL;
```
This query retrieves all employees where the "department" column is NULL.

### 19. Multiple Conditions with AND, OR, and NOT in WHERE Clauses

#### Explanation:
- AND operator combines multiple conditions where all conditions must be true.
- OR operator combines multiple conditions where at least one condition must be true.
- NOT operator negates a condition.

#### Hands-on Example:
```sql
SELECT * FROM orders WHERE total_amount > 100 AND order_date BETWEEN '2023-01-01' AND '2023-06-30';
```
This query selects all orders where the "total_amount" is greater than 100 and the "order_date" is between January 1, 2023, and June 30, 2023.

```sql
SELECT * FROM employees WHERE department = 'HR' OR department = 'Finance';
```
This query selects all employees whose department is either 'HR' or 'Finance'.

```sql
SELECT * FROM employees WHERE NOT department = 'IT';
```
This query selects all employees whose department is not 'IT'.

