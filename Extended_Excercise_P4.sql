-----------------------------------------------Extended Excercise----------------------------
SELECT * FROM EMPLOYEEES;
SELECT * FROM MANAGEERS;
SELECT  *FROM DEPARTMEENTS;
SELECT * FROM PROJECTS;


---------------------------------Functions in SQL - A Detailed excercise-------------------------------------
------------------------------------------------Senario#1-------------------------------------------------------
--Convert each employee’s joining date to this format:
--"Monday, 12-Feb-2021" and display with their full name.

SELECT E_first || ' ' || E_last AS E_name, 
TO_CHAR(joining_date, 'FMDAY, DD-MON-YYYY') FROM EMPLOYEEES;

------------------------------------------------Senario#2-------------------------------------------------------
--Show employee salary in this format using TO_CHAR:
--"Rs. 85,000 per month"

SELECT E_first || ' ' || E_last AS E_name,
'Rs.' || TO_CHAR(SALARY, 'FM99,999,999') || ' per month' AS SALARY FROM EMPLOYEEES;

---FM : FM stands for Fill Mode and is a format model modifier used to suppress padding in the return value. 
--This is particularly useful when converting dates or numbers to strings and 
--you want to avoid leading/trailing spaces or leading zeros that might be added by default to 
--ensure a consistent width for all values.

------------------------------------------------Senario#3-------------------------------------------------------
--Convert all project budgets (NUMBER) into VARCHAR and append " PKR".

SELECT CAST(budget AS VARCHAR2(45)) AS "PROJECT BUDGET" FROM PROJECTS;

------------------------------------------------Senario#4-------------------------------------------------------
--Convert joining_date to a number (YYYYMMDD) using conversion functions.
SELECT TO_NUMBER(TO_CHAR(joining_date, 'YYYYMMDD')) AS J_DATE FROM EMPLOYEEES;

--Date cannot be converted to number directly, therefore it is first converted to string using TO_CHAR

------------------------------------------------Senario#5-------------------------------------------------------
--Convert a date string '2024-03-15' into a proper DATE using TO_DATE
--and add 10 days.
SELECT TO_DATE('2024-03-15', 'YYYY-MM-DD') + 10 AS DATES FROM DUAL;

-- '+' can be used to add days to a date in Oracle

------------------------------------------------Senario#6-------------------------------------------------------
--For employees whose leaving_date is NULL, show:
--"Still Working" otherwise show the actual leaving_date.
SELECT E_first || ' ' || E_last AS E_name,
NVL(TO_CHAR(leaving_date), 'Still Working') AS E_Status FROM EMPLOYEEES;

--In NVL the arguments expr1 and expr2 can be of various data types, 
--but they must be compatible for implicit conversion if they are not identical.

------------------------------------------------Senario#7-------------------------------------------------------
--Display employee salary and a column:
--"Has Bonus" if bonus column is NOT NULL
--"No Bonus" if bonus is NULL
--(Use NVL2)
SELECT E_first || ' ' || E_last AS E_name,
NVL2(TO_CHAR(leaving_date), 'No Bonus', 'Has Bonus') FROM EMPLOYEEES;

------------------------------------------------Senario#8-------------------------------------------------------
--Compare salary with commission (if NULL treat as 0).
--Show the sum using NVL or COALESCE.


------------------------------------------------Senario#9-------------------------------------------------------
--Use NULLIF to return NULL when employee age = 0.
--(Assume some faulty data exists.)
SELECT E_first || ' ' || E_last AS E_name, NULLIF(Age, 0) FROM EMPLOYEEES;

--If both values are same it NULLIF returns NULL.

------------------------------------------------Senario#10-------------------------------------------------------
--Show first non-null value among: nickname, middle name, first name.
--(Use COALESCE)
SELECT * FROM EMPLOYEEES;
SELECT COALESCE(NULL,E_first, E_last, gender) AS Result 
FROM EMPLOYEEES; 

--The COALESCE function takes two or more compatible arguments and returns the first argument that is not null.
--The result is null only if all the arguments are null.

------------------------------------------------Senario#11-------------------------------------------------------
--Categorize employees based on salary:
--< 50000 → "Low"
--50000–90000 → "Medium"
--> 90000 → "High"
SELECT E_first || ' ' || E_last AS E_name, SALARY,
CASE
WHEN SALARY < 5000 THEN 'LOW'
WHEN SALARY BETWEEN 50000 AND 90000 THEN 'MEDIUM'
WHEN SALARY > 90000 THEN 'HIGH'
ELSE 'Default'
END 
FROM EMPLOYEEES;

------------------------------------------------Senario#12-------------------------------------------------------
--Use DECODE to assign:
--Gender='Male' → "M"
--Gender='Female' → "F"
--else "Other"
SElECT E_first || ' ' || E_last AS E_name,
DECODE(GENDER, 'Male', 'M', 'Female', 'F', 'Other') 
FROM EMPLOYEEES;

---Issue: Since I had defined Gender column as Char(6), every instance of 'Male' is padded with 2 spaces at the end
--therefore decode does not return M for 'Male'. 

SELECT * FROM EMPLOYEEES
WHERE GENDER = 'Male';       -----On the other hand = operator return result based on comparision using equal.

SELECT * FROM EMPLOYEEES
WHERE GENDER LIKE('Male');  ---Whereas LIKE Operator does not ignore trailing spaces, so does DECODE.

SELECT * FROM EMPLOYEEES
WHERE GENDER IN('M%E');  -----IN operator will not ignore trailing spaces as well.

SELECT E_first || ' ' || E_last AS E_name, SALARY,
CASE GENDER
WHEN 'Male' THEN 'M'
WHEN 'Female' THEN 'F'   -------CASE ignores trailing spaces as well!
ELSE 'other'                                                            
END 
FROM EMPLOYEEES;


--Answer: the equals operator (=), and DECODE generally ignores trailing spaces when performing string comparisons. 
--This means that a string like 'value' will be considered equal to 'value ' 
--(with multiple trailing spaces) when using the = operator.

------------------------------------------------Senario#13-------------------------------------------------------
--Use CASE to show status of project:
--end_date IS NULL → "Ongoing"
--end_date < SYSDATE → "Completed"
--end_date > SYSDATE → "Future Project"

SELECT PROJ_name, end_date,
CASE 
WHEN end_date IS NULL THEN 'Ongoing'
WHEN end_date < SYSDATE THEN 'Completed'
WHEN end_date > SYSDATE THEN 'Future Project'
ELSE 'obsolete'
END
FROM PROJECTS;

------------------------------------------------Senario#14-------------------------------------------------------
--Classify employees by joining month:
--Jan–Mar → "Q1"
--Apr–Jun → "Q2" etc.
SELECT E_first || ' ' || E_last AS E_Name, joining_date,
CASE 
WHEN EXTRACT(MONTH FROM joining_date) IN (1,2,3) THEN 'Q1'
WHEN EXTRACT(MONTH FROM joining_date) IN (4,5,6) THEN 'Q2'
WHEN EXTRACT(MONTH FROM joining_date) IN (7,8,9) THEN 'Q3'
WHEN EXTRACT(MONTH FROM joining_date) IN (10,11,12) THEN 'Q4'
ELSE 'Date Invalid!'
END
FROM EMPLOYEEES;

SELECT E_first, EXTRACT(MONTH FROM joining_date) FROM EMPLOYEEES;
--EXTRACT is used to fetch specific components like month, day, year, hours..etc from date.

------------------------------------------------Senario#15-------------------------------------------------------
--Create a CASE expression to show age group:
--"Young" (<24)
--"Adult" (20–50)
--"Senior" (>50)
SELECT e_first || ' ' || e_last AS E_name, AGE, 
CASE 
WHEN Age < 25 THEN 'Young'
WHEN Age BETWEEN 20 AND 50 THEN 'Adult'  ---CASE Statement returns the first matching instance.
WHEN Age > 50 THEN 'Senior'
ELSE 'Invalid Age'
END AS Age_desc
FROM EMPLOYEEES;

------------------------------------------------Senario#16-------------------------------------------------------
--Round salaries to nearest thousand.
SELECT e_first || ' ' || e_last AS E_name, 
SALARY, ROUND(SALARY, -3) FROM EMPLOYEEES;

--ROUND(salary, -3) rounds the salary column to the nearest thousand. 
--The -3 indicates rounding to the third digit to the left of the decimal point, effectively rounding to the nearest thousand.

------------------------------------------------Senario#17-------------------------------------------------------
-- Truncate salary to remove last 3 digits (12345 → 12300).
SELECT e_first || ' ' || e_last AS E_name,
SALARY, TRUNC(SALARY, -3) AS TRUNC_SALARY FROM EMPLOYEEES;

------------------------------------------------Senario#18-------------------------------------------------------
--Show whether each employee’s salary is even or odd using MOD.
SELECT e_first || ' ' || e_last AS E_name, SALARY,
CASE
WHEN MOD(SALARY, 2) = 1 THEN 'Odd'
WHEN MOD(SALARY, 2) = 0 THEN 'Even'
ELSE 'Neither'
END AS E_O_SALARY
FROM employeees;

------------------------------------------------Senario#19-------------------------------------------------------
--Increase salary to double using POWER for calculation.
SELECT E_first, SALARY, POWER(SALARY,2) AS SALARY_SQuARED, SQRT(POWER(SALARY,2)) AS SQRT_SALARY FROM EMPLOYEEES;

------------------------------------------------Senario#20-------------------------------------------------------
--Show ABSOLUTE, CEIL and FLOOR values of project budgets divided by 100000.
SELECT PROJ_NAME, BUDGET, ABS(Budget/100000) AS ABS, CEIL(Budget/100000) AS Ceil, FLOOR(budget/100000) AS floor 
, ROUND(BUDGET/100000) AS RND FROM PROJECTS;

------------------------------------------------Senario#21-------------------------------------------------------
--Generate a random whole number.
SELECT ROUND(DBMS_RANDOM.VALUE(1, 100)) AS Random_num 
FROM DUAL;

------------------------------------------------Senario#22-------------------------------------------------------
--Convert employee names to Proper Case (Initcap).
SELECT INITCAP(E_first) || ' ' || INITCAP(e_last) AS E_name
FROM EMPLOYEEES;

------------------------------------------------Senario#23-------------------------------------------------------
--Extract first 3 letters of each project name.
SELECT t.*, SUBSTR(Proj_name, 1,3) FROM PROJECTS t;

SELECT SUBSTR('HELLO,WORLD', 1, LENGTH('HELLOdsa')) FROM DUAL;

------------------------------------------------Senario#24-------------------------------------------------------
--Find employees whose last name contains 'an' (case-insensitive).
SELECT E_last, INSTR(LOWER(E_last),LOWER('AN'), -2) FROM EMPLOYEEES;
--Introducing LOWER() makes the statement case-insensitive

------------------------------------------------Senario#25-------------------------------------------------------
--Replace spaces in project names with dashes (-).
SELECT PROJ_NAME, REPLACE(PROJ_NAME, ' ', '-') FROM PROJECTS;

------------------------------------------------Senario#26-------------------------------------------------------
--Create a column showing employee ID padded to 5 digits with leading zeros.
SELECT e_first, e_last, LPAD(E_id, 5, 0)  FROM EMPLOYEEES;
SELECT * FROM EMPLOYEEES;

------------------------------------------------Senario#27-------------------------------------------------------
--Trim trailing spaces from department names and display the length before/after.
SELECT DEPT_ID, DEPT_NAME, LENGTH(DEPT_NAME) AS L_before, LENGTH(LTRIM(DEPT_NAME)) AS L_AFTER
FROM DEPARTMEENTS;

SELECT E_ID, E_FIRST, GENDER, LENGTH(GENDER) AS L_before, LENGTH(RTRIM(GENDER)) AS L_AFTER
FROM EMPLOYEEES;
------------------------------------------------Senario#28-------------------------------------------------------
--Show domain of employee emails by extracting substring after '@'.
----NO EMAILS COLUNM IN EMPLOYEEES TABLE, IF IT WAS PRESENT THE SOLUTION WOULD BE

SELECT E_first, SUBSTR(E_Mail, INSTR(E_Mail, '@', 1)) FROM EMPLOYEEES;

------------------------------------------------Senario#29-------------------------------------------------------
--Remove all vowels from employee first names (use multiple REPLACEs).
SELECT E_First, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(E_first, 'a',''), 'e',''),'i',''), 'o',''),'u','') AS Mod_name, 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(E_first, 'A',''), 'E',''), 'I',''), 'O',''), 'U','') AS MOD_text
FROM EMPLOYEEES;

------------------------------------------------Senario#30-------------------------------------------------------
--Count characters in every project name except spaces.
SELECT PROJ_NAME, LENGTH(REPLACE(PROJ_NAME, ' ', '')) FROM PROJECTS;

------------------------------------------------Senario#31-------------------------------------------------------
--Display only the last 4 characters of employee phone numbers.
--No number column though the solution will look like this if one existed.
SELECT E_first, SUBSTR(E_number, -4) FROM EMPLOYEEES;

------------------------------------------------Senario#32-------------------------------------------------------
--Convert employee names to Proper Case (Initcap).
SELECT Initcap(E_first) || ' ' || Initcap(E_last) AS E_name FROM EMPLOYEEES; 

------------------------------------------------Senario#33-------------------------------------------------------
--Show how many months each employee has worked (MONTHS_BETWEEN).
SELECT E_first || ' ' || E_last AS E_name, Round(MONTHS_BETWEEN(leaving_date, joining_date)) AS months_worked
FROM EMPLOYEEES;

------------------------------------------------Senario#34-------------------------------------------------------
--Add 6 months to project start date.
SELECT start_date, ADD_MONTHS(start_date, 6) AS ADDED_date FROM PROJECTS;

------------------------------------------------Senario#35-------------------------------------------------------
--Show the NEXT_DAY of joining date for Monday.
SELECT TO_CHAR(joining_date, 'FMDay, dd-mon-yyyy'), TO_CHAR(NEXT_DAY(joining_date, 'Monday'), 'FMDay, dd-mm-yyyy')
FROM EMPLOYEEES;
------------------------------------------------Senario#36-------------------------------------------------------
--Display LAST_DAY of each employee’s joining month.
SELECT E_first, LAST_DAY(joining_date) FROM EMPLOYEEES;
--LAST_DAY is used to return the last day of the month of the particular date. 

------------------------------------------------Senario#37-------------------------------------------------------
--Extract the year, month, day from joining_date and show in separate columns.
SELECT E_first, EXTRACT(DAY FROM joining_date) AS J_day,
EXTRACT(MONTH FROM joining_date) AS J_Month, 
EXTRACT(YEAR FROM joining_date) AS J_year 
FROM EMPLOYEEES;

------------------------------------------------Senario#38-------------------------------------------------------
------------------------------------------------Senario#39-------------------------------------------------------
------------------------------------------------Senario#40-------------------------------------------------------
