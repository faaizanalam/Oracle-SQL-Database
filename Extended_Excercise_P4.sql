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
WHERE GENDER = 'Male';       -----On the other hand = operator returns results based on comparision using equal.

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
--Show employees who joined within the last 90 days
SELECT * FROM EMPLOYEEES
WHERE joining_date >= SYSDATE - 90;

------------------------------------------------Senario#39-------------------------------------------------------
--Show the weekday name of joining_date using TO_CHAR + date format.
SELECT E_first, E_last, joining_date, TO_CHAR(NEXT_DAY(joining_date, 'Saturday'), 'FMDAY, dd-MON-YYYY') AS UP_weekend
FROM EMPLOYEEES;

------------------------------------------------Senario#40-------------------------------------------------------
--Display projects starting in the same month as today.
SELECT p.*, SYSDATE FROM PROJECTS p
WHERE (EXTRACT(MONTH FROM start_date) = EXTRACT(MONTH FROM SYSDATE));

------------------------------------------------Senario#41-------------------------------------------------------
--Calculate project duration in days.
SELECT Proj_name, start_date , end_date, Round(NVL(end_date, SYSDATE) - start_date) AS days  FROM PROJECTS;

------------------------------------------------Senario#42-------------------------------------------------------
--Show employees hired in 2021 using EXTRACT(YEAR FROM …).
SELECT * FROM EMPLOYEEES
WHERE EXTRACT(YEAR FROM joining_date) = 2021;

----------------------------------------------Advanced Senarios--------------------------------------------------
------------------------------------------------Senario#43-------------------------------------------------------
--ALTER TABLE EMPLOYEEES ADD Commission_pct NUMBER(8); 
--UPDATE EMPLOYEEES 
--SET Commission_pct = Salary * 0.10;
SELECT * FROM EMPLOYEEES;

--Write queries to:
--Display employee name and salary in this format:
--“$60,500.00 USD”
--(use conversion + numeric + character functions)

--Show salary category using CASE:
--< 40k → Low
--40k–80k → Medium
--80k → High

--Display commission as "No Commission" if NULL, else "Rs.<value>".

SELECT E_first || ' ' || E_last AS E_name,
TO_CHAR(SALARY, '$99,999,999.00') || ' USD' AS SALARY
FROM EMPLOYEEES;

SELECT E_first || ' ' || E_last AS E_name, SALARY, 
CASE 
WHEN SALARY < 40000 THEN 'Low'
WHEN SALARY BETWEEN 40000 AND 80000 THEN 'Medium'
WHEN SALARY > 80000 THEN 'High'
ELSE 'Invalid'
END
FROM EMPLOYEEES;


SELECT E_first || ' ' || E_last AS E_name,
NVL(TO_CHAR(Commission_pct), 'No Commission')
FROM EMPLOYEEES;

------------------------------------------------Senario#44-------------------------------------------------------
--Working With Dates
--Using hire_date:
--Show employee name and day of the week they were hired.
--Display hire_date in this format:
--"15-Jan-2022 (Saturday)"
--
--Calculate years of service, rounded down.
--
--Show "Old Employee" if > 10 years, else "New Employee".

SELECT E_first, E_last, TO_CHAR(joining_date, 'DAY') AS DAY_JOined
FROM EMPLOYEEES;

SELECT E_first, E_last, ROUND(MONTHS_BETWEEN(NVL(leaving_date, Sysdate), joining_date)/12) AS service
FROM EMPLOYEEES;

--Show "Old Employee" if > 10 years, else "New Employee".
SELECT E_first, E_last, ROUND(MONTHS_BETWEEN(NVL(leaving_date, Sysdate), joining_date)/12) AS service,
CASE
WHEN ROUND(MONTHS_BETWEEN(NVL(leaving_date, Sysdate), joining_date)/12) > 10 THEN 'Old Employee'
ELSE 'New Employee'
END
FROM EMPLOYEEES;

------------------------------------------------Senario#45-------------------------------------------------------
--Manipulating Text
--ALTER TABLE EMPLOYEEES
--ADD  Email VARCHAR2(50);
--
--UPDATE EMPLOYEEES
--SET Email = E_first || E_last || TO_CHAR(commission_pct) || '@honeybee.com'
--UPDATE EMPLOYEEES
--SET Email = lower(email);

--For columns first_name, last_name, email:
--Create a username:
--first 3 letters of first_name + last 2 letters of last_name (all lowercase)
--
SELECT LOWER(SUBSTR(e_first, 1, 3) || SUBSTR(e_last, -2)) AS Username  
FROM EMPLOYEEES;

--Extract domain from email (everything after @).
--
SELECT E_first, email, SUBSTR(email, INSTR(Email, '@')) AS domain 
FROM EMPLOYEEES;

--Show email without any digits.

--Show: "Name Length: <total characters>".
SELECT E_FIRST || ' ' || E_last AS E_name,
LENGTH( E_FIRST || ' ' || E_last) AS N_length,
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Email, '0', '')
, 1, ''), 2, ''), 3, ''), 4, ''), 5, ''), 6, ''), 7, ''), 8, ''), 9, '') AS D_Result
FROM EMPLOYEEES;

------------------------------------------------Senario#46-------------------------------------------------------
--Numeric Tasks
--Using columns salary, bonus, overtime_hours:
--Increase salary by 12.5% and round to 2 decimals.
SELECT E_first, SALARY + SALARY * 0.125  AS SALARY125 FROM EMPLOYEEES;

--Calculate total earning: salary + NVL(bonus, 0) + (overtime_hours * 500).
--Truncate salary to nearest thousand.
SELECT E_first, E_last, TRUNC(SALARY) FROM EMPLOYEEES;

--Display the absolute difference between salary and bonus.
--Assuming we have a bonus column
SELECT E_first, E_last, ABS(BONUS - SALARY) 
FROM EMPLOYEEES;

------------------------------------------------Senario#47-------------------------------------------------------
--Conversion Tasks
--Given a table with text_salary (VARCHAR) and text_date (VARCHAR):
--Convert text_salary '60,500' into number.
--Convert text_date '12-05-2021' into date.
--Display both converted values in a single query.
--Convert salary back into a VARCHAR with "PKR " prefix.

--AS SALARY AND DATE are already in the specified format lets assume for now.
SELECT TO_NUMBER('60,500', '9,999,999') FROM DUAL;

SELECT TO_DATE('12-05-2021', 'dd-mm-yyyy') FROM DUAL;

SELECT TO_NUMBER('60,500', '9,999,999'), TO_DATE('12-05-2021', 'dd-mm-yyyy') FROM DUAL;

--Convert salary back into a VARCHAR with "PKR " prefix.
SELECT CAST(60500 AS VARCHAR2(10)) FROM DUAL;

------------------------------------------------Senario#48-------------------------------------------------------
--CONDITIONAL Logic Challenges
--For every employee:
--If salary is NULL → show "Not Assigned", else show salary.
SELECT E_first, NVL(TO_CHAR(SALARY), 'Not Assigned') FROM EMPLOYEEES;

--If joining_date is in the current year → show "New Joiner".
SELECT E_First, 
CASE
WHEN EXTRACT(YEAR FROM joining_date) =  EXTRACT(year from SYSDATE)
THEN 'New Joiner'
ELSE 'OTHER'
END
FROM EMPLOYEEES;

SELECT E_FIRst, 
DECODE(EXTRACT(YEAR FROM joining_date), EXTRACT(year from SYSDATE), 'New Joiner', 'Unknown')
FROM EMPLOYEEES;

--If gender = 'M' → "Mr." + name, else "Ms." + name.
--USING CASE BECAUSE IT IGNORES TRAILING SPACES
SELECT 
CASE GENDER
WHEN 'Male' THEN 'Mr.' || E_first
WHEN 'Female' THEN 'Mrs.' || E_first
ELSE 'Gender not specified'
END
FROM EMPLOYEEES;

--If commission < 0 → force it to 0 using conditional functions.

------------------------------------------------Senario#49-------------------------------------------------------
--Date Arithmetic
--Using start_date, end_date:
--Show project duration in days.
SELECT PROJ_name, Round((NVL(end_date, SYSDATE) - start_date)) AS Duration From Projects;

--Show duration in months (rounded).
SELECT Proj_name, ROUND(MONTHS_BETWEEN(NVL(end_date, SYSDATE), start_date)) AS duration FROM PROJECTS;

--Add 45 days to start_date.
SELECT Proj_Name, start_date + 45 FROM PRojects; 

--Show "Expired" if end_date < SYSDATE else "Active".
SELECT PROJ_NAME, 
CASE 
WHEN end_date < SYSDATE THEN 'Expired'
ELSE 'Active'
END
AS STATUS FROM PROJECTS;

------------------------------------------------Senario#50-------------------------------------------------------
--Text Cleaning + Formatting
--Given a column description:
--Remove leading/trailing spaces.
SELECT '    THIS IS A Column    ', TRIM('    THIS IS A Column    ') AS TRIMMED_TEXT FROM DUAL;
--Convert multiple spaces between words to single space.
SELECT 'This  is   a  text     , with  multiple  spaces   .', 
REGEXP_REPLACE('This  is   a  text     , with  multiple  spaces   .',' {2,}',' ' ) 
FROM DUAL;
--Convert entire string to Proper Case (First letter uppercase).
SELECT INITCAP('this is a string') FROM DUAL;
--Extract first 10 characters and append "...".
SELECT RPAD(SUBSTR('This is a String.', 1, 10), 13, '-') FROM DUAL;

SELECT SUBSTR('This is a String.', 1, 10) || '---' FROM DUAL;

------------------------------------------------Senario#51-------------------------------------------------------
--Mixed-Type Challenge
--Given:
--employee_name, dept_code (like "D-15"), join_date.
--Extract department number from dept_code using SUBSTR/INSTR.
--Display the joining month name only.
SELECT EXTRACT(MONTH FROM joining_date) AS joining_month FROM EMPLOYEEES;

--Mask the employee name like:
--"F**** A***"
--(first letter only + * for rest)
SELECT RPAD(SUBSTR(E_first, 1,1), length(E_first), '*')|| ' ' || RPAD(SUBSTR(E_last, 1,1), length(E_last), '*') AS NAME
FROM EMPLOYEEES; 

--Show:
--"Joined X days ago"
--(compute using SYSDATE - join_date)
SELECT E_First || ' joined us ' || ROUND(SYSDATE - joining_date) || ' days ago' FROM EMPLOYEEES;

------------------------------------------------Senario#52-------------------------------------------------------
--NULL + Conversion + Character Mix
--Given nullable columns address_line1, address_line2:
--Create a full_address as:
--"Line1, Line2"
--but if line2 is NULL → only line1.
-----#####----Assuming----
SELECT 'Address  1' || NULL as Full_Address FROM DUAL;
SELECT 'Address  1,' || ' Address 2' as Full_Address FROM DUAL;
SELECT CONCAT('Address_1', 'Address_2') FROM DUAL;
SELECT CONCAT('Address_1', Null) FROM DUAL;

--Replace NULL with "N/A" in both lines.
SELECT CONCAT('Address_1', NVL(NULL, ' N/A')) FROM DUAL;

--Convert full_address to uppercase.
SELECT UPPER(CONCAT('Address_1', NVL(NULL, ' N/A'))) FROM DUAL;

--Show total address length.
SELECT LENGTH(CONCAT('Address_1', NVL(NULL, ' N/A'))) AS LENGTH FROM DUAL;

------------------------------------------------Senario#53-------------------------------------------------------
------------------------------------------------Senario#54-------------------------------------------------------


