CREATE OR REPLACE TYPE V2u_Ko_Sheet_Info_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , semester_code VARCHAR(5 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR(256 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Info_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_Info_t
            , university IN VARCHAR := NULL
            , faculty IN VARCHAR := NULL
            -- preamble
            , studies_modetier IN VARCHAR := NULL
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , semester_code IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , semester_number IN NUMBER := NULL
            , studies_specialty IN VARCHAR := NULL
            -- sheet
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Info_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_Info_t
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet IN V2u_Ko_Sheet_t
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(
                other IN V2u_Ko_Sheet_Info_t
            ) RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
