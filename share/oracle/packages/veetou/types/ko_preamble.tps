CREATE OR REPLACE TYPE V2u_Ko_Preamble_t FORCE AUTHID CURRENT_USER AS OBJECT
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Preamble_t(
              SELF IN OUT NOCOPY V2u_Ko_Preamble_t
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

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Preamble_t)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Preambles_t
    AS TABLE OF V2u_Ko_Preamble_t;

-- vim: set ft=sql ts=4 sw=4 et:
