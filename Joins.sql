SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT FIRST_NAME FROM Employees, Departments
WHERE Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID;

-------------------NATURAL JOIN uses the same logic-----------------

SELECT First_Name, Last_Name FROM Employees NATURAL JOIN Departments;

------------------If there are two are more than two common columns in participant tables

SELECT First_Name, Last_Name FROM Employees
NATURAL JOIN Departments
-----------------Employees and Department is joined and the resultant table 
------------------is natural joined with JOB_History....
NATURAL JOIN JOB_HISTORY;

SELECT * FROM JOB_HISTORY;

SELECT * FROM Employees
NATURAL JOIN Departments;



---SELECT (COLUMN_NAMES SEPERATED BY COMMAS) FROM <TABLE A>
-----NATURAL JOIN <TABLE B>;

SELECT * FROM Employees, Departments;

select * from employees s, employees t;


SELECT * FROM Employees E
JOIN Employees T
ON (E.first_name= t.first_name) AND (e.hire_date < TO_DATE('2009-12-12','YYYY-MM-DD'));


SELECT * FROM Employees E
JOIN Employees T ------------------------FIND DUPLICATES
ON (E.first_name = t.first_name) AND E.EMPLOYEE_ID <> T.EMPLOYEE_ID
ORDER BY E.First_name;


-----------------------------EQUI JOIN-------------------------------------

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM Employees E
JOIN departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.MANAGER_ID = D.MANAGER_ID);



---------------------------LEFT OUTER JOIN---------------------

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM Employees E
LEFT OUTER JOIN departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.MANAGER_ID = D.MANAGER_ID);


---------------------------RIGHT OUTER JOIN-----------------------------
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, E.DEPARTMENT_NAME FROM Employees E
RIGHT OUTER JOIN departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.MANAGER_ID = D.MANAGER_ID);


---------------------------FULL OUTER JOIN---------------------------
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM Employees E
FULL OUTER JOIN departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.MANAGER_ID = D.MANAGER_ID);

--------------------------INNER JOIN--------------------
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM Employees E
INNER JOIN departments D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.MANAGER_ID = D.MANAGER_ID);





------------------------------------JOINS Practice---------------------------------------
SELECT * FROM DEPARTMENTS;

SELECT * FROM Employees
NATURAL JOIN Departments;

SELECT * FROM Departments
Natural Join Employees;

SELECT * FROM Employees
NATURAL JOIN Departments
WHERE Employee_id > 1;

------------------------------SELF JOIN----------------------------------

SELECT * FROM Employees E
JOIN Employees T
ON (T.EMPLOYEE_ID = E.EMPLOYEE_ID)
WHERE E.COMMISSION_PCT IS NOT NULL;


SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME FROM Employees 
NATURAL JOIN DEPARTMENTS;

SELECT S.FIRST_NAME, S.LAST_NAME, S.DEPARTMENT_ID FROM Employees S
JOIN Employees T
ON (S.Employee_id = T.Employee_id) AND (S.HIRE_DATE = T.HIRE_DATE);

SELECT S.FIRST_NAME, S.LAST_NAME, S.DEPARTMENT_ID, S.HIRE_DATE FROM Employees S
JOIN Employees T
ON (S.Employee_id = T.Employee_id) AND (S.HIRE_DATE = T.HIRE_DATE)
WHERE S.DEPARTMENT_ID = T.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;






