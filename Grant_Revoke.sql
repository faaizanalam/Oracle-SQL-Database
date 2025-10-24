CREATE TABLE salespersons (
    sp_id        NUMBER PRIMARY KEY,
    first_name   VARCHAR2(100),
    last_name    VARCHAR2(100),
    joining_date DATE,
    leaving_date DATE,
    dob          DATE,
    salary       NUMBER
);

GRANT SELECT, UPDATE ON salespersons to dba;
GRANT ALL ON VEHICLEs TO testdba;

REVOKE SELECT, UPDATE ON salespersons from dba;
REVOKE ALL ON vehicles from testdba;