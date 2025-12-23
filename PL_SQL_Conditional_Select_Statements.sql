----------------------------------------Conditional Select Statements--------------------------------------------------
set serveroutput on;
DECLARE
    v_var_conditonal NUMBER := 22;
    
BEGIN
    IF MOD(v_var_conditonal, 2) = 0 
        THEN dbms_output.put_line('Variable contains an an even number');
    
    ELSIF MOD(v_var_conditonal, 2) = 1
        THEN dbms_output.put_line('Variable contains an an odd number');
        
    ELSE 
        dbms_output.put_line('The Variable seems to contain a non-compatible value');
        
    END IF;
    dbms_output.put_line(''); 
    dbms_output.put_line('After END IF');        
    
END;
/

-------------------------------------*************************-----------------------------------------------

DECLARE 
    var_cond_1 NUMBER := 88;
    var_cond_2 NUMBER := 89;
BEGIN
     dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
     dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
    IF MOD(var_cond_1, 2) = 0  AND MOD(var_cond_2, 2) = 0 THEN
        dbms_output.put_line('var_cond_1 is EVEN and var_cond_2 is EVEN');
    
    ELSIF MOD(var_cond_1, 2) = 0  AND MOD(var_cond_2, 2) = 1 THEN
        dbms_output.put_line('var_cond_1 is EVEN and var_cond_2 is ODD');
    
    ELSIF MOD(var_cond_1, 2) = 1  AND MOD(var_cond_2, 2) = 0 THEN
        dbms_output.put_line('var_cond_1 is ODD and var_cond_2 is EVEN');
    
    ELSIF MOD(var_cond_1, 2) = 1  AND MOD(var_cond_2, 2) = 1 THEN
        dbms_output.put_line('var_cond_1 is ODD and var_cond_2 is ODD');
    
    ELSE
        dbms_output.put_line('Either one or both of the variables contain an uncompatible value');
    
    END IF;
    dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
    dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
END;
/


SELECT CURRENT_TIME FROM DUAL;
SELECT CURRENT_DATE FROM DUAL;
SELECT CURRENT_TIMESTAMP FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

SELECT TRUNC(EXTRACT(SECOND FROM SYSTIMESTAMP)) AS CURR_TIME FROM DUAL;



-------------------------------------------------------PRACTICE----------------------------------------------
--Declare one variable v_current_seconds. Intialize it with current seconds (using current time).
--If current_seconds is greater than 30, then update all odd employee_ids by 299.
--
--Declare one variable v_current_seconds. intialize it with current seconds (using current time).
--If v_current_seconds is between 50-59 then print highest earning employee id and name.
--If v_current_seconds is between 40-49 then print 3rd highest earning employee id and name.
--If v_current_seconds is between 30-39 then print 5th highest earnnig employee id and name.
--If v_current_seconds is between 20-29 then print lowest earning employee id and name.
--else print "no_data"


Declare 
    v_current_seconds NUMBER := TRUNC(EXTRACT(SECOND FROM SYSTIMESTAMP));
    v_emp_first EMPLOYEES_FAIZAN.first_name%TYPE;
    v_emp_last EMPLOYEES_FAIZAN.last_name%TYPE;
    v_emp_salary EMPLOYEES_FAIZAN.salary%TYPE;
    
Begin
    dbms_output.put_line('Value stored in v_current_seconds is : ' || v_current_seconds);
    IF v_current_seconds > 30 THEN 
        UPDATE EMPLOYEES_FAIZAN
        SET EMPLOYEE_ID = EMPLOYEE_ID + 299;
        dbms_output.put_line('Employees Ids updated');
        
    ELSE 
        dbms_output.put_line('Employees Ids were not updated');
    END IF;
    
    --Since Variable is already decalred and intiated 
    IF v_current_seconds BETWEEN 50 AND 59 THEN
        SELECT first_name, last_name, salary INTO v_emp_first, v_emp_last, v_emp_salary 
        FROM EMPLOYEES_FAIZAN 
        ORDER BY SALARY DESC
        FETCH FIRST ROW ONLY;
        
        dbms_output.put_line('Highest Earning employee is ' || v_emp_first || ' ' || v_emp_last 
        || ' with salary : ' || v_emp_salary);
        
    ELSIF v_current_seconds BETWEEN 40 AND 49 THEN
        SELECT first_name, last_name, salary INTO v_emp_first, v_emp_last, v_emp_salary 
        FROM EMPLOYEES_FAIZAN 
        ORDER BY SALARY DESC
        OFFSET 2 ROWS
        FETCH NEXT ROW ONLY;
        
        dbms_output.put_line('3rd highest Earning employee is ' || v_emp_first || ' ' || v_emp_last 
        || ' with salary : ' || v_emp_salary);
       
    ELSIF v_current_seconds BETWEEN 30 AND 39 THEN
        SELECT first_name, last_name, salary INTO v_emp_first, v_emp_last, v_emp_salary 
        FROM EMPLOYEES_FAIZAN 
        ORDER BY SALARY DESC
        OFFSET 4 ROWS 
        FETCH NEXT ROW ONLY;
        
        dbms_output.put_line('5th highest Earning employee is ' || v_emp_first || ' ' || v_emp_last 
        || ' with salary : ' || v_emp_salary);
        
    ELSIF v_current_seconds BETWEEN 20 AND 29 THEN
        SELECT first_name, last_name, salary INTO v_emp_first, v_emp_last, v_emp_salary 
        FROM EMPLOYEES_FAIZAN 
        ORDER BY SALARY ASC
        FETCH FIRST ROW ONLY;
        
        dbms_output.put_line('Lowest Earning employee is ' || v_emp_first || ' ' || v_emp_last 
        || ' with salary : ' || v_emp_salary);
    
    ELSE 
        dbms_output.put_line('No Data');
    END IF;
    
End;
/


SELECT * FROM EMPLOYEES_FAIZAN;



----------------------------------------------------PL/SQL CASE STATEMENT----------------------------------------------------
--Take any one random employee, and take emp_id as constant.
--update the salary of the employee to 10000 if name of the employee is between A-G.
--else if department_id id odd then update its department's city to Swat.
--else update salary of that departments employee to 1500.
--
--Take one number in variable
--update variables value by 
--4 if number is two digit
--10 if number is three digits
--23 if number is four digits
--55 for all other

Declare
    v_emp_id employees_faizan.employee_id%TYPE; 
    v_emp_first employees_faizan.first_name%TYPE;
    v_dept_id departmentss.dept_id%TYPE;
    v_var_num NUMBER;
    
Begin
    SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID INTO v_emp_id, v_emp_first, v_dept_id FROM EMPLOYEES_FAIZAN
    ORDER BY SALARY DESC
    FETCH FIRST ROW ONLY;
    
    CASE
        WHEN v_emp_first BETWEEN 'A' AND 'G' THEN
            UPDATE EMPLOYEES_FAIZAN 
            SET SALARY = 10000 WHERE EMPLOYEE_ID = v_emp_id;
            dbms_output.put_line('This is CASE One');
            
        WHEN MOD(v_dept_id, 2) = 1 THEN
            UPDATE DEPARTMENTSS
            SET LOCATION = 'Swat'
            WHERE dept_id = v_dept_id;
            dbms_output.put_line('This is CASE Two');        
        
        ELSE 
            UPDATE EMPLOYEES_FAIZAN
            SET SALARY = SALARY + 1500
            WHERE department_id = v_dept_id;
            dbms_output.put_line('This is CASE Three');
            
        END CASE;
        
    v_var_num := TRUNC(DBMS_RANDOM.VALUE * 100 / DBMS_RANDOM.VALUE * 10);
    dbms_output.put_line('');
    dbms_output.put_line('The value of the variable is : ' || v_var_num);
    CASE length(v_var_num)
        
        WHEN 2 THEN
            v_var_num := 4;
            dbms_output.put_line('Variable contains 2 digit number.');

        WHEN 3 THEN
            v_var_num := 10;
            dbms_output.put_line('Variable contains 3 digit number.');
        WHEN 4 THEN
            v_var_num := 23;
            dbms_output.put_line('Variable contains 4 digit number.');
        ELSE 
            v_var_num := 55;
            dbms_output.put_line('Variable does not satisfy any other case digit number.');
        END CASE;
    
End;
/ 
--SELECT * FROM DEPARTMENTSS;
--SELECT * FROM EMPLOYEES_FAIZAN;


---------------------------------------------------GOTO Statement----------------------------------------------------------------
--Using GOTO Statement print 1 to 10 numbers;

--Update the salary of the employee by 3%
--and if the updated salary(whole number only) is odd then update the salary of the employee having emp_id greater than current emp_id
--but least out of all by 5%.
--and if the updated  salary(whole number only) is even then update the salary of all the employee having emp_id 
--greater than current emp_id by 2%.


DECLARE
    v_var_number NUMBER;
    v_var_emp_id EMPLOYEES_FAIZAN.employee_id%type;
    v_var_salary EMPLOYEES_FAIZAN.SALARY%TYPE;
BEGIN
    v_var_number := 0;
    
    <<label_goto>>   -----label
    IF v_var_number <10 THEN
        v_var_number := v_var_number + 1;
        dbms_output.put_line('Value stored in variable is : ' || v_var_number);
        
        GOTO label_goto;  ----GOTO statement
        
    END IF;
--    GOTO label_goto;  ----Infinite Loop

    SELECT EMPLOYEE_ID, SALARY INTO v_var_emp_id, v_var_salary FROM EMPLOYEES_FAIZAN
    WHERE EMPLOYEE_ID = 103;
--    ORDER BY SALARY DESC
--    FETCH FIRST ROW ONLY;
--    
    dbms_output.put_line('Value stored in v_var_salary is : ' || v_var_salary);
    
    UPDATE EMPLOYEES_FAIZAN
    SET SALARY = ROUND(SALARY + (SALARY * 0.03))
    WHERE employee_id = v_var_emp_id;
    
    SELECT SALARY INTO v_var_salary FROM EMPLOYEES_FAIZAN 
    WHERE employee_id = v_var_emp_id;
    
    dbms_output.put_line('Salary After update : ' || v_var_salary);
    
    CASE MOD(v_var_salary, 2)
        WHEN 0 THEN
            UPDATE EMPLOYEES_FAIZAN
            SET SALARY = ROUND(SALARY + (SALARY * 0.02))
            WHERE EMPLOYEE_ID > v_var_emp_id;
            dbms_output.put_line('Even Statement was executed..');
            
        WHEN 1 THEN
            UPDATE EMPLOYEES_FAIZAN
            SET SALARY = ROUND(SALARY + (SALARY * 0.05))
            WHERE EMPLOYEE_ID = (SELECT min(employee_id) FROM EMPLOYEES_FAIZAN
                                    WHERE employee_id > v_var_emp_id);
            dbms_output.put_line('Odd Statement was executed..');
              
        ELSE 
            dbms_output.put_line('ELSE Statement was executed');
    END CASE;
    
END;
/



SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES_FAIZAN
ORDER BY SALARY DESC
FETCH FIRST ROW ONLY;


SELECT * FROM EMPLOYEES_FAIZAN;










