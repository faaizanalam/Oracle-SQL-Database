//DDL
CREATE TABLE Employee(
ID_Number NUMBER(8),
Name CHAR(20),
Role VARCHAR(8),
Phone_Number NUMBER(13)
);

CREATE TABLE People(
emp_id VARCHAR(12),
"Date" DATE,
Salary INTEGER 
);

RENAME People TO Individuals

/*
DRL/DQL
//select * from Employee;
select * from People;

*/

//DDL
 ALTER TABLE Employee ADD GENDER VARCHAR2(8);
 ALTER TABLE Employee DROP COLUMN Phone_Number;
 ALTER TABLE Employee MODIFY ID_Number NUMBER(9); 



 //SELECT * FROM Employee;
 
 DROP TABLE Individuals;
 
 
 
 