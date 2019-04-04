CREATE OR REPLACE TYPE V2u_Ids_t IS TABLE OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Dz_Ids_t IS TABLE OF NUMBER(10);
/
CREATE OR REPLACE TYPE V2u_Integers_t IS TABLE OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Ints8_t IS TABLE OF NUMBER(8);
/
CREATE OR REPLACE TYPE V2u_Chars1_t IS TABLE OF CHAR(1 CHAR);
/
CREATE OR REPLACE TYPE V2u_5Chars1_t IS VARRAY(5) OF CHAR(1 CHAR);
/
CREATE OR REPLACE TYPE V2u_Chars3_t IS TABLE OF CHAR(3 CHAR);
/
CREATE OR REPLACE TYPE V2u_5Chars3_t IS VARRAY(5) OF CHAR(3 CHAR);
/
CREATE OR REPLACE TYPE V2u_Vchars1K_t IS TABLE OF VARCHAR2(1024 CHAR);
/
CREATE OR REPLACE TYPE V2u_5Vchars1K_t IS VARRAY(5) OF VARCHAR2(1024 CHAR);
/
CREATE OR REPLACE TYPE V2u_5Ids_t IS VARRAY(5) OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_20Ids_t IS VARRAY(20) OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Dz_5Ids_t IS VARRAY(5) OF NUMBER(10);
/
CREATE OR REPLACE TYPE V2u_Dz_20Ids_t IS VARRAY(20) OF NUMBER(10);
/
CREATE OR REPLACE TYPE V2u_Ints2_t IS TABLE OF NUMBER(2);
/
CREATE OR REPLACE TYPE V2u_Ints4_t IS TABLE OF NUMBER(4);
/
CREATE OR REPLACE TYPE V2u_Ints10_t IS TABLE OF NUMBER(10);
/
CREATE OR REPLACE TYPE V2u_Semester_Codes_t IS TABLE OF VARCHAR2(5 CHAR);
/
CREATE OR REPLACE TYPE V2u_Semester_5Codes_t IS VARRAY(5) OF VARCHAR2(5 CHAR);
/
CREATE OR REPLACE TYPE V2u_Semester_20Codes_t IS VARRAY(20) OF VARCHAR2(5 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_Grades_t IS TABLE OF VARCHAR2(10 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_5Grades_t IS VARRAY(5) OF VARCHAR2(10 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_20Grades_t IS VARRAY(20) OF VARCHAR2(10 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_5Codes_t IS VARRAY(5) OF VARCHAR2(32 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_Codes_t IS TABLE OF VARCHAR2(32 CHAR);
/
CREATE OR REPLACE TYPE V2u_Subj_20Codes_t IS VARRAY(20) OF VARCHAR2(32 CHAR);
/
CREATE OR REPLACE TYPE V2u_Program_Codes_t IS TABLE OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Program_5Codes_t IS VARRAY(5) OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Program_20Codes_t IS VARRAY(20) OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Prot_Codes_t IS TABLE OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Prot_5Codes_t IS VARRAY(5) OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Prot_20Codes_t IS VARRAY(20) OF VARCHAR2(20 CHAR);
/
CREATE OR REPLACE TYPE V2u_Dates_t IS TABLE OF DATE;
/
CREATE OR REPLACE TYPE V2u_5Dates_t IS VARRAY(5) OF DATE;
/
CREATE OR REPLACE TYPE V2u_20Dates_t IS VARRAY(20) OF DATE;

-- vim: set ft=sql ts=4 sw=4 et:
