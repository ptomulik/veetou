CREATE OR REPLACE TYPE V2u_Ids_t IS TABLE OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_5Ids_t IS VARRAY(5) OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Integers_t IS TABLE OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Ints2_t IS TABLE OF NUMBER(2);
/
CREATE OR REPLACE TYPE V2u_Ints4_t IS TABLE OF NUMBER(4);
/
CREATE OR REPLACE TYPE V2u_Subj_Grades_t IS TABLE OF VARCHAR2(10);
/
CREATE OR REPLACE TYPE V2u_Subj_Codes_t IS TABLE OF VARCHAR2(32);
/
CREATE OR REPLACE TYPE V2u_Subj_20Grades_t IS VARRAY(20) OF VARCHAR2(10);
/
CREATE OR REPLACE TYPE V2u_Subj_20Codes_t IS VARRAY(20) OF VARCHAR2(32);

-- vim: set ft=sql ts=4 sw=4 et:
