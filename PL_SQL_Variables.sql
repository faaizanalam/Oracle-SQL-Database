------------------------------------------------------PL/SQL---------------------------------------------------------
SET serveroutput on;
DECLARE 
    V_VARIABLE_DIRECT NUMBER(12);   ------DIRECT DECLARATION : Need to update every instance incase of a future update.
    V_VARIABLE_INDIRECT EMPLOYEESS.AGE%TYPE; ----INDIRECT DECLARTION : All Instances update automatically when the referance column is updated.
    
    V_VAR_DEFAULT VARCHAR(45) DEFAULT 'HELLO';  ----- Assigning a default value
    V_VAR_DEFAULT_2 NUMBER := 900;  ------Initializing a value now, that could be updated later(acts like a default value).
    
    V_VAR_CONST CONSTANT DATE := TO_DATE('22-JAN-2022', 'DD-MON-YYYY');  -----A constant value cannot be updated after intialization
    
    V_VAR_NULL VARCHAR2(45) NOT NULL := 'SOMETHING'; -----------THIS VARIABLE COULD NOT CONTAIN A NULL VALUE.
    
    V_VAR_BOOL BOOLEAN;   ----Declaring a Boolean type Variable.
    
    V_VAR_PLS PLS_INTEGER;  -----DECLARING a PLS_TYPE VARIABLE
    
    --ERROR: numeric or value error: character to number conversion error
     --V_VARIABLE_DIRECT_2 NUMBER(12) := 'SQL'; ---Assigning a string to anumber datatype.
    
    --ERROR: At most one declaration for 'V_VARIABLE_DIRECT' is permitted
    --V_VARIABLE_DIRECT NUMBER(12) := 6';   -----DUPLICATE DECLATION OF VARIABLE
    
    --ERROR: ERROR CONVERTING ONE DATATYPE TO ANOTHER.
    --V_VARIABLE_INDIRECT EMPLOYEESS.AGE%TYPE := 'Some Integer';  -----Trying to assign a static value to dynamic variable
    
    --ERROR : declaration of a constant 'V_VAR_CONST' must contain an initialization assignment
    --V_VAR_CONST CONSTANT DATE ;  -------Checking if could declare a constant variable without intial value.
    
    --ERROR : -----Trying to store a NULL Value in NOT NULL VARIABLE.
    --V_VAR_NULL2 VARCHAR(32) NOT NULL := NULL; ------Trying to store a NULL Value in NOT NULL VARIABLE.
    
BEGIN 
    V_VARIABLE_DIRECT := 65; 
    --dbms_output.put_line(V_VARIABLE); -----CANNOT PRINT UNDECLARED VARIABLE
    
    dbms_output.put_line(V_VARIABLE_DIRECT);
    dbms_output.put_line('');     ---Printing a new line.....
    dbms_output.put_line('THE Default value of the variable is : ' || V_VAR_DEFAULT_2);
    
    dbms_output.put_line(V_VAR_DEFAULT);
    dbms_output.put_line(V_VAR_CONST);
    --V_VAR_CONST := TO_DATE('22-12-2022', 'DD-MM-YYYY'); ----CANNOT BE USED AS AN ASSIGNMENT TARGET.

    dbms_output.put_line(V_VAR_NULL);
   -- V_VAR_NULL := NULL; PLS-00382: expression is of wrong type... PASSING NULL TO NOT NULL VARIABLE.
    V_VAR_BOOL := TRUE;
    --dbms_output.put_line(V_VAR_BOOL);  -----CANNOT OUTPUT a BOOLEAN VALUE using  dbms_output.put_line...
    
    V_VAR_PLS := 90;
    dbms_output.put_line('V_VAR_PLS : ' || V_VAR_PLS);
   
END;
/


DECLARE
    V_NUM NUMBER;
    V_NUM_MONTHS NUMBER DEFAULT 3;
    V_BIRTHDAY DATE NOT NULL DEFAULT TO_DATE('2001-04-09','YYYY-MM-DD');
    V_PI_VALUE CONSTANT NUMBER(3,2) := 3.14;
    V_VAR_SID CONSTANT DEPARTMENT.store_id%TYPE := 1;
    V_VAR_NAME DEPARTMENT.name%TYPE;
    V_VAR_City DEPARTMENT.city%TYPE NOT NULL := 'BANGLORE';
    
BEGIN
    --V_BIRTHDAY := NULL;   //PLS-00382: expression is of wrong type
    dbms_output.put_line('V_NUM VALUE : ' || V_NUM);
    NULL;
END;
/



---------------------------------------------------Variable Assignment------------------------------------------------
DECLARE 
    V_var_emp NUMBER;
    V_var_const CONSTANT NUMBER(2) := 12;
    V_var_first EMPLOYEESS.E_first%TYPE;
    V_var_last VARCHAR2(35);
    V_var_age INTEGER;
    V_var_gen EMPLOYEESS.GENDER%TYPE;
    V_var_dyn   DATE;
    V_var_sec   VARCHAR2(40);
    
    
BEGIN
    V_var_emp := 34;
    
    SELECT E_first INTO V_var_first FROM EMPLOYEESS
    WHERE SALARY = 73000; 
    dbms_output.put_line('Values stored in V_var_first is : ' || V_var_first);
    
--    SELECT E_First INTO V_var_first FROM EMPLOYEESS  ----no data to return from this query
--    WHERE SALARY = 900000;   
--    ---You cannot assign a NULL value to a variable via a SELECT INTO statement in PL/SQL
--    when no rows are returned by the query because the PL/SQL engine raises a NO_DATA_FOUND exception in that scenario. 
--    The exception occurs because a SELECT INTO statement is designed to fetch a single row, 
--    and a zero-row result set violates this fundamental expectation. 

    V_var_first := NULL;   -----Assigning NULL is possible...
    dbms_output.put_line('Values stored in V_var_first is : ' || V_var_first);
    
    SELECT EMP_ID, E_FIRST, E_LAST, AGE, GENDER INTO V_var_emp, V_var_first, V_var_last, V_var_age, V_var_gen FROM EMPLOYEESS
    WHERE SALARY = 73000;  -->>> Assigning multiple values to multiple variables using a single select statement.
    
    dbms_output.put_line(' ');   -- Adds a newline.......
    dbms_output.put_line(' ');
    dbms_output.put_line('V alue stored in V_var_emp is : ' || V_var_emp);
    dbms_output.put_line('Value stored in V_var_first is : ' || V_var_first);
    dbms_output.put_line('Value stored in V_var_last is : ' || V_var_last);
    dbms_output.put_line('Value stored in V_var_age is : ' || V_var_age);
    dbms_output.put_line('Value stored in V_var_gen is : ' || V_var_gen);

--    SELECT * FROM EMPLOYEESS 
--    WHERE SALARY = 73000;   --=>>>>>>>>>>> GENERAL SQL SELECT STATEMENTS CANNOT BE USED INSIDE A PL/SQL BlOCK
--                                              SELECT STATEMENTS SHOULD BE USED TO ASSIGN VALUES TO VARIABLES
END;
/

SELECT * FROM EMPLOYEESS 
WHERE SALARY =  900000;


----------------------------------------------PRACTICLE TASKS---------------------------------------------
--Use variables from "Variable Declartion" assignment.
--Assign any updated value to all the variables except constant variables.
--Add 2 months to the excisting v_birthday and assign it back to v_birthday.
--Assign the name of the department and city having max_dept_id in the department table.
--Assign the month and date of the exisiting value of v_birthday to v_num_days and v_num_months.


DECLARE
    v_num_days NUMBER;
    v_num_months NUMBER DEFAULT 3;
    v_birthday DATE NOT NULL DEFAULT DATE '2002-12-22';
    v_pi_value CONSTANT NUMBER(3,2) DEFAULT 3.14;
    V_dept_id CONSTANT DEPARTMENTSS.dept_id%TYPE DEFAULT 9;
    V_dept_name DEPARTMENTSS.dept_name%TYPE;
    V_dept_city DEPARTMENTSS.location%TYPE NOT NULL := 'Banglore';
    V_const CONSTANT VARCHAR2(35) := 'HELLO';   ----CONSTANT VARIABLES MUST BE INTIALIZED AT DECLARATION INSTANCE.
    
BEGIN
        ----------Assign any updated value to all the variables except constant variables.
    v_num_days := 100;
    SELECT ROUND((SYSDATE - joining_date)/30)  INTO v_num_months FROM EMPLOYEESS
    WHERE SALARY = 57000;
    dbms_output.put_line('The value stored in v_num_months is : ' || v_num_months);
    
    --SELECT dept_id INTO V_dept_id FROM EMPLOYEESS WHERE SALARY = 57000;   --CONSTANT, value can't be changed
    dbms_output.put_line('The value stored in V_dept_id is : ' || V_dept_id);
    
    SELECT dept_name INTO V_dept_name FROM DEPARTMENTSS WHERE dept_id = 7;
    dbms_output.put_line('The value stored in V_dept_name is : ' || V_dept_name);
    
    SELECT LOCATION INTO V_DEpt_City FROM DEPARTMENTSS   ---Variable names in PL/SQL are CASE INSENSITIVE
    WHERE dept_id = 7;
    dbms_output.put_line('The value stored in V_dept_City is : ' || V_dept_City);
    
    --Add 2 months to the excisting v_birthday and assign it back to v_birthday.
    v_birthday := ADD_MONTHS(v_birthday, 2);
    dbms_output.put_line('The value stored in v_birthday is : ' || v_birthday);
    
    --Assign the name of the department and city having max_dept_id in the department table.
    SELECT dept_name, location INTO V_dept_name, V_dept_City FROM DEPARTMENTSS 
    WHERE dept_id = (SELECT max(dept_id) FROM DEPARTMENTSS);
    dbms_output.put_line('The value stored in V_dept_name is : ' || V_dept_name || ' AND '
    || 'V_dept_City stores : ' || V_dept_City);

    --Assign the month and date of the exisiting value of v_birthday to v_num_days and v_num_months.
    v_num_days := EXTRACT(DAY FROM v_birthday);
    v_num_months := EXTRACT(MONTH FROM v_birthday);
    
    dbms_output.put_line('Updated value of v_num_days is : ' || v_num_days);
    dbms_output.put_line('Updated value of v_num_months is : ' || v_num_months);
    
END;
/

SELECT * FROM EMPLOYEESS;

SELECT * FROM DEPARTMENTSS;



---------------------------------------------------WORKING WITH VARIABLES-------------------------------------------
DECLARE
    v_var_spl NUMBER;
    v_var_bckup NUMBER;
    v_var_max NUMBER;
    v_var_count NUMBER;
    v_var_empid NUMBER;
    v_var_emp_name NUMBER;
    
BEGIN
    SELECT max(SALARY) INTO v_var_spl FROM EMPLOYEESS;
    dbms_output.put_line('Value stored in variable v_var_spl is : ' || v_var_spl);
    
    SELECT EMP_id INTO v_var_bckup FROM EMPLOYEESS WHERE SALARY = v_var_spl;
    dbms_output.put_line('Value stored in variable v_var_bckup is : ' || v_var_bckup);
    
    SELECT MAX(SALARY) INTO v_var_max FROM EMPLOYEESS WHERE EMP_ID < v_var_bckup;
    dbms_output.put_line('Value stored in variable v_var_max is : ' || v_var_max);
    
    SELECT COUNT(*) INTO v_var_count FROM EMPLOYEESS WHERE SALARY < v_var_spl;
    dbms_output.put_line('Value stored in variable v_var_count is : ' || v_var_count);
    
--    SELECT emp_id, e_first ||  ' ' || e_last INTO v_var_empid, v_var_emp_name
--    FROM EMPLOYEESS WHERE     
END;
/








