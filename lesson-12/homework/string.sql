--1) Combine two tables

Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select person.firstName, Person.lastName, Address.city, Address.state from Person
left join Address
on Person.personId=Address.personId

--2) Employees earning more than their managers

Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select e1.name as Employee, e1.salary, isnull(e2.name, 'Boss') as Manager, e2.salary as Managers_sal  
from Employee e1
left join Employee  e2
on e1.managerId=e2.id
where e1.salary>e2.salary

--3) Duplicate emails
drop table Person
Create table Person (id int, email varchar(255))
Truncate table Person
insert into Person (id, email) values ('1', 'a@b.com') 
insert into Person (id, email) values ('2', 'c@d.com') 
insert into Person (id, email) values ('3', 'a@b.com')

select email, count(id) count_id from Person
group by email
having count(id)>1

--4) Delete Duplicate Emails

Create table Person (id int, email varchar(255))
Truncate table Person
insert into Person (id, email) values ('1', 'john@example.com') 
insert into Person (id, email) values ('2', 'bob@example.com') 
insert into Person (id, email) values ('3', 'john@example.com')

select email, count(id)  from Person
group by email
having count(id)>1

WITH CTE_Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS rn
    FROM Person
)
DELETE FROM CTE_Duplicates
WHERE rn > 1;

--5) Find those parents who has only girls

CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select parentname from girls
except 
select parentname from boys

--6) Total over 50 and least



--7) carts

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

SELECT
	ISNULL(cart1.item, ' ' ) AS Item_Cart1, 
	ISNULL(cart2.Item, ' ') AS Item_Cart2 
FROM cart1
FULL JOIN  cart2
ON cart1.Item=Cart2.item
ORDER BY ISNULL(cart1.item, ' ' ),  ISNULL(cart2.Item, ' ')

--8) Customers who never order

Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

SELECT Customers.name AS Customers FROM   Customers
Left Join  Orders
ON Customers.id=Orders.customerId
WHERE  Orders.customerId is null 

--9) Students and Examinations
drop table Students
drop table Subjects
drop table Examinations

Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')


SELECT 
    s.student_name,
    sub.subject_name,
    COALESCE((
        SELECT COUNT(*)
        FROM Examinations e
        WHERE e.student_id = s.student_id AND e.subject_name = sub.subject_name
    ), 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
ORDER BY s.student_name, sub.subject_name;
