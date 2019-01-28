CREATE OR REPLACE TYPE V2u_Ko_Semester_Instance_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , semester_code VARCHAR2(5 CHAR)
    , semester_number NUMBER(2)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)
    , sheet_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Semester_Instance_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_Instance_t
            , job_uuid RAW
            , id NUMBER
            , semester_code IN VARCHAR2 := NULL
            , semester_number IN NUMBER := NULL
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            , sheet_id IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Semester_Instance_t)
        RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Thread_Indices_t
    AS TABLE OF NUMBER(2);
/
CREATE OR REPLACE TYPE V2u_Ko_Semester_Instances_t
    AS TABLE OF V2u_Ko_Semester_Instance_t;
/
CREATE OR REPLACE TYPE V2u_Ko_Semester_Threads_t
    AS TABLE OF V2u_Ko_Semester_Instances_t;
-- vim: set ft=sql ts=4 sw=4 et:
