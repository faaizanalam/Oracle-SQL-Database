------------------------------------------------------PL/SQL Cursors-------------------------------------------------------------
--------------------------------------------------------***********--------------------------------------------------------------
--Fetch all the empoyees with salary in odd number and print then in desc order of the salary using cursor.
DECLARE
    CURSOR cur_emp IS SELECT * FROM EMPLOYEES_FAIZAN
    WHERE MOD(SALARY, 2) = 1
    ORDER BY SALARY DESC;
    
    rec_cur_emp cur_emp%ROWTYPE;
    
BEGIN
    OPEN cur_emp;
    
    LOOP
    FETCH cur_emp INTO rec_cur_emp;
    
    DBMS_OUTPUT.PUT_LINE('ROW_COUNT : ' || cur_emp%ROWCOUNT);
    DBMS_OUTPUT.PUT_LINE('------------------------***********'|| cur_emp%ROWCOUNT || '***********----------------------');
    DBMS_OUTPUT.PUT_LINE('Employee_ID : ' || rec_cur_emp.Employee_ID);
    DBMS_OUTPUT.PUT_LINE('First_name : ' || rec_cur_emp.First_name);
    DBMS_OUTPUT.PUT_LINE('Last_name : ' || rec_cur_emp.Last_name);
    DBMS_OUTPUT.PUT_LINE('Department_id : ' || rec_cur_emp.Department_id);
    DBMS_OUTPUT.PUT_LINE('Salary : ' || rec_cur_emp.Salary);
    
    EXIT WHEN cur_emp%NOTFOUND;
    END LOOP;    
END;
/
SET SERVEROUTPUT ON;


--Print the details of all the employees with salary in ascending order and stop printing the data when 2nd odd salaried employee is 
----encountered.
DECLARE
    CURSOR cur_emp IS SELECT * FROM EMPLOYEES_FAIZAN
    ORDER BY SALARY ASC;
    
    rec_cur_emp cur_emp%ROWTYPE;
    v_count PLS_INTEGER := 0;
BEGIN
    OPEN cur_emp;
    LOOP
    FETCH cur_emp into rec_cur_emp;
    DBMS_OUTPUT.PUT_LINE('ROW_COUNT : ' || cur_emp%ROWCOUNT);
    DBMS_OUTPUT.PUT_LINE('------------------------***********'|| cur_emp%ROWCOUNT || '***********----------------------');
    DBMS_OUTPUT.PUT_LINE('Employee_ID : ' || rec_cur_emp.Employee_ID);
    DBMS_OUTPUT.PUT_LINE('First_name : ' || rec_cur_emp.First_name);
    DBMS_OUTPUT.PUT_LINE('Last_name : ' || rec_cur_emp.Last_name);
    DBMS_OUTPUT.PUT_LINE('Department_id : ' || rec_cur_emp.Department_id);
    DBMS_OUTPUT.PUT_LINE('Salary : ' || rec_cur_emp.Salary);
    
    IF MOD(rec_cur_emp.SALARY, 2) = 1 THEN
        v_count := v_count + 1;
    END IF;
    
    EXIT WHEN v_count = 2 OR cur_emp%NOTFOUND;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('v_count at : ' || v_count);
    --DBMS_OUTPUT.PUT_LINE('FETCH AT : ' || cur_emp%NOTFOUND);
END;
/

--Loop through all the departments one by one and print name of all the employees per department separated by ">" in single line.
DECLARE
    CURSOR cur_dept IS SELECT DEPT_ID ,
    DEPT_NAME FROM DEPARTMENTSS
    ORDER BY DEPT_ID;    
    rec_cur_dept cur_dept%ROWTYPE;
    
    emp_list VARCHAR(4000);
    
BEGIN
    OPEN cur_dept;
    
    LOOP
        FETCH cur_dept INTO rec_cur_dept;
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-----------------------------****************----------------------------');
        DBMS_OUTPUT.PUT_LINE('Department ID : ' || rec_cur_dept.DEPT_ID);
        DBMS_OUTPUT.PUT_LINE('Department Name : ' || rec_cur_dept.DEPT_NAME);
        DBMS_OUTPUT.PUT_LINE('------------------------***********EMPLOYEES***********----------------------');
        SELECT LISTAGG(First_name || ' ' || Last_name, '>') WITHIN GROUP(ORDER BY First_name) INTO emp_list
        FROM EMPLOYEES_FAIZAN
        WHERE DEPARTMENT_ID = rec_cur_dept.DEPT_ID;
        
        DBMS_OUTPUT.PUT_LINE(emp_list);
        
        EXIT WHEN cur_dept%NOTFOUND;
    END LOOP;
END;
/

SELECT * FROM EMPLOYEES_FAIZAN;
SELECT * FROM DEPARTMENTSS;



--Loop though all the departments and print the total salary of the employees of that department.

DECLARE
    CURSOR cur_dept IS SELECT DEPT_ID ,
    DEPT_NAME FROM DEPARTMENTSS
    ORDER BY DEPT_ID;    
    rec_cur_dept cur_dept%ROWTYPE;
    
    emp_sal_sum NUMBER(10) := 0;
    emp_count NUMBER(5);
BEGIN
    OPEN cur_dept;
    
    LOOP
        FETCH cur_dept INTO rec_cur_dept;
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('-----------------------------****************----------------------------');
        DBMS_OUTPUT.PUT_LINE('Department ID : ' || rec_cur_dept.DEPT_ID);
        DBMS_OUTPUT.PUT_LINE('Department Name : ' || rec_cur_dept.DEPT_NAME);
        DBMS_OUTPUT.PUT_LINE('------------------------***********EMPLOYEES***********----------------------');
        SELECT SUM(SALARY), COUNT(employee_id) INTO emp_sal_sum, emp_count
        FROM EMPLOYEES_FAIZAN
        WHERE DEPARTMENT_ID = rec_cur_dept.DEPT_ID;
        
        DBMS_OUTPUT.PUT_LINE('Number of employees in dept : ' || NVL(emp_count, 0));
        DBMS_OUTPUT.PUT_LINE('Salary sum : ' || NVL(emp_sal_sum, 0));
        
        EXIT WHEN cur_dept%NOTFOUND;
    END LOOP;
END;
/

SELECT * FROM EMPLOYEES_FAIZAN;
SELECT * FROM DEPARTMENTSS;


---------------------------------------------Parameterized Cursors--------------------------------------------
--Using the parameterized cursor,
----Fetch and print the details of all the employees with salary greater than 10000 in ascending order.
----Fetch and print the detials of all the employees with salary greater than 6000 in ascending order.
DECLARE
    CURSOR pcur_emp(sal_lmt NUMBER) IS 
    SELECT EMPLOYEE_ID ,
    FIRST_NAME ,
    LAST_NAME ,
    DEPARTMENT_ID ,
    SALARY  FROM EMPLOYEES_FAIZAN 
    WHERE SALARY > sal_lmt;
    
    rec_pcur_emp pcur_emp%ROWTYPE;
        
BEGIN
    OPEN pcur_emp(10000);  ---60000 in case of 2nd question
    LOOP
    FETCH pcur_emp INTO rec_pcur_emp;
    DBMS_OUTPUT.PUT_LINE('Employees with salary greater than 10k');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID : ' || rec_pcur_emp.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || rec_pcur_emp.First_name);
    DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || rec_pcur_emp.Last_name);
    DBMS_OUTPUT.PUT_LINE('DEPT_ID : ' || rec_pcur_emp.DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || rec_pcur_emp.SALARY);
    
    EXIT WHEN pcur_emp%NOTFOUND;
    
    END LOOP;
END;
/
   
--Using the parameterized cursor.
----Fetch and print the details of all the employees with HR department.
----Fetch and print the detials of all the employees with Admin department.
DECLARE
    CURSOR pcur_emp(par_a VARCHAR2) IS
    SELECT * FROM EMPLOYEES_FAIZAN
    WHERE DEPARTMENT_ID = (SELECT DEPT_ID FROM DEPARTMENTSS WHERE DEPT_NAME = par_a);
    
    rec_pcur_emp pcur_emp%ROWTYPE;
BEGIN
    OPEN pcur_emp('Human Resources');  -----Admin in case of admin.
    LOOP
    FETCH pcur_emp INTO rec_pcur_emp;
    DBMS_OUTPUT.PUT_LINE('Employees with deptartment HR');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID : ' || rec_pcur_emp.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || rec_pcur_emp.First_name);
    DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || rec_pcur_emp.Last_name);
    DBMS_OUTPUT.PUT_LINE('DEPT_ID : ' || rec_pcur_emp.DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || rec_pcur_emp.SALARY);
    
    EXIT WHEN pcur_emp%NOTFOUND;
    
    END LOOP;
    
END;
/


--Using the parameterized cursor,
----find if the given number is indivisible and try with 3-4 numbers.
DECLARE
    CURSOR p_cur(num NUMBER) IS 
    SELECT num AS NUMBER_ENTERED, LEVEL AS DIVISOR
    FROM DUAL CONNECT BY LEVEL = num - 1;
    
    rec_pcur p_cur%ROWTYPE;
    
    v_var NUMBER(2);
    
BEGIN
    OPEN p_cur(9);
    LOOP
        FETCH p_cur INTO rec_pcur;
        IF MOD(rec_pcur.NUMBER_ENTERED, rec_pcur.DIVISOR) = 0 THEN
            v_var := 1;
        END IF;
        
        EXIT WHEN p_cur%NOTFOUND;
    END LOOP;
    
    IF v_var = 1 THEN
        DBMS_OUTPUT.PUT_LINE('NUMBER IS DIVISIBLE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NUMBER IS NOT-DIVISIBLE');
    END IF;
    
END;
/



SELECT 9, LEVEL FROM DUAL
CONNECT BY LEVEL <= 9-1;


----------------------------------------------Cursors with FOR LOOP------------------------------------------------
--Using FOR LOOP, Print the details of employees where department is HR.
BEGIN
    FOR emp IN (SELECT EMPLOYEE_ID ,
    FIRST_NAME ,
    LAST_NAME ,
    DEPARTMENT_ID ,
    SALARY  FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = 
    (SELECT DEPT_ID FROM DEPARTMENTSS WHERE DEPT_NAME = 'Human Resources'))
    LOOP
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || emp.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || emp.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID : ' || emp.DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || emp.SALARY);
    
    END LOOP;
END;
/

SELECT * FROM EMPLOYEES_FAIZAN;
SELECT * FROM DEPARTMENTSS;


--Using FOR LOOP, update the salary of the employee by 10% + (1% * Number of employee with lower salary than current employee in the same dept).
DECLARE
    v_num NUMBER(5) := 0;
    emp_sal NUMBER(7) := 0;
    emp_count NUMBER := 0;
BEGIN
    FOR dept IN (SELECT DEPT_ID FROM DEPARTMENTSS)
    LOOP
        
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT in Consideration : ' || dept.DEPT_ID);
        FOR emp_outer IN (SELECT * FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = dept.DEPT_ID)
        LOOP
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('EMPLOYEE_ID Currently Being Processed : ' || emp_outer.employee_id);
            DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || emp_outer.FIRST_NAME);
            DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || emp_outer.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('SALARY BEFORE UPDATE: ' || emp_outer.SALARY);
            
            emp_count := emp_count + 1;
            DBMS_OUTPUT.PUT_LINE('EEMPLOYEE COUNT : ' || emp_count);
            v_num := 0;
            
            FOR emp_inner IN (SELECT * FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = dept.DEPT_ID)
            LOOP
                IF emp_inner.SALARY < emp_outer.SALARY THEN
                    v_num := v_num + 1;
                ELSE
                    NULL;
                END IF;
            END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('NUMBER OF EMPLOYEES WITH LOWER SALARY THEN CURRENT EMPLOYEE IN SAME DEPT : ' || v_num);
        DBMS_OUTPUT.PUT_LINE('APPLYING UPDATE : 10% + 1% * ' || v_num);   
        UPDATE EMPLOYEES_FAIZAN
        SET SALARY = TRUNC(SALARY + ((SALARY * 10/100) + ((SALARY * 1/100) * v_num)))
        WHERE EMPLOYEE_ID = emp_outer.EMPLOYEE_ID;
        
        SELECT SALARY INTO emp_sal FROM EMPLOYEES_FAIZAN
        WHERE Employee_id = emp_outer.employee_id;
        
        DBMS_OUTPUT.PUT_LINE('SALARY AFTER UPDATE(using cursor): ' || emp_outer.SALARY);
        DBMS_OUTPUT.PUT_LINE('SALARY AFTER UPDATE(using sub_query): ' || emp_sal);
        
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    END LOOP;
END;
/

--Using FOR LOOP, Fetch and Print the data of employees with odd salary in ascending order.
BEGIN
    FOR emp IN (SELECT * FROM EMPLOYEES WHERE MOD(SALARY, 2) = 1
    ORDER BY SALARY ASC)
    LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || emp.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || emp.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID : ' || emp.DEPARTMENT_ID);
        DBMS_OUTPUT.PUT_LINE('SALARY : ' || emp.SALARY); 
    END LOOP;
END;
/



----------------------------------------------Assignment------------------------------------------
--Use the basic cursor to print numbers from 1 to 100.
----Open and Fetch the data from cursor and sum the number generated by cursor query into one of the variables.
BEGIN
    FOR I IN (SELECT LEVEL FROM DUAL CONNECT BY LEVEL < 101)
    LOOP
    DBMS_OUTPUT.PUT_LINE(I.LEVEL);
    END LOOP;
END;
/

DECLARE
    CURSOR cur_num IS 
    SELECT LEVEL AS NUMBERS FROM DUAL CONNECT BY LEVEL < 101;
    
    rec_cur cur_num%ROWTYPE;
    v_sum NUMBER(8) := 0;
BEGIN
    OPEN cur_num;
    LOOP
        FETCH cur_num INTO rec_cur;
        DBMS_OUTPUT.PUT_LINE(rec_cur.NUMBERS);
        
        IF rec_cur.NUMBERS BETWEEN 51 AND 60 THEN
            NULL;
        ELSE
            v_sum := v_sum + rec_cur.NUMBERS;      
        END IF;
    EXIT WHEN cur_num%NOTFOUND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
    CLOSE cur_num;

END;
/

commit;

set serveroutput on;

----Use the For Loop to fetch all the employees of dept_id = 2 and loop through it.
--
DECLARE
    CURSOR cur_emp(emp NUMBER) IS
    SELECT * FROM EMPLOYEES_FAIZAN WHERE employee_id = emp;
    
    rec_cur_emp cur_emp%ROWTYPE;
BEGIN
    FOR i IN (SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = 2)
    LOOP
        DBMS_OUTPUT.PUT_LINE('CURRENT EMPLOYEE');
        DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || i.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || i.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID : ' || i.DEPARTMENT_ID);
        DBMS_OUTPUT.PUT_LINE('SALARY : ' || i.SALARY);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('EMPLOYEES WITH SALARIES LESS THAN CURRENT EMPLOYEE');
        
        OPEN cur_emp(i.EMPLOYEE_ID);
        LOOP
            FETCH cur_emp INTO rec_cur_emp;
            IF i.SALARY > rec_cur_emp.SALARY THEN
                    DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || i.FIRST_NAME);
                    DBMS_OUTPUT.PUT_LINE('LAST_NAME : ' || i.LAST_NAME);
                    DBMS_OUTPUT.PUT_LINE('DEPARTMENT_ID : ' || i.DEPARTMENT_ID);
                    DBMS_OUTPUT.PUT_LINE('SALARY : ' || i.SALARY);               
            END IF;
            EXIT WHEN cur_emp%NOTFOUND;
        END LOOP;
        CLOSE cur_emp;
    END LOOP;
    CLOSE cur_emp;
END;
/

SELECT * FROM EMPLOYEES_FAIZAN WHERE DEPARTMENT_ID = 2;