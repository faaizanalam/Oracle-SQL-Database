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


------------------------------------------------Senario#21-------------------------------------------------------------

------------------------------------------------Senario#22-------------------------------------------------------------

------------------------------------------------Senario#23-------------------------------------------------------------

------------------------------------------------Senario#24-------------------------------------------------------------

------------------------------------------------Senario#25-------------------------------------------------------------

------------------------------------------------Senario#26-------------------------------------------------------------

------------------------------------------------Senario#27-------------------------------------------------------------

------------------------------------------------Senario#28-------------------------------------------------------------

------------------------------------------------Senario#29-------------------------------------------------------------

------------------------------------------------Senario#30-------------------------------------------------------------



