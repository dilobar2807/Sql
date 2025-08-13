use new_code_9

--1) Task: Retrieve employees who earn the minimum salary in the company. Tables: employees
--(columns: id, name, salary)
drop table employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select  min(salary) as min_salary from employees
select * from employees

--2) Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
drop table products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products
where price>(select avg(price) from products)

--3)Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
drop table employees
drop table departments
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

select * from departments
select * from employees

select e.ID, e.Name from employees e
INNER JOIN Departments d
on e.department_id=d.id
where d.department_name='Sales'

--4)Task: Retrieve customers who have not placed any orders. Tables: customers
--(columns: customer_id, name), orders (columns: order_id, customer_id)

drop table customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

drop table orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);


select customers.customer_id, customers.name from Customers
LEFT JOIN Orders
on customers.customer_id=orders.customer_id
where orders.order_Id is null

--5) Task: Retrieve products with the highest price in each category. Tables: products 
--(columns: id, product_name, price, category_id)

drop table Products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

select * from Products as pdc1
where price=(select max(price) from Products as pdc2 where pdc2.category_id=pdc1.category_id) 

--6) Task: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

drop table departments
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

drop table employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);


SELECT TOP 1 DEPARTMENT_NAME, AVG(SALARY) AS MAX_AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_NAME
ORDER BY AVG(SALARY) DESC;

--7) Task: Retrieve employees earning more than the average salary in their department. Tables:
--employees (columns: id, name, salary, department_id)
drop table employees
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);


select * from Employees as emp1
where salary> (select avg(salary) from Employees as emp2 where emp2.department_id=emp1.department_id)

--8) Task: Retrieve students who received the highest grade in each course. Tables: students
--(columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select * from students
JOIN grades
on students.student_id=grades.student_id

select * from grades

--9) 9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in 
--each category. Tables: products (columns: id, product_name, price, category_id)

drop table products
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

SELECT id, product_name, price, category_id
FROM (
  SELECT
    id,
    product_name,
    price,
    category_id,
    DENSE_RANK() OVER (
      PARTITION BY category_id
      ORDER BY price DESC
    ) AS price_rank
  FROM products
) ranked
WHERE price_rank = 3;

select * from products
