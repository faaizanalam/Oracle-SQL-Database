-----------------------------------Index, Veiws, Sequence, Synonyms---------------------------------------------------
------------------------------------------------INDEX-----------------------------------------------------------------
------------------------------------------------Senario#1-------------------------------------------------------------
--Create an index on the salary column of EMPLOYEES to speed up salary-based searches.
CREATE INDEX idx_emp_sal ON EMPLOYEEES (Salary); 

------------------------------------------------Senario#2-------------------------------------------------------------
--Create a unique index on EMAIL to guarantee no duplicates.
CREATE UNIQUE INDEX unk_idx_emp_email ON EMPLOYEEES (Email);

------------------------------------------------Senario#3-------------------------------------------------------------
--Create a composite index for queries that filter by (dept_id, mgr_id).
CREATE INDEX cmp_idx_emp_diji ON EMPLOYEEES(dept_id, mgr_id);

------------------------------------------------Senario#4-------------------------------------------------------------
--Create a function-based index on UPPER(last_name).
CREATE INDEX idx_func_emp_lstnam ON EMPLOYEEES(UPPER(e_last));

------------------------------------------------Senario#5-------------------------------------------------------------
--Create an index that helps this query:
--SELECT * FROM employees WHERE hire_date BETWEEN '01-JAN-2010' AND '31-DEC-2015';
CREATE INDEX idx_emp_hrdate ON EMPLOYEEES(JOINING_DATE);
--Since the query solely depends on joining_date an index on column joining_date will improve the results.

------------------------------------------------Senario#6-------------------------------------------------------------
--Create a bitmap index for the GENDER column.
CREATE BITMAP INDEX idx_btmp_emp_gnd ON EMPLOYEEES(gender);

------------------------------------------------Senario#7-------------------------------------------------------------
--Drop an existing index safely (only if not used by constraints).
DROP INDEX idx_emp_hrdate;

------------------------------------------------Senario#8-------------------------------------------------------------
--Disable an index temporarily for a bulk insert operation.
ALTER INDEX idx_func_emp_lstnam UNUSABLE;
ALTER INDEX idx_func_emp_lstnam REBUILD;

------------------------------------------------Senario#9-------------------------------------------------------------
--Create an index to speed up ORDER BY salary DESC.
CREATE INDEX idx_func_emp_sal ON EMPLOYEEES(Salary DESC);

------------------------------------------------Senario#10-------------------------------------------------------------
--Analyze whether indexing AGE is good or bad — justify and act accordingly.
--It could be good are bad according to usecase, an index on AGE will imploving queries filtering through AGE but
--it could slow down dml operations on it.

------------------------------------------------Senario#11-------------------------------------------------------------
--Create a simple view that shows employee name and salary.
CREATE VIEW view_emp AS 
SELECT E_first || ' ' ||  E_last AS E_name, Salary
FROM EMPLOYEEES;

SELECT * FROM view_emp;
DROP VIEW view_emp;

------------------------------------------------Senario#12-------------------------------------------------------------
--Create a view that includes computed column: yearly_salary.
CREATE VIEW view_emp_c_sal AS
SELECT E_First || ' ' || E_last AS E_name, TO_CHAR(Salary * 12, '99,999,999') AS Yearly_Salary
FROM EMPLOYEEES;

SELECT * FROM view_emp_c_sal;
DROP VIEW view_emp_c_sal;

------------------------------------------------Senario#13-------------------------------------------------------------
--Create a view that only shows employees from department 50.
CREATE VIEW veiw_emp_deptid AS 
SELECT * FROM EMPLOYEEES
WHERE Dept_id = 50;

SELECT * FROM veiw_emp_deptid;

------------------------------------------------Senario#14-------------------------------------------------------------
--Create a view that restricts results using WITH CHECK OPTION.
CREATE VIEW veiw_emp_1 AS 
SELECT * FROM EMPLOYEEES
WHERE SALARY > 5000
WITH CHECK OPTION;

----CHECK OPTION keyword controls data input in the table, if the new value does not satisfy the defination of 
--the view, it wont be inserted.

------------------------------------------------Senario#15-------------------------------------------------------------
--Create a read-only view for managers’ data.
CREATE VIEW view_mgr AS 
SELECT * FROM MANAGEERS 
WITH READ ONlY;

SELECT * FROM view_mgr;


------------------------------------------------Senario#16-------------------------------------------------------------
CREATE OR REPLACE VIEW view_demo AS
SELECT MGR_first, dept_id FROM MANAGEERS;
SELECT * FROM view_demo;

CREATE OR REPLACE VIEW view_demo AS 
SELECT mgr_first, dept_id, gender ,age FROM MANAGEERS;--------------ALtering table structure
SELECT * FROM view_demo;

UPDATE view_demo
SET age = 56                  ---------------------Trying to manipluate table data using view.
WHERE mgr_first = 'Baber';

SELECT * FROM MANAGEERS         ---------Updated table data using view..
WHERE mgr_first = 'Baber';

CREATE OR REPLACE VIEW view_demo AS 
SELECT * FROM EMPLOYEEES
WHERE AGE < 59
WITH CHECK OPTION;

SELECT * FROM view_demo;

UPDATE view_demo
SET AGE = 60                   ------Updating view with check options using incompatible value failed. 
WHERE e_first = 'Faizan';

CREATE OR REPLACE VIEW view_demo_rdonly AS
SELECT * FROM EMPLOYEEES
WITH READ ONLY;
SELECT * FROM view_demo_rdonly;

UPDATE view_demo_rdonly
SET AGE = 60 ------------------------CANNOT PERFORM A DML OPERATION ON A READ_ONLY VIEW
WHERE E_first = 'Faizan';

CREATE OR REPLACE VIEW view_demo AS 
SELECT E_first, dept_id FROM EMPLOYEEES;

INSERT INTO view_demo(E_first, dept_id)
VALUES('Fasih', '55');             ------Cannot insert into view due to integrity constraints on base table

DELETE FROM view_demo
WHERE E_first = 'Omer'; ------------deleting a row from VIEW also deletes the original row from base table.

SELECT * FROM EMPLOYEEES
WHERE E_first = 'Omer'; --------------row deleted from base table

CREATE OR REPLACE VIEW view_demo AS
SELECT M.MGR_ID, E.E_first FROM MANAGEERS M, EMPLOYEEES E; -------View using  Cartesian Product
SELECT * FROM view_demo;

------------------------------------------------Senario#17-------------------------------------------------------------
--Create a view combining employees + projects (use basic SELECT).
CREATE OR REPLACE VIEW view_emp_pjt AS
SELECT P.PROJ_ID, P.PROJ_NAME, P.DEPT_ID, E.E_first, E.E_last, E.Mgr_id 
FROM EMPLOYEEES E, PROJECTS P
WHERE P.dept_id = E.dept_id;

SELECT * FROM view_emp_pjt;

SELECT * FROM EMPLOYEEES;
SELECT * FROM PROJECTS;
------------------------------------------------Senario#18-------------------------------------------------------------
--Replace an existing view using OR REPLACE.
CREATE OR REPLACE VIEW view_demo AS
SELECT E_first || '' || E_last AS E_name FROM ------cannot create view without specifing an alias...
EMPLOYEEES;

------------------------------------------------Senario#19-------------------------------------------------------------
--Drop a view safely and test what happens if you query it afterward.
DROP VIEW view_demo;   ------VIEW DROPPED
SELECT * FROM View_demo; ------TABLE OR VIEW DOES NOT EXIST.

------------------------------------------------Senario#20-------------------------------------------------------------
--Materialized views
CREATE MATERIALIZED VIEW view_mat_empl 
REFRESH FORCE 
ON COMMIT 
AS
SELECT * FROM EMPLOYEEES
WHERE SALARY > 80000;

------------------------------------------------Sequences-------------------------------------------------------------
--CREATE SEQUENCE sequence_name
--START WITH initial_value
--INCREMENT BY increment_value
--MINVALUE minimum value
--MAXVALUE maximum value
--CYCLE|NOCYCLE ;

CREATE SEQUENCE seq_demo
START WITH -4
INCREMENT BY -1
MINVALUE -10
MAXVALUE -4
NOCYCLE
CACHE 6;

DROP SEQUENCE seq_demo;

CREATE TABLE sequencee
( 
ID number(10),
NAME char(20)
);

SELECT * FROM sequencee;
INSERT into sequencee VALUES
(seq_demo.nextval,'Shubham');

INSERT into sequencee VALUES
(seq_demo.nextval,'Aman');


------------------------------------------------Senario#21-------------------------------------------------------------
--Create a basic sequence starting from 1 increment by 1.
CREATE SEQUENCE seq_bas_emp
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 3
NOCYCLE;

------------------------------------------------Senario#22-------------------------------------------------------------
--Create a sequence starting at 500, increment by 5, maxvalue 800.
CREATE SEQUENCE seq_2
START WITH 500
INCREMENT BY 5
MAXVALUE 800;

DROP SEQUENCE seq_2;

------------------------------------------------Senario#23-------------------------------------------------------------
--Create a reverse sequence decreasing from 3000 to 2000.
CREATE SEQUENCE seq_rev
START WITH 3000
INCREMENT BY -1
MAXVALUE 3000;

------------------------------------------------Senario#24-------------------------------------------------------------
CREATE TABLE FOR_SEQ(
IDs NUMBER
);

INSERT INTO FOR_SEQ
VALUES(seq_rev.nextval);

SELECT * FROM FOR_SEQ;

------------------------------------------------Senario#25-------------------------------------------------------------
--Use CURRVAL in a SELECT and explain how it behaves.
CREATE TABLE FOR_SEQQ(
Id1 NUMBER,
Id2 NUMBER
);

SELECT * FROM FOR_SEQQ;

INSERT INTO FOR_SEQQ
VALUES(seq_rev.NEXTVAL, seq_rev.CURRVAL);
-----------------------------------------------CURRVAL AND NEXTVAL will return same values when used in same query,
--------------------------------------------------regardless of the order of the clauses, in the statement.
INSERT INTO FOR_SEQQ
VALUES(seq_rev.CURRVAL, seq_rev.NEXTVAL);

INSERT INTO FOR_SEQQ
VALUES(seq_rev.NEXTVAL, 2);

INSERT INTO FOR_SEQQ
VALUES(2, seq_rev.CURRVAL);

------------------------------------------------Senario#26-------------------------------------------------------------
--Alter a sequence to increase cache size.
ALTER SEQUENCE seq_rev
CACHE 5;

ALTER SEQUENCE seq_rev
CACHE 10;            -----------Ioncreasing Cache size

--CACHE clause in a CREATE SEQUENCE statement is used to preallocate a specified number of sequence values and
--store them in memory for faster access. This improves performance by reducing the need to frequently 
--access the data dictionary for sequence number generation

------------------------------------------------Senario#27-------------------------------------------------------------
--Drop and recreate a sequence without breaking existing inserts.



------------------------------------------------Senario#28-------------------------------------------------------------
--Create sequence-based primary keys for a PROJECTS table.
CREATE SEQUENCE seq_F_seqq_pk
START WITH 1
INCREMENT BY 1;

DROP SEQUENCE seq_F_seqq_pk;

CREATE TABLE SEQ_demo2(
id_col NUMBER DEFAULT seq_F_seqq_pk.NEXTVAL PRIMARY KEY
);
SELECT * FROM SEQ_Demo2;

INSERT INTO SEQ_Demo2
VALUES(seq_F_seqq_pk.CURRVAL);  ------ PK Voilated----

------------------------------------------------Senario#29-------------------------------------------------------------
--Create a custom formatted ID like EMP-0010 using sequence.
CREATE SEQUENCE seq_cus
START WITH 1
INCREMENT BY 1;

CREATE TABLE CUS_SEQ_DEMO(
pk_id VARCHAR2(45) PRIMARY KEY
);
DROP TABLE CUS_SEQ_DEMO;

INSERT INTO CUS_SEQ_DEMO
VALUES('EMP-' || LPAD(seq_cus.NEXTVAL, 4, '0'));
SELECT * FROM CUS_SEQ_DEMO;

------------------------------------------------Senario#30-------------------------------------------------------------
--Simulate a "gap problem" where NEXTVAL gets called multiple times unintentionally — and resolve it.

------------------------------------------------Senario#31-------------------------------------------------------------
--Create a private synonym for EMPLOYEES.
SELECT * FROM SYS.SYNONYMS;
--Public SYNONYMOUS do not belong to a single schema therefore the can have the same name as any db object.
--private SYNONYMOUS on the other hand cannot have the same name as any other object in its schema.
CREATE OR REPLACE SYNONYM syn_emp
FOR EMPLOYEEES;

------------------------------------------------Senario#32-------------------------------------------------------------
--Create a public synonym for PROJECTS.
CREATE OR REPLACE SYNONYM syn_proj
FOR PEOJECTS;

------------------------------------------------Senario#33-------------------------------------------------------------
--Create a synonym for a view instead of a table.
CREATE VIEW view_syn AS 
SELECT * FROM EMPLOYEEES;

CREATE OR REPLACE SYNONYM syn_view
FOR view_syn;

------------------------------------------------Senario#34-------------------------------------------------------------
--Create a synonym pointing to another user’s table.
CREATE OR REPLACE SYNONYM syn_view
FOR sys.Emp;
-----------------------SYNONYM will be created even if you dont have access to a certain object owned by other user,
--but it can wont be accessible through the synonym.

CREATE OR REPLACE SYNONYM syn_view
FOR sys.ThisTableDoesNotExist;   -------SYNONYM does not verify object existance during creation.

SELECT * FROM syn_view;
SELECT * FROM sys.EMP;
------------------------------------------------Senario#35-------------------------------------------------------------
--Remove a synonym and see what happens to dependent queries.
CREATE OR REPLACE SYNONYM syn_view
FOR sys.Emp;
SELECT * FROM syn_view;

DROP SYNONYM syn_view;
SELECT * FROM syn_view;

--Table or view not accessible. When the SYNONYM is dropped the dependent query become invalid.

------------------------------------------------Senario#36-------------------------------------------------------------
--Replace a synonym using CREATE OR REPLACE SYNONYM.
CREATE OR REPLACE SYNONYM syn_chk
FOR MANAGEERS;

------------------------------------------------Senario#37-------------------------------------------------------------
--Check synonym validity after the original object is dropped.
CREATE TABLE Brb(
col1 varchar2(45)
);

CREATE SYNONYM syn_brb
FOR Brb;

SELECT * FROM syn_brb;
DROP SYNONYM syn_brb;
SELECT * FROM syn_brb;

CREATE SYNONYM syn_brb
FOR EMPLOYEEES;

DROP TABLE brb;

----If the assosiated onject is dropped, SYNONYM becomes invalid.
------------------------------------------------Senario#38-------------------------------------------------------------
--Create a synonym to shorten an extremely long table name.
CREATE OR REPLACE SYNONYM syn_emp
FOR SYS.EMPLOYEES_ATTENDANCE_DATA;

SELECT * FROM syn_emp;

------------------------------------------------Senario#39-------------------------------------------------------------
--Create a synonym chain (synonym referencing another synonym).
CREATE SYNONYM syn_sys
FOR syn_emp;

SELECT * FROM syn_sys;  -----Pointing to another column

------------------------------------------------Senario#40-------------------------------------------------------------
--Fix ORA-00980 where a synonym translation becomes invalid.
--Recreate the table associated with the Synoym, would resolve this issue.




