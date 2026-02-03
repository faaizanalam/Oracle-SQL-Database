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


-------------------------------------------********************----------------------------------
--Create a function to calculate and return the tax need to be paid by an employee.
--Tax Calculation
--Salary > 1000 ---> 10%
--Salary > 5000 ---> (First conditional operation ) + 20% on remainnig amount.
--Salary > 10000 --> (First conditional operation ) + (Second conditional operation) + 30% on remainnig amount.
CREATE OR REPLACE FUNCTION FUNC_TAX(p_in_emp EMPLOYEEES.SALARY%TYPE) RETURN NUMBER
IS
    emp_count NUMBER(3);
    emp_sal NUMBER(8);
    tax_amt NUMBER(8);
    i_count NUMBER(2);
BEGIN
    SELECT COUNT(*) INTO emp_count FROM EMPLOYEEES
    WHERE E_ID = p_in_emp;
    
    IF emp_count = 0 THEN
        RETURN -1;
    ELSIF emp_count > 1 THEN
        RETURN -2;
    END IF;
    
    SELECT SALARY INTO emp_sal FROM EMPLOYEEES
    WHERE E_ID = p_in_emp;
    
    IF emp_sal > 10000 THEN
        emp_sal := emp_sal - (emp_sal * 10/100);
        tax_amt := emp_sal * 10/100;
        i_count := 1;
        
        IF emp_sal > 50000 THEN
            emp_sal := emp_sal - (emp_sal * 20/100);
            tax_amt := tax_amt + (emp_sal * 20/100);
            i_count := i_count + 1;
            
            IF emp_sal > 70000 THEN
                emp_sal := emp_sal - (emp_sal * 20/100);
                tax_amt := tax_amt + (emp_sal * 30/100);
                i_count := i_count + 1;
            END IF;
        END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('i_count : ' || i_count);
    DBMS_OUTPUT.PUT_LINE('SALARY AFTER TAX DEDUCTION : ' || emp_sal ); 
    RETURN tax_amt;
    
END FUNC_TAX;
/

DECLARE
v_func NUMBER(5);
BEGIN
    
    v_func := FUNC_TAX(60);
    DBMS_OUTPUT.PUT_LINE('Total Tax : ' || v_func);
END;
/
SELECT * FROM EMPLOYEEES;

---------------------------------------*********************-------------------------------------------
--Create a table to store the number of notes available in the ATM and input records into it for 50, 100, 500, 1000, 5000 notes 
--and their quantity.
--Create a function to return the number of notes ATM should withdraw with passed amount
--and also IF withdrawal is not possible then send appropriate error message.

CREATE TABLE ATM_WITHDRAWAL
(Five_HUNDRED NUMBER(7),
One_THOUSAND NUMBER(7),
Five_THOUSAND NUMBER(7)
);

CREATE OR REPLACE FUNCTION FUNC_ATM(p_in_amt NUMBER) RETURN VARCHAR2
IS
v_F_hund NUMBER(4);
v_thousnd NUMBER(3);
v_F_thousand NUMBER(3);

count_f_hund NUMBER := 0;
count_thousand NUMBER := 0;
count_f_thousand NUMBER := 0;

v_qou NUMBER;
v_rem NUMBER;
v_inp NUMBER;
v_total NUMBER;
BEGIN
    SELECT Five_HUNDRED * 500 + One_THOUSAND * 1000 + Five_THOUSAND * 5000 
    INTO v_total FROM ATM_WITHDRAWAL;
    IF MOD(p_in_amt, 500) <> 0 THEN
        DBMS_OUTPUT.PUT_LINE('Amount should be a multiple of 500.');
        RETURN 'Amount should be a multiple of 500.';

    ELSIF p_in_amt > v_total THEN
        DBMS_OUTPUT.PUT_LINE('Amount exceeds ATM Withdrawal limit');
        RETURN 'Amount exceeds ATM Withdrawal limit';
    ELSE
        SELECT Five_HUNDRED, One_THOUSAND, Five_THOUSAND INTO v_F_hund, v_thousnd, v_F_thousand
        FROM ATM_WITHDRAWAL;
        --v_qou := v_p_in_amt / 500; 
        --v_rem := MOD(p_in_amt, 5000);
        v_inp := p_in_amt;  
        
        LOOP
            IF v_inp >= 5000  THEN    ------In progress
                v_inp := v_inp - 5000;
                count_f_thousand := count_f_thousand + 1;
            ELSIF v_inp >= 1000 THEN
                v_inp := v_inp - 1000;
                count_thousand := count_thousand + 1;
            ELSIF v_inp = 500 THEN
                v_inp := v_inp - 500;
                count_f_hund := count_f_hund + 1;
            END IF;
            
            EXIT WHEN v_inp = 0;
            
        END LOOP;
    END IF;
    RETURN 'Notes withdrawn for amount : ' || p_in_amt || 'are ;
            5000 : ' || count_f_thousand || CHR(10) || '1000 : ' || count_thousand 
            || CHR(10) || '500 : ' || count_f_hund;
END;
/



SELECT 45 + 90 + 90 FROM DUAL;


SELECT TRUNC(14000/5000) FROM DUAL;
SELECT MOD(15000, 5000) FROM DUAL;
