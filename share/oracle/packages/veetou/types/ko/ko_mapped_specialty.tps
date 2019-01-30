CREATE OR REPLACE TYPE V2u_Ko_Mapped_Specialty_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , specent_id NUMBER(38)
    , specmap_id NUMBER(38)
    , matching_score NUMBER(38)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , mapped_program_code VARCHAR2(32 CHAR)
    , mapped_modetier_code VARCHAR2(32 CHAR)
    , mapped_field_code VARCHAR2(32 CHAR)
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Mapped_Specialty_t
            , job_uuid IN RAW
            , specent_id IN NUMBER
            , specmap_id IN NUMBER
            , matching_score IN NUMBER
            , university VARCHAR2
            , faculty VARCHAR2
            , studies_modetier VARCHAR2
            , studies_field VARCHAR2
            , studies_specialty VARCHAR2
            , mapped_program_code VARCHAR2
            , mapped_modetier_code VARCHAR2
            , mapped_field_code VARCHAR2
            , semester_number NUMBER
            , expr_semester_number VARCHAR2
            , semester_code VARCHAR2
            , expr_semester_code VARCHAR2
            , ects_mandatory NUMBER
            , expr_ects_mandatory VARCHAR2
            , ects_other NUMBER
            , expr_ects_other VARCHAR2
            , ects_total NUMBER
            , expr_ects_total VARCHAR2
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with (
              other V2u_Ko_Mapped_Specialty_t
            ) RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
