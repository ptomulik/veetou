CREATE OR REPLACE TYPE V2u_Ko_Classes_Semester_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_V_t
    ( classes_type VARCHAR2(1 CHAR)
    , classes_hours NUMBER(8)

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
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
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , classes_type VARCHAR2
            , classes_hours NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type VARCHAR2
            , classes_hours NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
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
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , classes_type VARCHAR2
            , classes_hours NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type VARCHAR2
            , classes_hours NUMBER
            )

    , OVERRIDING MEMBER FUNCTION cmp_impl(other IN V2u_Ko_Subject_Semester_V_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_impl(other IN V2u_Ko_Classes_Semester_V_t)
            RETURN INTEGER
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
