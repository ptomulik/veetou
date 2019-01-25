CREATE OR REPLACE TYPE V2u_Ko_Mapped_Subject_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , subject_instance_id NUMBER(38)
    , subject_mapping_id NUMBER(38)
    , matching_score NUMBER(38)
    , subj_code VARCHAR2(32 CHAR)
    , mapped_subj_code VARCHAR2(20 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , university VARCHAR2(256 CHAR)
    , expr_university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , expr_faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , expr_studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(32 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Subject_t(
              SELF IN OUT NOCOPY V2u_Ko_Mapped_Subject_t
            , job_uuid IN RAW
            , subject_instance_id IN NUMBER
            , subject_mapping_id IN NUMBER
            , matching_score IN NUMBER
            , subj_code IN VARCHAR2 := NULL
            , mapped_subj_code IN VARCHAR2 := NULL
            , subj_name IN VARCHAR2 := NULL
            , expr_subj_name IN VARCHAR2 := NULL
            , university IN VARCHAR2 := NULL
            , expr_university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , expr_faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , expr_studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , expr_studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , expr_studies_specialty IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , expr_semester_code IN VARCHAR2 := NULL
            , subj_hours_w IN NUMBER := NULL
            , expr_subj_hours_w IN VARCHAR2 := NULL
            , subj_hours_c IN NUMBER := NULL
            , expr_subj_hours_c IN VARCHAR2 := NULL
            , subj_hours_l IN NUMBER := NULL
            , expr_subj_hours_l IN VARCHAR2 := NULL
            , subj_hours_p IN NUMBER := NULL
            , expr_subj_hours_p IN VARCHAR2 := NULL
            , subj_hours_s IN NUMBER := NULL
            , expr_subj_hours_s IN VARCHAR2 := NULL
            , subj_credit_kind IN VARCHAR2 := NULL
            , expr_subj_credit_kind IN VARCHAR2 := NULL
            , subj_ects IN NUMBER := NULL
            , expr_subj_ects IN VARCHAR2 := NULL
            , subj_tutor IN VARCHAR2 := NULL
            , expr_subj_tutor IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with (
              other V2u_Ko_Mapped_Subject_t
            ) RETURN NUMBER
    );

-- vim: set ft=sql ts=4 sw=4 et:
