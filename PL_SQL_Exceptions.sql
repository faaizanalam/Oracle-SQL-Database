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
-->Create a user defined exception too_much_cost and assign -20333 error code to it.
---->If total salary of the dept 'Administration' is greater than 30,000 than raise the too much cost exception and print suitable message to 
----handle the exception.


DECLARE
    too_much_cost EXCEPTION;
    PRAGMA EXCEPTION_INIT(too_much_cost, -20333);
    v_sal NUMBER(5);
BEGIN
    SELECT SUM(SALARY) INTO v_sal FROM EMPLOYEES
    WHERE department_id = 
        (SELECT department_id FROM DEPARTMENTS
            WHERE department_name = 'Administration');
    
    IF v_sal > 30000 THEN
        RAISE too_much_cost;
    END IF;
    dbms_output.put_line('The exception did not execute');
EXCEPTION
    WHEN too_much_cost THEN
        dbms_output.put_line('Salary sum of Administration staff exceeds 30000');
END;
/

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

-->If total employees having salary > 8000 are more than 10 than raise too_many_rows system exception and catch this exception with suitable message
-->In continuation to it, if above exception is not thrown then only check for number employees with salary > 5000.
-->If it is more than 8 then raise user defined exception and handle it 


DECLARE
    v_cont NUMBER(8):= 0;
    more_than_eight EXCEPTION;
    PRAGMA EXCEPTION_INIT(more_than_eight, -20001);

BEGIN
    SELECT COUNT(SALARY) INTO v_cont FROM EMPLOYEES
    WHERE SALARY > 8000;
    
--    SELECT COUNT(SALARY) INTO v_cont FROM EMPLOYEES
--    WHERE SALARY > 11500;
    dbms_output.put_line(v_cont);
    
    IF v_cont > 10 THEN
        RAISE too_many_rows;
        
    ELSIF v_cont > 8 THEN
        RAISE more_than_eight;
        
    END IF;
    
EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('Returned rows exceed 10');
    WHEN more_than_eight THEN
        dbms_output.put_line('2nd Exception, rows exceed 8');
END;
/

SELECT COUNT(SALARY) FROM EMPLOYEES
    WHERE SALARY > 11500;

-------------------------------------------------RAISE APPLICATION ERROR----------------------------------------------------------------
-----------------------------------------------**************************---------------------------------------------------------------
-->Using raise application error raise the application error if current_second is odd.
---->If the current second is even then check for the current minute of the time and if it is odd then raise another application error.
---->In both the cases, the error message and error code should be different.
DECLARE
    v_sec NUMBER(4);
    v_min NUMBER(4);
BEGIN
    SELECT TRUNC(EXTRACT(SECOND FROM SYSTIMESTAMP)) INTO v_sec FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('SECONDS : ' || v_sec);
    IF MOD(v_sec, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION 1 ODD SECONDS');
        RAISE_APPLICATION_ERROR(-20002, '1st Exception, Current second is odd!');
        DBMS_OUTPUT.PUT_LINE('EXCEPTION 1');
    ELSIF MOD(v_sec, 2) = 0 THEN
        SELECT TRUNC(EXTRACT(MINUTE FROM SYSTIMESTAMP)) INTO v_min FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('MINUTES : ' || v_min);
        DBMS_OUTPUT.PUT_LINE('EXCEPTION 2 EVEN SECONDS');
        IF MOD(v_min, 2) = 1 THEN
            RAISE_APPLICATION_ERROR(-20004, '2nd Exception, Current minute is odd!');
        END IF;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Execption Handled');
END;
/


SELECT ROUND(EXTRACT(SECOND FROM SYSTIMESTAMP)) FROM DUAL;

SELECT ROUND(EXTRACT(SECOND FROM SYSTIMESTAMP)),
TRUNC(EXTRACT(SECOND FROM SYSTIMESTAMP)) 
FROM DUAL;

-->If total salary of HR department is greater than Operations department.
---->Then raise error with HR > Operations error and code should be -20400.
---->ELSE raise error with Operations > HR error and code should be -20500.

DECLARE
    v_hr NUMBER(8);
    v_opr NUMBER(8);
    
BEGIN
    SELECT SUM(SALARY) INTO v_hr FROM EMPLOYEES
    WHERE department_id = (SELECT department_id FROM DEPARTMENTS
        WHERE department_name = 'Human Resources');
        
    SELECT SUM(SALARY) INTO v_opr FROM EMPLOYEES
    WHERE department_id = (SELECT department_id FROM DEPARTMENTS
        WHERE department_name = 'Operations');
    
    DBMS_OUTPUT.PUT_LINE('TOTAL SALARY HR : ' || v_hr);
    DBMS_OUTPUT.PUT_LINE('TOTAL SALARY Operations : ' || NVL(v_opr, 0));
    
    IF v_hr > v_opr THEN
        DBMS_OUTPUT.PUT_LINE('HR SALARY SUM IS GREATER THAN OPERATIONS');
        RAISE_APPLICATION_ERROR(-20400, 'HR > Operation');
    ELSIF v_hr < v_opr THEN
        DBMS_OUTPUT.PUT_LINE('HR SALARY SUM IS LESS THAN OPERATIONS');
        RAISE_APPLICATION_ERROR(-20400, 'HR < Operation');
    ELSE
        DBMS_OUTPUT.PUT_LINE('HR SALARY SUM IS EQUAL THAN OPERATIONS');
        RAISE_APPLICATION_ERROR(-20400, 'HR = Operation');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
END;
/

SELECT SUM(SALARY) FROM EMPLOYEES
WHERE department_id = (SELECT department_id FROM DEPARTMENTS
        WHERE department_name = 'Human Resources');
        
    
SELECT SUM(SALARY) FROM EMPLOYEES
WHERE department_id = (SELECT department_id FROM DEPARTMENTS
        WHERE department_name = 'Operations');




