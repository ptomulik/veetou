CREATE OR REPLACE TYPE Veetou_Ko_Student_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
            , student_index IN VARCHAR
            , student_name IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Student_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
        , student_index IN VARCHAR
        , student_name IN VARCHAR := NULL
        , first_name IN VARCHAR := NULL
        , last_name IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := student_index;
        SELF.student_name := student_name;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := refined.student_index;
        SELF.student_name := refined.student_name;
        SELF.first_name := refined.first_name;
        SELF.last_name := refined.last_name;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Student_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := preamble.student_index;
        SELF.student_name := preamble.student_name;
        SELF.first_name := preamble.first_name;
        SELF.last_name := preamble.last_name;
        RETURN;
    END;

    MAP MEMBER FUNCTION map_fcn
        RETURN VARCHAR
    IS
    BEGIN
        RETURN student_index;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
