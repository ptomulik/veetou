CREATE OR REPLACE TYPE V2u_Subject_Map_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( subj_code VARCHAR2(32 CHAR)
    , map_subj_code VARCHAR2(20 CHAR)
    , map_subj_lang VARCHAR2(3 CHAR)
    , map_subj_ects NUMBER(4)
    , map_org_unit VARCHAR2(20 CHAR)
    , map_org_unit_recipient VARCHAR2(20 CHAR)
    , subject_pattern V2u_Subject_Pattern_t
    , specialty_pattern V2u_Specialty_Pattern_t
    , semester_pattern V2u_Semester_Pattern_t

    , CONSTRUCTOR FUNCTION V2u_Subject_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_subj_ects IN NUMBER
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Subject_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subject_map IN V2u_Subject_Map_B_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_subj_ects IN NUMBER
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subject_map IN V2u_Subject_Map_B_t
            )

    , MEMBER FUNCTION match_attributes(
              subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            ) RETURN INTEGER
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
