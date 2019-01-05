CREATE OR REPLACE TYPE V2u_Ko_Semester_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Distinct_t
    ( semester_code VARCHAR2(5 CHAR)
    , semester_number NUMBER(2)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_t
            , id NUMBER := NULL
            , job_uuid RAW
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , sheet IN V2u_Ko_Sheet_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    , MEMBER FUNCTION cmp_val(other IN V2u_Ko_Semester_t)
        RETURN INTEGER
    , MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
        RETURN V2u_Ko_Semester_t
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Semesters_t
    AS TABLE OF V2u_Ko_Semester_t;
/
CREATE OR REPLACE TYPE V2u_Ko_Semester_Tables_t
    AS TABLE OF V2u_Ko_Semesters_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
