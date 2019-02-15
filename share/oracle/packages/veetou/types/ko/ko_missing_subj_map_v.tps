CREATE OR REPLACE TYPE V2u_Ko_Missing_Subj_Map_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Subject_Map_B_t
    ( job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Subj_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subj_Map_V_t
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Subj_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subj_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subj_Map_V_t
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subj_Map_V_t
            , id IN NUMBER := NULL
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Subj_Maps_V_t
    AS TABLE OF V2u_Ko_Missing_Subj_Map_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
