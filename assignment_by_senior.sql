
CREATE TABLE department(
deptid      NUMBER GENERATED ALWAYS AS IDENTITY,
dname       VARCHAR2(10),
CONSTRAINT PK_DEPARTMENT_DEPTID PRIMARY KEY(deptid));

INSERT INTO department(dname) values('manager');
INSERT INTO department(dname) values('accountant');

CREATE TABLE employee(
empid           NUMBER GENERATED ALWAYS AS IDENTITY,
ename           VARCHAR2(10),
email           VARCHAR2(10),
mobile_no       VARCHAR2(10),
joining_date    DATE,
city            VARCHAR2(10),
salary          NUMBER,
deptid          NUMBER,
CONSTRAINT PK_EMPLOYEE_EMPID PRIMARY KEY(empid),
CONSTRAINT FK_EMPLOYEE_DEPTID FOREIGN KEY(deptid) REFERENCES department(deptid));




--####################################################################################
--SQL:

--1. Write a query to list all the employees with their department name.

SELECT empid,ename,email,mobile_no,joining_date,city,salary,dname
FROM employee INNER JOIN department
USING(deptid);

--2. Write a query to display employees with salary more than <3000>.

SELECT empid,ename,email,mobile_no,joining_date,city,salary
FROM employee
WHERE salary>3000;

--3. Write a query to display employees joined after entered <17-NOV-81>.

SELECT empid,ename,email,mobile_no,joining_date,city,salary
FROM epmloyee
WHERE joining_date > '17-NOV-81';

--------------------------------------------------
SELECT empid,ename,email,mobile_no,joining_date,city,salary
FROM epmloyee
WHERE joining_date > date '1981-11-17';

--4. create new table employee1 with column employee_name, employee_mobile_no,email, copy data from employee table.

CREATE TABLE employee1 as
    SELECT ename,mobile_no,email FROM employee;

--5. add address column in employee1 table.

ALTER TABLE employee
ADD address VARCHAR2(10);

--6. modify  employee_mobile_no column of employee1 table and change data type.

ALTER TABLE employee
MODIFY mobile_no NUMBER;

----------------------------------------------------------------------------------------------------------------
ALTER TABLE employee
ADD temp_col NUMBER;

UPDATE employee
SET temp_col = to_number(mobile_no);

ALTER TABLE employee
DROP COLUMN mobile_no;

ALTER TABLE employee
RENAME COLUMN temp_col to mobile_no;


--PL SQL:
SET SERVEROUTPUT ON;

--1. Write a procedure to add department with output variable "result".
CREATE OR REPLACE PROCEDURE add_department( result OUT department.dname%type,p_input department.deptid%type ) AS

BEGIN
    SELECT dname INTO result
    FROM department
    WHERE deptid=p_input;
END;

DECLARE
    v_result department.dname%type;
BEGIN
    add_department(v_result,23);
    DBMS_OUTPUT.put_line(v_result);
END;


--2. Write a procedure to add Employee with output variable "result"
CREATE OR REPLACE PROCEDURE add_emplyee( p_empid NUMBER,result OUT employee.ename%TYPE) AS

BEGIN 
    SELECT ename INTO result
    FROM employee
    WHERE empid = p_empid;
END;

DECLARE
    v_result employee.ename%type;
BEGIN
    add_department(v_result,1);
    DBMS_OUTPUT.put_line(v_result);
END;

--3 Write a procedure to update Employees department (Input -> empid, department_name)
CREATE OR REPLACE PROCEDURE update_employee(p_deptid department.deptid%type,p_dname department.dname%type) AS
    e_no_data_found EXCEPTION;
    BEGIN
            UPDATE department
            SET dname=p_dname
            WHERE deptid=p_deptid;
            
            IF SQL%NOTFOUND THEN RAISE e_no_data_found;
            END IF;
            
            EXCEPTION 
                WHEN e_no_data_found THEN dbms_output.put_line('data not found');
    END;
    
DECLARE
    v_deptid department.deptid%type :=&v_deptid;
    v_dname department.dname%type :='&v_dname' ;

BEGIN
     update_employee(v_deptid,v_dname);
    
END;

SELECT * FROM department;

-- 4.Write a function that returns Employee Department name based on emp id

CREATE OR REPLACE FUNCTION function_name (p_empid employee.empid%type) RETURN department.dname%type IS

    v_dname department.dname%type;
BEGIN
    SELECT dname INTO v_dname 
    FROM employee INNER JOIN department
    USING (deptid)
    WHERE empid=p_empid;
    
    return v_dname;
END;


begin
    DBMS_OUTPUT.put_line(function_name(1));
END;

--5. Write a function that returns Employee joining date in (10-Mar-2021) format based on emp_id 

CREATE OR REPLACE FUNCTION emp_joinint_date(p_empid employee.empid%type) RETURN DATE IS

v_date DATE;
BEGIN
    SELECT joining_date INTO v_date 
    FROM employee
    WHERE empid=p_empid;
    
    return v_date;
    
    
END;

DECLARE
    v_date DATE;
BEGIN
    v_date:=emp_joinint_date(10);
    dbms_output.put_line(to_date(v_date,'DD-MON-YYYY'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.put_line('no data found');
END;

