SELECT * FROM EMPLOYEEES
ORDER BY SALARY DESC;
SELECT * FROM PROJECTS;
SELECT * FROM MANAGEERS;
SELECT * FROM DEPARTMEENTS;

-----------------------SQL AGGREGATE FUNCTION----------------------------------
SELECT COUNT(mgr_first) FROM MANAGEERS;
SELECT COUNT(*) FROM MANAGEERS;

SELECT MAX(joining_date), MIN(AGE), MIN(leaving_date), AVG(Salary) FROM MANAGEERS;
SELECT SUM(SALARY)/COUNT(SALARY) AS AVERAGE_SALARY FROM MANAGEERS;

SELECT DISTINCT(COUNT(mgr_first)) FROM MANAGEERS;
SELECT COUNT(DISTINCT mgr_first) FROM MANAGEERS;

SELECT AVG(DISTINCT SALARY) FROM MANAGEERS; 

-------------------SQL SUBQUERIES-------------------------------------------

SELECT E_first || ' ' || E_last AS E_Name FROM 
EMPLOYEEES WHERE
SALARY = (SELECT SALARY FROM EMPLOYEEES 
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEEES));







------------------------------------SQL GROUP BY-----------------------------------
SELECT COUNT(dept_id) FROM EMPLOYEEES;

SELECT E_first, dept_id FROM EMPLOYEEES GROUP BY dept_id;

SELECT dept_id, COUNT(*) FROM EMPLOYEEES GROUP BY dept_id;

SELECT dept_id, count(*) FROM EMPLOYEEES;

SELECT dept_id FROM EMPLOYEEES
WHERE Count(emp)<2;


SELECT E_first || ' ' || E_last AS E_Name, dept_id FROM EMPLOYEEES
WHERE dept_id IN (SELECT dept_id FROM EMPLOYEEES GROUP BY dept_id
HAVING COUNT(*) < 3);


SELECT * FROM 
(SELECT MAX(SALARY) FROM EMPLOYEEES
GROUP BY dept_id);

-----------------------------------------------Senariosss-------------------------------------------------------
SELECT * FROM EMPLOYEEES;
SELECT * FROM DEPARTMEENTS;
SELECT * FROM MANAGEERS;
SELECT * FROM PROJECTS;
------------------------------------------------Senario#1-------------------------------------------------------
--Count employees per department
--Show each dept_id and how many employees are in that department.
--Show only departments where employee count > 3.

SELECT dept_id, count(dept_id) AS NUMBER_OF_EMP FROM EMPLOYEEES -------1 & 2
GROUP BY dept_id;

SELECT dept_id FROM EMPLOYEEES
GROUP BY dept_id                       -------------------------3
HAVING count(dept_id) > 3;

------------------------------------------------Senario#2-------------------------------------------------------
--Find average salary of Male and Female employees separately using GROUP BY.
SELECT Gender, CAST(AVG(SALARY) AS INT) AS AVG_SALARY FROM EMPLOYEEES
GROUP BY Gender;

------------------------------------------------Senario#3-------------------------------------------------------
--Show employees whose age is greater than the average age of all employees
--(using a subquery inside WHERE
SELECT E_first || ' ' || E_last AS E_Name, AGE FROM EMPLOYEEES
WHERE AGE > (SELECT AVG(AGE) FROM EMPLOYEEES);  ---------------AVG(AGE) = 28.85

SELECT AGE FROM EMPLOYEEES;

------------------------------------------------Senario#4-------------------------------------------------------
--Group projects by dept_id and show total budget.
--Filter only those departments whose total budget is above 1,000,000.
SELECT * FROM PROJECTS;
SELECT dept_id, SUM(BUDGET) FROM PROJECTS
GROUP BY dept_id;

SELECT dept_id FROM PROJECTS
GROUP BY dept_id 
HAVING SUM(BUDGET) > 1000000;
------------------------------------------------Senario#5-------------------------------------------------------
--Use subquery to display name + salary of employee(s) whose salary equals
--the maximum salary in the entire company.
--(Make sure it handles ties)

SELECT E_first || ' ' || E_last AS E_Name, SALARY FROM EMPLOYEEES
WHERE SALARY >= (SELECT MAX(SALARY) FROM EMPLOYEEES) AND
SALARY >= (SELECT MAX(SALARY) FROM MANAGEERS);

UPDATE EMPLOYEEES
SET SALARY = 150000
WHERE SALARY = 95000;

------------------------------------------------Senario#6-------------------------------------------------------
--Use aggregate function with a conditional check in WHERE:
--Active → end_date IS NULL
--Completed → end_date IS NOT NULL
--Show total count for each group.

-----------------

------------------------------------------------Senario#7-------------------------------------------------------
--Find departments that have more than one manager
--Use HAVING to filter groups where count(mgr_id) > 1.

SELECT dept_id FROM MANAGEERS
GROUP BY dept_id
HAVING count(mgr_id) > 1; 

------------------------------------------------Senario#8-------------------------------------------------------
--Average project duration
--For each department show the average duration of projects
--(duration = end_date – start_date).
--Ignore projects where end_date is NULL (still running).

SELECT AVG(DISTINCT(End_date) - Start_date) AS PROJECT_DURATION, dept_id FROM PROJECTS
GROUP BY dept_id; 

SELECT * FROM PROJECTS;

------------------------------------------------Senario#9-------------------------------------------------------
--Use a subquery to find the employee(s) with the second highest salary.
--No ORDER BY LIMIT tricks — only subqueries logic.

SELECT * FROM EMPLOYEEES
WHERE SALARY = (SELECT 


------------------------------------------------Senario#10-------------------------------------------------------
--Find employees whose salary is greater than the average salary of their gender group
--(using a correlated subquery).

SELECT * FROM EMPLOYEEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES)

;
------------------------------------------------Senario#11-------------------------------------------------------
--Show employee name + salary where salary is
--less than the overall company average salary
--(using a subquery in WHERE)
SELECT E_first || ' ' || E_last AS E_Name, Salary FROM EMPLOYEEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEEES) AND 
SALARY < (SELECT AVG(SALARY) FROM MANAGEERS);

------------------------------------------------Senario#12-------------------------------------------------------
--Department(s) with the highest number of employees
--Use a subquery to find the max employee count,
--then show dept_id(s) with that count.
SELECT dept_id, COUNT(dept_id) AS N_of_Emp FROM EMPLOYEEES
GROUP BY dept_id;




HAVING COUNT(dept_id) =   
(SELECT MAX(COUNT(dept_id)) FROM EMPLOYEEES
GROUP BY dept_id);

------------------------------------------------Senario#13-------------------------------------------------------
--Managers earning above manager-average salary
--Find managers whose salary is greater than the average salary of all managers.
--Use a subquery — no joins.

SELECT mgr_first || ' ' || mgr_last AS M_name, SALARY FROM MANAGEERS
WHERE SALARY > (SELECT AVG(SALARY) FROM MANAGEERS);

------------------------------------------------Senario#14-------------------------------------------------------
--Find departments where all employees are above age 30
--Use GROUP BY and a HAVING condition on MIN(age).
SELECT dept_id FROM EMPLOYEEES 
GROUP BY dept_id
HAVING MIN(AGE) = 28;

SELECT * FROM EMPLOYEEES
ORDEr BY dept_id;
------------------------------------------------Senario#15-------------------------------------------------------
--Total budget vs average budget difference
--For each department:
--Show dept_id + (SUM(budget) − (overall AVG(budget) from subquery))
--→ demonstrates aggregate inside SELECT subquery logic

SELECT dept_id, sum(budget) - AVG(budget) AS Budget_Difference FROM PROJECTS
GROUP BY dept_id;

SELECT * FROM PROJECTS;
SELECT DEPT_id, AVG(BUDGET) FROM PROJECTS
GROUP BY DEPT_ID;
SELECT DEPT_id, BUDGET FROM PROJECTS
ORDER BY dept_id;
------------------------------------------------Senario#16-------------------------------------------------------
--Top 3 (tied) highest cost projects
--Show all projects whose budget is in the top 3 highest distinct budgets
--using subqueries only
--(no FETCH/TOP/ROWNUM)



