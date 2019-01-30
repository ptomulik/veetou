CREATE OR REPLACE TYPE V2u_Ko_Preamble_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , studies_modetier VARCHAR2(100 CHAR)
    , title VARCHAR2(256 CHAR)
    , student_index VARCHAR2(32 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , semester_code VARCHAR2(5 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR2(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Preamble_t(
              SELF IN OUT NOCOPY V2u_Ko_Preamble_t
            , job_uuid IN RAW
            , id IN NUMBER
            , studies_modetier IN VARCHAR2 := NULL
            , title IN VARCHAR2 := NULL
            , student_index IN VARCHAR2 := NULL
            , first_name IN VARCHAR2 := NULL
            , last_name IN VARCHAR2 := NULL
            , student_name IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , semester_number IN NUMBER := NULL
            , studies_specialty IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Preambles_t
    AS TABLE OF V2u_Ko_Preamble_t;

-- vim: set ft=sql ts=4 sw=4 et:
