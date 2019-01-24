CREATE OR REPLACE TYPE V2u_Subject_Mapping_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , subj_code VARCHAR(20 CHAR)
    , mapped_subj_code VARCHAR(20 CHAR)
    , expr_subj_name VARCHAR(256 CHAR)
    , expr_university VARCHAR(256 CHAR)
    , expr_faculty VARCHAR(256 CHAR)
    , expr_studies_modetier VARCHAR(256 CHAR)
    , expr_studies_field VARCHAR(256 CHAR)
    , expr_studies_specialty VARCHAR(256 CHAR)
    , expr_semester_code VARCHAR(256 CHAR)
    , expr_subj_hours_w VARCHAR(256 CHAR)
    , expr_subj_hours_c VARCHAR(256 CHAR)
    , expr_subj_hours_l VARCHAR(256 CHAR)
    , expr_subj_hours_p VARCHAR(256 CHAR)
    , expr_subj_hours_s VARCHAR(256 CHAR)
    , expr_subj_credit_kind VARCHAR(256 CHAR)
    , expr_subj_ects VARCHAR(256 CHAR)
    , expr_subj_tutor VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Subject_Mapping_t(
              SELF IN OUT NOCOPY V2u_Subject_Mapping_t
            , id IN NUMBER
            , subj_code IN VARCHAR := NULL
            , mapped_subj_code IN VARCHAR := NULL
            , expr_subj_name IN VARCHAR := NULL
            , expr_university IN VARCHAR := NULL
            , expr_faculty IN VARCHAR := NULL
            , expr_studies_modetier IN VARCHAR := NULL
            , expr_studies_field IN VARCHAR := NULL
            , expr_studies_specialty IN VARCHAR := NULL
            , expr_semester_code IN VARCHAR := NULL
            , expr_subj_hours_w IN VARCHAR := NULL
            , expr_subj_hours_c IN VARCHAR := NULL
            , expr_subj_hours_l IN VARCHAR := NULL
            , expr_subj_hours_p IN VARCHAR := NULL
            , expr_subj_hours_s IN VARCHAR := NULL
            , expr_subj_credit_kind IN VARCHAR := NULL
            , expr_subj_ects IN VARCHAR := NULL
            , expr_subj_tutor IN VARCHAR := NULL
            )
        RETURN SELF AS RESULT

    , MEMBER FUNCTION match_expr_fields(
              subj_name IN VARCHAR
            , university IN VARCHAR
            , faculty IN VARCHAR
            , studies_modetier IN VARCHAR
            , studies_field IN VARCHAR
            , studies_specialty IN VARCHAR
            , semester_code IN VARCHAR
            , subj_hours_w IN VARCHAR
            , subj_hours_c IN VARCHAR
            , subj_hours_l IN VARCHAR
            , subj_hours_p IN VARCHAR
            , subj_hours_s IN VARCHAR
            , subj_credit_kind IN VARCHAR
            , subj_ects IN VARCHAR
            , subj_tutor IN VARCHAR
            )
        RETURN INTEGER

    , MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_university(university IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_faculty(faculty IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR) RETURN INTEGER

    );
/
CREATE OR REPLACE TYPE V2u_Subject_Mappings_t
    AS TABLE OF V2u_Subject_Mapping_t;

-- vim: set ft=sql ts=4 sw=4 et:
