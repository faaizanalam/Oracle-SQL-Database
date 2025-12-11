------------------------------------------------PROJECT-------------------------------------------------------------
--------------------------------Corporate Employee & Project Management System--------------------------------------
--Your company has multiple departments, employees, managers, and projects.
--You are tasked to design, populate, and analyze the database while optimizing for queries, integrity, and reporting.

CREATE TABLE DEPARTMENTSS(
dept_id   NUMBER(8) PRIMARY KEY,
dept_name VARCHAR2(50) UNIQUE NOT NULL,
location  VARCHAR2(80)
);

CREATE TABLE MANAGERSS(                                 
mgr_id NUMBER(8) PRIMARY KEY,
mgr_first VARCHAR2(45),
mgr_last VARCHAR(45),
dept_id NUMBER(8),
age INT,
gender VARCHAR2(6),
salary NUMBER(10),
joining_date DATE,
leaving_date DATE,

CONSTRAINT fk_mgr_dpt_dID FOREIGN KEY (dept_id) REFERENCES DEPARTMENTSS(dept_id),
CONSTRAINT chk_mgr_salary CHECK (SALARY > 0)
);

CREATE SEQUENCE seq_empl_e_id 
START WITH 100000
INCREMENT by 1
MAXVALUE 199999
MINVALUE 0
NOCYCLE;

CREATE TABLE EMPLOYEESS(
emp_id NUMBER(8) PRIMARY KEY,
E_first VARCHAR2(50),
E_last VARCHAR2(50),
age INT,
gender VARCHAR2(6),
dept_id NUMBER(8),
mgr_id NUMBER(8),
salary NUMBER(10),
joining_date DATE,
leaving_date DATE,

CONSTRAINT fk_empl_dept_dID FOREIGN KEY (dept_id) REFERENCES DEPARTMENTSS(dept_id),
CONSTRAINT fk_empl_mgr_mID FOREIGN KEY (mgr_id) REFERENCES MANAGERSS(mgr_id)
);

CREATE SEQUENCE seq_prj_pID
START WITH 300000
INCREMENT BY 1
MINVALUE 0
MAXVALUE 350000
NOCYCLE;


CREATE TABLE PROJECTSS(
proj_id NUMBER(8)PRIMARY KEY,
proj_name VARCHAR2(65) UNIQUE,
dept_id NUMBER(8),
start_date DATE,
end_date DATE,
budget NUMBER(15),

CONSTRAINT fk_prj_dept_dID FOREIGN KEY (dept_id) REFERENCES DEPARTMENTSS(dept_id)
);


CREATE TABLE EMPLOYEE_PROJECTS( 
emp_id NUMBER(8),
proj_id NUMBER(8),
hours_allocated NUMBER(5),

CONSTRAINT fk_empProj_emp_eID FOREIGN KEY (emp_id) REFERENCES EMPLOYEESS(emP_id),
CONSTRAINT fk_empProj_proj_P_id FOREIGN KEY (proj_id) REFERENCES PROJECTSS(proj_id)
);

CREATE SEQUENCE seq_ATrail_aID
START WITH 400000
INCREMENT BY 1
MINVALUE 0
MAXVALUE 500000
NOCYCLE;

CREATE TABLE AUDIT_TRAIL(
audit_id NUMBER(8) PRIMARY KEY,
emp_id NUMBER(8),
action VARCHAR2(100),
action_date DATE DEFAULT SYSDATE,

CONSTRAINT fk_ATrail_emp_eID FOREIGN KEY (emp_id) REFERENCES EMPLOYEESS(emp_id)
);

CREATE SEQUENCE seq_pyroll_pyrll
START WITH 200000
INCREMENT BY 1
MINVALUE 100000
MAXVALUE 250000
NOCYCLE;

CREATE TABLE PAYROLLS(
payroll_id NUMBER(8) PRIMARY KEY,
emp_id NUMBER(8),
salary_paid NUMBER(10),
pay_date DATE,

CONSTRAINT fk_pyrol_emp_eID FOREIGN KEY (emp_id) REFERENCES EMPLOYEESS(emp_id)
);

----------------------------------------------Populate Data (DML + Sequences)---------------------------------------------
---------------------------------------------------------Query1-----------------------------------------------------------
--Insert at least 10 departments, 10 managers, 50 employees, 10 projects.
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(1, 'Human Resources', 'Lahore');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(2, 'Finance','Karachi');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(3, 'IT','Islamabad');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(4, 'Marketing','Peshawar');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(5, 'Sales','Lahore');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(6, 'Customer Support','Karachi');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(7, 'Research & Development','Islamabad');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(8, 'Cybersecurity','Islamabad');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(9, 'Logistics','Quetta');
INSERT INTO DEPARTMENTSS(dept_id, dept_name, location)
VALUES(10, 'Procurement','Multan');

SELECT * FROM DEPARTMENTSS;
----------------------------------------------------MANAGERS---------------------------------------------------------------

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES
(10000, 'Zubair', 'Hassan', 1, 29, 'Male', 78000,
TO_DATE('2023-01-10','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10001, 'Hina', 'Khalid', 2, 27, 'Female', 80000,
TO_DATE('2022-05-18','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10002, 'Osama', 'Rashid', 3, 31, 'Male', 82000,
TO_DATE('2021-09-25','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10003, 'Ayesha', 'Nawaz', 4, 28, 'Female', 100000,
TO_DATE('2023-03-12','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10004, 'Saad', 'Farhan', 5, 32, 'Male', 100500,
TO_DATE('2020-08-05','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10005, 'Komal', 'Shah', 6, 26, 'Female', 106000,
TO_DATE('2023-07-01','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10006, 'Bilal', 'Raza', 7, 30, 'Male', 100000,
TO_DATE('2021-12-10','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10007, 'Nimra', 'Aziz', 8, 27, 'Female', 90000,
TO_DATE('2022-11-20','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10008, 'Tariq', 'Hameed', 9, 33, 'Male', 93000,
TO_DATE('2020-06-15','YYYY-MM-DD'), NULL);

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10009, 'Sadia', 'Rauf', 10, 28, 'Female', 87000,
TO_DATE('2023-02-10','YYYY-MM-DD'), NULL);

SELECT * FROM  MANAGERSS;

----------------------------------------------------EMPLOYEESS---------------------------------------------------------------

SELECT * FROM EMPLOYEESS;

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Fatima', 'Khan', 32, 'Female', 1, 10000, 65000, TO_DATE('2019-06-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Usman', 'Shah', 41, 'Male', 2, 10001, 72000, TO_DATE('2018-01-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Ayesha', 'Malik', 27, 'Female', 3, 10002, 54000, TO_DATE('2022-09-05','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Zain', 'Raza', 35, 'Male', 4, 10003, 77000, TO_DATE('2020-02-18','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hassan', 'Javed', 30, 'Male', 5, 10004, 60000, TO_DATE('2021-05-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Nimra', 'Saeed', 26, 'Female', 6, 10005, 52000, TO_DATE('2022-03-03','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Rehan', 'Iqbal', 38, 'Male', 7, 10006, 79000, TO_DATE('2017-08-27','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Maha', 'Aftab', 31, 'Female', 8, 10007, 68000, TO_DATE('2020-12-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Shahid', 'Rafiq', 44, 'Male', 9, 10008, 80000, TO_DATE('2015-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hiba', 'Faisal', 24, 'Female', 10, 10009, 51000, TO_DATE('2023-04-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Saad', 'Qureshi', 29, 'Male', 8, 10001, 62000, TO_DATE('2021-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Farah', 'Naz', 36, 'Female', 7, 10002, 69000, TO_DATE('2018-02-16','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Talha', 'Akram', 33, 'Male', 6, 10003, 75000, TO_DATE('2019-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Mehwish', 'Hassan', 28, 'Female', 5, 10004, 56000, TO_DATE('2022-07-18','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Ali', 'Raza', 30, 'Male', 1, 10000, 67000, TO_DATE('2021-03-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Fatima', 'Shah', 27, 'Female', 2, 10001, 52000, TO_DATE('2020-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Usman', 'Iqbal', 32, 'Male', 3, 10002, 74000, TO_DATE('2019-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Ayesha', 'Khan', 29, 'Female', 4, 10003, 58000, TO_DATE('2022-01-15','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Zain', 'Ali', 34, 'Male', 5, 10004, 79000, TO_DATE('2018-05-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hassan', 'Javed', 31, 'Male', 6, 10005, 64000, TO_DATE('2021-08-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Nimra', 'Saeed', 26, 'Female', 7, 10006, 51000, TO_DATE('2022-03-05','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Rehan', 'Iqbal', 38, 'Male', 8, 10007, 78000, TO_DATE('2017-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Maha', 'Aftab', 31, 'Female', 9, 10008, 69000, TO_DATE('2020-12-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Shahid', 'Rafiq', 44, 'Male', 10, 10009, 80000, TO_DATE('2015-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hiba', 'Faisal', 24, 'Female', 1, 10000, 50000, TO_DATE('2023-04-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Saad', 'Qureshi', 29, 'Male', 2, 10001, 62000, TO_DATE('2021-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Farah', 'Naz', 36, 'Female', 3, 10002, 70000, TO_DATE('2018-02-16','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Talha', 'Akram', 33, 'Male', 4, 10003, 76000, TO_DATE('2019-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Laiba', 'Khalid', 28, 'Female', 5, 10004, 52000, TO_DATE('2022-07-18','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Furqan', 'Mehmood', 30, 'Male', 6, 10005, 64000, TO_DATE('2021-05-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Rabia', 'Sohail', 27, 'Female', 7, 10006, 57000, TO_DATE('2022-03-03','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Adeel', 'Haider', 35, 'Male', 8, 10007, 69000, TO_DATE('2018-02-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Maryam', 'Iqbal', 24, 'Female', 9, 10008, 53000, TO_DATE('2022-09-09','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEESS (EMP_ID, E_FIRST, E_LAST, GENDER, AGE, SALARY, DEPT_ID, JOINING_DATE, LEAVING_DATE)
VALUES (seq_empl_e_id.NEXTVAL, 'Shoaib', 'Anjum', 34, 'Male', 2, 10008, 72600, '10-JAN-2018', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Nadia', 'Hassan', 29, 'Female', 1, 10002, 54000, '05-MAR-2020', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Irfan', 'Khan', 41, 'Male', 3, 10004, 85000,'12-NOV-2016', '25-JUL-2023');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Ayesha', 'Javed', 26, 'Female', 4, 10002, 48000, '22-AUG-2022', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hamza', 'Raza', 'Male', 38, 2, 10001, 69000, '17-JUN-2017', '19-DEC-2021');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Mariam', 'Saeed', 'Female', 33, 1, 10007, 61000, '03-FEB-2019', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Bilal', 'Ahmed', 45, 'Male', 8, 10009, 90000, '09-SEP-2015', '15-MAR-2022');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Tania', 'Shah', 31, 'Female', 4, 10000, 58000, '11-OCT-2020', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Adnan', 'Yousaf', 36, 'Male', 2, 10003,73000, '14-JAN-2017', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Rabia', 'Imran', 27, 'Female', 1, 10005, 50000, '26-MAY-2021', '01-JUN-2024');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Shoaib', 'Akhtar', 34, 'Male', 2, 10003, 72000, '10-JAN-2018', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Nadia', 'Hassan', 29, 'Female', 1, 10005, 54000, '05-MAR-2020', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Irfan', 'Khan', 41, 'Male', 3, 10008, 85000, '12-NOV-2016', '25-JUL-2023');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Ayesha', 'Javed', 26, 'Female', 4, 10000, 48000, '22-AUG-2022', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hamza', 'Raza', 38, 'Male', 2, 10003, 69000, '17-JUN-2017', '19-DEC-2021');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Sumaira', 'Iqbal', 32, 'Female', 6, 10000, 62000, '08-APR-2019', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Farhan', 'Mirza', 39, 'Male', 7, 10006, 78000, '15-AUG-2016', '30-JUN-2020');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Sadaf', 'Bibi', 28, 'Female', 3, 10008, 55000, '21-JAN-2021', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Danish', 'Malik', 35, 'Male', 5, 10006, 70000, '18-SEP-2017', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Rania', 'Aslam', 30, 'Female', 8, 10009, 59000, '13-MAR-2020', '01-JAN-2023');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Usman', 'Arif', 37, 'Male', 2, 10003, 75000, '10-JUL-2018', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Mehwish', 'Sultan', 34, 'Female', 1, 10005, 64000, '05-JAN-2019', '30-SEP-2023');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Kamran', 'Qureshi', 42, 'Male', 7, 10010, 88000, '12-MAY-2016', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Sania', 'Farooq', 29, 'Female', 4, 10000, 52000, '23-MAR-2021', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Arsalan', 'Mehmood', 33, 'Male', 6, 10001, 69000, '17-AUG-2019', '10-NOV-2022');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Iqra', 'Khalid', 27, 'Female', 3, 10008, 50000, '01-JUL-2022', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Hassan', 'Rafiq', 40, 'Male', 5, 10006, 82000, '09-NOV-2015', '15-FEB-2021');

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Zara', 'Rehman', 32, 'Female', 8, 10009, 63000, '14-APR-2019', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Talha', 'Sohail', 36, 'Male', 2, 10003, 71000, '27-OCT-2017', NULL);

INSERT INTO EMPLOYEESS(EMP_ID, E_FIRST, E_LAST, AGE, GENDER, DEPT_ID, MGR_ID, SALARY, JOINING_DATE, LEAVING_DATE) VALUES
(seq_empl_e_id.NEXTVAL, 'Nimra', 'Waheed', 30, 'Female', 1, 10005, 56000, '06-DEC-2020', '01-AUG-2024');



----------------------------------------------------PROJECTS---------------------------------------------------------------
DESC PROJECTSS;

SELECT * FROM PROJECTSS;

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'HR Onboarding Automation', 1, '10-JAN-2021', '15-SEP-2021', 150000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Finance Audit System Upgrade', 2, '05-MAR-2020', '20-DEC-2020', 220000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Inventory Tracking Platform', 3, '12-NOV-2021', '05-AUG-2022', 185000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Website Redesign Initiative', 4, '18-MAY-2022', '30-OCT-2022', 90000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Manufacturing Line Upgrade', 5, '01-FEB-2021', '10-NOV-2021', 300000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Logistics Optimization Project', 6, '22-AUG-2020', '15-MAR-2021', 170000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Customer Support Portal', 7, '11-OCT-2019', '25-JUL-2020', 120000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'R&D Prototype Development', 8, '14-JAN-2022', '01-DEC-2022', 450000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Quality Control Automation', 9, '03-APR-2021', '21-NOV-2021', 200000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Corporate Social Responsibility Drive', 10, '09-AUG-2023', '30-JAN-2024', 80000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Internal Networking Upgrade', 4, '15-MAR-2022', '20-DEC-2022', 130000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Automated Attendance Monitoring System', 1, '01-JUL-2021', '05-APR-2022', 115000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Product Packaging Redesign', 5, '10-FEB-2020', '30-NOV-2020', 160000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Cloud Migration Project', 1, '05-JAN-2023', NULL, 250000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Employee Feedback Portal', 2, '15-FEB-2022', NULL, 90000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'AI Chatbot Development', 3, '12-MAR-2023', NULL, 320000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Mobile Payment Integration', 4, '08-APR-2023', NULL, 180000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Data Analytics Dashboard', 5, '20-MAY-2022', NULL, 210000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Website SEO Optimization', 6, '01-JUN-2023', NULL, 95000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Inventory Forecasting Tool', 7, '10-JUL-2022', NULL, 175000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Customer Loyalty Program', 8, '18-AUG-2023', NULL, 140000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'ERP System Enhancement', 9, '25-SEP-2022', NULL, 300000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Internal Security Audit', 10, '03-OCT-2023', NULL, 120000);

INSERT INTO PROJECTSS(PROJ_ID, PROJ_NAME, DEPT_ID, START_DATE, END_DATE, BUDGET) VALUES 
(seq_prj_pID.NEXTVAL, 'Supplier Integration System', 1, '12-NOV-2022', NULL, 160000);


--------------------------------------------**********---------------------------------------------------------------
--Assign employees to projects using EMPLOYEE_PROJECTS table. Include some employees in multiple projects.

DESC EMPLOYEESS;
DESC PROJECTSS;
DESC EMPLOYEE_PROJECTS;

CREATE VIEW view_emp_proj_data_entry AS
SELECT EMP_ID, P.PROJ_ID, 
CASE
WHEN P.BUDGET <100000 THEN 300
WHEN P.BUDGET BETWEEN 100000 AND 149999 THEN 325
WHEN P.BUDGET BETWEEN 150000 AND 250000 THEN 350
WHEN P.BUDGET > 250000 THEN 400 
END
AS HOURS_ALLOCATED FROM EMPLOYEESS E
INNER JOIN PROJECTSS P
ON E.dept_id = P.dept_id
WHERE E.joining_date <= P.start_date;

---CREATED A VIEW ABOVE TO ENTER DATA IN TABLE "EMPLOYEE_PROJECTS".

SELECT * FROM EMPLOYEESS;

INSERT INTO EMPLOYEE_PROJECTS(EMP_ID, PROJ_ID, HOURS_ALLOCATED)
SELECT emp_id, proj_id, hours_allocated 
FROM view_emp_proj_data_entry;

SELECT * FROM view_emp_proj_data_entry;
DROP VIEW view_emp_proj_data_entry;

DESC EMPLOYEE_PROJECTS;

SELECT * FROM EMPLOYEE_PROJECTS;

----------------------------DATA INSERTED----------->>>>>>>>>>>>>>>>>>>

-----------------------------------------------------*******************------------------------------------------
--Insert payroll records for employees using the payroll sequence.
SELECT * FROM PAYROLLS;
SELECT * FROM EMPLOYEESS;
INSERT INTO PAYROLLS(PAYROLL_ID, EMP_ID, SALARY_PAID, PAY_DATE)
VALUES(seq_pyroll_pyrll.NEXTVAL, );

--Creating a View for this purpose

CREATE VIEW view_pyroll_dataEntry AS
SELECT EMP_ID, SALARY, JOINING_DATE, LEAVING_DATE FROM EMPLOYEESS;

SELECT * FROM view_pyroll_dataEntry;

UPDATE view_pyroll_dataEntry 
SET JOINING_DATE = ADD_MONTHS(TRUNC(JOINING_DATE, 'MM'), -1);  ------CONVERTING ALL VIEW DATES TO First of next month for PAYROLL ENTRY


MERGE INTO PAYROLLS P
USING view_pyroll_dataEntry VP
ON (P.EMP_ID = VP.EMP_ID)
WHEN MATCHED THEN 
UPDATE SET PAY_DATE = ADD_MONTHS(PAY_DATE, 1)
WHERE P.PAY_DATE < VP.LEAVING_DATE

WHEN NOT MATCHED THEN 
INSERT(PAYROLL_ID, EMP_ID, SALARY_PAID, PAY_DATE)
VALUES(seq_pyroll_pyrll.NEXTVAL, VP.EMP_ID, VP.SALARY, VP.JOINING_DATE);


SELECT ADD_MONTHS(TRUNC(TO_DATE('22-JAN-2002', 'DD-MON-YYYY'), 'MM'), 1)FROM DUAL;


---------------DATA INSERTED--------->>>>>>>>>>>>>>>>>>>>

---------------------------------------------****-----------------------------------------------------
--------Populate audit trail for salary updates for 5 employees.
UPDATE EMPLOYEESS 
SET E_first = 'Faizan' 
WHERE EMP_ID = 100014;  -----------UPDATE 1

UPDATE EMPLOYEESS
SET AGE = 23
WHERE EMP_ID = 100009;   ----------UPDATE 2

UPADTE EMPLOYEESS 
SET E_LAST = 'Malik'
WHERE EMP_ID = 100039;  -----------UPDATE 3


UPDATE EMPLOYEESS
SET JOINING_DATE = JOINING_DATE + dept_id
WHERE EMP_ID = 100001    ----------UPDATE 4

UPDATE EMPLOYEESS
SET JOINING_DATE = JOINING_DATE + dept_id   
WHERE EMP_ID = 100008;   ----------UPDATE 5

SELECT * FROM EMPLOYEESS;

SELECT EXTRACT(DAY FROM DATE '2023-08-22') FROM DUAL;


SELECT * FROM AUDIT_TRAIL;
INSERT INTO AUDIT_TRAIL(AUDIT_ID, EMP_ID, ACTION)
VALUES(seq_ATrail_aID.NEXTVAL, 100014, 'Changed employees first name to "Faizan"');

INSERT INTO AUDIT_TRAIL(AUDIT_ID, EMP_ID, ACTION)
VALUES(seq_ATrail_aID.NEXTVAL, 100009, 'Updated Employee Age to 23');

INSERT INTO AUDIT_TRAIL(AUDIT_ID, EMP_ID, ACTION)
VALUES(seq_ATrail_aID.NEXTVAL, 100039, 'Updated employees last name to "Malik"');

INSERT INTO AUDIT_TRAIL(AUDIT_ID, EMP_ID, ACTION)
VALUES(seq_ATrail_aID.NEXTVAL, 100001, 'Changed employees "Joining date" to "Joining date + dept_id"');

INSERT INTO AUDIT_TRAIL(AUDIT_ID, EMP_ID, ACTION)
VALUES(seq_ATrail_aID.NEXTVAL, 100008, 'Changed employees "Joining date" to "Joining date + dept_id"');


SELECT * FROM EMPLOYEESS;

SELECT * FROM AUDIT_TRAIL;

--------------------------Task Complete----------->>>>>>>>>>>

----------------------------------------Advanced Queries (Test joins, subqueries, operators, aggregates)-------------------------
SELECT * FROM EMPLOYEESS;
SELECT * FROM MANAGERSS;
SELECT * FROM DEPARTMENTSS;
SELECT * FROM PAYROLLS;
SELECT * FROM PROJECTSS;
SELECT * FROM EMPLOYEE_PROJECTS;
SELECT * FROM AUDIT_TRAIL;

--Display employee full name, dept_name, manager full name, and salary. 
SELECT E_first || ' ' || E_last AS E_Name, D.DEPT_NAME, 
Mgr_first || ' ' || mgr_last AS MGR_Name, E.SALARY FROM EMPLOYEESS E
LEFT JOIN 
DEPARTMENTSS D ON E.DEPT_ID = D.DEPT_ID
LEFT JOIN 
MANAGERSS M ON M.mgr_id = E.mgr_id
;

--Filter salary between 60k and 90k and employee + manager in same department.
SELECT E.E_first || ' ' || E.E_last AS E_Name, 
M.Mgr_first || ' ' || M.mgr_last AS MGR_Name, E.SALARY FROM EMPLOYEESS E
LEFT JOIN 
MANAGERSS M ON M.mgr_id = E.mgr_id
WHERE (E.SALARY BETWEEN 60000 AND 90000) AND (E.dept_id = M.dept_id);

----------------------Show departments with no employees.
SELECT D.dept_id FROM DEPARTMENTSS D
LEFT JOIN EMPLOYEESS E 
ON D.dept_id = E.dept_id
GROUP BY D.dept_id
HAVING COUNT(E.dept_id) = 0;


---------------------------List employees working on more than 2 projects.------------------------------------
SELECT E.EMP_ID, COUNT(E.EMP_ID) FROM PROJECTSS P
INNER JOIN EMPLOYEESS E
ON P.dept_id = E.dept_id
GROUP BY E.EMP_ID
HAVING COUNT(E.EMP_ID) > 2
;

--Find employees whose salary is greater than the average salary of their department.
SELECT * FROM EMPLOYEESS E
WHERE SALARY > (
SELECT AVG(SALARY) FROM EMPLOYEESS EV
WHERE E.dept_id = EV.dept_id);

SELECT * FROM EMPLOYEESS E
JOIN MANAGERSS M ON E.mgr_id = M.mgr_id
WHERE E.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEESS);


--Find employees reporting to the highest-paid manager.
SELECT * FROM EMPLOYEESS 
WHERE mgr_id IN (
SELECT mgr_id FROM MANAGERSS
WHERE SALARY = (SELECT MAX(SALARY) FROM MANAGERSS));


--Show departments with avg salary > 65k and list the highest-paid employee in that department.
SELECT d.dept_id FROM DEPARTMENTSS D 
INNER JOIN EMPLOYEESS E
ON E.dept_id = D.dept_id
GROUP BY d.dept_id   -------------
HAVING AVG(E.SALARY) > 65000
--AND E.SALARY = MAX(E.SALARY)
;

SELECT MAX()

SELECT d.dept_id FROM DEPARTMENTSS D 
INNER JOIN EMPLOYEESS E
ON E.dept_id = D.dept_id
GROUP BY d.dept_id   -------------
HAVING AVG(E.SALARY) > 65000

SELECT MAX(SALARY) FROM EMPLOYEESS

--Show employees with names starting with A or B, excluding those with salary < 50k.
SELECT * FROM EMPLOYEESS
WHERE E_First LIKE 'A%' OR E_First LIKE 'B%'
AND SALARY >= 50000;


--Show employees not assigned to any project.
SELECT * FROM EMPLOYEESS E
LEFT OUTER JOIN PROJECTSS P
ON E.dept_id = P.dept_id
WHERE PROJ_ID IS NULL;

----------------------------------------------Functions & Calculations--------------------------------
--Show employee full name in UPPERCASE, initials, and salary rounded to nearest 1000.
SELECT E_first || ' ' || E_last AS E_name, 
SUBSTR(E_First, 1,1) || ' AND ' || SUBSTR(E_last, 1,1) AS Initials,
ROUND(SALARY, -3) AS Rounded_to_1000
FROM EMPLOYEESS; 

--Calculate years of experience using joining_date.
SELECT 
E_first || ' ' || E_last AS E_name,
ROUND((SYSDATE - joining_date) / 365, 1 ) || ' Years' AS Experiance
FROM EMPLOYEESS;

--Handle NULL leaving_date using NVL/COALESCE, displaying “Still Working” if null.
SELECT E.*,  NVL(TO_CHAR(leaving_date), 'Still Working')
FROM EMPLOYEESS E;               -------------------------------NVL

SELECT E.*,  NVL2(TO_CHAR(leaving_date), 'Left' , 'Still Working')
FROM EMPLOYEESS E;               -------------------------------NVL2

SELECT E.*,  COALESCE(TO_CHAR(leaving_date), 'Still Working')
FROM EMPLOYEESS E;               ------------------------------COALESCE


--Categorize salary into LOW (<60k), MEDIUM (60-90k), HIGH (>90k) using CASE.
SELECT E.*,
CASE 
WHEN Salary < 60000 THEN 'LOW'
WHEN Salary BETWEEN 60000 AND 90000 THEN 'MEDIUM'
WHEN Salary > 90000 THEN 'HIGH'
ELSE 'UNKNOWN'
END AS Salary_GROUP
FROM EMPLOYEESS E;


--Format project codes using LPAD and sequence: PRJ_0001, PRJ_0002.
SELECT 'PRJ_' || LPAD(Proj_id, 9, '0') FROM PROJECTSS;

SELECT * FROM PROJECTSS;

------------------------>>>>>>>>>>>>>>>>>>>>Task Completed...

------------------------------------------------Aggregates, Grouping, HAVING-----------------------------
--Count employees per department.
SELECT d.dept_id, COUNT(d.dept_id) AS TOTAL_EMPLOYEES FROM EMPLOYEESS E
INNER JOIN DEPARTMENTSS D
ON D.dept_id = E.dept_id
GROUP BY d.dept_id;

--Show average salary per manager, but only for managers with more than 3 employees.
SELECT M.mgr_id,COUNT(E.emp_id) AS T_Employeess,  AVG(M.SALARY) AS AVERAGE_SALARY FROM EMPLOYEESS E
INNER JOIN MANAGERSS M
ON M.dept_id = E.dept_id
GROUP BY M.mgr_id
HAVING COUNT(E.emp_id) > 3;

--List total budget per department.
SELECT D.dept_id, SUM(P.BUDGET) AS PROEJCT_BUDGET_SUM FROM PROJECTSS P
INNER JOIN DEPARTMENTSS D
ON P.dept_id = D.dept_id
GROUP BY D.dept_id;

--Use HAVING to filter departments with total project budget > 500k.
SELECT D.dept_id FROM PROJECTSS P
INNER JOIN DEPARTMENTSS D
ON P.dept_id = D.dept_id
GROUP BY  D.dept_id
HAVING SUM(P.BUDGET) > 500000;

-------------------------->>>>>>>>>>>>>>Task Completed...............

-------------------------------------Views & Synonyms--------------------------------------------------
--Create a view EMPLOYEE_OVERVIEW showing:
--emp_id, full name, dept_name, manager name, salary, projects assigned (count), years of experience.

CREATE VIEW EMPLOYEE_OVERVIEW AS 
SELECT E.emp_id, 
E.E_first || ' ' || E.E_last AS E_Name,
D.dept_name,
M.Mgr_first || ' ' || M.Mgr_last AS M_Name,
E.SALARY AS EMPLOYEE_SALARY,
NVL(COUNT(P.proj_id), 0) AS PROJECTS_ASSIGNED,
ROUND((SYSDATE - E.Joining_date) / 365, 1) AS YEARS_OF_EXPERIANCE

FROM EMPLOYEESS E
LEFT JOIN DEPARTMENTSS D
ON E.dept_id = D.dept_id
LEFT JOIN MANAGERSS M
ON E.mgr_id = M.mgr_id
LEFT JOIN PROJECTSS P
ON P.dept_id = E.dept_id

GROUP BY E.emp_id, E.E_first, E.E_last, 
M.Mgr_first, M.Mgr_last,
E.SALARY,
D.dept_name, E.joining_date;

SELECT * FROM EMPLOYEE_OVERVIEW; ------VIEW_CREATED 


----------Create a view DEPT_BUDGET_REPORT showing dept_id, dept_name, total_budget, avg_salary.
CREATE VIEW DEPT_BUDGET_REPORT AS 
SELECT D.dept_id, D.dept_name, SUM(BUDGET) AS BUDEGT, ROUND(AVG(SALARY)) AS AVERAGE_SALARY FROM DEPARTMENTSS D
LEFT JOIN PROJECTSS P 
ON D.dept_id = P.dept_id
LEFT JOIN EMPLOYEESS E
ON D.dept_id = E.dept_id
GROUP BY D.dept_id, D.dept_name;

SELECT * FROM DEPT_BUDGET_REPORT;


------------------------Create a private synonym for EMPLOYEE_OVERVIEW.
CREATE SYNONYM syn_EMPLOYEE_OVERVIEW
FOR EMPLOYEE_OVERVIEW;

SELECT * FROM syn_EMPLOYEE_OVERVIEW;

------------------------Create a public synonym for DEPT_BUDGET_REPORT.
CREATE OR REPLACE PUBLIC SYNONYM syn_DEPT_BUDGET_REPORT
FOR DEPT_BUDGET_REPORT;

SELECT * FROM syn_DEPT_BUDGET_REPORT;

-----------------------Make EMPLOYEE_OVERVIEW updatable but hide salary column.
CREATE OR REPLACE VIEW EMPLOYEE_OVERVIEW AS
SELECT E.emp_id, 
E.E_first || ' ' || E.E_last AS E_Name,
D.dept_name,
M.Mgr_first || ' ' || M.Mgr_last AS M_Name,
--E.SALARY AS EMPLOYEE_SALARY,
NVL(COUNT(P.proj_id), 0) AS PROJECTS_ASSIGNED,
ROUND((SYSDATE - E.Joining_date) / 365, 1) AS YEARS_OF_EXPERIANCE

FROM EMPLOYEESS E
LEFT JOIN DEPARTMENTSS D
ON E.dept_id = D.dept_id
LEFT JOIN MANAGERSS M
ON E.mgr_id = M.mgr_id
LEFT JOIN PROJECTSS P
ON P.dept_id = E.dept_id

GROUP BY E.emp_id, E.E_first, E.E_last, 
M.Mgr_first, M.Mgr_last,
E.SALARY,
D.dept_name, E.joining_date;


------------Use WITH CHECK OPTION to restrict view to employees earning > 60k.
CREATE OR REPLACE VIEW EMPLOYEE_OVERVIEW AS
SELECT E.emp_id, 
E.E_first || ' ' || E.E_last AS E_Name,
D.dept_name,
M.Mgr_first || ' ' || M.Mgr_last AS M_Name,
--E.SALARY AS EMPLOYEE_SALARY,
NVL(COUNT(P.proj_id), 0) AS PROJECTS_ASSIGNED,
ROUND((SYSDATE - E.Joining_date) / 365, 1) AS YEARS_OF_EXPERIANCE

FROM EMPLOYEESS E
LEFT JOIN DEPARTMENTSS D
ON E.dept_id = D.dept_id
LEFT JOIN MANAGERSS M
ON E.mgr_id = M.mgr_id
LEFT JOIN PROJECTSS P
ON P.dept_id = E.dept_id

GROUP BY E.emp_id, E.E_first, E.E_last, 
M.Mgr_first, M.Mgr_last,
E.SALARY,
D.dept_name, E.joining_date
HAVING E.SALARY > 60000

WITH CHECK OPTION;

SELECT * FROM EMPLOYEE_OVERVIEW;

--------------------------------->>>>>>>>>>>>>>>>>>>>>TASK COMPLETED

-----------------------------------------------Indexing-------------------------------------------------
------------Create an index on EMPLOYEES.salary.
CREATE INDEX idx_emps_sal
ON EMPLOYEESS(SALARY);


------------Create a composite index on (dept_id, joining_date).
CREATE INDEX idx_com_emp
ON EMPLOYEESS(dept_id, joining_date);

------------Create a function-based index for case-insensitive search on last_name.
CREATE INDEX idx_func_lst
ON EMPLOYEESS(UPPER(E_last));

------------Create an index to speed up EMPLOYEE_PROJECTS.hours_allocated queries.
CREATE INDEX idx_empProj_HrAlloc 
ON EMPLOYEE_PROJECTS(HOURS_ALLOCATED);

----------------------------------------->>>>>>>>>>>>>>>TASKS COMPLETED
--------------------------------------------------Advanced Retrieval-----------------------------------------------
--List top 5 highest-paid employees with department name and manager.
SELECT * FROM EMPLOYEESS
ORDER BY SALARY DESC
FETCH FIRST 5 ROWS WITH TIES;

--Show employees ranked by salary within each department (use RANK or DENSE_RANK).
SELECT E.*, RANK() OVER(ORDER BY SALARY DESC) AS SALARY_RANK, 
DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSE_RANK
FROM EMPLOYEESS E;


SELECT E.*, RANK() OVER (ORDER BY SAlaRY DESC) AS RANK_SALARY, 
DENSE_RANK() OVER (ORDER BY SAlaRY DESC) AS DENSE_RANK_SALARY,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUMBER
FROM EMPLOYEESS E
OFFSET 5 ROWS
FETCH FIRST 5 ROWS ONLY;    

---------------------------------------------------------------------------------------

--Show employees 6-10 by salary descending (OFFSET + FETCH).



Show departments with total employees, total salary, highest-paid employee, total project budget in one query.

Use subqueries to find employees whose salary is higher than at least 2 managers.
