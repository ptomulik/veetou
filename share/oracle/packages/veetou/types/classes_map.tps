CREATE OR REPLACE TYPE V2u_Classes_Map_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( classes_type VARCHAR2(32 CHAR)
    , map_classes_type VARCHAR2(32 CHAR)
    , expr_subj_code VARCHAR(256 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)
    , expr_university VARCHAR2(8 CHAR)
    , expr_faculty VARCHAR2(8 CHAR)
    , expr_studies_modetier VARCHAR2(100 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , expr_semester_number VARCHAR2(256 CHAR)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , expr_ects_other VARCHAR2(256 CHAR)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Classes_Map_t(
              SELF IN OUT NOCOPY V2u_Classes_Map_t
            , id IN NUMBER := NULL
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , expr_subj_code IN VARCHAR2
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

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Classes_Map_t)
        RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
              subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
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

    , MEMBER FUNCTION match_subj_code(subj_code IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_university(university IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_faculty(faculty IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_semester_number(semester_number IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_mandatory(ects_mandatory IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_other(ects_other IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_total(ects_total IN INTEGER) RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Classes_Maps_t
    AS TABLE OF V2u_Classes_Map_t;

-- vim: set ft=sql ts=4 sw=4 et:
