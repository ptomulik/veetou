CREATE OR REPLACE TYPE V2u_Ko_Student_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Distinct_t
    ( student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
            RETURN V2u_Ko_Student_t
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
