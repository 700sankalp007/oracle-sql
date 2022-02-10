--SEQUENCE

SELECT *
FROM rec;
    
TRUNCATE TABLE rec;

commit;

--creating seequence

CREATE SEQUENCE rec_id 
INCREMENT BY 1
MAXVALUE 50
MINVALUE 1
CACHE 20;

INSERT INTO rec values(rec_id.NEXTVAL,'record_1');
INSERT INTO rec values(rec_id.NEXTVAL,'record_2');
INSERT INTO rec values(rec_id.NEXTVAL,'record_3');
INSERT INTO rec values(rec_id.NEXTVAL,'record_4');
INSERT INTO rec values(rec_id.NEXTVAL,'record_5');

--ALTER SEQUENCE 

ALTER SEQUENCE rec_id MAXVALUE 10;
ALTER SEQUENCE rec_id MINVALUE 0;

TRUNCATE TABLE rec;
commit;

--Droping sequence

DROP SEQUENCE rec_id;

-###############################################################

CREATE SEQUENCE sec_temp
INCREMENT BY 1
MINVALUE 0
MAXVALUE 15;

INSERT INTO rec values(sec_temp.NEXTVAL,'record_1');
INSERT INTO rec values(sec_temp.NEXTVAL,'record_2');
INSERT INTO rec values(sec_temp.NEXTVAL,'record_3');
INSERT INTO rec values(sec_temp.NEXTVAL,'record_4');
INSERT INTO rec values(sec_temp.NEXTVAL,'record_5');

DROP SEQUENCE sec_temp;

--we can give sequence in create statement as auto fill
GENERATED [ALWAYS | BY DEFAULT [ON NULL]] AS IDENTITY [START WITH <starting_number>]

CREATE TABLE emp(
eid	NUMBER  GENERETED ALWAYS AS IDENTITY,
ename	VARCHAR2(10));


CREATE TABLE tem(
tid     NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT PK_TEMP_TD PRIMARY KEY );






