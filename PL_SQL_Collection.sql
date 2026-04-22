----------------------------------------------------------------------------------------------------------------
------------------------------------------PL/SQL Collection-----------------------------------------------------
--Create associative array to store all the departments and its city into it.
----Delete the city from the associative array for inactive department.
----Access each elements of the associative array and print the depatment_id --> City.
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

--Create associative array to store the department id for each employees. emp_id --> manager_name
----store department of all the employees of department HR.
----delete the manager if the salary of his/her is less than 5000 and print the details.



SET SERVEROUT ON;






SELECT DEPT_NAME FROM DEPT_TRG WHERE STATUS = 'Inactive';





