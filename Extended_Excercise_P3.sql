---------------------------------Functions in SQL - A Detailed excercise-------------------------------------
SELECT * FROM EMPLOYEEES;
SELECT * FROM MANAGEERS;
SELECT  *FROM DEPARTMEENTS;
SELECT * FROM PROJECTS;

--------------------------------------Conversion Function---------------------------------
--------------------------------------Implicit Conversion---------------------------------
SELECT * FROM EMPLOYEEES
WHERE SALARY < '500000';  -------implicit conversion of string to number

---------------------------------------Explicit Conversions------------------------------
----------------------------------------Conversion Functions-----------------------------
----------------------------------------------TO_CHAR------------------------------------
SELECT TO_CHAR(1234) FROM dual; -------Strings show up at left side of the output dialog 
SELECT 1234 FROM dual;        ---------Numbers show up at right side of the output dialog

SELECT SYSDATE FROM dual;
SELECT To_CHAR(sysdate) AS A FROM DUAL;

SELECT E_first || ' ' || E_last AS E_NAME, TO_CHAR(joining_date, 'MM-DD-YY HH-MI-SS') FROM EMPLOYEEES;
SELECT E_first || ' ' || E_last AS E_NAME, TO_CHAR(joining_date, 'MM/DD/YY') FROM EMPLOYEEES;
SELECT E_first || ' ' || E_last AS E_NAME, TO_CHAR(joining_date, 'MM-YYYY--DD') FROM EMPLOYEEES;
SELECT E_first || ' ' || E_last AS E_NAME, TO_CHAR(joining_date, 'MM YYYY DD') FROM EMPLOYEEES;

SELECT TO_CHAR(1234, '$99999999') FROM dual;
SELECT E_first, TO_CHAR(SALARY, '$99,999,999')FROM EMPLOYEEES;
SELECT mgr_first, TO_CHAR(SALARY, '$999,999,999') FROM MANAGEERS;

----------------------------------------------TO_NUMBER--------------------------------------------------
SELECT TO_NUMBER('45,000', '9,999,999,999') FROM dual;
SELECT TO_NUMBER('$45,000', '$9,999,999,999') FROM dual;
SELECT TO_NUMBER('$45,000.002', '$9,999,999,999.999999') FROM dual;
SELECT TO_NUMBER('String') FROM DUAL;   -----error
SELECT TO_NUMBER('$55,000', 'L99,999') FROM DUAL; ----------L is used for currency;

SELECT * FROM nls_session_parameters;

//SELECT TO_NUMBER(45000, '00000000') FROM dual;

----------------------------------------------TO_NUMBER--------------------------------------------------
SELECT TO_DATE('May 22, 1999', 'MM DD, YYYY') FROM DUAL;
SELECT TO_DATE('22/12/23', 'DD-MM-YY') FROM DUAL;


----------------------------------------------NULL HANDLING--------------------------------------------------
---------------------------------------------------NVL-------------------------------------------------------
SELECT E_id, NVL(TO_CHAR(leaving_date, 'DD-MM-YYYY'), 'Working Employee') FROM EMPLOYEEES;
SELECT * FROM EMPLOYEEES;

SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID, First_name, Last_name, NVL(commission_pct, 'NOT Assigned yet') FROM employees;  -----String cannot be converted to Number
SELECT EMPLOYEE_ID, First_name, Last_name, NVL(commission_pct, '0') FROM employees;   ------
SELECT * FROM EMPLOYEES;

-------------------------------------------- ------NVL2-------------------------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, NVL2(commission_pct, Salary*commission_pct, '0')FROM EMPLOYEES;
SELECT * FROM EMPLOYEES;


---------------------------------------------------COALESCE---------------------------------------------------
SELECT COALESCE(First_name, Last_name, Email, Phone_number) AS COALESCE FROM EMPLOYEES;
SELECT COALESCE(Commission_pct, Employee_id, SALARY) AS COALESCE FROM EMPLOYEES;

----------------------------------------------------NULLIF----------------------------------------------------
SELECT NULLIF(123,123) FROM dual;
SELECT NULLIF('Faizan', 'Faizan') FROM dual;    ------Return 1st parameter when there is not a match.
SELECT NULLIF('hello', 'Hello') FROM dual;

-----------------------------------------------------LNNVL----------------------------------------------------
SELECT * FROM EMPLOYEEES 
WHERE LNNVL(leaving_date = NULL);

SELECT * FROM EMPLOYEEES 
WHERE LNNVL(leaving_date <> NULL);

SELECT * FROM EMPLOYEEES 
WHERE LNNVL(leaving_date IS NULL);

SELECT * FROM EMPLOYEEES 
WHERE LNNVL(leaving_date IS NOT NULL);

-----------------------------------------------------Conditional Functions-----------------------------------------
---------------------------------------------------------Case Statement--------------------------------------------
commit;



