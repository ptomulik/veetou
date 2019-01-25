CREATE OR REPLACE TYPE V2u_Ko_Student_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , job_uuid IN RAW
            , id IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2 := NULL
            , first_name IN VARCHAR2 := NULL
            , last_name IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , job_uuid IN RAW
            , id IN NUMBER
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN VARCHAR2
    );

-- vim: set ft=sql ts=4 sw=4 et:
