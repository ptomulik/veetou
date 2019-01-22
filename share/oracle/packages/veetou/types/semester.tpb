CREATE OR REPLACE TYPE BODY V2u_Semester_t AS
    CONSTRUCTOR FUNCTION V2u_Semester_t(
          SELF IN OUT NOCOPY V2u_Semester_t
        , code IN VARCHAR
        , id IN NUMBER := NULL
        , start_date IN DATE := NULL
        , end_date IN DATE := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.code := code;
        IF id IS NULL THEN
            SELF.id := V2u_Util.To_Semester_Id(code);
        ELSE
            SELF.id := id;
        END IF;
        SELF.start_date := start_date;
        SELF.end_date := end_date;
        RETURN;
    END;

    MAP MEMBER FUNCTION map_id
        RETURN NUMBER
    IS
    BEGIN
        RETURN id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
