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

---------------------------------------OTHERS EXCEPTION : SQLCODE & SQLERRM-------------------------------------------------------------
-----------------------------------------------*********************--------------------------------------------------------------------
-----------------------------------------------INTERNAL EXCEPTION-----------------------------------------------------------------------
DECLARE
    v_num NUMBER(5);
BEGIN
    SELECT 50000000 INTO v_num FROM DUAL;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR CODE : ' || SQLCODE);
        dbms_output.put_line('ERROR MESSAGE : ' || SQLERRM);
END;
/

-----------------------------------------------UNNAMMED EXCEPTION-----------------------------------------------------------------------
DECLARE 
    v_exp EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_exp, -2292);
BEGIN
    DELETE FROM DEPARTMENTS
    WHERE DEPARTMENT_NAME = 'Human Resources';
    
EXCEPTION
    WHEN v_exp THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DELETING, FOREIGN KEY CONSTRAINT VOILATED!');
        dbms_output.put_line('ERROR CODE : ' || SQLCODE);
        dbms_output.put_line('ERROR MESSAGE : ' || SQLERRM);
END;
/

SELECT * FROM DEPARTMENTS;

-----------------------------------------------USER DEFINED EXCEPTION-----------------------------------------------------------------------
DECLARE
    v_exp EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_exp, -20099);
BEGIN
    RAISE v_exp;
    
EXCEPTION
    WHEN v_exP THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        dbms_output.put_line('ERROR CODE : ' || SQLCODE);
        dbms_output.put_line('ERROR MESSAGE : ' || SQLERRM);  -- No message is returned for user defined exception with error code.
END;
/

-----------------------------------------------USER DEFINED EXCEPTION WITHOUT PRAGMA----------------------------------------------------
DECLARE
    v_exp EXCEPTION;
BEGIN
    RAISE v_exp;
    
EXCEPTION
    WHEN v_exP THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        dbms_output.put_line('ERROR CODE : ' || SQLCODE);   -- 1 returned for user defined exception without error code.
        dbms_output.put_line('ERROR MESSAGE : ' || SQLERRM); -- Error message: User-defined Exception.
END;
/

----------------------------------------------RAISE APPLICATION ERROR EXCEPTION----------------------------------------------------------
DECLARE

BEGIN
--    RAISE_APPLICATION_ERROR(-20004, NULL);
    RAISE_APPLICATION_ERROR(-20009, 'THIS IS AN ERROR');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        dbms_output.put_line('ERROR CODE : ' || SQLCODE);
        dbms_output.put_line('ERROR MESSAGE : ' || SQLERRM);
END;
/


------------------------------------------------Assignment------------------------------------------------------------------
--Try to fetch emp_id and emp_name of the employee having salary = 1500 into single variable using INTO 
--and try if error occurs then handle it with OTHERS and print useful details reagarding the error.(Type of error, internal error message)
DECLARE
    v_id EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_name EMPLOYEES.FIRST_NAME%TYPE;
    
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME INTO v_id, v_name FROM EMPLOYEES
    WHERE SALARY = 1500;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR!');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

--Try to divide the current minute with last digit of the current seconds and if error arrises then handle it with OTHERS with useful info about it 
DECLARE 
    v_sec NUMBER(2);
    v_min NUMBER(2);
    
BEGIN
    SELECT TRUNC(EXTRACT(SECOND FROM SYSTIMESTAMP)) INTO v_sec FROM DUAL;
    SELECT TRUNC(EXTRACT(MINUTE FROM SYSTIMESTAMP)) INTO v_min FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('Current minute : ' || v_min);
    DBMS_OUTPUT.PUT_LINE('Current second : ' || v_sec);
    v_sec := SUBSTR(v_sec, -1); 
    DBMS_OUTPUT.PUT_LINE('Last digit of current second is : ' || v_sec);
    
    DBMS_OUTPUT.PUT_LINE(v_min || ' divided by' || v_sec || ' is equal to : ' || TRUNC(v_min/v_sec));
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRORxxxxxxxxxxxxxxxxxxxxxxxxxxx!');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR INFO : ' || SQLERRM);
END;
/

--Create user-defined exception, attach error code with it. Raise the Exception if Department ID 2 has more than 4 employees in it,
--handle the error using OTHERS.
DECLARE
    v_ude EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_ude, -20010);
    v_emp NUMBER(2) := 0;
BEGIN
    SELECT COUNT(EMPLOYEE_ID) INTO v_emp FROM EMPLOYEES
    WHERE department_id = 2;
    DBMS_OUTPUT.PUT_LINE('EMPLOYEES IN DEPT_ID 2 ARE : ' || v_emp);
--    v_emp := 5;
    IF v_emp > 4 THEN
        RAISE v_ude;
    ELSE
        DBMS_OUTPUT.PUT_LINE('LESS THAN 4');
    END IF;
    
EXCEPTION
    WHEN v_ude THEN
        DBMS_OUTPUT.PUT_LINE('ERROR---------!!');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

--Try to delete dept_id = 1 from departmemts table, and if any error then handle it gracefully and print all the details about the error.
DECLARE
    
BEGIN
    DELETE FROM DEPARTMENTS 
    WHERE DEPARTMENT_ID = 10;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR-----!');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

--If total records into depratment and employees are greater than 17 then raise_application_error with code and messages of your choice 
--and print that code and message in exception block.

DECLARE
    v_dep NUMBER;
    v_emp NUMBER;
    v_ude EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_ude, -20200);
BEGIN
    SELECT COUNT(EMPLOYEE_ID) INTO v_emp FROM EMPLOYEES;
    SELECT COUNT(DEPARTMENT_ID) INTO v_dep FROM DEPARTMENTS;
    
    IF v_emp > 17 AND v_dep > 17 THEN
        RAISE v_ude;
        
    END IF;
EXCEPTION
    WHEN v_ude THEN
        DBMS_OUTPUT.PUT_LINE('ERROR-----!');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
    
END;
/

---------------------------------------------------------Assignment----------------------------------------------------------------------
--CREATE a PL/SQL BLOCK DECLARE ONE VARIABLE v_salary.
---->Take the v_salary = 8100, and fetch emp_id, name, salary, manager_id from employees table using salary > v_salary condition.
SET SERVEROUTPUT ON;
DECLARE 
    v_salary NUMBER(5) := 8100;
    v_emp EMPLOYEES.employee_id%TYPE;
    v_name EMPLOYEES.FIRST_NAME%TYPE;
    v_sal EMPLOYEES.SALARY%TYPE;
    v_mgr EMPLOYEES.MANAGER_ID%TYPE;
BEGIN
    SELECT employee_id, First_name || ' ' || Last_name, Salary, manager_id INTO v_emp, v_name, v_sal, v_mgr
    FROM EMPLOYEES
    WHERE salary > v_salary;
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('Too many rows returned! Variable expected a single row');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);   --  -1422
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);--   exact fetch returns more than requested number of rows
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('NO data returned! Variable expected atleast one row');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);   --  100 / -1403
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);--  no data found
END;
/


--Try to assign the date in wrong format to date variable and check the SQLCODE and error message thrown by Oracle.
DECLARE
    v_date DATE;
    
BEGIN
    v_date := TO_DATE('25-12-2002', 'MM-DD-YYYY');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);   --  -1843
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);--   not a valid month
END;
/

--Declare three variables and assign one variable the value which is var1/var2.
---->Try to assign var2 as 0 and check the erro details.
DECLARE
    var1 NUMBER(5) := 5.566675;  -----***
    var2 NUMBER(5) := 0;
    var3 NUMBER(5);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Variable value : ' || var1);
    var3 := var1/var2;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE); --   -1476
        DBMS_OUTPUT.PUT_LINE('ERRO INFO : ' || SQLERRM);  --    divisor is equal to zero

--*** How 5.56365363 is stored in NUMBER(5)
--Even though the default scale is 0, the NUMBER data type in Oracle is a true decimal data type that can handle fractional values. 
--When you attempt to insert a value with more digits than specified, the database attempts to fit it into the defined precision and scale. 
--Rounding: The database will round the excess fractional digits to fit the specified scale (which is 0 in this case).
--Result: The value 5.56365363 would be rounded to the nearest whole number, which is 6.              
END;
/

--Try to update a number column of employees table with a varchar value and check the error details.
DECLARE
    
BEGIN
    UPDATE EMPLOYEES
    SET COMMISSION_PCT = 'Eight';
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INFO : ' || SQLCODE); --     -1722
        DBMS_OUTPUT.PUT_LINE('ERRO INFO : ' || SQLERRM); --     Invalid Number
END;
/















