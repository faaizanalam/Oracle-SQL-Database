-------------------------------This excercise includes all concepts we have learned so far in SQL--------------------------------
----------------------------------------SQL Final Showdown Exercises-------------------------------------------------------------
-------------------------------------------Database Design & DDL-------------------------------------------------------------
--Create tables: EMPLOYEEES, MANAGEEERS, DEPARTMEEENTS, PROJEEEECTS, PAYROLL.
--Include primary keys, foreign keys, NOT NULL, UNIQUE constraints.
--Use appropriate data types (DATE, VARCHAR, NUMBER).
--Add a CHECK constraint on EMPLOYEES.salary > 0.
--Add a default value for EMPLOYEES.joining_date as SYSDATE.
--Merge new departments from a CSV-like input into DEPARTMENTS using MERGE.

CREATE TABLE EMPLOYEEEES(
E_ID NUMBER(10) PRIMARY KEY, 
E_first VARCHAR2(45) NOT NULL,
E_last VARCHAR2(45),
E_number NUMBER(11) NOT NULL,
E_email VARCHAR2(45) NOT NULL,
E_age INT,
E_gender VARCHAR2(6),
E_dept NUMBER(10),
E_address VARCHAR2(200),
E_joining DATE,
E_leaving DATE
);
DROP TABLE DEPARTMEEENTS;
DROP TABLE MANAGEEERS;

CREATE TABLE MANAGEEERS(
Mgr_ID NUMBER(10),
dept_id NUMBER(10),
FOREIGN KEY(mgr_id) REFERENCES EMPLOYEEEES(E_Id),
FOREIGN KEY(dept_id) REFERENCES DEPARTMEEENTS(dept_id)
);

DROP TABLE MANAGEEERS;

CREATE TABLE DEPARTMEEENTS(
dept_id NUMBER(10) PRIMARY KEY,
dept_name VARCHAR2(45) NOT NULL,
mgr_id NUMBER(10),
dept_location VARCHAR2(40)
);
ALTER TABLE DEPARTMEEENTS DROP COLUMN mgr_id;

CREATE TABLE PROJEEEECTS(
proj_id NUMBER(10) PRIMARY KEY,
proj_name VARCHAR2(45) NOT NULL,
dept_id NUMBER(10),
proj_startDate DATE NOT NULL,
proj_enddate DATE,
proj_budget NUMBER NOT NULL
);

CREATE TABLE PAYROLL(
E_ID NUMBER(10),
bank VARCHAR2(45) NOT NULL,
bank_account VARCHAR2(24) NOT NULL,
Gross_salary NUMBER,
Net_salary NUMBER 
);


---------------------------------------------------Constraints----------------------------------------------------
ALTER TABLE EMPLOYEEEES ADD CONSTRAINT chk_joining_date CHECK (E_joining < SYSDATE); -----this will not ececute because check constraint
--is used with static values and does not support dynamic values.
ALTER TABLE EMPLOYEEEES MODIFY (E_joining DEFAULT SYSDATE);
ALTER TABLE EMPLOYEEEES ADD CONSTRAINT fk_emp_dept_deptid FOREIGN KEY (E_dept) REFERENCES DEPARTMEEENTS (dept_id);
ALTER TABLE EMPLOYEEEES ADD CONSTRAINT chk_emp_gndr CHECK (Upper(E_gender) IN ('MALE','FEMALE') );
ALTER TABLE EMPLOYEEEES ADD CONSTRAINT chk_emp_num CHECK (length(E_number) < 13);
ALTER TABLE EMPLOYEEEES MODIFY E_address VARCHAR2(200) NOT NULL;


ALTER TABLE MANAGEEERS ADD CONSTRAINT fk_mgr_dept_dept_id FOREIGN KEY(dept_id) REFERENCES DEPARTMEEENTS(dept_id);

ALTER TABLE DEPARTMEEENTS ADD CONSTRAINT fk_dept_mgr_mgrID FOREIGN KEY (mgr_id) REFERENCES MANAGEEERS(mgr_id);

ALTER TABLE PROJEEEECTS ADD CONSTRAINT fk_proj_dept_deptID FOREIGN KEY (dept_id) REFERENCES DEPARTMEEENTS(dept_id);

ALTER TABLE PAYROLL ADD CONSTRAINT fk_pyroll_emp_EID FOREIGN KEY (E_id) REFERENCES EMPLOYEEEES(E_id);
ALTER TABLE PAYROLL ADD CONSTRAINT chk_salary CHECK (Net_Salary > 0);


------------------------------------------------Data Insertion & DML-------------------------------------------------------------
--Insert 10+ employees, making sure some salaries, ages, and departments overlap.
--Insertion in EMPLOYEEEES is not possible without inserting values in deptartment as Integrity constraints exist.
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (101, 'Human Resources', 'Lahore');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (102, 'Finance', 'Karachi');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (103, 'IT', 'Islamabad');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (104, 'Marketing', 'Peshawar');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (105, 'Sales', 'Lahore');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (106, 'Customer Support', 'Karachi');

INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (107, 'Research & Development', 'Islamabad');

INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (108, 'Cybersecurity', 'Islamabad');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (109, 'Logistics', 'Quetta');
INSERT INTO DEPARTMEEENTS(dept_id, dept_name, dept_location) 
VALUES (110, 'Procurement', 'Multan');




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

SELECT * FROM MANAGEEERS;
SELECT * FROM DEPARTMEEENTS;
--Insert managers and projects; assign employees to managers.
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (3,101);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (1,103);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (6,105);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (4,107);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (11,110);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (2,102);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (14,106); 
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (4,104);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (33,108);  
INSERT INTO MANAGEEERS (Mgr_ID, dept_id) VALUES (34,109);  

SELECT * FROM MANAGEEERS;
SELECT * FROM DEPARTMEEENTS;
SELECT * FROM EMPLOYEEEES;
INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(501, 'HR Automation System', 101, TO_DATE('2022-01-01','YYYY-MM-DD'), NULL, 1200000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(502, 'Financial Audit Portal', 102, TO_DATE('2021-07-10','YYYY-MM-DD'), TO_DATE('2022-05-15','YYYY-MM-DD'), 2300000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(503, 'AI Chatbot Platform', 103, TO_DATE('2023-02-01','YYYY-MM-DD'), NULL, 1800000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(504, 'Digital Marketing Suite', 104, TO_DATE('2022-11-20','YYYY-MM-DD'), NULL, 900000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(505, 'Sales Optimization Engine', 105, TO_DATE('2022-02-10','YYYY-MM-DD'), NULL, 1100000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(506, 'Customer Ticketing Portal', 106, TO_DATE('2023-01-15','YYYY-MM-DD'), NULL, 900000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(507, 'AI Research Initiative', 107, TO_DATE('2021-09-01','YYYY-MM-DD'), TO_DATE('2023-06-20','YYYY-MM-DD'), 2500000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(508, 'Network Intrusion Detection', 108, TO_DATE('2022-11-05','YYYY-MM-DD'), NULL, 3200000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(509, 'Logistics Tracking Platform', 109, TO_DATE('2020-05-10','YYYY-MM-DD'), NULL, 1500000);

INSERT INTO PROJEEEECTS(proj_id, proj_name, dept_id, proj_startdate, proj_enddate, proj_budget) VALUES
(510, 'Vendor Management Portal', 110, TO_DATE('2022-08-15','YYYY-MM-DD'), NULL, 1000000);


INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (1, 'HBL Bank', 'PK12HBL000123456789', 150000, 130000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (2, 'UBL Bank', 'PK45UBL000654321987', 180000, 150000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (3, 'MCB Bank', 'PK67MCB000678912345', 200000, 170000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (4, 'Meezan Bank', 'PK09MEZ000989123765', 140000, 120000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (5, 'HBL Bank', 'PK12HBL000543216789', 160000, 140000);

INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (6, 'HBL Bank', 'PK12HBL000234567890', 155000, 135000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (7, 'UBL Bank', 'PK45UBL000876543210', 120000, 105000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (8, 'MCB Bank', 'PK67MCB000123459876', 220000, 195000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (9, 'Meezan Bank', 'PK09MEZ000445566778', 180000, 160000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (10, 'Bank Al Habib', 'PK22BAH000667788990', 170000, 150000);

INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (11, 'UBL Bank', 'PK45UBL000334455667', 115000, 99000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (12, 'Meezan Bank', 'PK09MEZ000112233445', 165000, 143000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (13, 'HBL Bank', 'PK12HBL000998877665', 210000, 185000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (14, 'Bank Al Habib', 'PK22BAH000556677889', 145000, 125000);
INSERT INTO PAYROLL(e_id, bank, bank_account, gross_salary, net_salary) VALUES (15, 'MCB Bank', 'PK67MCB000778899001', 150000, 130000);
SELECT * FROM PAYROLL;

INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(16, 'MCB', 'PK11MCB00016745028933', 54000, 52500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (17, 'NBP', 'PK98NBP00017823094567', 51000, 49500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (18, 'Meezan', 'PK09MEZN00182450976321', 70000, 67000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (19, 'HBL', 'PK76HBL00019234587014', 68000, 65500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (20, 'MCB', 'PK22MCB00020458791234', 56000, 54200);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (21, 'UBL', 'PK55UBL00021567890321', 75000, 72000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (22, 'ABL', 'PK87ABL00022456987012', 53000, 51500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES (23, 'NBP', 'PK33NBP00023908457621', 50000, 48500);

INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(24, 'Meezan', 'PK42MEZN00124567890321', 72000, 69000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(25, 'HBL',    'PK59HBL00026890345712', 64000, 62000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(26, 'UBL',    'PK81UBL00027894560123', 56000, 54000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(27, 'MCB',    'PK14MCB00028903456789', 61000, 59000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(28, 'ABL',    'PK73ABL00029567890123', 53000, 51500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(29, 'NBP',    'PK06NBP00030789456123', 58000, 56000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(30, 'Meezan', 'PK21MEZN00131890567412', 69000, 66500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(31, 'HBL',    'PK37HBL00032984567098', 51000, 49500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(32, 'MCB',    'PK88MCB00033890567432', 75000, 72000);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(33, 'UBL',    'PK45UBL00034987560129', 67000, 64500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(34, 'MCB',    'PK88MCB00033890567342', 74000, 72500);
INSERT INTO payroll (E_ID, bank, bank_account, Gross_salary, Net_salary)
VALUES(35, 'UBL',    'PK45UBL00034987560123', 67500, 64500);


--Update employee salaries using conditional logic (e.g., +10% if experience > 5 years).
UPDATE PAYROLL P
SET NET_SALARY = (NET_SALARY + NET_SALARY * 0.1)
WHERE E_id IN 
(SELECT E_id FROM EMPLOYEEEES WHERE 
SYSDATE - E_joining >= 5);

--Delete employees with leaving_date < '2015-01-01'.
DELETE FROM EMPLOYEEEES
WHERE E_leaving < TO_DATE('2015-01-01', 'YYYY-MM-DD');

------------------------------------------------Queries & Joins-------------------------------------------------------------
--Show each employee’s name, department name, and manager name.
SELECT E.E_first || ' ' || E.E_last AS E_name,
Dept_name AS Department_Name, M.mgr_id,
Ms.E_first || ' ' || Ms.E_last AS MANAGER_Name 
FROM EMPLOYEEEES E
INNER JOIN DEPARTMEEENTS D
ON E.E_dept = D.Dept_id
LEFT OUTER JOIN MANAGEEERS M
ON E.E_dept = M.dept_id
LEFT JOIN EMPLOYEEEES Ms
ON M.mgr_id = Ms.E_id;

--First INNER JOIN WILL RETURN ALL ROWS IN EMPLOYEEES ALONG WITH THIER DEPARTMENT DETAILS
--Second JOIN WILL ATTACH MANAGERS ID WITH RESPECTIVE EMPLOYEES ACCORDING TO DEPT_ID MATCH.
--Third JOIN WILL LINK BOVE QUERY WITH EMPLOYEES TABLE AGAIN TO PICK MANAGERS NAME BASED ON E_ID MATCHING.

SELECT * FROM DEPARTMEEENTS;
SELECT * FROM MANAGEEERS;
SELECT * FROM EMPLOYEEEES;

--Display employees whose salary is between 60,000 and 90,000 and have the same department as their manager.
SELECT * FROM EMPLOYEEEES E
WHERE EXISTS (SELECT E_ID FROM PAYROLL P
WHERE Net_salary BETWEEN 60000 AND 90000)
SELECT * FROM PAYROLL;
E.E_id = P.E_id AND 
--Show departments with no employees (use LEFT JOIN or NOT EXISTS).
SELECT * FROM DEPARTMEEENTS D
LEFT JOIN EMPLOYEEEES E
ON D.dept_id = E.E_dept
WHERE E_dept IS NULL;
--Show employees working on more than 1 project (use COUNT + GROUP BY + HAVING).
SELECT * FROM PROJEEEECTS;
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(201, 'HR Analytics System', 101, TO_DATE('2022-01-10','YYYY-MM-DD'), TO_DATE('2022-06-15','YYYY-MM-DD'), 1500000);
(202, 'Recruitment Automation', 101, TO_DATE('2023-03-01','YYYY-MM-DD'), NULL, 900000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(203, 'Cloud Migration Phase I', 102, TO_DATE('2021-11-01','YYYY-MM-DD'), TO_DATE('2022-07-20','YYYY-MM-DD'), 3500000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(204, 'Infrastructure Upgrade', 102, TO_DATE('2023-02-10','YYYY-MM-DD'), NULL, 4200000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(205, 'Financial Dashboard', 103, TO_DATE('2022-04-16','YYYY-MM-DD'), TO_DATE('2022-12-20','YYYY-MM-DD'), 1800000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(206, 'Audit Automation Tool', 103, TO_DATE('2023-05-01','YYYY-MM-DD'), NULL, 1250000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(207, 'Marketing Campaign 2023', 104, TO_DATE('2023-01-05','YYYY-MM-DD'), TO_DATE('2023-08-30','YYYY-MM-DD'), 2600000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(208, 'Brand Revamp Initiative', 104, TO_DATE('2024-02-10','YYYY-MM-DD'), NULL, 3000000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(209, 'Inventory Management System', 105, TO_DATE('2022-03-12','YYYY-MM-DD'), TO_DATE('2023-01-20','YYYY-MM-DD'), 2000000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(210, 'Logistics Optimization', 105, TO_DATE('2023-04-05','YYYY-MM-DD'), NULL, 2500000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(211, 'Customer CRM Upgrade', 106, TO_DATE('2021-09-01','YYYY-MM-DD'), TO_DATE('2022-03-15','YYYY-MM-DD'), 1600000);
INSERT INTO PROJEEEECTS (proj_id, proj_name, dept_id, proj_startDate, proj_enddate, proj_budget) VALUES
(212, 'Support Ticket Automation', 106, TO_DATE('2023-06-10','YYYY-MM-DD'), NULL, 1100000);

--Show employees working on more than 1 project (use COUNT + GROUP BY + HAVING).
SELECT * FROM EMPLOYEEEES
WHERE E_dept IN (
SELECT dept_id from PROJEEEECTS
GROUP BY DEPT_ID
HAVING count(dept_id)>=2);

--Show all employees along with projects they are not assigned to (set operators or NOT IN).
--SELECT * FROM EMPLOYEEEES 
--
--SELECT * FROM EMPLOYEEEES E
--INNER JOIN PROJEEEECTS P  
--ON E.E_dept = P.dept_id
--;

------------------------------------------------Operators & Filtering-------------------------------------------------------------
--Select employees whose first name starts with 'A' or 'B' (LIKE).
SELECT * FROM EMPLOYEEEES 
WHERE E_first LIKE('A%', 'B%');

--Select employees whose salary is not between 50k and 70k.
SELECT * FROM EMPLOYEEEES
WHERE E_id IN (SELECT E_ID FROM PAYROLL
WHERE NET_SALARY BETWEEN 50000 AND 70000);

--Use IN / NOT IN to filter employees by department IDs.
SELECT * FROM EMPLOYEEEES
WHERE E_dept IN (102,103, 104);

--Use logical operators (AND, OR, NOT) to filter multiple conditions.
SELECT * FROM EMPLOYEEEES
WHERE E_dept IN (102,103, 104) AND E_age < 27;

------------------------------------------------Aggregates, Grouping, HAVING-------------------------------------------------------------
--Show total salary per department.
SELECT LISTAGG((E_first || ' ' || E_last), ', ') WITHIN GROUP(ORDER BY E_first) AS EMP, E.E_Dept, SUM(Net_SALARY) AS SALARY_SUM, count(E_dept) AS TOTAL_EMP
FROM EMPLOYEEEES E 
INNER JOIN PAYROLL P
ON E.E_Id = P.E_id
GROUP BY E_dept;

SELECT * FROM EMPLOYEEEES
WHERE e_dept = 109;

SELECT SUM(Net_SALARY) FROM PAYROLL
GROUP BY Dept_id;

SELECT * FROM PAYROLL;

--Show average age per manager, only for managers with >2 employees.
SELECT AVG(E_age), LISTAGG((E_first || ' ' || E_AGE), ',') AS MANAGERS FROM MANAGEEERS M
INNER JOIN EMPLOYEEEES E
ON M.Mgr_id = E.E_id
WHERE E_dept IN (SELECT E_dept FROM EMPLOYEEEES
GROUP BY E_dept
HAVING COUNT(E_dept) > 2);

--Show maximum salary in each department, including department name.
SELECT MAX(NET_SALARY), dept_name, LISTAGG(NET_SALARY, ', ') FROM EMPLOYEEEES E
INNER JOIN PAYROLL P
ON E.E_ID = P.E_ID
LEFT JOIN DEPARTMEEENTS D
ON D.dept_id = E.E_dept
GROUP BY dept_name;

--Show count of employees per department and filter departments with count > 3.
SELECT COUNT(E_dept) AS Total_EMP, e_dept FROM EMPLOYEEEES E
RIGHT JOIN DEPARTMEEENTS D
ON E.E_dept = D.dept_id
GROUP BY E_dept
HAVING COUNT(E_DEPT) > 3;

------------------------------------------------Subqueries-------------------------------------------------------------
--Show employees with salary higher than the average salary of their department.
SELECT * FROM EMPLOYEEEES
WHERE E_ID IN (
SELECT E_ID FROM PAYROLL
WHERE NET_SALARY > (SELECT AVG(NET_SALARY) FROM PAYROLL))
ORDER BY E_ID;
--
--OFFSET 5 ROWS
--FETCH NEXT 5 ROWS ONLY;

--List employees who report to the manager with the highest salary.
SELECT * FROM EMPLOYEEEES E
WHERE E_dept IN (
SELECT dept_id FROM MANAGEEERS 
WHERE mgr_id IN (
SELECT E_ID FROM PAYROLL
WHERE NET_SALARY = (
SELECT MAX(NET_SALARY) FROM PAYROLL P
INNER JOIN MANAGEEERS 
ON mgr_id = E_id
)));

SELECT * FROM PAYROLL;
SELECT * FROM EMPLOYEEEES;

--Show departments without any projects.
SELECT * FROM DEPARTMEEENTS
WHERE dept_id NOT IN (
SELECT dept_id FROM PROJEEEECTS);

--Find employees whose salary is greater than at least 2 managers’ salaries.

SELECT * FROM EMPLOYEEEES
WHERE E_ID IN (
SELECT E_id FROM PAYROLL
WHERE NET_SALARY > (
SELECT NET_SALARY FROM PAYROLL P
INNER JOIN MANAGEEERS M 
ON M.mgr_id = P.E_id)
);

------------------------------------------------Functions-------------------------------------------------------------
--Use character functions to display employee names in UPPERCASE, lowercase, and initials.
SELECT UPPER(E_first || ' ' || E_last) AS E_Upper,
LOWER(E_first || ' ' || E_last) AS E_Lower,
INITCAP(E_first || ' ' || E_last) AS E_Initial
FROM EMPLOYEEEES;

--Use numeric functions to calculate yearly_salary = ROUND(salary * 12, 2).
SELECT E_first || ' ' || E_last E_name, TO_CHAR(ROUND(net_salary * 12, 2),'999,999,999') Yearly_salary FROM EMPLOYEEES E
INNER JOIN PAYROLL P
ON E.E_id = P.E_id;

--Use date functions to calculate experience in years (SYSDATE - joining_date).
SELECT E_first || ' ' || E_last E_name, TRUNC(MONTHS_BETWEEN(SYSDATE, E_joining)/12) Experiance
FROM EMPLOYEEEES;

--Handle NULL leaving_date using NVL/COALESCE.
SELECT E_id, NVL(TO_CHAR(E_leaving), 'Active Employee') AS EMP_status FROM EMPLOYEEEES;

SELECT E_id, NVL2(TO_CHAR(E_leaving),'Discontinued', 'Active Employee') AS EMP_status FROM EMPLOYEEEES;

SELECT COALESCE(NULL, TO_CHAR(E_leaving), TO_CHAR(E_id), 'Active Employee') AS EMP_status FROM EMPLOYEEEES;

--Use conditional CASE to categorize salaries into Low, Medium, High.
SELECT E.*,
CASE 
WHEN NET_SALARY < 90000
THEN 'Low'
WHEN NET_SALARY BETWEEN 90000 AND 120000
THEN 'Medium'
WHEN NET_SALARY > 120000
THEN 'High'
ELSE 'Default'
END AS SALARY_STATUS
FROM PAYROLL P
INNER JOIN EMPLOYEEEES E
ON P.E_id = E.E_id;

------------------------------------------------Set Operators-------------------------------------------------------------
--Use UNION to list all employees and managers in a single list.
--MANAGERS AND EMPLOYEEES ALREADY IN SAME TABLE!

--Use INTERSECT to find employees who are also listed as project leaders.
SELECT * FROM EMPLOYEEES
INTERSECT;
mgr_id,
SELECT  dept_id FROM MANAGEEERS
INTERSECT 

SELECT dept_id FROM DEPARTMEEENTS
INTERSECT
SELECT dept_id FROM PROJEEEECTS;

--Use MINUS/EXCEPT to find employees not assigned to any project.



------------------------------------------------ORDER BY, OFFSET, FETCH-------------------------------------------------------------
--Show top 5 highest-paid employees.
SELECT E.*, NET_SALARY FROM EMPLOYEEEES E
INNER JOIN PAYROLL P
ON E.E_id = P.E_id
ORDER BY NET_SALARY DESC
FETCH FIRST 5 ROWS ONLY;

--Show employees 6-10 by salary descending.
SELECT E.*, NET_SALARY FROM EMPLOYEEEES E
INNER JOIN PAYROLL P
ON E.E_id = P.E_id
ORDER BY NET_SALARY DESC
OFFSET 6 ROWS
FETCH FIRST 4 ROWS WITH TIES;


--Order employees by department, then by joining_date.
SELECT * FROM EMPLOYEEEES
ORDER BY E_dept, E_joining;


------------------------------------------------Indexes-------------------------------------------------------------
--Create an index on EMPLOYEES.salary to speed up queries.
CREATE INDEX idx_payrl_sal
ON PAYROLL(NET_SALARY);


--Create a composite index on (dept_id, joining_date).
CREATE INDEX idx_empp_dept_jdate
ON EMPLOYEEEES(E_dept, E_joining);

--Create a function-based index for case-insensitive last name search.
CREATE INDEX idx_empp_Lname
ON EMPLOYEEEES(LOWER(E_last));  -- ---- -- -- -- LOWER() should be used in the query to use the index.

------------------------------------------------Views-------------------------------------------------------------
--Create a view showing employee name, department, salary, manager name. E.E_first || ' ' || E.E_last AS E_Name, dept_name, Net_salary, EM.E_first || ' ' || EM.E_last AS Manager_Name
CREATE VIEW view_emppp AS
SELECT * 
FROM EMPLOYEEEES E
LEFT JOIN DEPARTMEEENTS D
ON E.E_dept = D.dept_id
LEFT JOIN PAYROLL P
ON P.E_id = E.E_id
LEFT JOIN MANAGEEERS M
ON M.dept_id = E.E_dept
LEFT JOIN EMPLOYEEEES EM
ON EM.E_Id = M.mgr_id;

DROP VIEW view_emppp;
SELECT * FROM view_emppp;

SELECT * FROM DEPARTMEEENTS;

--Create a view with calculated column: yearly_salary = salary * 12.
CREATE VIEW view_payroll AS 
SELECT E_ID, (NET_SALARY * 12) AS YEARLY_SALARY FROM PAYROLL;

--Create a view that only shows employees earning > 70k with WITH CHECK OPTION.
CREATE VIEW view_empp_salary AS 
SELECT * FROM EMPLOYEEEES E
WHERE EXISTS (SELECT * FROM PAYROLL P
WHERE E.E_ID = P.E_id AND NET_SALARY > 70000)
WITH CHECK OPTION;

SELECT * FROM view_empp_salary;

DROP VIEW view_empp_salary;

SELECT E_ID FROM PAYROlL
WHERE NET_SALARY > 70000;

--Create a read-only view for managers to see payroll only.
CREATE VIEW view_mgr_pyroll AS
SELECT P.* FROM EMPLOYEEEES E
INNER JOIN PAYROLL P
ON E.E_id = P.E_id
WITH READ ONLY;

SELECT * FROM view_mgr_pyroll;

------------------------------------------------Sequences-------------------------------------------------------------
--Create a sequence for EMPLOYEES.emp_id starting at 1000.
CREATE SEQUENCE seq_empp_e_id
START WITH 1000;     -----increment by 1 by default

CREATE TABLE demmmo(
dum1 NUMBER);

INSERT INTO demmmo (dum1)
VALUES (seq_empp_e_id.NEXTVAL);

SELECT * FROM demmmo;


--Use NEXTVAL in insert statements for new employees.
--Use NEXTVAL IN place of corresponding column in insert statement.

--Create a formatted project ID using LPAD + sequence: PRJ_0001.
INSERT INTO DEMO(dummy)
VALUES('PRJ_' || LPAD(seq_empp_e_id.NEXTVAL, 4, '0'));

--Demonstrate CURRVAL usage after inserting multiple rows.
CREATE TABLE DEMMO(
dummy VARCHAR2(45));

INSERT INTO DEMMO(dummy)
VALUES('PRJ_' || LPAD(TO_CHAR(seq_empp_e_id.NEXTVAL), 4, '0'));

SELECT * FROM DEMMO;  --THE SEQUNCE STARTS FROM 7 BECUASE THIS IS THE POINT TO WHICH THE CURSOR IS POINTING NOW.

------------------------------------------------SSynonyms-------------------------------------------------------------
--Create a private synonym for PROJECTS and query through it.
CREATE SYNONYM syn_projj
FOR PROJEEEECTS;
SELECT * FROM syn_projj;

--Create a public synonym for EMPLOYEES.
CREATE PUBLIC SYNONYM syn_empl
FOR EMPLOYEEEES;

--Create a synonym for a view and test SELECT statements.
--CREATING SYNONYM FOR VIEW CREATED IN PREVIOUS SENARIOS.
CREATE SYNONYM syn_view_mgr_pyroll
FOR view_mgr_pyroll;

SELECT * FROM syn_view_mgr_pyroll;

--Test renaming underlying object and updating synonym.
CREATE VIEW view_empSimple AS
SELECT E_id FROM EMPLOYEEEES;

CREATE OR REPLACE SYNONYM syn_empS
FOR view_empSimple;

SELECT * FROM syn_empS;

RENAME view_empSimple TO view_empSRENAMED;

SELECT * FROM syn_empS;

CREATE OR REPLACE SYNONYM syn_empS
FOR view_empSRENAMED;

SELECT * FROM syn_empS;

DROP VIEW view_empSimple;
DROP VIEW view_empSRENAMED;

--------------------------------------------Advanced Mixed Scenarios-------------------------------------------------------------
--Create a view showing:
--Employee full name
--Department
--Number of projects assigned
--Average project budget
--Index underlying tables to speed queries.
CREATE VIEW view_adv_snr AS
SELECT E_first || ' ' || E_last AS E_Name, Dept_name, 








--Insert new employees using a sequence-generated emp_id, assign them to projects, then query top 3 employees by project budget via a view + synonym.

--Trigger challenge:
--Whenever salary is updated, insert into AUDIT_LOG (with sequence-generated audit_id).
--Create a view for HR showing last 10 audits.
--Use index on audit_date for faster retrieval.

--Reporting challenge:
--Show departments with avg salary > 75k, total employees, highest-paid employee name, total project budget — all in one query.

--Cleanup challenge:
--Drop a table used in a synonym
--Observe the effect on the view and synonym
--Recreate the table and restore full functionality.




------------------------------------------------Senario#17-------------------------------------------------------------

------------------------------------------------Senario#20-------------------------------------------------------------













