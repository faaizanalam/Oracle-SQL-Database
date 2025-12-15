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










