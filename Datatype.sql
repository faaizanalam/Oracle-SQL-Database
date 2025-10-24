CREATE TABLE employeees(
    emp_id        NUMBER PRIMARY KEY,
    first_name   VARCHAR2(100),
    last_name    VARCHAR2(100),
    joining_date DATE,
    leaving_date DATE,
    dob          DATE,
    salary       INT
);

ALTER TABLE employeees ADD CONSTRAINT pk_emp PRIMARY KEY (emp_id);