CREATE OR REPLACE TYPE V2u_Subject_Expr_B_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Specialty_Expr_B_t
    ( expr_subj_name VARCHAR2(256 CHAR)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Subject_Expr_B_t(
              SELF IN OUT NOCOPY V2u_Subject_Expr_B_t
            , id IN NUMBER := NULL
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
              SELF IN OUT NOCOPY V2u_Subject_Expr_B_t
            , id IN NUMBER := NULL
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

    , MEMBER FUNCTION cmp_val(other IN V2u_Subject_Expr_B_t)
        RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
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

    , MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR2) RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
