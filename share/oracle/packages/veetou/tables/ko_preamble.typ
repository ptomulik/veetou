CREATE OR REPLACE TYPE Veetou_Ko_Preamble_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( studies_modetier VARCHAR(256 CHAR)
    , title VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , semester_code VARCHAR(32 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , semester_number NUMBER(4)
    , studies_specialty VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Preamble_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Preamble_Typ
            , studies_modetier VARCHAR := NULL
            , title VARCHAR := NULL
            , student_index VARCHAR := NULL
            , first_name VARCHAR := NULL
            , last_name VARCHAR := NULL
            , student_name VARCHAR := NULL
            , semester_code VARCHAR := NULL
            , studies_field VARCHAR := NULL
            , semester_number NUMBER := NULL
            , studies_specialty VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Preamble_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Preamble_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Preamble_Typ
        , studies_modetier VARCHAR := NULL
        , title VARCHAR := NULL
        , student_index VARCHAR := NULL
        , first_name VARCHAR := NULL
        , last_name VARCHAR := NULL
        , student_name VARCHAR := NULL
        , semester_code VARCHAR := NULL
        , studies_field VARCHAR := NULL
        , semester_number NUMBER := NULL
        , studies_specialty VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.studies_modetier := studies_modetier;
        SELF.title := title;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.semester_code := semester_code;
        SELF.studies_field := studies_field;
        SELF.semester_number := semester_number;
        SELF.studies_specialty := studies_specialty;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
