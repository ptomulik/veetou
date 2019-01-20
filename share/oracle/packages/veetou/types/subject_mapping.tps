CREATE OR REPLACE TYPE Veetou_Subject_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( subj_code VARCHAR(20 CHAR)
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

    , CONSTRUCTOR FUNCTION Veetou_Subject_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Subject_Mapping_Typ
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
              SELF IN Veetou_Subject_Mapping_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_name(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_name IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_university(
              SELF IN Veetou_Subject_Mapping_Typ
            , university IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_faculty(
              SELF IN Veetou_Subject_Mapping_Typ
            , faculty IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_modetier(
              SELF IN Veetou_Subject_Mapping_Typ
            , studies_modetier IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_field(
              SELF IN Veetou_Subject_Mapping_Typ
            , studies_field IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_specialty(
              SELF IN Veetou_Subject_Mapping_Typ
            , studies_specialty IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(
              SELF IN Veetou_Subject_Mapping_Typ
            , semester_code IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_w(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_hours_w IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_c(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_hours_c IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_l(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_hours_l IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_p(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_hours_p IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_s(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_hours_s IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_credit_kind(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_credit_kind IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_ects(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_ects IN INTEGER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_tutor(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_tutor IN VARCHAR
            ) RETURN INTEGER

    );
/
CREATE OR REPLACE TYPE Veetou_Subject_Mappings_Typ
    AS TABLE OF Veetou_Subject_Mapping_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
