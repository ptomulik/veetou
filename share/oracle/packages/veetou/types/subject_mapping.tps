CREATE OR REPLACE TYPE V2u_Subject_Mapping_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , subj_code VARCHAR2(32 CHAR)
    , mapped_subj_code VARCHAR2(32 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , expr_university VARCHAR2(256 CHAR)
    , expr_faculty VARCHAR2(256 CHAR)
    , expr_studies_modetier VARCHAR2(256 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Subject_Mapping_t(
              SELF IN OUT NOCOPY V2u_Subject_Mapping_t
            , id IN NUMBER
            , subj_code IN VARCHAR2 := NULL
            , mapped_subj_code IN VARCHAR2 := NULL
            , expr_subj_name IN VARCHAR2 := NULL
            , expr_university IN VARCHAR2 := NULL
            , expr_faculty IN VARCHAR2 := NULL
            , expr_studies_modetier IN VARCHAR2 := NULL
            , expr_studies_field IN VARCHAR2 := NULL
            , expr_studies_specialty IN VARCHAR2 := NULL
            , expr_semester_code IN VARCHAR2 := NULL
            , expr_subj_hours_w IN VARCHAR2 := NULL
            , expr_subj_hours_c IN VARCHAR2 := NULL
            , expr_subj_hours_l IN VARCHAR2 := NULL
            , expr_subj_hours_p IN VARCHAR2 := NULL
            , expr_subj_hours_s IN VARCHAR2 := NULL
            , expr_subj_credit_kind IN VARCHAR2 := NULL
            , expr_subj_ects IN VARCHAR2 := NULL
            , expr_subj_tutor IN VARCHAR2 := NULL
            )
        RETURN SELF AS RESULT

    , MEMBER FUNCTION match_expr_fields(
              subj_name IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , subj_hours_w IN VARCHAR2
            , subj_hours_c IN VARCHAR2
            , subj_hours_l IN VARCHAR2
            , subj_hours_p IN VARCHAR2
            , subj_hours_s IN VARCHAR2
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN VARCHAR2
            , subj_tutor IN VARCHAR2
            )
        RETURN INTEGER

    , MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_university(university IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_faculty(faculty IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR2) RETURN INTEGER

    );
/
CREATE OR REPLACE TYPE V2u_Subject_Mappings_t
    AS TABLE OF V2u_Subject_Mapping_t;

-- vim: set ft=sql ts=4 sw=4 et:
