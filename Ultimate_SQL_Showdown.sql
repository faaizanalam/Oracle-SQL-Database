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

----------------------------------------------------MANAGERS---------------------------------------------------------------
INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES(10000, );

INSERT INTO MANAGERSS(MGR_ID, MGR_FIRST, MGR_LAST, DEPT_ID,AGE, GENDER,SALARY,JOINING_DATE,LEAVING_DATE)
VALUES
(10000, 'Zubair', 'Hassan', 1, 29, 'Male', 101,
 'Gulberg Lahore', TO_DATE('2023-01-10','YYYY-MM-DD'), NULL),

(71, 'Hina', 'Khalid', 3216677885, 'hina.khalid@company.com', 27, 'Female', 102,
 'DHA Karachi', TO_DATE('2022-05-18','YYYY-MM-DD'), NULL),

(72, 'Osama', 'Rashid', 3457788124, 'osama.rashid@company.com', 31, 'Male', 103,
 'F-11 Islamabad', TO_DATE('2021-09-25','YYYY-MM-DD'), NULL),

(73, 'Ayesha', 'Nawaz', 3099988125, 'ayesha.nawaz@company.com', 28, 'Female', 104,
 'Johar Town Lahore', TO_DATE('2023-03-12','YYYY-MM-DD'), NULL),

(74, 'Saad', 'Farhan', 3005566775, 'saad.farhan@company.com', 32, 'Male', 105,
 'Askari 15 Lahore', TO_DATE('2020-08-05','YYYY-MM-DD'), NULL),

(75, 'Komal', 'Shah', 3207788992, 'komal.shah@company.com', 26, 'Female', 106,
 'Bahria Town Islamabad', TO_DATE('2023-07-01','YYYY-MM-DD'), NULL),

(76, 'Bilal', 'Raza', 3335566775, 'bilal.raza@company.com', 30, 'Male', 107,
 'Gulshan Karachi', TO_DATE('2021-12-10','YYYY-MM-DD'), NULL),

(77, 'Nimra', 'Aziz', 3457788993, 'nimra.aziz@company.com', 27, 'Female', 108,
 'F-10 Islamabad', TO_DATE('2022-11-20','YYYY-MM-DD'), NULL),

(78, 'Tariq', 'Hameed', 3126677882, 'tariq.hameed@company.com', 33, 'Male', 109,
 'Saddar Karachi', TO_DATE('2020-06-15','YYYY-MM-DD'), NULL),

(79, 'Sadia', 'Rauf', 3011122346, 'sadia.rauf@company.com', 28, 'Female', 110,
 'PECHS Karachi', TO_DATE('2023-02-10','YYYY-MM-DD'), NULL);




INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving)
VALUES(1, 'Ali', 'Ahmad', 3001234567, 'ali.ahmad@company.com', 29, 'Male', 103,
 'G-10 Islamabad', TO_DATE('2021-03-15','YYYY-MM-DD'), NULL);


INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving)
VALUES (2, 'Fatima', 'Khan', 3219876543, 'fatima.khan@company.com', 32, 'Female', 102,
 'DHA Karachi', TO_DATE('2019-06-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(3, 'Usman', 'Shah', 3339998887, 'usman.shah@company.com', 41, 'Male', 101,
 'Model Town Lahore', TO_DATE('2018-01-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(4, 'Ayesha', 'Malik', 3457766554, 'ayesha.malik@company.com', 27, 'Female', 104,
 'Hayatabad Peshawar', TO_DATE('2022-09-05','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(5, 'Zain', 'Raza', 3011239876, 'zain.raza@company.com', 35, 'Male', 103,
 'F-11 Islamabad', TO_DATE('2020-02-18','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(6, 'Hassan', 'Javed', 3025566778, 'hassan.javed@company.com', 30, 'Male', 105,
 'Johar Town Lahore', TO_DATE('2021-05-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(7, 'Nimra', 'Saeed', 3207766554, 'nimra.saeed@company.com', 26, 'Female', 106,
 'Clifton Karachi', TO_DATE('2022-03-03','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(8, 'Rehan', 'Iqbal', 3359988776, 'rehan.iqbal@company.com', 38, 'Male', 107,
 'G-9 Islamabad', TO_DATE('2017-08-27','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(9, 'Maha', 'Aftab', 3185566990, 'maha.aftab@company.com', 31, 'Female', 108,
 'PWD Islamabad', TO_DATE('2020-12-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(10, 'Shahid', 'Rafiq', 3331112223, 'shahid.rafiq@company.com', 44, 'Male', 109,
 'Sariab Road Quetta', TO_DATE('2015-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(11, 'Hiba', 'Faisal', 3456677889, 'hiba.faisal@company.com', 24, 'Female', 110,
 'Shah Rukn-e-Alam Multan', TO_DATE('2023-04-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(12, 'Saad', 'Qureshi', 3009988776, 'saad.qureshi@company.com', 29, 'Male', 108,
 'F-8 Islamabad', TO_DATE('2021-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(13, 'Farah', 'Naz', 3018899776, 'farah.naz@company.com', 36, 'Female', 107,
 'Bahria Town Islamabad', TO_DATE('2018-02-16','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(14, 'Talha', 'Akram', 3116677889, 'talha.akram@company.com', 33, 'Male', 106,
 'North Nazimabad Karachi', TO_DATE('2019-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(e_id,e_first,e_last,E_number,E_email,E_age,e_gender,e_dept,e_address,e_joining,e_leaving) VALUES
(15, 'Mehwish', 'Hassan', 3097788991, 'mehwish.hassan@company.com', 28, 'Female', 105,
 'Askari 10 Lahore', TO_DATE('2022-07-18','YYYY-MM-DD'), NULL);
 
 INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(16, 'Ali', 'Raza', 3001123456, 'ali.raza@company.com', 30, 'Male', 101, 'G-11 Islamabad', TO_DATE('2021-03-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(17, 'Fatima', 'Shah', 3001123457, 'fatima.shah@company.com', 27, 'Female', 102, 'DHA Karachi', TO_DATE('2020-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(18, 'Usman', 'Iqbal', 3001123458, 'usman.iqbal@company.com', 32, 'Male', 103, 'F-10 Islamabad', TO_DATE('2019-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(19, 'Ayesha', 'Khan', 3001123459, 'ayesha.khan@company.com', 29, 'Female', 104, 'Gulshan Karachi', TO_DATE('2022-01-15','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(20, 'Zain', 'Ali', 3001123460, 'zain.ali@company.com', 34, 'Male', 105, 'Johar Town Lahore', TO_DATE('2018-05-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(21, 'Hassan', 'Javed', 3001123461, 'hassan.javed@company.com', 31, 'Male', 106, 'Clifton Karachi', TO_DATE('2021-08-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(22, 'Nimra', 'Saeed', 3001123462, 'nimra.saeed@company.com', 26, 'Female', 107, 'G-9 Islamabad', TO_DATE('2022-03-05','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(23, 'Rehan', 'Iqbal', 3001123463, 'rehan.iqbal@company.com', 38, 'Male', 108, 'F-8 Islamabad', TO_DATE('2017-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(24, 'Maha', 'Aftab', 3001123464, 'maha.aftab@company.com', 31, 'Female', 109, 'PWD Islamabad', TO_DATE('2020-12-01','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(25, 'Shahid', 'Rafiq', 3001123465, 'shahid.rafiq@company.com', 44, 'Male', 110, 'Sariab Road Quetta', TO_DATE('2015-09-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(26, 'Hiba', 'Faisal', 3001123466, 'hiba.faisal@company.com', 24, 'Female', 101, 'Shah Rukn-e-Alam Multan', TO_DATE('2023-04-20','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(27, 'Saad', 'Qureshi', 3001123467, 'saad.qureshi@company.com', 29, 'Male', 102, 'F-8 Islamabad', TO_DATE('2021-06-25','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(28, 'Farah', 'Naz', 3001123468, 'farah.naz@company.com', 36, 'Female', 103, 'Bahria Town Islamabad', TO_DATE('2018-02-16','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(29, 'Talha', 'Akram', 3001123469, 'talha.akram@company.com', 33, 'Male', 104, 'North Nazimabad Karachi', TO_DATE('2019-10-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(30, 'Laiba', 'Khalid', 3001123470, 'laiba.khalid@company.com', 28, 'Female', 105, 'Askari 10 Lahore', TO_DATE('2022-07-18','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(31, 'Furqan', 'Mehmood', 3001123471, 'furqan.mehmood@company.com', 30, 'Male', 106, 'DHA Phase 6 Lahore', TO_DATE('2021-05-12','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(32, 'Rabia', 'Sohail', 3001123472, 'rabia.sohail@company.com', 27, 'Female', 107, 'Clifton Karachi', TO_DATE('2022-03-03','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(33, 'Adeel', 'Haider', 3001123473, 'adeel.haider@company.com', 35, 'Male', 108, 'Faisal Town Lahore', TO_DATE('2018-02-10','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(34, 'Maryam', 'Iqbal', 3001123474, 'maryam.iqbal@company.com', 24, 'Female', 109, 'Satellite Town Rawalpindi', TO_DATE('2022-09-09','YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEEEES(E_ID, E_first, E_last, E_number, E_email, E_age, E_gender, E_dept, E_address, E_joining, E_leaving) VALUES
(35, 'Taha', 'Rafique', 3001123475, 'taha.rafique@company.com', 29, 'Male', 110, 'DHA Phase 6 Lahore', TO_DATE('2020-06-14','YYYY-MM-DD'), NULL);


