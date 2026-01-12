----------------------------------------------PL/SQL Excecise---------------------------------------------------------------------
--Variables
--IF / CASE / GOTO
--All loops
--CONTINUE / EXIT
--Exception handling (built-in + user-defined)
--SQLCODE / SQLERRM
--RAISE / RAISE_APPLICATION_ERROR

-----------------------------------------------------Senario#1-----------------------------------------------------------------------
--Write a PL/SQL block that:

--Stores a salary in a variable
--If salary is:
--NULL → raise an application error -20001
--Less than 0 → raise an application error -20002
--Greater than 200,000 → raise an application error -20003
--Otherwise print "Salary Accepted"
SET SERVEROUTPUT ON;
Declare
    v_sal NUMBER(8);
Begin 
    SELECT SALARY * 120 INTO v_sal FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 121;
    
    DBMS_OUTPUT.PUT_LINE('Value stored in v_sal : ' || v_sal);
    IF V_sal IS NULL THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Nothing to display');
    ELSIF v_sal < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Salary less than 0');
    ELSIF v_sal > 200000 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Salary greater than 200000');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salary Accepted');
    END IF;
--Exception
--    WHEN OTHERS THEN 
--        DBMS_OUTPUT.PUT_LINE('ESCEPTION HANDLED');
End;
/

SELECT SALARY FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 121;








