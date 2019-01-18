CREATE OR REPLACE TYPE Veetou_Semester_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( code VARCHAR(32 CHAR)
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
CREATE OR REPLACE TYPE BODY Veetou_Semester_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Semester_Typ(
          SELF IN OUT NOCOPY Veetou_Semester_Typ
        , code IN VARCHAR
        , start_date IN DATE := NULL
        , end_date IN DATE := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.code := code;
        SELF.start_date := start_date;
        SELF.end_date := end_date;
        RETURN;
    END;

    MAP MEMBER FUNCTION id
        RETURN NUMBER
    IS
    BEGIN
        RETURN VEETOU_Util.To_Semester_Id(code);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Semester_Codes_Typ
    AS TABLE OF VARCHAR(32);
/
CREATE OR REPLACE TYPE Veetou_Semesters_Typ
    AS TABLE OF Veetou_Semester_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
