CREATE OR REPLACE TYPE V2u_Ko_Student_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , student_index IN VARCHAR
            , student_name IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN VARCHAR
    );

-- vim: set ft=sql ts=4 sw=4 et:
