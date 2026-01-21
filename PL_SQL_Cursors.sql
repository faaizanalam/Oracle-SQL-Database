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























