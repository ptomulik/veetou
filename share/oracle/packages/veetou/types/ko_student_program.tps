CREATE OR REPLACE TYPE Veetou_Ko_Student_Program_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , studies_specialty VARCHAR(256 CHAR)
    , semesters Veetou_Ko_Semester_Summlog_Typ

    , CONSTRUCTOR FUNCTION Veetou_Ko_Student_Program_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Program_Typ
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , studies_specialty IN VARCHAR := NULL
            , semesters Veetou_Ko_Semester_Summlog_Typ := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Student_Program_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Program_Typ
            , sheet_info IN Veetou_Ko_Sheet_Info_Typ
      ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Student_Program_Typ)
            RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
