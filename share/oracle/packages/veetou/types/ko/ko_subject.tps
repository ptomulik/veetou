CREATE OR REPLACE TYPE V2u_Ko_Subject_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Distinct_t
    ( subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR2(256 CHAR)
    /* , subj_grades V2u_Subj_20Grades_t */
    , tr_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            /* , subj_grades IN V2u_Subj_20Grades_t := NULL */
            , tr_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Ko_Subject_t)
            RETURN INTEGER

    , MEMBER FUNCTION dup(new_tr_ids IN V2u_Ids_t := NULL)
            RETURN V2u_Ko_Subject_t
    );

-- vim: set ft=sql ts=4 sw=4 et:
