CREATE OR REPLACE TYPE Veetou_Ko_Preamble_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , studies_modetier VARCHAR(256 CHAR)
    , title VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , semester_code VARCHAR(5 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Preamble_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Preamble_Typ
            , id NUMBER := NULL
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

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Preamble_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Preambles_Typ
    AS TABLE OF Veetou_Ko_Preamble_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
