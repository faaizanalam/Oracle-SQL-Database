CREATE TABLE salespersons (
    sp_id        NUMBER PRIMARY KEY,
    first_name   VARCHAR2(100),
    last_name    VARCHAR2(100),
    joining_date DATE,
    leaving_date DATE,
    dob          DATE,
    salary       NUMBER
);
desc salespersons;

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

--CREATE TABLE HOUSES (
--    h_id      NUMBER,
--    h_no       NUMBER UNIQUE,
--    h_owner    VARCHAR2(45) NOT NULL, //inline contraint
--    h_address  VARCHAR2(45),
--    h_area     INT,
--    h_rooms    INT CHECK ( h_rooms < 10 ),
--    h_price    FLOAT,
--    sp_id      NUMBER,
--    CONSTRAINT pk_houses PRIMARY KEY ( h_id ),   //Out of line contraint 
--    CONSTRAINT p_houses CHECK ( h_price < 5000000 ),
--    constraint s_houses_fk_salespersons FOREIGN KEY ( SP_ID ) REFERANCES SALESPERSONS ( SP_ID ) 
--    );
--
--desc HOUSES;
--

// drop TABLE HOUSES;

//TRUNCATE TABLE HOUSES;




GRANT SELECT, UPDATE ON salespersons to dba;
GRANT ALL ON VEHICLEs TO testdba;

REVOKE SELECT, UPDATE ON salespersons from dba;
REVOKE ALL ON vehicles from testdba;


--*************************comments***************************

CREATE TABLE sample(
sam1 NUMBER,
sam2 VARCHAR2(45),
sam3 INT,
sam4 DATE
);


COMMENT ON TABLE sample IS 'This is a sample table';
COMMENT ON COLUMN sample.sam1 IS 'This is a comment on a column 1 of sample table';







