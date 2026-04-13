--------------------------------------------------------------------------------------------------------------
--------------------------------------------PL/SQL Triggers---------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_EMP_FZN
BEFORE INSERT OR UPDATE OR DELETE ON EMPLOYEES_FAIZAN
FOR EACH ROW

BEGIN
    IF UPDATING THEN
        INSERT INTO TAB_PROC_LOG (LOG_ID, LOG_TS, ACTION_TAKEN)
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'TABLE HAS BEEN UPDATED!!!');
    ELSIF DELETING THEN
        INSERT INTO TAB_PROC_LOG (LOG_ID, LOG_TS, ACTION_TAKEN)
        VALUES(SEQ_TAB_PROC_LOG.NEXTVAL, SYSTIMESTAMP,'A DELETE ATTEMPT WAS MADE!!!');
        DBMS_OUTPUT.PUT_LINE('Record deleted');
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

