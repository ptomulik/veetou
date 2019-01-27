CREATE OR REPLACE TYPE V2u_Ko_Sheet_Info_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , student_index VARCHAR2(32 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , semester_code VARCHAR2(5 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR2(256 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Info_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_Info_t
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            -- preamble
            , studies_modetier IN VARCHAR2 := NULL
            , student_index IN VARCHAR2 := NULL
            , first_name IN VARCHAR2 := NULL
            , last_name IN VARCHAR2 := NULL
            , student_name IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , semester_number IN NUMBER := NULL
            , studies_specialty IN VARCHAR2 := NULL
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
