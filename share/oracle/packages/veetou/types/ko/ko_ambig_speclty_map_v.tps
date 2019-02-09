CREATE OR REPLACE TYPE V2u_Ko_Ambig_Speclty_Map_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , map_count NUMBER(38)
    , map_ids V2u_Ids_t
    , matching_scores V2u_Integers_t
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , semester_number NUMBER(2)
    , semester_code VARCHAR2(5 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Ambig_Speclty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Ambig_Speclty_Map_V_t
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , map_count IN NUMBER
            , map_ids IN V2u_Ids_t
            , matching_scores IN V2u_Integers_t
            , university VARCHAR2
            , faculty VARCHAR2
            , studies_modetier VARCHAR2
            , studies_field VARCHAR2
            , studies_specialty VARCHAR2
            , semester_number NUMBER
            , semester_code VARCHAR2
            , ects_mandatory NUMBER
            , ects_other NUMBER
            , ects_total NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Ambig_Speclty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Ambig_Speclty_Map_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map_count IN NUMBER
            , map_ids IN V2u_Ids_t
            , matching_scores IN V2u_Integers_t
            ) RETURN SELF AS RESULT

--    , ORDER MEMBER FUNCTION cmp_with (
--              other V2u_Ko_Ambig_Speclty_Map_V_t
--            ) RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
