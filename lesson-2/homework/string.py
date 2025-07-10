--1. Create a table Employees with columns: EmpID INT, Name varchar(50), and salary decimal(10,2)
CREATE TABLE  Employees ( EmpID int,  NAME varchar(50), SALARY decimal(10,2))

--2) Insert three records into the Employees table using different insert into approaches

Insert into  Employees (EmpID, NAME, SALARY) values (1, 'Michael' , 10000.00),
 (2, 'Emily', 7000.00),
 (3, 'James ',5400.00)

SELECT * FROM  Employees
--3) Update the salary of an Employee to 7000 where EmpID=1

Update Employees
set salary=7000
where EmpID=1

--4) Delete as record from the Employees table where EmpID=2

delete from Employees
where EmpID=2
--5) Give a brief definition for difference between DELETE, TRUNCATE and DROP

-- Delete ning vazifasi jadvaldagi malumotlarni o'chiradi, asosan qatorlarni o'chiradi, manzili berilmasa qatorma 
-- qator barcha malumotlarni ochiradi
-- Truncate esa barcha malumotlarni birdan o'chiradi, delete dan farqi Truncate tezroq ishlaydi chunki delete qatorma 
-- qator ochirgani sababli sekinroq ochiradi, Truncate ning Dropdan farqi esa Drop malumotlarni butunlay o'chiradi,
--Truncate bilan o'chirilganda esa table saqlanadi.
--Delete faqat malumotlargatasir qiladi, Truncate ham malumotlarga tasir qiladi, Drop esa jadvalning o'ziga tasir 
-- qiladi.

--6) Modify the Name column in the Employees table to varchar(100)

alter table Employees 
alter column NAME varchar(100)

--7) Add a new column Department (varchar(50)) to the Employees table
alter table Employees 
add Department varchar(50)
--8) Change the datatype of the salary column to float
alter table Employees
alter column salary float

--9) create another table Departments with columns Departmant ID, (int, primary key) and DepartmentName 
--varchar(50)

create table Departments 
	(DepartmentID  int   Primary key, 
	DepartmentName  varchar(50))
--10) Remove all records from the Employees table without deleting   its structure

delete from Departments

select * from  Departments
--11) Insert five records into the departments table using insert into select method

insert into Departments (DepartmentID, DepartmentName) values 
(101, 'HumanResourse'),
(102, 'Finance'),
(103, 'Marketing'),
(104, 'Sales'),
(105, 'Information Tecnology')

--12) Update the Department of all employees where salary>5000 to management

--13) Write a query that removes all employees but keeps the table struvture intact




select * from  Departments

