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
--Create the procedure to update the department of the lowest salaried employee of the department of the passed(input) employee to the next
--highest average salaried department. INSERT the logs into log table(assignment_logs)
CREATE OR REPLACE PROCEDURE PROC_EMP_SAL(p_inp_dept DEPARTMENTSS.DEPT_ID%TYPE)
AS
    v_low_emp NUMBER(9);
    v_dept_avg NUMBER(9);
    v_dept NUMBER;
    v_dept_upt NUMBER;
    
BEGIN
    SELECT deptartment_id INTO v_dept FROM EMPLOYEES_FAIZAN
    WHERE EMPLOYEE_ID = p_inp_dept;
    
    SELECT EMPLOYEE_ID INTO v_low_emp FROM EMPLOYEES_FAIZAN
    WHERE department_id = v_dept AND SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = v_dept);
    
    SELECT AVG(SALARY) INTO v_dept_avg FROM EMPLOYEES_FAIZAN
    WHERE department_id = v_dept;
    
    SELECT dept_id INTO v_dept_upt FROM EMPLOYEES_FAIZAN
    WHERE v_dept_avg < (SELECT AVG(SALARY) FROM )
    
END;
/





--Create a procedure to divide the salary decrements amoung all the employees of the department using their salary ratio.
--department name and total salary decrement for department as an input. log the details into log table(assignment_logs).


