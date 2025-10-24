//*//Creating a table 
CREATE TABLE departments (
    dpt_id      NUMBER,
    dpt_name    VARCHAR2(100),
    dpt_members VARCHAR2(100)
);

CREATE TABLE employees (
    emp_id     NUMBER,
    first_name VARCHAR2(100),
    last_name  VARCHAR2(100),
    gender     CHAR(6),
    salary     INT
);

desc departments
desc employees
*//

--Salesperson
--Cars
--Sales

CREATE TABLE salespersons (
    sp_id         NUMBER,
    first_name   VARCHAR2(100),
    last_name    VARCHAR2(100),
    joining_date DATE,
    leaving_date DATE,
    dob          DATE,
    salary       NUMBER
);

CREATE TABLE Vehicles (
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

desc salespersons
desc vehicles
desc sales

CREATE TABLE HOUSES (
    h_id      NUMBER,
    h_no      NUMBER UNIQUE,
    h_owner   VARCHAR2(45) NOT NULL, //inline contraint
    h_address VARCHAR2(45),
    h_area    INT,
    h_rooms   INT CHECK (h_rooms<10),
    h_price   FLOAT,
    sp_id     FLOAT,
    CONSTRAINT PK_HOUSES PRIMARY KEY(h_id),   //Out of line contraint 
    CONSTRAINT P_HOUSES CHECK (h_price < 5000000),
    CONSTRAINT S_HOUSES_FK_SALESPERSONS FOREIGN KEY (sp_id) REFERANCES salespersons(sp_id) 
    );

desc HOUSES;

// drop TABLE HOUSES;

//TRUNCATE TABLE HOUSES;
