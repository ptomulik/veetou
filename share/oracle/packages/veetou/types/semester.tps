CREATE OR REPLACE TYPE V2u_Semester_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( code VARCHAR2(5 CHAR)
    , start_date DATE
    , end_date DATE

    , CONSTRUCTOR FUNCTION V2u_Semester_t(
              SELF IN OUT NOCOPY V2u_Semester_t
            , id IN NUMBER := NULL
            , code IN VARCHAR2
            , start_date IN DATE
            , end_date IN DATE
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    , MEMBER FUNCTION cmp_val(other IN V2u_Semester_t)
        RETURN INTEGER
    , STATIC FUNCTION to_code(semester_id IN NUMBER)
        RETURN VARCHAR2
    , STATIC FUNCTION to_id(semester_code IN VARCHAR2)
        RETURN NUMBER
    , STATIC FUNCTION sem_add(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    , STATIC FUNCTION sem_sub(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    );
/
CREATE OR REPLACE TYPE V2u_Semesters_t
    AS TABLE OF V2u_Semester_t;

-- vim: set ft=sql ts=4 sw=4 et:
