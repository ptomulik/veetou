CREATE OR REPLACE TYPE V2u_Ko_Student_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Student_t)
        RETURN INTEGER

    , MEMBER FUNCTION dup_with(
              new_id IN NUMBER
            , new_sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t

    , MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
            , new_sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t
    );

-- vim: set ft=sql ts=4 sw=4 et:
