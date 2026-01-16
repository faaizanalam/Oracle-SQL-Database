----------------------------------------------------------Pl/SQL Record Type----------------------------------------------------------------
----------------------------------------------------------************************----------------------------------------------------------
--Using the record type based on table, print the details of the employees: Check(Firstname);
set serveroutput on;
DECLARE
    vrec_emp employeess%ROWTYPE;
BEGIN
    SELECT * INTO vrec_emp FROM EMPLOYEESS
    WHERE E_FIRST = 'Iqra';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || vrec_emp.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('E_FIRST : ' || vrec_emp.E_FIRST);
    DBMS_OUTPUT.PUT_LINE('E_LAST : ' || vrec_emp.E_LAST);
    DBMS_OUTPUT.PUT_LINE('AGE : ' || vrec_emp.AGE);
    DBMS_OUTPUT.PUT_LINE('GENDER : ' || vrec_emp.GENDER);
    DBMS_OUTPUT.PUT_LINE('DEPT_ID : ' || vrec_emp.DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('MGR_ID : ' || vrec_emp.MGR_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || vrec_emp.SALARY);
    DBMS_OUTPUT.PUT_LINE('JOINING_DATE : ' || vrec_emp.JOINING_DATE);
    DBMS_OUTPUT.PUT_LINE('LEAVING_DATE : ' || vrec_emp.LEAVING_DATE);
END;
/

SELECT * FROM EMPLOYEESS
WHERE E_FIRST = 'Iqra';
DESC EMPLOYEESS;

----------------------------------------------------------************************----------------------------------------------------------
--Using the record type based on the table, fetch the data from the table and print the data of the lowest salaried employee with salary 
--greater than 7500 in ascending order.

DECLARE
    vrec_emp Employeess%ROWTYPE;
BEGIN
    SELECT * INTO vrec_emp FROM EMPLOYEESS
    WHERE SALARY > 7500
    ORDER BY SALARY DESC
    FETCH FIRST 1 ROWS ONLY;
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || vrec_emp.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('E_FIRST : ' || vrec_emp.E_FIRST);
    DBMS_OUTPUT.PUT_LINE('E_LAST : ' || vrec_emp.E_LAST);
    DBMS_OUTPUT.PUT_LINE('AGE : ' || vrec_emp.AGE);
    DBMS_OUTPUT.PUT_LINE('GENDER : ' || vrec_emp.GENDER);
    DBMS_OUTPUT.PUT_LINE('DEPT_ID : ' || vrec_emp.DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('MGR_ID : ' || vrec_emp.MGR_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || vrec_emp.SALARY);
    DBMS_OUTPUT.PUT_LINE('JOINING_DATE : ' || vrec_emp.JOINING_DATE);
    DBMS_OUTPUT.PUT_LINE('LEAVING_DATE : ' || vrec_emp.LEAVING_DATE);
    
END;
/

----------------------------------------------------------************************----------------------------------------------------------
-->Using the record type based on table, fetch the data of employee: 'Iqra'
---->and using the same record type update only salary, manager_id, dept_id of employee: 'Adeel';
DECLARE
    vrec_emp Employeess%ROWTYPE;
    
BEGIN
    SELECT * INTO vrec_emp FROM EMPLOYEESS
    WHERE E_first = 'Iqra';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || vrec_emp.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('E_FIRST : ' || vrec_emp.E_FIRST);
    DBMS_OUTPUT.PUT_LINE('E_LAST : ' || vrec_emp.E_LAST);
    DBMS_OUTPUT.PUT_LINE('AGE : ' || vrec_emp.AGE);
    DBMS_OUTPUT.PUT_LINE('GENDER : ' || vrec_emp.GENDER);
    DBMS_OUTPUT.PUT_LINE('DEPT_ID : ' || vrec_emp.DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('MGR_ID : ' || vrec_emp.MGR_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || vrec_emp.SALARY);
    DBMS_OUTPUT.PUT_LINE('JOINING_DATE : ' || vrec_emp.JOINING_DATE);
    DBMS_OUTPUT.PUT_LINE('LEAVING_DATE : ' || vrec_emp.LEAVING_DATE);
    
--    UPDATE SET EMPLOYEESS
--    SET ROW = vrec_emp;
        --Above query would update the whole row with the record, not a solution to the problem.
    
    -->>>One way of doing the update...
--    UPDATE EMPLOYEESS
--    SET SALARY = vrec_emp.SALARY, manager_id = vrec_emp.manager_id, dept_id = vrec_emp.dept_id
--    WHERE E_first = 'Adeel';
    
    ---> Alternatively we have a better solution to this --->
    --Since the record type 'vrec_emp' is storing the record of employee 'Iqra', we'll just update the columns in vrec_emp which need to be
    --updated in employee 'Adeel' by row values of 'Adeel'.
    SELECT EMP_ID, E_FIRST, E_LAST, AGE, GENDER, JOINING_DATE, LEAVING_DATE INTO 
    vrec_emp.EMP_ID, vrec_emp.E_FIRST, vrec_emp.E_LAST, vrec_emp.AGE, vrec_emp.GENDER, vrec_emp.JOINING_DATE, vrec_emp.LEAVING_DATE
    FROM EMPLOYEESS
    WHERE E_First = 'Adeel';
    
    UPDATE EMPLOYEESS
    SET ROW = vrec_emp
    WHERE E_FIRST = 'Adeel';
    
END;
/

SELECT * FROM EMPLOYEESS
WHERE E_FIRST IN ('Iqra','Adeel');
desc EMPLOYEESS;
----------------------------------------------------------************************----------------------------------------------------------
-->Insert one record into department table using record type based on table.
DECLARE
    vrec_dept DEPARTMENTSS%ROWTYPE;
BEGIN
    vrec_dept.Variable := 34;
    vrec_dept.DEPT_ID := 12;
    vrec_dept.DEPT_NAME := 'Administration';
    vrec_dept.LOCATION := 'Faisalabad';
    
    INSERT INTO DEPARTMENTSS VALUES vrec_dept;
END;
/

----------DATA_DICTIONARIES REVISION
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_OBJECTS;
SELECT * FROM USER_TAB_COLUMNS;
SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_TRIGGERS;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_TAB_COMMENTS;

SELECT * FROM DEPARTMENTSS;



