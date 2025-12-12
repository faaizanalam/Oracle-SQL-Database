------------------------------------------------------PL/SQL---------------------------------------------------------
DECLARE 
    V_VARIABLE_DIRECT NUMBER(12);   ------DIRECT DECLARATION : Need to update every instance incase of a future update.
    V_VARIABLE_INDIRECT EMPLOYEESS.AGE%TYPE; ----INDIRECT DECLARTION : All Instances update automatically when the referance column is updated.
    V_VARIABLE_INDIRECT EMPLOYEESS.AGE%TYPE := 'Some Integer';  -----Trying to assign a static value to dynamic variable
    
    V_VAR_DEFAULT VARCHAR(45) DEFAULT 'HELLO';  ----- Assigning a default value
    V_VAR_DEFAULT_2 NUMBER := 65;  ------Initializing a value now, that could be updated later(acts like a default value).
    
    V_VAR_CONST CONSTANT DATE := TO_DATE('22-mon-2022', 'DD-MON-YYYY');  -----A constant value cannot be updated after intialization
    V_VAR_CONST CONSTANT DATE ;  -------Checking if could declare a constant variable without intial value.
    V_VAR_NULL VARCHAR2(45) NOT NULL := 'SOMETHING' -----------THIS VARIABLE COULD NOT CONTAIN A NULL VALUE.
    V_VAR_NULL2 VARCHAR(32) NOT NULL := NULL; ------Trying to store a NULL Value in NOT NULL VARIABLE.
    
    
    