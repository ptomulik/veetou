CREATE OR REPLACE TYPE Veetou_Ko_Semester_Summary_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( semester_code VARCHAR(5 CHAR)
    , semester_number NUMBER(2)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)
    , sheet_id NUMBER(38)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summary_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summary_Typ
            , semester_code IN VARCHAR := NULL
            , semester_number IN NUMBER := NULL
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            , sheet_id IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summary_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summary_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            , sheet IN Veetou_Ko_Sheet_Typ
            , sheet_id IN NUMBER := NULL
      ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Semester_Summary_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Thread_Indices_Typ
    AS TABLE OF NUMBER(2);
/
CREATE OR REPLACE TYPE Veetou_Ko_Semester_Summaries_Typ
    AS TABLE OF Veetou_Ko_Semester_Summary_Typ;
/
CREATE OR REPLACE TYPE Veetou_Ko_Semester_Threads_Typ
    AS TABLE OF Veetou_Ko_Semester_Summaries_Typ;
-- vim: set ft=sql ts=4 sw=4 et:
