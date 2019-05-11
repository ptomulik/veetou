CREATE OR REPLACE TYPE V2u_Ko_Classes_Map_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , map_id NUMBER(38)
    , matching_score NUMBER(38)
    , highest_score NUMBER(32)
    , selected NUMBER(1)
    , reason VARCHAR2(300)
    , classes_type VARCHAR2(1 CHAR)
    , map_classes_type VARCHAR2(20 CHAR)
    , classes_hours NUMBER(8)
    , map_classes_hours NUMBER(8)
    , map_proto_type VARCHAR2(20 CHAR)
    , subj_code VARCHAR2(32 CHAR)
    , expr_subj_code VARCHAR2(256 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , subj_hours_w NUMBER(8)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , subj_hours_c NUMBER(8)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , subj_hours_l NUMBER(8)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , subj_hours_p NUMBER(8)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , subj_hours_s NUMBER(8)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , subj_ects NUMBER(4)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , subj_tutor VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)
    , university VARCHAR2(8 CHAR)
    , expr_university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , expr_faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , expr_studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(5 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , semester_number NUMBER(2)
    , expr_semester_number VARCHAR2(256 CHAR)
    , ects_mandatory NUMBER(4)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , ects_other NUMBER(4)
    , expr_ects_other VARCHAR2(256 CHAR)
    , ects_total NUMBER(4)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map IN V2u_Classes_Map_t
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
