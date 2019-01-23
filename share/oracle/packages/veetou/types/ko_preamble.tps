CREATE OR REPLACE TYPE V2u_Ko_Preamble_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
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
            , job_uuid IN RAW
            , id IN NUMBER
            , studies_modetier IN VARCHAR := NULL
            , title IN VARCHAR := NULL
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , semester_code IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , semester_number IN NUMBER := NULL
            , studies_specialty IN VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Preambles_t
    AS TABLE OF V2u_Ko_Preamble_t;

-- vim: set ft=sql ts=4 sw=4 et:
