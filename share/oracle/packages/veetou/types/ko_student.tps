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
            , preamble IN Veetou_Ko_Preamble_Typ
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN VARCHAR
    );

-- vim: set ft=sql ts=4 sw=4 et:
