CREATE OR REPLACE TYPE V2u_Specialty_Expr_B_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Semester_Expr_B_t
    ( expr_university VARCHAR2(8 CHAR)
    , expr_faculty VARCHAR2(8 CHAR)
    , expr_studies_modetier VARCHAR2(100 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Specialty_Expr_B_t(
              SELF IN OUT NOCOPY V2u_Specialty_Expr_B_t
            , id IN NUMBER := NULL
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
              SELF IN OUT NOCOPY V2u_Specialty_Expr_B_t
            , id IN NUMBER := NULL
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

    , MEMBER FUNCTION cmp_val(other IN V2u_Specialty_Expr_B_t)
        RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
              university IN VARCHAR2
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

    , MEMBER FUNCTION match_university(university IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_faculty(faculty IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2) RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
