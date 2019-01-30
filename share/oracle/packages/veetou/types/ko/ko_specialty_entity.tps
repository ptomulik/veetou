CREATE OR REPLACE TYPE V2u_Ko_Specialty_Entity_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Distinct_t
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , semester_number NUMBER(2)
    , semester_code VARCHAR2(5 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Entity_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Entity_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
        RETURN V2u_Ko_Specialty_Entity_t

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Specialty_Entities_t
    AS TABLE OF V2u_Ko_Specialty_Entity_t;

-- vim: set ft=sql ts=4 sw=4 et:
