CREATE TABLE class(
c_name VARCHAR2(45),
c_students INT,
c_id INT
);

CREATE TABLE STUDENTS(
s_id NUMBER PRIMARY KEY,
s_firstname VARCHAR2(50) NOT NULL,
s_lastname VARCHAR2(50) NOT NULL,
s_gender CHAR(6),
s_age INT,
s_class VARCHAR(15),
s_number NUMBER(13)


--CONSTRAINT s_age_student CHECK (s_age > 2 )
);


--*******************************ADD**************************
ALTER TABLE STUDENTS ADD DOB DATE;
ALTER TABLE STUDENTS ADD CONSTRAINT age_student CHECK (s_age < 50);
ALTER TABLE CLASS ADD CONSTRAINT pk_class PRIMARY KEY (c_id);

--*******************************MODIFY**************************
ALTER TABLE STUDENTS MODIFY s_number NOT NULL;
ALTER TABLE STUDENTS DROP COLUMN DOB;
ALTER TABLE STUDENTS RENAME s_number TO s_phone; --won't work
desc students;


desc CLASS;
desc STUDENTS;




CREATE TABLE teacher (
    t_id      NUMBER(8),
    t_name    VARCHAR2(45),
    s_id      NUMBER(8),
    t_age     INT,
    t_joining DATE,
    t_salary  NUMBER
);

CREATE TABLE subject (
    s_id   NUMBER(8),
    s_name VARCHAR2(40),
    t_id   NUMBER(8)
);


---ALTER OPERATIONS

ALTER TABLE Teacher ADD CONSTRAINT PK_TEACHER PRIMARY KEY (t_id);
ALTER TABLE Teacher MODIFY t_name NOT NULL;
ALTER TABLE subject ADD CONSTRAINT PK_Subject PRIMARY KEY (s_id);
ALTER TABLE TEACHER MODIFY s_id NUMBER(8); 
ALTER TABLE Teacher ADD CONSTRAINT FK_Stubject FOREIGN KEY(s_id) REFERENCES subject (s_id);
ALTER TABLE Teacher MODIFY t_age NUMBER(3); 

ALTER TABLE Subject ADD CONSTRAINT FK_Teacher FOREIGN KEY (t_id) REFERENCES Teacher (t_id);
ALTER TABLE Teacher MODIFY t_age NOT NULL;
ALTER TABLE Subject MODIFY s_name NOT NULL;


desc  TEACHER;
desc Subject;






