----------------------------------------------------------------------------------------------------------------
------------------------------------------PL/SQL Collection-----------------------------------------------------
--Create associative array to store all the departments and its city into it.
----Delete the city from the associative array for inactive department.
----Access each elements of the associative array and print the depatment_id --> City.
SET SERVEROUT ON;
DECLARE
--    TYPE AA_DEPT_LOCATION IS TABLE OF VARCHAR2(60) Error : Due to missing index, it was implicitly considered as a nested table, nested tables use number as index by default and trying to index it using 'dept_name' was generating a numeric to string conversion error!!
    TYPE AA_DEPT_LOCATION IS TABLE OF VARCHAR2(60) INDEX BY VARCHAR2(60);
    
    vaa_dept_loc AA_DEPT_LOCATION;
    v_idx VARcHAR2(60);

    CURSOR cur_dept_NL IS
    SELECT DEPT_NAME, LOCATION 
    FROM DEPT_TRG;
    
BEGIN

    FOR rec IN cur_dept_NL
    LOOP
        vaa_dept_loc(rec.DEPT_NAME) := rec.LOCATION;
    END LOOP; 
    
    v_idx := vaa_dept_loc.FIRST;
    WHILE v_idx IS NOT NULL
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ' >> ' || vaa_dept_loc(v_idx));
        v_idx := vaa_dept_loc.NEXT(v_idx);
    END LOOP;
    
    FOR i IN (SELECT DEPT_NAME FROM DEPT_TRG WHERE STATUS = 'Inactive')
    LOOP
        --vaa_dept_loc.DELETE(i); This failed because >>>>> In PL/SQL, the loop index i is not the value itself; it is a "container" for the row. Even with a single column, you must use dot notation to reach the data inside that container.
        vaa_dept_loc.DELETE(i.dept_name);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    v_idx := vaa_dept_loc.FIRST;
    WHILE v_idx IS NOT NULL
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ' >> ' || vaa_dept_loc(v_idx));
        v_idx := vaa_dept_loc.NEXT(v_idx);
    END LOOP;
    
END;
/

--Create associative array to store the department name for each employees. emp_id --> department_name
----Print all the employees of department Sales.
----delete the department if its budget is less than 100000 and print the details.

/*
DECLARE
    TYPE AA_EMP_DEPT_ID IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER; 
    V_AA_EMP_DEPT_ID AA_EMP_DEPT_ID;
    
    CURSOR cur_aa_emp_dept_id IS 
        SELECT e.employee_id, d.dept_name FROM EMP_TRG E
        JOIN DEPT_TRG D ON e.department_id = d.dept_id;
    idx PLS_INTEGER;
BEGIN
    FOR rec in cur_aa_emp_dept_id
    LOOP
        V_AA_EMP_DEPT_ID(rec.employee_id) := rec.dept_name;
    END LOOP;
    
    ------------------------------------------------------
    idx := V_AA_EMP_DEPT_ID.FIRST;
    WHILE idx IS NOT NULL
    LOOP
        IF V_AA_EMP_DEPT_ID(idx) = 'Human Resources' THEN
            DBMS_OUTPUT.PUT_LINE( idx || '>>>>>>>>>>>' || V_AA_EMP_DEPT_ID(idx));
        END IF;
        idx := V_AA_EMP_DEPT_ID.NEXT(idx);    
    END LOOP;
    
    ----------------------------------------------------
    idx := V_AA_EMP_DEPT_ID.FIRST;
    FOR i IN (SELECT DEPT_NAME FROM EMP_TRG E
        JOIN DEPT_TRG D ON e.department_id = d.dept_id
        GROUP BY DEPT_NAME
        HAVING SUM(SALARY) < 100000)
    LOOP
        FOR j IN cur_aa_emp_dept_id
        LOOP
            IF V_AA_EMP_DEPT_ID(j.employee_id) = i.dept_name THEN
                V_AA_EMP_DEPT_ID.DELETE(j.employee_id);
            END IF;
        END LOOP;
        
    END LOOP;
END;
/

This code was written by me, thi code suffered from a 
runtime error caused by illegally reusing an explicit cursor in a nested loop, and 
it suffered from severe performance bottlenecks by repeatedly querying physical database tables inside those loops.

*/

/*
Following code is AI refined version fixes the cursor bug and drastically improves execution speed by querying
the database only once at the beginning, processing all 
subsequent deletions purely in-memory using the data already stored in your associative array.
*/

DECLARE
    TYPE AA_EMP_DEPT_ID IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER; 
    V_AA_EMP_DEPT_ID AA_EMP_DEPT_ID;
    
    CURSOR cur_aa_emp_dept_id IS 
        SELECT e.employee_id, d.dept_name 
        FROM EMP_TRG E
        JOIN DEPT_TRG D ON e.department_id = d.dept_id;
        
    idx PLS_INTEGER;
BEGIN
    -- 1. Populate the Associative Array
    FOR rec IN cur_aa_emp_dept_id
    LOOP
        V_AA_EMP_DEPT_ID(rec.employee_id) := rec.dept_name;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    -- 2. Print Human Resources Employees
    idx := V_AA_EMP_DEPT_ID.FIRST;
    WHILE idx IS NOT NULL
    LOOP
        IF V_AA_EMP_DEPT_ID(idx) = 'Sales' THEN
            DBMS_OUTPUT.PUT_LINE(idx || '>>>>>>>>>>>' || V_AA_EMP_DEPT_ID(idx));
        END IF;
        idx := V_AA_EMP_DEPT_ID.NEXT(idx);    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    -- 3. Delete low-salary departments (Fixed and Highly Optimized)
    FOR i IN (SELECT d.dept_name 
              FROM EMP_TRG e
              JOIN DEPT_TRG d ON e.department_id = d.dept_id
              GROUP BY d.dept_name
              HAVING SUM(e.salary) < 900000)
    LOOP
        -- Loop directly through the associative array in memory (Zero DB hits!)
        idx := V_AA_EMP_DEPT_ID.FIRST;
        WHILE idx IS NOT NULL
        LOOP
            IF V_AA_EMP_DEPT_ID(idx) = i.dept_name THEN
                DBMS_OUTPUT.PUT_LINE(idx || '>>>>>>>>>>>' || V_AA_EMP_DEPT_ID(idx) || ' has been deleted.');
                V_AA_EMP_DEPT_ID.DELETE(idx);
            END IF;
            idx := V_AA_EMP_DEPT_ID.NEXT(idx);
        END LOOP;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
     idx := V_AA_EMP_DEPT_ID.FIRST;
    WHILE idx IS NOT NULL
    LOOP
        DBMS_OUTPUT.PUT_LINE(idx || '>>>>>>>>>>>' || V_AA_EMP_DEPT_ID(idx));
        idx := V_AA_EMP_DEPT_ID.NEXT(idx);    
    END LOOP;
END;



/








SELECT * FROM DEPT_TRG;







