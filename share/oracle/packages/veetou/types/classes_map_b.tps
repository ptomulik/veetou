CREATE OR REPLACE TYPE V2u_Classes_Map_B_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( classes_type VARCHAR2(1 CHAR)
    , map_classes_type VARCHAR2(20 CHAR)
    , map_classes_hours NUMBER(8)
    , map_proto_type VARCHAR2(20 CHAR)
    , expr_subj_code VARCHAR2(256 CHAR)
    , expr_subj_name VARCHAR2(256 CHAR)
    , expr_subj_hours_w VARCHAR2(256 CHAR)
    , expr_subj_hours_c VARCHAR2(256 CHAR)
    , expr_subj_hours_l VARCHAR2(256 CHAR)
    , expr_subj_hours_p VARCHAR2(256 CHAR)
    , expr_subj_hours_s VARCHAR2(256 CHAR)
    , expr_subj_credit_kind VARCHAR2(256 CHAR)
    , expr_subj_ects VARCHAR2(256 CHAR)
    , expr_subj_tutor VARCHAR2(256 CHAR)
    , expr_university VARCHAR2(256 CHAR)
    , expr_faculty VARCHAR2(256 CHAR)
    , expr_studies_modetier VARCHAR2(256 CHAR)
    , expr_studies_field VARCHAR2(256 CHAR)
    , expr_studies_specialty VARCHAR2(256 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , expr_semester_number VARCHAR2(256 CHAR)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , expr_ects_other VARCHAR2(256 CHAR)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Classes_Map_B_t(
              SELF IN OUT NOCOPY V2u_Classes_Map_B_t
            , id IN NUMBER := NULL
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , map_classes_hours IN NUMBER
            , map_proto_type IN VARCHAR2
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
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Map_B_t
            , id IN NUMBER := NULL
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , map_classes_hours IN NUMBER
            , map_proto_type IN VARCHAR2
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

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Classes_Map_B_t)
        RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
