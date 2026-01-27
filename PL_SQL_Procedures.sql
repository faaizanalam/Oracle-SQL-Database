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

CREATE OR REPLACE PROCEDURE PROC_LOGIN_FLOW_EMP(username IN EMPLOYEES_FAIZAN.FIRST_NAME%TYPE, password IN VARCHAR2, v_out OUT VARCHAR2)
AS

v_var_out VARCHAR2(200);
v_password VARCHAR2(200);
v_username VARCHAR(45);
BEGIN
    SELECT FIRST_NAME || EMPLOYEE_ID INTO v_username FROM EMPLOYEES_FAIZAN
    
    
    SELECT LAST_NAME || '@' || EMPLOYEE_ID INTO v_password FROM EMPLOYEES_FAIZAN
    WHERE FIRST_NAME = username;
    
    
    
EXCEPTION

END;
/




