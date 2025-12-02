-------------------------------------------Extension of Excercise 5---------------------------------------
-----------------------------------------------------INDEX------------------------------------------------
------------------------------------------------Senario#1-------------------------------------------------------------
--Create a non-unique index on a column that frequently appears inside a subquery
--filter in the EMPLOYEES table (you decide which column).

CREATE INDEX ind_emp_fr_col 
ON EMPLOYEEES (E_first);   ------Since E_first is mostly used, creating a non-unique index for it.

------------------------------------------------Senario#2-------------------------------------------------------------
--Create a function-based index to speed up a query that searches employees by case-insensitive last name.
CREATE INDEX idx_func_uppr
ON EMPLOYEEES(UPPER(E_last));

SELECT * FROM EMPLOYEEES     -- - - - - --searching using UPPER(E_last), inorder to use the index and case insensitive searching.
WHERE E_last = UPPER(E_last);

------------------------------------------------Senario#3-------------------------------------------------------------
--Drop and recreate an index so it becomes a composite index covering (dept_id, salary).

DROP INDEX idx_emp_uppr;

CREATE INDEX idx_emp_uppr 
ON EMPLOYEEES(dept_id, salary);

------------------------------------------------Senario#4-------------------------------------------------------------
--Create an index that will improve performance of:
--
--SELECT dept_id, AVG(salary) FROM employees
--WHERE salary > 60000
--GROUP BY dept_id;

CREATE INDEX idx_emp_slry
ON employeees(SALARY);

------------------------------------------------Senario#5-------------------------------------------------------------
--Create a view that shows department name, manager name, and total employees under that manager.
--
--CREATE VIEW veiw_mgr AS
--SELECT D.dept_name, M.mgr_first, COUNT(mgr_id)
--FROM DEPARTMEENTS D
--INNER JOIN MANAGEERS M
--ON D.Dept_id = M.Dept_id
--GROUP BY D.dept_name, M.mgr_first;

------------------------------------------------Senario#6-------------------------------------------------------------
--Create an updatable view that allows changing salary but not department.
CREATE VIEW view_salary_employees AS
SELECT E_ID,
E_FIRST,
E_LAST,
AGE,
GENDER,
DEPT_ID,
MGR_ID,
JOINING_DATE,
LEAVING_DATE,
COMMISSION_PCT,
EMAIL FROM EMPLOYEEES;

SELECT * FROM view_salary_employees; -----SALARY COLUMN NOT INCLUDED THUS, IT CAN'T BE UPDATED!
------------------------------------------------Senario#7-------------------------------------------------------------
--Create a view that returns only employees who joined in the last 5 years.
CREATE VIEW view_emp_lastfive AS
SELECT * FROM EMPLOYEEES
WHERE joining_date > ADD_MONTHS(SYSDATE, -60);

SELECT * FROM view_emp_lastfive;
------------------------------------------------Senario#8-------------------------------------------------------------
--Create a view that hides employees with NULL leaving_date but still remains updatable for other fields.
CREATE VIEW view_emp_nulls AS
SELECT * FROM EMPLOYEEES
WHERE leaving_date IS NOT NULL;

SELECT * FROM view_emp_nulls;

------------------------------------------------Senario#9-------------------------------------------------------------
------------------------------------------------Sequence-------------------------------------------------------------

--Create a sequence starting at 2000 that increments by 5 and use it to insert five dummy rows into a TEST table.
CREATE TABLE TEST(
dummy1 VARCHAR2(50));

DROP TABLE test;

CREATE SEQUENCE seq_test
START WITH 2000
INCREMENT BY 5
MINVALUE 5
MAXVALUE 9000
NOCYCLE;

DROP SEQUENCE seq_test;

INSERT INTO test(dummy1)
VALUES(seq_test.NEXTVAL);

SELECT * FROM test;
------------------------------------------------Senario#10-------------------------------------------------------------
--Alter a sequence so that it cycles after reaching a limit.
--ALTERING UBOVE SEQUANCE;
ALTER SEQUENCE seq_test
CYCLE;  -------CHANGED NO CYCLE STATUS OF SEQ_TEST TO CYCLE(repeating values).

------------------------------------------------Senario#11-------------------------------------------------------------
--Create a sequence that generates project codes in the format:
--PRJ_0001, PRJ_0002

CREATE SEQUENCE seq_pr
START WITH 1
INCREMENT BY 1
MAXVALUE 7000
MINVALUE 0
NOCYCLE;

--USING test TABLE CREATED ABOVE

INSERT INTO test(dummy1)
VALUES('PRJ_' || LPAD(seq_pr.NEXTVAL, 5, '0'));

SELECT * FROM test;
------------------------------------------------Senario#12-------------------------------------------------------------
------------------------------------------------Synonyms-------------------------------------------------------------
---Create a private synonym for a table and perform all CRUD operations using only the synonym.
CREATE SYNONYM syn_test
FOR test;

INSERT INTO syn_test(dummy1)
VALUES('PRJ_' || LPAD(seq_pr.NEXTVAL, 5, '0'));

ALTER TABLE syn_test 
ADD (dummy2 VARCHAR2(50));-------------ALTER DOES NOT WORK WITH synonym.

DELETE FROM syn_test 
WHERE dummy1 = 'hello';

------------------------------------------------Senario#13-------------------------------------------------------------
--Create a synonym for a view and verify if DML operations still work.
CREATE VIEW view_test AS
SELECT * FROM test;
CREATE SYNONYM syn_test1
FOR view_test;

DROP SYNONYM syn_test1;

SELECT * FROM syn_test1;
INSERT INTO syn_test1(dummy1, dummy2)
VALUES('hello','123');

------------------------------------------------Senario#14-------------------------------------------------------------
--Create a synonym for a sequence and use it to insert values.
CREATE SYNONYM syn_seq_pr
FOR seq_pr;

insert into syn_test(dummy1,dummy2)
VALUES(syn_seq_pr.NEXTVAL, '123');

------------------------------------------------Senario#15-------------------------------------------------------------
--Create a synonym for a table in another schema (use dummy names if only one schema exists).
CREATE SYNONYM syn_schema
FOR sys.EMPLOYEES;

------------------------------------------------Senario#16-------------------------------------------------------------
------------------------------------------------MIXED TASKS-------------------------------------------------------------
--Create a system that:
--Uses a sequence to generate employee IDs.
--Inserts the rows into EMPLOYEES.
--Creates a view that shows employee's full name, department, and joining_month (use TO_CHAR).
--Create an index on the view’s underlying joining_date column to increase view query speed.

CREATE SEQUENCE seq_Eid 
START WITH 0
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9000
NOCYCLE;

CREATE TABLE EMP(
E_id NUMBER(9),
E_Name VARCHAR2(20)
);

INSERT INTO EMP(E_id, E_name)
VALUES(seq_eid.NEXTVAL, 'Faizan Alam');

INSERT INTO EMP(E_id, E_name)
VALUES(seq_eid.NEXTVAL, 'OLA');

INSERT INTO EMP(E_id, E_name)
VALUES(seq_eid.NEXTVAL, 'LOL');

--Creates a view that shows employee's full name, department, and joining_month (use TO_CHAR).
CREATE VIEW view_emp_NDJ AS
SELECT E_first || ' ' || E_last AS E_Name, dept_id, EXTRACT(MONTH FROM joining_date) AS JOINING_MONTH
FROM EMPLOYEEES;

SELECT * FROM view_emp_NDJ;

--Create an index on the view’s underlying joining_date column to increase view query speed.
CREATE INDEX idx_emp_jd
ON EMPLOYEEES(joining_date);

------------------------------------------------Senario#17-------------------------------------------------------------
--Create a view that returns all employees earning above the company-average salary.
CREATE VIEW view_emp_sal AS
SELECT * FROM EMPLOYEEES
WHERE SALARY > 
(SELECT AVG(SALARY) FROM EMPLOYEEES);

DROP VIEW view_emp_sal;

SELECT * FROM view_emp_sal;

--Create an index that speeds up the above view’s query.
CREATE INDEX idx_EMP_SAL1
ON EMPLOYEEES(SALARY);

--Create a private synonym for that view and run queries using only the synonym.
CREATE SYNONYM syn_view_emp_sal1
FOR view_emp_sal;

------------------------------------------------Senario#18-------------------------------------------------------------
--Create a table PAYROLL_LOG.
CREATE TABLE PAYROLL_LOG(
Dummy1 VARCHAR2(45)
);

--Create a sequence that will generate unique paycheck numbers.
CREATE SEQUENCE seq_paycheck
START WITH 12321434321
INCREMENT BY 1
MINVALUE 1
NOCYCLE;

--Insert payroll entries using the sequence.
INSERT INTO PAYROLL_LOG(dummy1)
VALUES(seq_paycheck.NEXTVAL);

--Create a synonym for PAYROLL_LOG.
CREATE SYNONYM syn_pyLog
FOR PAYROLL_LOG;

--Query only using the synonym.
SELECT * FROM syn_pyLog;

------------------------------------------------Senario#19-------------------------------------------------------------
--Create a view that shows:
--Department
--Total employees
--Average salary

CREATE VIEW view_emp_DTA AS
SELECT COUNT(e_id) AS Total_Employees, AVG(salary) AS Average_Salary, dept_id 
FROM EMPLOYEEES
GROUP BY dept_id;

--Build an index that helps this view refresh faster.
CREATE INDEX idx_view_emp_dta
ON EMPLOYEEES(dept_id);


--Run a query using HAVING on the view to show departments with avg salary > 70,000.
SELECT dept_id FROM EMPLOYEEES
GROUP BY dept_id
HAVING AVG(SALARY) > 70000;


