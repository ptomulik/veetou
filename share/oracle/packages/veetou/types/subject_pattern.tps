CREATE OR REPLACE TYPE V2u_Subject_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_subj_code VARCHAR2(256 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Subject_Pattern_t(
              SELF IN OUT NOCOPY V2u_Subject_Pattern_t
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
            )
        RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Pattern_t
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
            )

    , MEMBER FUNCTION match_attributes(
              subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
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
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
