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

----------------------------------------------TO_NUMBER--------------------------------------------------
SELECT TO_DATE('May 22, 1999', 'MM DD, YYYY') FROM DUAL;
SELECT TO_DATE('22/12/23', 'DD-MM-YY') FROM DUAL;


