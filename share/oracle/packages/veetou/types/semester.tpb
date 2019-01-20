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

-- vim: set ft=sql ts=4 sw=4 et:
