----------------------------------------------------------Exception handling in SQL----------------------------------------------------------
----------------------------------------------------------************************----------------------------------------------------------
--Create a PL/SQL Block to fetch employees salary having first name "Ali".
--->If not available then show the highest salary using exception block.
SET SERVEROUTPUT ON;
DECLARE
    v_var NUMBER(9);
BEGIN
    SELECT SALARY INTO v_var FROM EMPLOYEES
    WHERE first_name = 'Ali';
    dbms_output.put_line(v_var);

EXCEPTION    
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Exception section: No data was found!');
        dbms_output.put_line('Printing highest salary instead');
        SELECT MAX(SALARY) INTO v_var FROM EMPLOYEES;
        dbms_output.put_line('Highest Salary : ' || v_var);  
END;
/


--Create a Pl/SQL Block to fetch the highest paid employee in dept = 4.
---> IF no employee exist for dept 4 then 
------> display dept name of dept 4.
---------> If dept does not exist then create dept with id =4 and name "Production" and location = "Lasbela".
DECLARE
    v_nam VARCHAR2(20);
    v_dept_name VARCHAR2(45);
BEGIN
    SELECT first_name INTO v_nam FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 4;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        BEGIN
            SELECT DEPT_NAME INTO v_dept_name FROM DEPARTMENTSS
            WHERE DEPT_ID = 11;
            dbms_output.put_line(v_dept_name);
        EXCEPTION
           WHEN NO_DATA_FOUND THEN 
                INSERT INTO DEPARTMENTSS(DEPT_ID, DEPT_NAME, LOCATION)
                VALUES(11, 'Production', 'Lasbela');
                dbms_output.put_line('Data Inserted');
        END;
    
END;
/

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTSS;

----------------------------------------------RAISE EXCEPTION--------------------------------------------------------
----------------------------------------***************************--------------------------------------------------
DECLARE
    
BEGIN
    
EXCEPTION
    
END;
/





















