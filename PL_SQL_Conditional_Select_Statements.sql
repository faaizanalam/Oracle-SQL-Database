----------------------------------------Conditional Select Statements--------------------------------------------------
set serveroutput on;
DECLARE
    v_var_conditonal NUMBER := 22;
    
BEGIN
    IF MOD(v_var_conditonal, 2) = 0 
        THEN dbms_output.put_line('Variable contains an an even number');
    
    ELSIF MOD(v_var_conditonal, 2) = 1
        THEN dbms_output.put_line('Variable contains an an odd number');
        
    ELSE 
        dbms_output.put_line('The Variable seems to contain a non-compatible value');
        
    END IF;
    dbms_output.put_line(''); 
    dbms_output.put_line('After END IF');        
    
END;
/

-------------------------------------*************************-----------------------------------------------

DECLARE 
    var_cond_1 NUMBER := 88;
    var_cond_2 NUMBER := 89;
BEGIN
     dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
     dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
    IF MOD(var_cond_1, 2) = 0  AND MOD(var_cond_2, 2) = 0 THEN
        dbms_output.put_line('var_cond_1 is EVEN and var_cond_2 is EVEN');
    
    ELSIF MOD(var_cond_1, 2) = 0  AND MOD(var_cond_2, 2) = 1 THEN
        dbms_output.put_line('var_cond_1 is EVEN and var_cond_2 is ODD');
    
    ELSIF MOD(var_cond_1, 2) = 1  AND MOD(var_cond_2, 2) = 0 THEN
        dbms_output.put_line('var_cond_1 is ODD and var_cond_2 is EVEN');
    
    ELSIF MOD(var_cond_1, 2) = 1  AND MOD(var_cond_2, 2) = 1 THEN
        dbms_output.put_line('var_cond_1 is ODD and var_cond_2 is ODD');
    
    ELSE
        dbms_output.put_line('Either one or both of the variables contain an uncompatible value');
    
    END IF;
    dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
    dbms_output.put_line('----------------------------------------------*******************------------------------------------------------');
END;
/