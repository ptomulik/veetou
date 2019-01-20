CREATE OR REPLACE TYPE Veetou_Semester_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( code VARCHAR(5 CHAR)
    , start_date DATE
    , end_date DATE

    , CONSTRUCTOR FUNCTION Veetou_Semester_Typ(
              SELF IN OUT NOCOPY Veetou_Semester_Typ
            , code IN VARCHAR
            , start_date IN DATE := NULL
            , end_date IN DATE := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION id RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Semester_Codes_Typ
    AS TABLE OF VARCHAR(5 CHAR);
/
CREATE OR REPLACE TYPE Veetou_Semesters_Typ
    AS TABLE OF Veetou_Semester_Typ;
-- vim: set ft=sql ts=4 sw=4 et:
