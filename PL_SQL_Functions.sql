-------------------------------------------------************************-------------------------------------------
-------------------------------------------------------PL/SQL Functions---------------------------------------------
--Create the function to return the average salary of the passed department and use it in a query.
CREATE OR REPLACE FUNCTION FUNC_DEPT_AVG(p_in_dept IN EMPLOYEES_FAIZAN.DEPARTMENT_ID%TYPE, p_in_emp EMPLOYEES_FAIZAN.EMPLOYEE_ID%TYPE) RETURN NUMBER
IS 
    v_avg NUMBER(8);
    v_count NUMBER;
    v_dept NUMBER := p_in_dept;
BEGIN
    IF p_in_dept IS NULL AND p_in_emp IS NULL THEN
        --DBMS_OUTPUT.PUT_LINE('BOTH PARAMETERS CANNOT BE NULL');
        RETURN -1;
        
    ELSIF p_in_dept IS NULL THEN
        SELECT COUNT(*) INTO v_count FROM EMPLOYEES_FAIZAN
        WHERE EMPLOYEE_ID = p_in_emp;
        
        IF v_count = 0 THEN
            RETURN -1;
        ELSE
            SELECT DEPARTMENT_ID INTO v_dept FROM EMPLOYEES_FAIZAN
            WHERE EMPLOYEE_ID = p_in_emp;
        END IF;
    END IF;
    
    SELECT COUNT(*) INTO v_count FROM EMPLOYEES_FAIZAN
    WHERE DEPARTMENT_ID = v_dept;
        
    IF v_count = 0 THEN
    RETURN -1;
            
    ELSE                
        SELECT AVG(SALARY) INTO v_avg FROM EMPLOYEES_FAIZAN
        WHERE DEPARTMENT_ID = v_dept;
        RETURN v_avg;
    END IF;
END FUNC_DEPT_AVG;
/

SET SERVEROUT ON;
BEGIN

    IF FUNC_DEPT_AVG(NULL, 103) = -1 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR, Either both or one of the parameter is INVALID');
    ELSE
        FOR i IN 1..10
        LOOP 
            DBMS_OUTPUT.PUT_LINE(i || ' x ' || FUNC_DEPT_AVG(NULL, 100) || ' = ' || FUNC_DEPT_AVG(NULL, 100) * i  );    
        END LOOP;
    END IF;
END;
/
SELECT * FROM EMPLOYEES_FAIZAN;




