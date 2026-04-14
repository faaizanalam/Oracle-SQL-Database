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
