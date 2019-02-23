CREATE OR REPLACE TYPE V2u_Ko_Specialty_Map_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , map_id NUMBER(38)
    , matching_score NUMBER(38)
    , highest_score NUMBER(38)
    , selected NUMBER(1)
    , reason VARCHAR2(20)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , map_program_code VARCHAR2(32 CHAR)
    , map_modetier_code VARCHAR2(32 CHAR)
    , map_field_code VARCHAR2(32 CHAR)
    , map_specialty_code VARCHAR2(32 CHAR)
    , semester_number NUMBER(2)
    , expr_semester_number VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(5 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , ects_mandatory NUMBER(4)
    , expr_ects_mandatory VARCHAR2(256)
    , ects_other NUMBER(4)
    , expr_ects_other VARCHAR2(256)
    , ects_total NUMBER(4)
    , expr_ects_total VARCHAR2(256)

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map IN V2u_Specialty_Map_t
            , matching_score IN NUMBER
            , highest_score NUMBER
            , selected NUMBER
            , reason VARCHAR2
            ) RETURN SELF AS RESULT
    );

-- vim: set ft=sql ts=4 sw=4 et:
