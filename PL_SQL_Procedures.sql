 --------------------------------------------------PL/SQL Procedures--------------------------------------------------------
 --------------------------------------------------*****************--------------------------------------------------------
 -- Create a table to store logs(log_id, log_ts, action_taken)
 ---1.Create the procedure to update the salary of the employees by a given percentage. (emp_id, dept_id, increment_percentage, as input).
 ----log the details into logs table if provided data is incorrect.
 
CREATE TABLE TAB_PROC_LOG
(log_id NUMBER PRIMARY KEY,
log_ts TIMESTAMP,
action_taken VARCHAR2(200)
);

CREATE SEQUENCE SEQ_TAB_PROC_LOG
START WITH 10000
INCREMENT BY 1
MAXVALUE 5000000;
 
BEGIN
    PROC_EMP_SAL(100, 9, 15);
END;
/

SELECT * FROM TAB_PROC_LOG;
SELECT * FROM EMPLOYEES_FAIZAN;
SELECT * FROM DEPARTMENTSS;
 
-------PROCEDURE FOR REFERANCE
--CREATE OR REPLACE PROCEDURE proc_emp_sal (
--    p_emp_id               IN NUMBER,
--    p_dept_id              IN departmentss.dept_id%TYPE,
--    p_increment_percentage IN NUMBER
--) AS
--    v_dept departmentss.dept_id%TYPE;
--BEGIN
--    SELECT
--        department_id
--    INTO v_dept
--    FROM
--        employees_faizan
--    WHERE
--        employee_id = p_emp_id;
--
--    IF v_dept <> p_dept_id THEN
--        dbms_output.put_line('FAILED');
--        INSERT INTO tab_proc_log (
--            log_id,
--            log_ts,
--            action_taken
--        ) VALUES ( seq_tab_proc_log.NEXTVAL,
--                   trunc(systimestamp),
--                   to_char('Employee dept_id and entered dept_id do not match, for employee_id' || p_emp_id) );
--
--        RETURN;
--    ELSIF p_dept_id IS NULL THEN
--        dbms_output.put_line('FAILED');
--        INSERT INTO tab_proc_log (
--            log_id,
--            log_ts,
--            action_taken
--        ) VALUES ( seq_tab_proc_log.NEXTVAL,
--                   trunc(systimestamp),
--                   to_char('dept_id was NULL against entered employee_id : ' || p_emp_id) );
--
--        RETURN;
--    ELSE
--        UPDATE employees_faizan
--        SET
--            salary = salary + salary * p_increment_percentage / 100
--        WHERE
--            employee_id = p_emp_id;
--
--        dbms_output.put_line('SUCCESS');
--        INSERT INTO tab_proc_log (
--            log_id,
--            log_ts,
--            action_taken
--        ) VALUES ( seq_tab_proc_log.NEXTVAL,
--                   trunc(systimestamp),
--                   'SALARY INCREASED BY '
--                   || p_increment_percentage
--                   || ' for employee id : '
--                   || p_emp_id );
--
--        RETURN;
--    END IF;
--
--EXCEPTION
--    WHEN no_data_found THEN
--        dbms_output.put_line('FAILED, NO EMPLOYEE WITH EMPLOYEE_ID : '
--                             || p_emp_id
--                             || ' WAS FOUND.');
--        INSERT INTO tab_proc_log (
--            log_id,
--            log_ts,
--            action_taken
--        ) VALUES ( seq_tab_proc_log.NEXTVAL,
--                   trunc(systimestamp),
--                   'Cannot update salary, no employee with id : ' || p_emp_id );
--
--        RETURN;
--    WHEN too_many_rows THEN
--        dbms_output.put_line('FAILED, MULTIPLE EMPLOYEES WITH EMPLOYEE_ID : '
--                             || p_emp_id
--                             || ' WERE FOUND.');
--        INSERT INTO tab_proc_log (
--            log_id,
--            log_ts,
--            action_taken
--        ) VALUES ( seq_tab_proc_log.NEXTVAL,
--                   trunc(systimestamp),
--                   'Salary not updated, multiple records found against id : ' || p_emp_id );
--
--END;

-------------------------------------------------*******************-------------------------------------------------
 ---2. Create the procedure which can be for login flow. It should accept username(firstname), password (lastname@emp_id)
 ----validates the data, returns success/failed as an output and make an entry in logs table if failed. 

--CREATE OR REPLACE PROCEDURE PROC_LOGIN_FLOW_EMP(p_username IN EMPLOYEES_FAIZAN.FIRST_NAME%TYPE, p_password IN VARCHAR2, v_out OUT VARCHAR2)
--AS
--
--v_var_out VARCHAR2(200);
----v_password VARCHAR2(200);
----v_username VARCHAR(45);
--v_check NUMBER(2) := 0;
--
--CURSOR cur_emp_usrname IS
--SELECT FIRST_NAME || EMPLOYEE_ID AS v_username, LAST_NAME || '@' || EMPLOYEE_ID AS v_password FROM EMPLOYEES_FAIZAN;
--
--rec_curemp_usrname cur_emp_usrname%ROWTYPE;
--BEGIN
--    OPEN cur_emp_usrname;
--    LOOP
--        FETCH cur_emp_usrname INTO rec_curemp_usrname;
--        IF rec_curemp_usrname.v_username = p_username THEN
--            v_check := 1;
--            EXIT;         
--        END IF;
--        EXIT WHEN cur_emp_usrname%NOTFOUND;
--    END LOOP;
--    
--    IF v_check = 1 THEN
--        IF p_password = rec_curemp_usrname.v_password THEN
--            v_out := 'Success!';
--            INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--            trunc(systimestamp), 'User logged in with Username : ' || p_username || ' and Password : ' || p_password);
--        ELSE
--            v_out := 'Failed!';
-- --           DBMS_OUTPUT.PUTLINE('Either Username or password is incorrect, Access denied!');
--            INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--            trunc(systimestamp), 'Invalid Password entered, login attempt using Username : ' || p_username || ' and Password : ' || p_password);
--            
--        END IF;    
--    ELSE
--        v_out := 'Failed!';
----        DBMS_OUTPUT.PUT_LINE('Entered username is incorrect.');
--        INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--        trunc(systimestamp), 'Invalid Username entered, login attempt using Username : ' || p_username || ' and Password : ' || p_password);
--    END IF;
--    
--END;
--/
SET SERVEROUTPUT ON;
DECLARE
v_var VARCHAR2(300);
BEGIN

    PROC_LOGIN_FLOW_EMP('Steven100','King@100', v_var);
    DBMS_OUTPUT.PUT_LINE(v_var);

END;
/
SELECT * FROM TAB_PROC_LOG;
SELECT * FROM EMPLOYEES_FAIZAN;
SELECT * FROM DEPARTMENTSS;


------------------------------------------------*****************------------------------------------------
--Create the procedure to update the department of the lowest salaried employee of the department of the passed input(employee_id) to the next
--highest average salaried department. INSERT the logs into log table(assignment_logs)
--
--CREATE OR REPLACE PROCEDURE PROC_EMP_DEPT_UPT(p_inp_emp EMPLOYEES_FAIZAN.EMPLOYEE_ID%TYPE, p_out_res OUT VARCHAR2)
--AS
--    v_low_emp NUMBER(9);
--    v_dept_avg NUMBER(9);
--    v_dept NUMBER;
--    v_dept_upt NUMBER;
--    
--BEGIN
--    SELECT department_id INTO v_dept FROM EMPLOYEES_FAIZAN
--    WHERE EMPLOYEE_ID = p_inp_emp;
--    
--    SELECT EMPLOYEE_ID INTO v_low_emp FROM EMPLOYEES_FAIZAN
--    WHERE department_id = v_dept AND SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = v_dept)
--    FETCH FIRST 1 ROW ONLY;
--
--
--    SELECT AVG(SALARY) INTO v_dept_avg FROM EMPLOYEES_FAIZAN
--    WHERE department_id = v_dept;
--    
--    SELECT department_id INTO v_dept_upt FROM EMPLOYEES_FAIZAN
--    GROUP BY department_id
--    HAVING AVG(SALARY) > v_dept_avg 
--    ORDER BY AVG(SALARY)
--    FETCH FIRST 1 ROW ONLY;
--    
--    UPDATE EMPLOYEES_FAIZAN
--    SET DEPARTMENT_ID = v_dept_upt
--    WHERE EMPLOYEE_ID = v_low_emp;
--    
--    p_out_res := 'Success! Employee with id : ' || v_low_emp || '  having dept_id : ' || v_dept || ' was updated with dept_id : ' || v_dept_upt;
--    
--    INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--    systimestamp, 'Success! Employee with id : ' || v_low_emp || '  having dept_id : ' || v_dept || ' was updated with dept_id : ' || v_dept_upt);
--    
--EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--        IF v_dept IS NULL THEN
--            p_out_res := 'Task Failed, No Employee exists with Employee_id : ' || p_inp_emp;
--            INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--            systimestamp, 'Task Failed, No Employee exists with Employee_id : ' || p_inp_emp);
--            RETURN;
--        ELSIF v_dept_upt IS NULL THEN 
--            p_out_res := 'Task Failed, No department with higher salary averge than dept : ' || v_dept_avg || ' (employee dept) Exists.';
--            INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
--            systimestamp, 'Task Failed, No department with higher salary averge than dept : ' || v_dept_avg || ' (employee dept) Exists.');
--            RETURN;
--        END IF;
--END;
--/

DECLARE
    p_out VARCHAR(200);
BEGIN
    PROC_EMP_DEPT_UPT(105, p_out);
    DBMS_OUTPUT.PUT_LINE(p_out);
END;
/


SELECT * FROM EMPLOYEES_FAIZAN;

SELECT AVG(SALARY) FROM EMPLOYEES_FAIZAN
WHERE department_id = 6;

SELECT department_id FROM EMPLOYEES_FAIZAN
    GROUP BY department_id
    HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES_FAIZAN
                            WHERE department_id = 10)
    ORDER BY AVG(SALARY)
    FETCH FIRST 1 ROW ONLY;

SELECT * FROM tab_proc_log;



--Create a procedure to divide the salary decrements amoung all the employees of the department using their salary ratio.
--department name and total salary decrement for department as an input. log the details into log table(assignment_logs).
CREATE OR REPLACE PROCEDURE PROC_EMP_SAL_UPT(p_in_dept_name IN DEPARTMENTSS.DEPT_NAME%TYPE, p_in_decr IN NUMBER, p_out_status OUT VARCHAR2)
AS
    v_dept_id NUMBER(7);
    v_dept_sal_sum NUMBER(9);
BEGIN
    SELECT DEPT_ID INTO v_dept_id FROM DEPARTMENTSS
    WHERE DEPT_NAME = p_in_dept_name;
    
    SELECT SUM(SALARY) INTO v_dept_sal_sum FROM EMPLOYEES_FAIZAN
    GROUP BY SALARY
    HAVING DEPARTMENT_ID = v_dept_id
    ORDER BY SALARY
    FETCH FIRST 1 ROWS ONLY;
    
    IF v_dept_sal_sum < p_in_decr THEN
        p_out_status := 'TASK FAILED! ENTERED AMOUNT EXCEEDS TOTAL DEPT BUDGET';
        INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
        systimestamp, 'TASK FAILED! ENTERED AMOUNT EXCEEDS TOTAL DEPT BUDGET');
        RETURN;
        
    ELSE       
        UPDATE EMPLOYEES_FAIZAN
        SET SALARY = SALARY / v_dept_sal_sum * p_in_decr
        WHERE DEPARTMENT_ID = v_dept_id;
        
        p_out_status := 'PROC_EMP_SAL_UPT----->>SALARIES HAVE BEEN DECREMNETED SUCCESSFULLY!';
        INSERT INTO tab_proc_log (log_id, log_ts, action_taken) VALUES ( seq_tab_proc_log.NEXTVAL,
        systimestamp, 'PROC_EMP_SAL_UPT----->>SALARIES HAVE BEEN DECREMNETED SUCCESSFULLY!');
        RETURN;
    END IF;
    
    
           
END;
/

DECLARE
    v_out VARCHAR2(300);
BEGIN

    PROC_EMP_SAL_UPT('Human Resources', 100, v_out);
    DBMS_OUTPUT.PUT_LINE(v_out);

END;
/

SELECT * FROM EMPLOYEES_FAIZAN
WHERE DEPARTMENT_ID = (SELECT DEPT_ID FROM DEPARTMENTSS WHERE DEPT_NAME = 'Human Resources');
SELECT * FROM tab_proc_log;
SELECT * FROM DEPARTMENTSS
WHERE DEPT_NAME = 'Human Resources';


------------------------------------------------****************************------------------------------------------------
---------------------------------------------------------Assignment---------------------------------------------------------
--Create a procedure which accepts the department_name, employee_firstname and lastname in a single parameter 
---serparated by a hyphen and manager_id.
---Output variable should be emp_id(returns employee's emp_id or -1 incase of an error).
----Out_paramter should print a status message regarding the success or failure of the operation(SQL CODE, SQLERRM).
----ALL PARAMETERS SHOULD BE VALIDATED!
-----If the employee does not exists then add it to the table, with salary : second highest in the dept + 100 and then return its emp id.

CREATE TABLE EMP_PROC(
EMP_ID NUMBER PRIMARY KEY,
FIRST_NAME VARCHAR2(60),        --------CREATING A DUMMY TABLE FOR THE TASK
LAST_NAME VARCHAR2(60),
MANAGERS_ID NUMBER(4),
DEPT_ID NUMBER(6),
SALARY NUMBER(9)
);


CREATE SEQUENCE SEQ_EMP_PROC        ------SEQUENCE FOR THE TABLE
START WITH 3090
INCREMENT BY 1
MAXVALUE 300000;

---------------------->>>>>>>>>>>>>>>>>>>>>>>>>>90 Records inserted 
SELECT * FROM EMP_PROC;

CREATE OR REPLACE PROCEDURE PROC_EMP_VALID(P_in_dept_name EMP_PROC.DEPT_NAME%TYPE, p_in_emp_name VARCHAR2, p_in_mgr_id EMP_PROC.MANAGERS_ID%TYPE, 
p_out_empid OUT NUMBER, p_out_status OUT VARCHAR2)
AS 
    NO_HYPHEN_FOUND EXCEPTION;
    
    PRAGMA EXCEPTION_INIT(NO_HYPHEN_FOUND, -20003);
    
    v_salary NUMBER(8);
    v_first VARCHAR2(70);
    v_last VARCHAR2(70);
    v_name_chk NUMBER(4);
    v_hyphen NUMBER(3);
    v_dept NUMBER(3);
    v_mgr NUMBER(5);
    v_mgr_chk NUMBER(5);
    e_id NUMBER(8);
BEGIN
    v_hyphen := INSTR(p_in_emp_name, '-', 1);
    
    SELECT Dept_id INTO v_dept FROM DEPARTMENTSS 
    WHERE INITCAP(DEPT_NAME) = INITCAP(P_in_dept_name);
    
    CASE
        WHEN v_hyphen = 0 THEN
            DBMS_OUTPUT.PUT_lINE('NO HYPHEN FOUND');
            RAISE NO_HYPHEN_FOUND;
    
        WHEN v_dept NOT BETWEEN 1 AND 10 THEN
            DBMS_OUTPUT.PUT_lINE(' INVALID DEPT ID');
            RAISE INVALID_DEPT;
        
        WHEN v_mgr NOT BETWEEN 101 AND 105 THEN
            DBMS_OUTPUT.PUT_lINE(' INVALID MGR ID');
            RAISE INVALID_MGR;
        
        ELSE 
            v_first := SUBSTR(p_in_emp_name, v_hyphen + 1);
            v_last := SUBSTR(p_in_emp_name, 1, v_hyphen - 1);
            
            SELECT COUNT(*) INTO v_name_chk FROM EMP_PROC 
            WHERE First_name = v_first AND Last_name = v_last;
            
            IF v_name_chk > 0 THEN
                SELECT COUNT(*) INTO v_dept_chk FROM EMP_PROC
                WHERE First_name = v_first AND Last_name = v_last AND Dept_id = v_dept;
                 
                SELECT COUNT(*), emp_id INTO v_mgr_chk, e_id FROM EMP_PROC
                WHERE First_name = v_first AND Last_name = v_last AND Dept_id = v_dept AND Managers_id = p_in_mgr_id;
                
                IF v_mgr_chk > 0 THEN
                    DBMS_OUTPUT.PUT_LINE('SUCCESS');
                    p_out_empid := e_id;
                ELSE
                    DBMS_OUTPUT.PUTLINE('');
                    SELECT SALARY INTO v_salary FROM EMP_PROC 
                    ORDER BY SALARY ASC
                    OFFSET 1 ROWS 
                    FETCH NEXT 1 ROWS ONLY;
                    INSERT INTO EMP_PROC(EMP_ID, FIRST_NAME, LAST_NAME, MANAGERS_ID, DEPT_ID, SALARY)
                    VALUES(SEQ_EMP_PROC.NEXTVAL, v_first, v_last, );
                 END IF;
        
            ELSE
                SELECT SALARY INTO v_salary FROM EMP_PROC 
                ORDER BY SALARY ASC
                OFFSET 1 ROWS 
                FETCH NEXT 1 ROWS ONLY;
               INSERT INTO EMP_PROC(EMP_ID, FIRST_NAME, LAST_NAME, MANAGERS_ID, DEPT_ID, SALARY)
               VALUES(SEQ_EMP_PROC.NEXTVAL, v_first, v_last, );
            END IF;
    END CASE;
                                    ------------------------Incomplete....!
EXCEPTION
    WHEN NO_HYPHEN_FOUND THEN
    
    WHEN INVALID_DEPT THEN
    
    WHEN INVALID_MGR_ID THEN


END;
/


------------------------------------------***********************-------------------------------------------
-------------------------------------------*********************--------------------------------------------

SELECT * FROM DUAL;
SELECT INSTR('HELLO-WORLD', '-', 1) FROM DUAL;

SELECT SUBSTR('HELLO-WORLD', (SELECT INSTR('HELLO-WORLD', '-', 1) FROM DUAL) + 1) FROM DUAL;
S
SELECT SUBSTR('HELLO-WORLD', 1, (SELECT INSTR('HELLO-WORLD', '-', 1) FROM DUAL) - 1) FROM DUAL;
S



