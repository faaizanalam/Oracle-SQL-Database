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


-----------------------------------------------------Senario#2-----------------------------------------------------------------------
--Given a variable v_salary, assign grade:
--
--A → salary ≥ 120,000
--B → salary between 80,000 and 119,999
--C → salary between 50,000 and 79,999
--D → salary below 50,000
--Use CASE, not IF.
--Print the grade.
--

Declare 
    v_salary VARCHAR2(10);
    v_sal NUMBER(8);
Begin
    SELECT SALARY * 12 INTO v_sal FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 120;
    
    CASE 
        WHEN v_sal >= 120000 THEN
            v_salary := 'A';
        WHEN v_sal BETWEEN 80000 and 119999 THEN
            v_salary := 'B';
        WHEN v_sal BETWEEN 50000 and 79999 THEN
            v_salary := 'C';
        WHEN v_sal < 50000 THEN
            v_salary := 'D';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('Salary stored in variable : ' || v_sal);
    DBMS_OUTPUT.PUT_LINE('Grade Assigned to variable was : ' || v_salary);
    
End;
/

-----------------------------------------------------Senario#3-----------------------------------------------------------------------
--Simulate 7 working days using a loop.
--If day = 6 or 7 → skip processing (CONTINUE)
--For remaining days print "Processed day X"

BEGIN

    FOR i IN 1..7
    LOOP
        IF i < 6 THEN 
            DBMS_OUTPUT.PUT_LINE('Proccessing day : ' || i);
        ELSE
            CONTINUE;
        END IF;
    END LOOP;

END;
/

-----------------------------------------------------Senario#4-----------------------------------------------------------------------
--Loop from 1 to 10:
--If value = 5, raise NO_DATA_FOUND
--Catch the exception and print "Error on record 5"
--Continue processing remaining values
--Output must process all numbers except 5.

BEGIN
    FOR i IN 1..10
    LOOP
        IF i = 5 THEN
            BEGIN
                RAISE NO_DATA_FOUND;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('Error on record 5');
                    CONTINUE; 
            END;
--            CONTINUE;            
        END IF;
        DBMS_OUTPUT.PUT_LINE('LOOP ITTERATION : ' || i);
    END LOOP;
END;
/

-----------------------------------------------------Senario#5-----------------------------------------------------------------------
--Given joining_year = 2015
--Calculate experience as current_year - joining_year
--If experience < 0 → raise application error
--If experience > 40 → print warning
--Else print experience

DECLARE
    v_join NUMBER(4) := 2015;
    v_exp NUMBER(2);
BEGIN
    v_exp := EXTRACT(YEAR FROM SYSDATE) - v_join;
    IF v_exp < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Experiance cannot be negative');
    ELSIF v_exp > 40 THEN
        DBMS_OUTPUT.PUT_LINE('WARNING! Suspect ought to die anytime soon!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Experiance in years : ' || v_exp);
    END IF;
END;
/

-----------------------------------------------------Senario#6-----------------------------------------------------------------------
--Given a password length variable:
--If length < 8 → raise application error
--If length between 8 and 12 → print "Medium strength"
--If > 12 → print "Strong password"

DECLARE
    v_pass VARCHAR2(45) := '&amp';
    v_len NUMBER(2);
BEGIN
    v_len := LENGTH(v_pass);
    
    IF v_len < 8 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Password should be atleast 8 charachters ');
        
    ELSIF v_len BETWEEN 8 AND 12 THEN
        DBMS_OUTPUT.PUT_LINE('Medium Strength');
    
    ELSIF v_len > 12 THEN 
        DBMS_OUTPUT.PUT_LINE('Strong password');
    END IF;
END;
/

-----------------------------------------------------Senario#7-----------------------------------------------------------------------
--Simulate payroll for 5 employees:
--Loop 1 to 5
--If employee number = 3 → simulate error using ZERO_DIVIDE
--Catch error and log:
--employee number
--SQLCODE
--SQLERRM
--Continue payroll for others
DECLARE
    v_emp NUMBER(2);
BEGIN
    FOR i IN 1..5
    LOOP
        v_emp := i;
        IF i = 3 THEN
            Raise ZERO_DIVIDE;
        END IF;
    END LOOP;
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE NUMBER : ' || v_emp);
        DBMS_OUTPUT.PUT_LINE('Error Code : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error Message : ' || SQLERRM);

END;
/

-----------------------------------------------------Senario#8-----------------------------------------------------------------------
--Given v_budget:  -----department budget
--If NULL → error
--If negative → error
--If budget > 1,000,000 → print "Requires approval"
--Else print "Approved"
--Use nested IF.
DECLARE
    v_budget NUMBER(15);
    dept_id NUMBER(2) := &num;
BEGIN
    SELECT TRUNC(SUM(SALARY)) INTO v_budget FROM EMPLOYEES
    WHERE DEPARTMENT_ID = dept_id;
    
    IF v_budget IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'No Data to show, check if the entered dept exists');
    ELSIF v_budget < 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Budget cannot be negative');
    ELSIF v_budget > 1000000 THEN
        DBMS_OUTPUT.PUT_LINE('REQUIRES APPROVAL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Approved');
    END IF;

END;
/
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

-----------------------------------------------------Senario#9-----------------------------------------------------------------------
--Loop from 1 to 20:
--Print:
--“Even” numbers only
--Skip odd numbers using CONTINUE

BEGIN
    FOR i IN 1..20
    LOOP
        CASE MOD(i,2)
            WHEN 0 THEN
                DBMS_OUTPUT.PUT_LINE(i);
            WHEN 1 THEN
                CONTINUE;
        END CASE;
    END LOOP; 
END;
/

-----------------------------------------------------Senario#10-----------------------------------------------------------------------
--Loop indefinitely:
--Start counter from 1
--Print counter
--Exit loop when counter reaches 7
--Use basic LOOP, not FOR.
DECLARE
    v_con NUMBER(2);
BEGIN
    v_con := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter at : ' || v_con);
        v_con := v_con + 1;
        
        EXIT WHEN v_con = 7;
    END LOOP;
END;
/

-----------------------------------------------------Senario#10-----------------------------------------------------------------------
--Write a block that:
--Raises a custom error
--Catches it using WHEN OTHERS
--Prints:
--Error code
--Error message
--Timestamp using SYSDATE
DECLARE
    v_err EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_err, -20007);
BEGIN
    FOR i IN 1..8
    LOOP
        IF i = 7 THEN
            RAISE v_err;
        END IF;
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message : ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE(SYSTIMESTAMP);
END;
/

-----------------------------------------------------Senario#11-----------------------------------------------------------------------
--Validate a record using multiple checks:
--Age must be between 18 and 60
--Salary must be > 30,000
--Experience must be ≥ 1 year
--If any rule fails, raise an appropriate application error.
DECLARE
    v_age EMPLOYEEES.age%TYPE;
    v_sal EMPLOYEEES.salary%TYPE;
    v_exp NUMBER(10);
    v_eid NUMBER(3) := &amp;
BEGIN
    SELECT AGE, SALARY, TRUNC((SYSDATE - Joining_date)/365) INTO v_age, v_sal, v_exp FROM EMPLOYEEES
    WHERE E_ID = v_eid;
    
    IF v_age BETWEEN 18 AND 60 THEN
        IF v_sal > 30000 THEN 
            IF v_exp > 1 THEN
                DBMS_OUTPUT.PUT_LINE('RECORD VALIDATED');
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'Work experiance should be atleat 1 year');
            END IF;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Salary must be greater than 30000');
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Age should be between 18 and 25');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Record exists for the input');
END;
/


-----------------------------------------------------Senario#12-----------------------------------------------------------------------
--Loop employees 1–5:
--If employee number is even → eligible
--If odd → not eligible
--Print result using CASE

BEGIN
    FOR i IN 1..5
    LOOP
        CASE MOD(i,2)
            WHEN 1 THEN
                DBMS_OUTPUT.PUT_LINE('Employee ' || i || ' is Eligible');
            WHEN 0 THEN
                DBMS_OUTPUT.PUT_LINE('Employee ' || i || ' is Not e
                ligible');
        END CASE;
    END LOOP;
END;
/

-----------------------------------------------------Senario#13-----------------------------------------------------------------------
--Write a block that:
--Performs a division
--Handles ZERO_DIVIDE
--Uses SQLCODE and SQLERRM
--Re-raises the exception
--Explain why re-raising is important.
DECLARE
    v_quotient NUMBER(4);
    v_divisor NUMBER(4) := 0;
    v_divident NUMBER(4) := 9;
BEGIN
    BEGIN
        v_quotient := v_divident / v_divisor;
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE('INNER BLOCK : Cannot divide by Zero');
            RAISE;
    END;
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('OUTER BLOCK : CANNOT DIVIVDE BY ZERO');
END;
/
--When an exception occurs, PL/SQL stops normal execution and jumps to the EXCEPTION block. 
--If that block finishes without a RAISE statement, control returns to the calling environment as if the procedure completed successfully.


-----------------------------------------------------Senario#14-----------------------------------------------------------------------
--Simulate processing 10 employee records:
--Loop 1–10
--If employee ID is:
--4 → missing data
--7 → invalid salary
--Handle each case with different messages
--Continue processing
--At end, print "Batch completed"
--This mirrors real payroll/ETL systems.
DECLARE
    i NUMBER(2) := 0;
BEGIN
    WHILE(i <= 10)
    LOOP
        BEGIN
            CASE i
                WHEN 4 THEN
                    RAISE_APPLICATION_ERROR(-20001, 'MISSING DATA');
                WHEN 6 THEN 
                    RAISE_APPLICATION_ERROR(-20003, 'INVALID SALARY');
                ELSE
                    NULL;
            END CASE;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('MISSING DATA');
        
        END;
        i := i + 1;
    END LOOP;    
    DBMS_OUTPUT.PUT_LINE('Batch Completed');
END;
/

--If no condition is met and no ELSE clause is present, it raises a CASE_NOT_FOUND exception. (CASE Statement)

-----------------------------------------------------Senario#15-----------------------------------------------------------------------
--Loop from 1 to 20:
--Print numbers
--If number divisible by 6 → print "Checkpoint reached"
--Exit loop only after two checkpoints are reached
--No hardcoded exit number.

DECLARE
    v_counter NUMBER(2) := 0;    
BEGIN
    FOR i IN 1..20
    LOOP
        IF MOD(i, 6) = 0 THEN
            v_counter := v_counter + 1;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Value of i : ' || i);
        DBMS_OUTPUT.PUT_LINE('Value of v_counter : '|| v_counter);
    EXIT WHEN v_counter = 2;
    END LOOP;    
END;
/

-----------------------------------------------------Senario#16-----------------------------------------------------------------------
--Simulate processing 15 records:
--If record divisible by 4 → NO_DATA_FOUND
--If divisible by 7 → ZERO_DIVIDE
--Log the error message
--Continue processing
--Count total errors
--Print total errors at the end

DECLARE
    v_err NUMBER(2) := 0;
BEGIN
    FOR i IN 1..15
    LOOP
        BEGIN
            IF MOD(i,4) = 0 THEN
                v_err := v_err + 1;
                RAISE NO_DATA_FOUND;
            ELSIF MOD(i, 7) = 0 THEN
                v_err := v_err + 1;
                RAISE ZERO_DIVIDE;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
                
            WHEN ZERO_DIVIDE THEN
                DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_lINE('Total number of errors : ' || v_err);
END;
/

-----------------------------------------------------Senario#17-----------------------------------------------------------------------
--Using a basic LOOP, print numbers from 10 down to 1.
--No FOR loop. No REVERSE keyword.
DECLARE
    v_num NUMBER(2);
BEGIN
    v_num := 10;
    LOOP
    DBMS_OUTPUT.PUT_LINE('Current Number : ' || v_num);
    v_num := v_num - 1;
    EXIT WHEN v_num = 0;
    END LOOP;
END;
/

-----------------------------------------------------Senario#18-----------------------------------------------------------------------
--Create a block where:
--Inner block raises a user-defined exception
--Inner block handles it and logs message
--Outer block re-raises the exception
--Final output should stop execution
--This tests exception propagation, not syntax.
DECLARE
    v_udf EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_udf, -20006);
BEGIN
    BEGIN
        RAISE v_udf;
    EXCEPTION
        WHEN v_udf THEN
            DBMS_OUTPUT.PUT_LINE('USER_DEFINED_ERROR ----- INNER BLOCK');
            RAISE;     ---Re-raisiing
    END;
EXCEPTION
    WHEN v_udf THEN
        DBMS_OUTPUT.PUT_LINE('RE-RAISED USER_DEFINED_ERROR ----- OUTER BLOCK');
END;
/

-----------------------------------------------------Senario#19-----------------------------------------------------------------------
--Write a block that:
--Performs multiple divisions inside a loop
--Handles ZERO_DIVIDE silently
--Counts how many times division failed
--Prints summary at the end
--No printing inside exception block.

DECLARE
    v_counter NUMBER := 0;
    v_num NUMBER := 0;
    v_end NUMBER := &amp;
BEGIN
    FOR i IN 1..v_end
    LOOP
        BEGIN
            v_num := i / 0;
        EXCEPTION
            WHEN ZERO_DIVIDE THEN
                v_counter := v_counter + 1;
                NULL;
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Silent handles : ' || v_counter);
END;
/


-----------------------------------------------------Senario#20-----------------------------------------------------------------------
--Raise a custom error using RAISE_APPLICATION_ERROR
--Catch it using WHEN OTHERS
--Log error
--Re-raise the same error   
BEGIN
    BEGIN
        RAISE_APPLICATION_ERROR(-20005,'This is a custom error');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('INNER BLOCK');
            DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
            RAISE;
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OUTER BLOCK');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

--Explain why this pattern is used in production systems.
--When an exception occurs, PL/SQL stops normal execution and jumps to the EXCEPTION block. 
--If that block finishes without a RAISE statement, control returns to the calling environment as if the procedure completed successfully.

-----------------------------------------------------Senario#21-----------------------------------------------------------------------
--Assign performance label using CASE:
--Salary ≥ 150,000 → Excellent
--Salary ≥ 100,000 → Very Good
--Salary ≥ 70,000 → Good
--Else → Needs Review
--Then:
--If label = Needs Review → raise warning error
--Else print label

DECLARE
    v_label VARCHAR2(45);
    v_sal NUMBER(9);
    v_eid NUMBER := &amp;
BEGIN
    SELECT SALARY INTO v_sal FROM EMPLOYEEES
    WHERE E_ID = v_eid;
    
    CASE 
        WHEN v_sal >= 150000 THEN
            v_label := 'Excellent';
        WHEN v_sal >= 100000 THEN
            v_label := 'Good';
        WHEN v_sal >= 70000 THEN
            v_label := 'Good';
        ELSE 
            v_label := 'Needs Review';
        
    END CASE;
    
    IF v_label = 'Needs Reivew' THEN
        RAISE_APPLICATION_ERROR(-20009, 'Warning!!!!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Label : ' || v_label);
        
    END IF;
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

SELECT * FROM EMPLOYEEES;

-----------------------------------------------------Senario#22-----------------------------------------------------------------------
--Given:
--department_id
--salary
--
--Rules:
--Dept 10: minimum salary 50k
--Dept 20: minimum salary 60k
--Dept 30: minimum salary 70k
--Invalid department → error
--Invalid salary → error
--Valid → print approval
--Must use CASE + IF combo.

DECLARE
    v_dept EMPLOYEES.DEPARTMENT_ID%TYPE := &amp;
    v_sal EMPLOYEES.SALARY%TYPE;    
BEGIN
    SELECT MIN(SALARY) INTO v_sal FROM EMPLOYEES
    WHERE department_id = v_dept;
    CASE v_dept
        WHEN 10 THEN
            IF v_sal < 50000 THEN
                RAISE_APPLICATION_ERROR(-20009, 'DEPT 10: Invalid Salary');
            END IF;
        WHEN 20 THEN
            IF v_sal < 60000 THEN
                RAISE_APPLICATION_ERROR(-20010, 'DEPT 20: Invalid Salary');
            END IF;
        WHEN 30 THEN
            IF v_sal < 70000 THEN
                RAISE_APPLICATION_ERROR(-20011, 'DEPT 30: Invalid Salary');
            END IF; 
        ELSE
            RAISE_APPLICATION_ERROR(-20003, 'Invalid Department');
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Results are valid');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/

-----------------------------------------------------Senario#23-----------------------------------------------------------------------
--What’s wrong with this logic?
--
--IF v_salary = NULL THEN
--  RAISE_APPLICATION_ERROR(-20001,'Salary missing');
--END IF;
--
--Fix it and explain why the original fails.

DECLARE
    v_salary NUMBER := NULL;
BEGIN
    IF v_salary = NULL THEN
    RAISE_APPLICATION_ERROR(-20001,'Salary missing');
    END IF;
END;
/

--Above scripts contains a logical error in how the if statement compares the variable with NULL value, 
--equla operator never returns true or false when compared with null, because there is nothing to compare to, thus the IF
--clause is never executed and no exception is raised.
--In order to solve it we should replace the equal operator with 'IS' operator, as carried below;
DECLARE
    v_salary NUMBER := NULL;
BEGIN
    IF v_salary IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001,'Salary missing');
    END IF;
END;
/

-----------------------------------------------------Senario#24-----------------------------------------------------------------------
--Why does this code stop early?
--
--FOR i IN 1..10 LOOP
--  IF i = 5 THEN
--    RAISE NO_DATA_FOUND;
--  END IF;
--  DBMS_OUTPUT.PUT_LINE(i);
--END LOOP;
--
--Rewrite it so only record 5 fails.

--WHEN FOR LOOP REACHES counter 5, the program raises an expection ending program execution. 
--In order to solve this we could write the if part of the code inside an inner block, and handling exception there.
BEGIN
FOR i IN 1..10 LOOP
    BEGIN
        IF i = 5 THEN
            RAISE no_data_found;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
            DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
            CONTINUE;
    END;
    dbms_output.put_line(i);
END LOOP;
END;
/

-----------------------------------------------------Senario#25-----------------------------------------------------------------------
--Write a block where:
--If validation fails, execution jumps to cleanup section
--Cleanup prints "Resources released"
--Normal execution prints "Completed successfully"
--Use GOTO correctly and safely.

DECLARE
    v_inp NUMBER := &amp; 
BEGIN
    IF v_inp > 1 THEN
        NULL;
    ELSE
        GOTO cleanup;
    END IF;    
    
    DBMS_OUTPUT.PUT_LINE('Completed successfully');
    GOTO ending;
    
    <<cleanup>>
    DBMS_OUTPUT.PUT_LINE('Resources released');
    
    <<ending>>
    NULL;
END;
/


-----------------------------------------------------Senario#26-----------------------------------------------------------------------
--Simulate payroll for 8 employees:
--Loop through employees
--If employee number:
--
--3 → missing salary
--6 → invalid bonus
--Handle errors individually
--Count successful payrolls
--Count failed payrolls
--Print final summary
--
--This must:
--Continue after failures
--Use SQLERRM
--Use at least one CONTINUE
--Use one user-defined exception
DECLARE
    v_count_err NUMBER(5) := 0;
    v_count_suc NUMBER(5) := 0;
    missing_salary EXCEPTION;
    PRAGMA EXCEPTION_INIT(missing_salary, -22002);
BEGIN
    FOR i IN 1..8
    LOOP
        BEGIN
            IF i = 3 THEN
                v_count_err := v_count_err + 1;
                RAISE missing_salary;
            ELSIF i = 6 THEN
                v_count_err := v_count_err + 1;
                RAISE_APPLICATION_ERROR(-20002, 'Invalid Boss');
            ELSE
                v_count_suc := v_count_suc + 1;
                CONTINUE;
            END IF;
        
            EXCEPTION
            WHEN missing_salary THEN
                DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED, DETAILS BELOW, CODE CONTNUES');
                DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
                
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED, DETAILS BELOW, CODE CONTNUES');
                DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
            END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Successful payrolls : ' || v_count_suc);
    DBMS_OUTPUT.PUT_LINE('Total Failed payrolls : ' || v_count_err);
END;
/

-----------------------------------------------------Senario#27-----------------------------------------------------------------------
--Write a PL/SQL block that:
--Accepts user input variables
--Validates all inputs
--Handles unexpected errors
--Never crashes silently
--Always logs final status
--This is how production PL/SQL is judged.

DECLARE
    v_str VARCHAR2(45) := '&String';
    v_num NUMBER(8) := &number;
    v_str_short EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_str_short, -20023);
BEGIN
    IF LENGTH(v_str) < 3 THEN
        RAISE v_str_short;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_num);
    
    IF v_num < 0 THEN
        RAISE_APPLICATION_ERROR(-20034, 'Number must be positive');
    END IF;
    
EXCEPTION
    WHEN v_str_short THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : Entered string too short');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HANDLED');
        DBMS_OUTPUT.PUT_LINE('ERROR CODE : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE : ' || SQLERRM);
END;
/
