---------------------------------------------------SQL Itterations-----------------------------------------------------
set serveroutput on;
--Multiplication table of 3 using Basic loop....
--Using basic loop print the current second of time, 48 times..

Declare
    v_num NUMBER(5) := 0;
    
Begin
--    Loop
--        IF (v_num <= 10) THEN
--            dbms_output.put_line('3 x ' || v_num || ' = ' || 3 * v_num);
--            v_num := v_num + 1;
--        ELSE 
--            exit;
--        End If;
--    End Loop;
--    
    
    -----------------------------------Alternative Solution-----------------------------------
    LOOP
        dbms_output.put_line('3 x ' || v_num || ' = ' || 3 * v_num);
        v_num := v_num + 1;
        
        EXIT WHEN v_num > 10;
    END LOOP;
End;
/


--Using basic loop print the current second of time, 48 times..
Declare
    v_count NUMBER(3) := 0;
    
Begin
--    LOOP
--        IF (v_count <= 48) THEN
--            dbms_output.put_line('Second value at Itteration number : ' || v_count || ' is : ' || 
--            EXTRACT(SECOND FROM SYSTIMESTAMP));
--            v_count := v_count + 1;
--        ELSE
--            EXIT;
--        END IF;
--    END LOOP;
--    
    
    ---------------------------ALTERNATE----------------------------
    
    LOOP
        dbms_output.put_line('Second value at Itteration number : ' || v_count || ' is : ' || 
        EXTRACT(SECOND FROM SYSTIMESTAMP));
        v_count := v_count + 1;
        
        EXIT WHEN v_count > 48;
    END LOOP;
    
End;
/


------------------------------------------FOR LOOP---------------------------------------------------
--Create a multiplication table of 3 using FOR LOOP.
DECLARE

BEGIN
    FOR i IN 0..10
    LOOP
        dbms_output.put_line('3 x ' || i || ' = ' || 3 * i);
    END LOOP;
END;
/

--Print all indivisible numbers between 1-100 using FOR LOOP.(Number that is not divisible by any other number except itself.)

DECLARE
    v_div NUMBER(3) := 0;
BEGIN
    FOR i IN 1..100
    LOOP
        v_div := 0;
        IF i >= 3 THEN 
            FOR j IN 2..i - 1
            LOOP
                IF MOD(i,j) = 0 THEN
                    v_div := 1;
                END IF; 
            END LOOP;
        END IF;
        IF v_div = 0 THEN 
            dbms_output.put_line(i);
        END IF;
    END LOOP;
END;
/



--            IF v_num <= 100 THEN
--                IF (i < v_num) AND MOD(v_num,i) = 0 THEN
--                    dbms_output.put_line(i);
--                END IF;
--                v_num := v_num + 1;
--            ELSE
--                EXIT;
--            END IF;
            
--        END LOOP;


--USING FOR LOOP, Print all the leap years starting from 2001 to 1 in reverse order.

BEGIN
    FOR i IN REVERSE 1..2001
    LOOP
        IF MOD(i,4) = 0 THEN
        dbms_output.put_line(i);
        END IF;
    END LOOP;
END;
/

--------------------------------------------While Loop------------------------------------------------------
--Using WHILE loop, Print multiplication table of 3.
DECLARE
    i NUMBER(3) := 0;
BEGIN
    WHILE(i < 10)
    LOOP
        i := i + 1;
        dbms_output.put_line(3 || ' x ' || i || ' = ' || 3 * i);
    END LOOP;
END;
/


--Using WHILE Loop, Create the series of x^2 + 5 till 300. x starts from 1.
DECLARE
    v_num NUMBER(4) := 1;
BEGIN
    WHILE(v_num <= 300)
    LOOP
        dbms_output.put_line((v_num ** 2) + 5);
        v_num := v_num + 1;
    END LOOP;
END;
/

--Using WHILE Loop, Insert 10 records into one temporary table, add any numbers but all different.
CREATE TABLE temp_tab(
col_1 NUMBER(2)
);

CREATE SEQUENCE seq_temp_tab
START WITH 1
INCREMENT BY 1
MAXVALUE 45
CYCLE;

DECLARE
    v_num NUMBER := 0;
BEGIN
--    WHILE((SELECT COUNT(col_1) FROM temp_tab) < 10)
    WHILE(v_num < 10)
    LOOP
        INSERT INTO temp_tab(col_1)
        VALUES(seq_temp_tab.NEXTVAL);
        v_num := v_num +1;
    END LOOP;


END;
/
SELECT * FROM temp_tab;    --Data Inserted.......


--------------------------------------------------CONTINUE STATEMENT---------------------------------------------------
--Insert all characters between A-O (case-insensitive) into table (create one table of one varchar2 column) --> String : LEARNVERN
CREATE TABLE TAB_DEMOO(
col_1 VARCHAR2(45)
);

DECLARE
    v_str VARCHAR2(40) := 'LEARNVERN';
    v_insrt VARCHAR2(45);
    str_len NUMBER := length(v_str);
BEGIN
    FOR i IN 1..str_len
    LOOP
        v_insrt := SUBSTR(v_str, i, 1);
        IF UPPER(v_insrt) BETWEEN 'A' AND 'O' THEN
            CONTINUE;
        ELSE
            INSERT INTO TAB_DEMOO(col_1)
            VALUES(v_insrt);
        END IF;
    END LOOP;
END;
/

SELECT * FROM TAB_DEMOO;

--Seperate each digit of the number and print only if it is odd number: 987896732834. Print all occurance of the digit.
DECLARE
    v_num NUMBER := 987896732834;
    num_len NUMBER(2);
    num_val NUMBER(2);
BEGIN
    num_len := LENGTH(v_num);
    FOR i IN 1..num_len
    LOOP
        num_val := SUBSTR(v_num, i, 1);
        IF MOD(num_val, 2) = 1 THEN
            dbms_output.put_line(num_val);
        END IF;
    END LOOP;
END;
/
commit;


--------------------------------------------------Assignment Itterations----------------------------------------------
----------------------------------------------------**************-----------------------------------------------
--Create a PL/SQL Block to use WHILE Loop to Execute for next 2 seconds, add 1 to it in each iteration.
--Variable should be initialized with 0 and print the value of variable at the end.
DECLARE 
    v_var NUMBER := 0;
    v_time TIMESTAMP; 
BEGIN
    v_time := SYSTIMESTAMP + 2/86400;
    dbms_output.put_line(v_time);
    dbms_output.put_line(SYSTIMESTAMP);
    
    WHILE (SYSTIMESTAMP <= v_time)
    LOOP
    v_var := v_var + 1;
    dbms_output.put_line('Value stored in VARIABLE : ' || v_var);
    END LOOP;
    
END;
/


--Create a PL/SQL block, declare a number variable and intialize it with 1.
--Have a loop multiply odd number with the variable.
--if the value of the variable is more than 1000, exit the loop and print the value of the variable.

DECLARE
    v_num NUMBER(5) := 1;

BEGIN
    FOR i IN 0..10000
    LOOP 
        IF(MOD(i, 2) = 1) THEN
            dbms_output.put_line(v_num * i); 
        ELSE 
            continue;
        END IF;
    EXIT WHEN v_num >= 1000;
    END LOOP;
    
    ------------------------------------------------ALTERNATLY------------------------------------------------
    FOR i IN 0..1000
    LOOP 
        IF(MOD(i, 2) = 1) THEN
            v_num := v_num * i;
            dbms_output.put_line(v_num); 
        ELSE 
            continue;
        END IF;
        
        EXIT WHEN v_num >= 1000;
    END LOOP;
    
    
END;
/














