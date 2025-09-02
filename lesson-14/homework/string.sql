
--1) Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.
--(TestMultipleColumns)

select*,
SUBSTRING (Name, 1, charindex(',', Name)-1) as First_Name,
substring (Name, charindex(',', Name)+1, len(Name))  as Surname
from TestMultipleColumns 

--2)Write a SQL query to find strings from a table where the string itself contains the % character.
--(TestPercent)

SELECT * FROM TestPercent
WHERE Strs LIKE '%[%]%'

--3)In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT S.id,
	LTRIM(RTRIM(Value)) AS Part
FROM Splitter S
CROSS APPLY
	STRING_SPLIT(S.Vals, '.')
ORDER BY s.id 

--4) Write a SQL query to replace all integers (digits) in the string with 'X'.
--(1234ABC123456XYZ1234567890ADS)

Select Replace(
	Replace( 
		Replace('1234ABC123456XYZ1234567890ADS', '1234', 'XXXX'), '56', 'XX'), '7890', 'XXXX')

--5) Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.)
--.(testDots)
select  REPLACE(Vals, '.', '') as Vals_ from testDots
where len(Vals)-len(REPLACE(Vals, '.', ''))>2

--6) Write a SQL query to count the spaces present in the string.(CountSpaces)

SELECT texts, REPLACE(texts, ' ', '') AS without_spaces, LEN(texts)-LEN(REPLACE(texts, ' ', ''))  AS Counts 
FROM CountSpaces

--7)write a SQL query that finds out employees who earn more than their managers.(Employee)
select e1.Name as Employee_Name, e1.salary as Salary, isnull(e2.Name, 'Boss') as Manager,
isnull(e2.Salary, e1.salary) as Manager_SAl from Employee e1
left join Employee e2
on e1.ManagerId=e2.Id
where e1.salary>e2.salary

--8) Find the employees who have been with the company for more than 10 years, but less than 15 years. 
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date).(Employees)

SELECT  EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, 
DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS  Years_Of_Service  FROM Employees
WHERE  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) between 10 and 15

--Medium tasks
--1) Write a SQL query to separate the integer values and the character values into two different columns.
--(rtcfvty34redt)

declare @letter varchar(50)='rtcfvty34redt'
declare @lowercase varchar(50)=''
declare @count int=1
while @count<=len(@letter)
begin
if ASCII(substring(@letter, @count, 1)) between 97 and 122
begin
	set @lowercase=@lowercase+substring(@letter, @count, 1)
end
set @count=@count+1
end
select @letter, @lowercase

--2)write a SQL query to find all dates' Ids with higher temperature compared to its previous 
--(yesterday's) dates.(weather)

select * from weather w1
 join weather w2
on  datediff(day, w2.RecordDate, w1.RecordDate)=1  
where w1.Temperature>w2.Temperature

--3) Write an SQL query that reports the first login date for each player.(Activity)

SELECT 
    player_id,
    MIN(event_date) AS first_login_date
FROM 
    Activity
GROUP BY 
    player_id;

--4) Your task is to return the third item from that list.(fruits)

select 
substring(fruit_list,
charindex(',', fruit_list, charindex(',', fruit_list)+1)+1,
charindex(',', fruit_list, charindex(',', fruit_list, charindex(',', fruit_list)+1)+1)
-CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1)  as third_fruit
from fruits; 

--5) Write a SQL query to create a table where each character from the string will be converted into a row.
--(sdgfhsdgfhs@121313131)

declare @str varchar(100)='sdgfhsdgfhs@121313131'
declare @i int =1
declare @len int=len(@str)

create table #chars (char nvarchar(1))
while @i<=@len
begin 
	insert into #chars (char)
	values (SUBSTRING(@str, @i, 1));
	set @i=@i+1
	end

select * from #chars

--6) You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value 
--of p1.code is 0, replace it with the value of p2.code.(p1,p2)

select p1.id,
case when p1.code=0 then p2.code
else p1.code end as code
from p1
join p2
on p1.id=p2.id
