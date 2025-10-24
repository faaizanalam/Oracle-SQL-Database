CREATE TABLE HOUSES (
    h_id      NUMBER,
    h_no       NUMBER UNIQUE,
    h_owner    VARCHAR2(45) NOT NULL, //inline contraint
    h_address  VARCHAR2(45),
    h_area     INT,
    h_rooms    INT CHECK ( h_rooms < 10 ),
    h_price    FLOAT,
    sp_id      NUMBER,
    CONSTRAINT pk_houses PRIMARY KEY ( h_id ),   //Out of line contraint 
    CONSTRAINT p_houses CHECK ( h_price < 5000000 ),
    constraint s_houses_fk_salespersons FOREIGN KEY ( SP_ID ) REFERANCES SALESPERSONS ( SP_ID ) 
    
    CONSTRAINT chk_no CHECK (h_no > 50000)
    
    );
    ALTER TABLE HOUSES ADD CONSTRAINT 
    
    ALTER TABLE HOUSES DROP CONSTRAINT chk_no;