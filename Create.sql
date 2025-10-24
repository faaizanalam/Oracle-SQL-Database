CREATE TABLE employees(
    emp_id        NUMBER PRIMARY KEY,
    first_name   VARCHAR2(100),
    last_name    VARCHAR2(100),
    joining_date DATE,
    leaving_date DATE,
    dob          DATE,
    salary       NUMBER
);

Create TABLE Vehicles (
    v_id NUMBER,
    engine_number NUMBER,
    make VARCHAR2(100),
    model VARCHAR2(100),
    year VARCHAR2(100),
    price VARCHAR(100)
);

CREATE TABLE sales (
    s_id          NUMBER,
    sale_date     DATE,
    sp_id         NUMBER,
    v_id          NUMBER,
    sale_amt      NUMBER,
    comission_amt NUMBER
);


