CREATE OR REPLACE TYPE V2u_Subject_Map_Base_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Map_Base_t
    ( subj_code VARCHAR2(32 CHAR)
    , map_subj_code VARCHAR2(32 CHAR)
    , map_subj_lang VARCHAR2(3 CHAR)
    , map_org_unit VARCHAR2(20 CHAR)
    , map_org_unit_recipient VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Subject_Map_Base_t(
              SELF IN OUT NOCOPY V2u_Subject_Map_Base_t
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
            )
        RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Map_Base_t
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
            )

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Subject_Map_Base_t)
        RETURN INTEGER

    , OVERRIDING MEMBER FUNCTION match_expr_fields(
              subj_name IN VARCHAR2
            , subj_hours_w IN VARCHAR2
            , subj_hours_c IN VARCHAR2
            , subj_hours_l IN VARCHAR2
            , subj_hours_p IN VARCHAR2
            , subj_hours_s IN VARCHAR2
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN VARCHAR2
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN VARCHAR2
            , ects_mandatory IN VARCHAR2
            , ects_other IN VARCHAR2
            , ects_total IN VARCHAR2
            )
        RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
