--------------------------------------------------------------------------------------------------------------
--------------------------------------------PL/SQL Triggers---------------------------------------------------
--------------------------------------------ROW LEVEL TRIGGERS---------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_EMP_FZN
AFTER INSERT OR UPDATE OR DELETE ON EMPLOYEES_FAIZAN
FOR EACH ROW

BEGIN
    IF UPDATING THEN
        INSERT INTO TAB_PROC_LOG (LOG_ID, LOG_TS, ACTION_TAKEN)
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'TABLE HAS BEEN UPDATED!!!');
    ELSIF DELETING THEN
        INSERT INTO TAB_PROC_LOG (LOG_ID, LOG_TS, ACTION_TAKEN)
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'A DELETE ATTEMPT WAS MADE!!!');
        DBMS_OUTPUT.PUT_LINE('Record deleted');
        --commit;  ---cannot commit in trigger....
        RAISE_APPLICATION_ERROR(-20091, 'Unable to delete a record');
    ELSIF INSERTING THEN
        INSERT INTO TAB_PROC_LOG (LOG_ID, LOG_TS, ACTION_TAKEN)
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'NEW DATA HAS BEEN INSERTED!!!');
    END IF;
   
    /*
    EXCEPTION -- If exception block is added the trigger will execute successfully canceling out the affect of RAE which prevents delete.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('SQL CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQL MESSAGE : ' || SQLERRM);
    */  
    
END;
/
SET SERVEROUTPUT ON;

ALTER TRIGGER TRG_EMP_FZN DISABLE;
ALTER TRIGGER TRG_EMP_FZN ENABLE;

SELECT * FROM EMPLOYEES_FAIZAN;

INSERT INTO EMPLOYEES_FAIZAN
VALUES(300, 'Faizan', 'Alam', 9, 76900);

DELETE FROM EMPLOYEES_FAIZAN
WHERE employee_id = 300;


-------------------------------------ROW LEVEL TRIGGER TO CHECK INPUTS IN EMPLOYEES------------------------------------
-----------------------------------------------TABLE FOR ACTIVE DEPARTMENTS--------------------------------------------
/*
CREATE TABLE EMP_TRG AS SELECT E.* FROM  EMPLOYEES_FAIZAN E;
CREATE TABLE DEPT_TRG AS SELECT * FROM DEPARTMENTSS;

ALTER TABLE DEPT_TRG ADD STATUS VARCHAR(40);

SELECT * FROM DEPT_TRG;
UPDATE DEPT_TRG
SET STATUS = 'Active'
WHERE MOD(DEPT_ID, 2) = 0;

UPDATE DEPT_TRG
SET STATUS = 'Inactive'
WHERE MOD(DEPT_ID, 2) = 1;
*/
----------------------------SETTING OBJECTS FOR TRIGGER CREATION, WE HAVE NOW 2 NEW TABLES FOR EMPLOYEES AND DEPARTMENT
---------AND A NEW "STATUS" COLUMN IN DEPARTMENT TABLE ON WHICH OUR TRIGGER WILL BE BASED ON....
SELECT * FROM EMP_TRG;
SELECT * FROM DEPT_TRG;

CREATE OR REPLACE TRIGGER TRG_EMP_DEPT_ID 
BEFORE INSERT OR UPDATE ON EMP_TRG
FOR EACH ROW
--WHEN (NEW.DEPARTMENT_ID IN (SELECT DEPT_ID FROM DEPT_TRG WHERE STATUS = 'Inactive'))   --subquries do not work in trigger when condition.
DECLARE
    v_status DEPT_TRG.STATUS%TYPE;
BEGIN
    SELECT STATUS INTO v_status FROM DEPT_TRG
    WHERE dept_id = :new.department_id;
    
    IF v_status = 'Inactive' THEN
        RAISE_APPLICATION_ERROR(-20033, 'Error updating EMP_TRG with dept_id ' || :new.department_id ||
                                    CHR(10) || ' Department is Inactive!');
    END IF;
END;
/

SELECT * FROM EMP_TRG;
SELECT * FROM DEPT_TRG;

BEGIN

    UPDATE EMP_TRG 
    SET DEPARTMENT_ID = 3
    WHERE EMPLOYEE_ID = 106;
    
    INSERT INTO EMP_TRG
    VALUES(305, 'Anis', 'Ahmed', 7, 65000);

END;
/

----------------------------------------------------ROW LEVEL TRG TASKS-------------------------------------------------
--CREATE TRIGGER ON EMPLOYEES TABLE TO FILL emp_id USING employees_seq AND IGNORE ANY emp_id SET IN INSERT/UPDATE STATEMENT.
CREATE SEQUENCE SEQ_EMP_TRG
START WITH 500
MINVALUE 500
MAXVALUE 600
INCREMENT BY 1
NOCYCLE
;

CREATE OR REPLACE TRIGGER TRG_EMP_BUI_EMP_ID 
BEFORE INSERT OR UPDATE OF EMPLOYEE_ID ON EMP_TRG
FOR EACH ROW
BEGIN
    
    :NEW.EMPLOYEE_ID := SEQ_EMP_TRG.nextval;
    
END;
/

UPDATE EMP_TRG
SET EMPLOYEE_ID = 4500
WHERE EMPLOYEE_ID = 300;
SELECT * FROM EMP_TRG;

ALTER TRIGGER TRG_EMP_DEPT_ID DISABLE;

---------------------------------------------------------------------------------------------------------------------
--CREATE TRIGGER ON DEPARTMENT TABLE TO AUDIT NEW DEPT ADDITION, DEPARTMENT NAME/CITY CHANGE AND DEPARTMENT DELETION.
----AUDIT DATA SHOULD GO INTO LOGS TABLE..
CREATE OR REPLACE TRIGGER TRG_DEPT_AUDIT
BEFORE INSERT OR UPDATE OR DELETE ON DEPT_TRG
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO TAB_PROC_LOG
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'An '|| :NEW.STATUS ||' department with id : ' || :NEW.dept_id || ' named : ' || :NEW.DEPT_NAME || CHR(10) || ' with location : ' || :NEW.LOCATION || ' was added to DEPT_TRG');
    ELSIF DELETING THEN
        INSERT INTO TAB_PROC_LOG
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'Department with id : ' || :OLD.dept_id || ' named : ' || :OLD.DEPT_NAME || 
        CHR(10) || ' with location : ' || :OLD.LOCATION || ' was deleted from DEPT_TRG');
    ELSIF UPDATING THEN
        INSERT INTO TAB_PROC_LOG
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'Department with id : ' || :OLD.dept_id || ' named : ' || :OLD.DEPT_NAME || 
        CHR(10) || ' with location : ' || :OLD.LOCATION || ' was updated with ' || CHR(10) || ' ID : ' 
        || :NEW.dept_id || ' NAME : ' || :NEW.DEPT_NAME || ' LOCATION : ' || :NEW.LOCATION || ' and STATUS : ' || :NEW.STATUS);

    END IF;

END;
/

INSERT INTO DEPT_TRG
VALUES(13, 'Management', 'Lasbela', 'Active');

UPDATE DEPT_TRG
SET DEPT_NAME = 'UX/UI'
WHERE DEPT_ID = 13;

DELETE FROM DEPT_TRG
WHERE DEPT_ID = 13;

SELECT * FROM DEPT_TRG;
SELECT * FROM TAB_PROC_LOG;

-----------------------------------------------------------------------------------------------------------------------
--CREATE UPDATE TRIGGER ON SALARY CHANGE. LOG THE SALARY CHANGE INTO LOGS TABLE.
CREATE OR REPLACE TRIGGER TRG_EMP_SAL_BU
BEFORE UPDATE OF SALARY ON EMP_TRG
FOR EACH ROW
BEGIN
    
    INSERT INTO TAB_PROC_LOG
    VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'SALARY OF EMPLOYEE_ID : ' || :NEW.EMPLOYEE_ID || ' WAS UPDATED FROM '
    || CHR(10) || ' PREVIUOS SALARY : ' || :OLD.SALARY || ' TO CURRENT SALARY : ' || :NEW.SALARY);
    
END;
/

UPDATE EMP_TRG
SET SALARY = 95000
WHERE EMPLOYEE_ID = 501;

SELECT * FROM EMP_TRG;
SELECT * FROM TAB_PROC_LOG;

-----------------------------------------------------------------------------------------------------------------------
--CREATE INSERT TRIGGER ON DEPARTMENT TABLE TO CREATE DEFAULT EMPLOYEE IN THE EMPLOYEES TABLE.
CREATE OR REPLACE TRIGGER TRG_DEPT_DEF_EMP_BI
BEFORE INSERT ON DEPT_TRG 
FOR EACH ROW
BEGIN
    INSERT INTO EMP_TRG
    VALUES(SEQ_EMP_TRG.nextval, 'DEFAUT', 'USER', :NEW.DEPT_ID, 0);
END;
/


INSERT INTO DEPT_TRG
VALUES(13, 'UI/UX', 'Lasbela', 'Inactive');

SELECT * FROM EMP_TRG;
SELECT * FROM DEPT_TRG;

-----------------------------------------------------------------------------------------------------------------------
--DISABLE ALL THE TRIGGERS CREATED IN THIS ASSIGNMENT. TRY TO DROP ONE OF THE TRIGGERS.
ALTER TRIGGER TRG_EMP_FZN DISABLE; 
ALTER TRIGGER TRG_EMP_DEPT_ID DISABLE;
ALTER TRIGGER TRG_EMP_BUI_EMP_ID DISABLE;
ALTER TRIGGER TRG_DEPT_AUDIT DISABLE;
ALTER TRIGGER TRG_EMP_SAL_BU DISABLE;
ALTER TRIGGER TRG_DEPT_DEF_EMP_BI DISABLE;

DROP TRIGGER TRG_EMP_FZN;

-----------------------------------------------------------------------------------------------------------------------
--------------------------------------Statement Level Triggers---------------------------------------------------------
--Create a statement level trigger to prevent anyone from deleting any of the departments.
CREATE OR REPLACE TRIGGER TRG_DEPT_B_DLT
BEFORE DELETE ON DEPT_TRG
BEGIN
    RAISE_APPLICATION_ERROR(-20004, 'Trigger prevents delete in DEPARTMENT table');

END;
/

DELETE FROM DEPT_TRG;
-----------------------------------------------------------------------------------------------------------------------
--Create a statement level trigger to prevent update employees salary between 1-15 of the month.
CREATE OR REPLACE TRIGGER TRG_EMP_SAL_BUD
BEFORE UPDATE ON EMP_TRG
DECLARE
    v_day NUMBER(3);
BEGIN
    SELECT EXTRACT(DAY FROM SYSDATE) INTO v_day FROM DUAL;    
    IF v_day BETWEEN 1 AND 15 THEN
        RAISE_APPLICATION_ERROR(-20033, 'CANNOT UPDATE SALARY ON ' || v_day || ' OF THE MONTH.');
    END IF;
    
END;
/

UPDATE EMP_TRG
SET SALARY = 30000
WHERE EMPLOYEE_ID = 501;

SELECT * FROM EMP_TRG
WHERE EMPLOYEE_ID BETWEEN 100 AND 160;

SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;

-----------------------------------------------------------------------------------------------------------------------
--Create a statement level trigger on employees table to allow update on employees only if less than 3 department are Active.
----and log entry when employees data are updated, which will be useful to create the report on the employees data update frequency.
CREATE OR REPLACE TRIGGER TRG_EMP_UPT_DEPT_ACTIVE
BEFORE UPDATE ON EMP_TRG
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM DEPT_TRG
    WHERE STATUS = 'Active';
    
    IF v_count > 3 THEN
        RAISE_APPLICATION_ERROR(-20093, 'Cannot update when number of Active department is : ' || v_count);
    END IF;
END;
/

UPDATE EMP_TRG
SET SALARY = 55000
WHERE EMPLOYEE_ID = 108;

SELECT * FROM DEPT_TRG;

-----------------------------------------------------------------------------------------------------------------------
--Disable all the triggers created in this assignment.

ALTER TRIGGER TRG_EMP_UPT_DEPT_ACTIVE DISABLE;
ALTER TRIGGER TRG_EMP_SAL_BUD DISABLE; 
ALTER TRIGGER TRG_DEPT_B_DLT DISABLE;

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------Compund Triggers-----------------------------------------------------------
--Create a Compound Trigger on Employees table to log details into assignment_logs table for each type of triggers.
---- AFTER Statment --> Log total number of active departments into logs table.
---- For row level triggers --> Log entry into logs table for old and new salary and Department name if changed.
--                              Log all the column values in case employee data is inserted/deleted.
--  Use global variable to update th value with trigger type(BS, AS, BER, AER) in each trigger level body and print it in the after statement trigger.
-- Disable all the triggers created in this assignment.

CREATE OR REPLACE TRIGGER TRG_CMD_EMP
FOR UPDATE OR INSERT OR DELETE ON EMP_TRG
COMPOUND TRIGGER
    v_count NUMBER;
    v_trg VARCHAR2(100);

BEFORE EACH ROW IS
BEGIN

    INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Entered in Before Each Row Trigger');

    IF UPDATING THEN
        IF :old.department_id = :new.department_id THEN 
            INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Old Salary : ' || :old.SALARY 
            || ' New Salary : ' || :new.SALARY);
        ELSE
            INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Old Salary : ' || :old.SALARY 
            || ' New Salary : ' || :new.SALARY || ' Old Dept : ' || :old.DEPARTMENT_ID || ' New Dept : ' || :new.DEPARTMENT_ID);
        END IF;

    ELSIF DELETING THEN
        INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Employee ID : ' || :old.EMPLOYEE_ID || ' First Name : '
        || :old.FIRST_NAME || ' Last Name : ' || :old.LAST_NAME || ' Department ID : ' || :old.DEPARTMENT_ID || 'Salary : ' || :old.SALARY);

    ELSIF INSERTING THEN
        INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Employee ID : ' || :new.EMPLOYEE_ID || ' First Name : '
        || :new.FIRST_NAME || ' Last Name : ' || :new.LAST_NAME || ' Department ID : ' || :new.DEPARTMENT_ID || 'Salary : ' || :new.SALARY);

    END IF;

    v_trg := ' Trigger type : BEFORE EACH ROW';
END BEFORE EACH ROW;


BEFORE STATEMENT IS
BEGIN
    INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Entered in Before Statement Trigger');
    v_trg := ' Trigger type : BEFORE EACH ROW';
END BEFORE STATEMENT;


AFTER EACH ROW IS
BEGIN
    INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Entered in After Each Row Trigger');
    v_trg := ' Trigger type : BEFORE EACH ROW';
END AFTER EACH ROW;


AFTER STATEMENT IS
BEGIN
    INSERT INTO TAB_PROC_LOG VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP, 'Entered in After Statement Trigger');

    SELECT COUNT(*) INTO v_count FROM DEPT_TRG
    WHERE STATUS = 'Active';

    DBMS_OUTPUT.PUT_LINE(v_trg);
END AFTER STATEMENT;

END TRG_CMD_EMP;
/

ALTER TRIGGER TRG_CMD_EMP DISABLE;

-------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Assignment Employees-------------------------------------------
--Create the update trigger on employees table to print the value updated by the SQL.
CREATE OR REPLACE TRIGGER TRG_EMP_UPD_BER
BEFORE UPDATE ON EMP_TRG
FOR EACH ROW 
BEGIN
    IF :new.employee_id <> :old.employee_id THEN
        DBMS_OUTPUT.PUT_LINE('>>Old Employee ID : ' || :old.employee_id || ' >>New Employee ID : ' || :new.employee_id);
    END IF; 
    
    IF :new.First_name <> :old.First_name THEN
        DBMS_OUTPUT.PUT_LINE('>>Old First Name : ' || :old.First_name || ' >>New First Name : ' || :new.First_name);
    END IF; 
    
    IF :new.Last_name <> :old.Last_name THEN
        DBMS_OUTPUT.PUT_LINE('>>Old Last Name : ' || :old.Last_name || ' >>New Last Name : ' || :new.Last_name);
    END IF; 
    
    IF :new.Department_id <> :old.Department_id THEN
        DBMS_OUTPUT.PUT_LINE('>>Old Department Id : ' || :old.Department_id || ' >>New Department Id : ' || :new.Department_id);
    END IF; 
    
    IF :new.Salary <> :old.Salary THEN
        DBMS_OUTPUT.PUT_LINE('>>Old Salary : ' || :old.Salary || ' >>New Salary : ' || :new.Salary);
    END IF;
END TRG_EMP_UPD_BER;
/

ALTER TRIGGER TRG_EMP_UPD_BER DISABLE;

-----------------------------------------------------Assignment Department-------------------------------------------
--Disable all triggers on a table.
--Create a Coumpound Trigger on departments table to print before and after values of the data updated by the SQL.
--Statemtent level trigger should also be utilized to print the time to execute the SQL statement.

ALTER TABLE DEPT_TRG DISABLE ALL TRIGGERS;

CREATE OR REPLACE TRIGGER TRG_DEPT_UP
FOR UPDATE ON DEPT_TRG
COMPOUND TRIGGER
BEFORE STATEMENT IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Execution time of Before Statement Trigger : ' || SYSTIMESTAMP);

END BEFORE STATEMENT;

BEFORE EACH ROW IS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Values before updation');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Dept ID ; ' || :old.dept_id);
    DBMS_OUTPUT.PUT_LINE('Dept Name ; ' || :old.dept_name);
    DBMS_OUTPUT.PUT_LINE('Location ; ' || :old.location);
    DBMS_OUTPUT.PUT_LINE('Status ; ' || :old.status);
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Execution time of After Statement Trigger : ' || SYSTIMESTAMP);
END AFTER STATEMENT;

AFTER EACH ROW IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Values after updation');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Dept ID ; ' || :new.dept_id);
    DBMS_OUTPUT.PUT_LINE('Dept Name ; ' || :new.dept_name);
    DBMS_OUTPUT.PUT_LINE('Location ; ' || :new.location);
    DBMS_OUTPUT.PUT_LINE('Status ; ' || :new.status);

END AFTER EACH ROW;

END TRG_DEPT_UP;
/

SELECT * FROM DEPT_TRG;
