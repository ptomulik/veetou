CREATE OR REPLACE TYPE V2u_Semester_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( code VARCHAR2(5 CHAR)
    , id NUMBER(38)
    , start_date DATE
    , end_date DATE

    , CONSTRUCTOR FUNCTION V2u_Semester_t(
              SELF IN OUT NOCOPY V2u_Semester_t
            , code IN VARCHAR2
            , id IN NUMBER := NULL
            , start_date IN DATE := NULL
            , end_date IN DATE := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_id RETURN NUMBER
    , STATIC FUNCTION to_code(semester_id IN NUMBER)
        RETURN VARCHAR2
    , STATIC FUNCTION to_id(semester_code IN VARCHAR2)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Semester_Codes_t
    AS TABLE OF VARCHAR2(5 CHAR);
/
CREATE OR REPLACE TYPE V2u_Semesters_t
    AS TABLE OF V2u_Semester_t;
-- vim: set ft=sql ts=4 sw=4 et:
