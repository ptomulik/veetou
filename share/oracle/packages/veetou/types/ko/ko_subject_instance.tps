CREATE OR REPLACE TYPE V2u_Ko_Subject_Instance_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(32 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR2(256 CHAR)
    , subj_grades V2u_Subj_20Grades_t
    , tr_ids V2u_Ko_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Instance_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Instance_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR2 := NULL
            , subj_name IN VARCHAR2 := NULL
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR2 := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR2 := NULL
            , subj_grades IN V2u_Subj_20Grades_t := NULL
            , tr_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with (
              other V2u_Ko_Subject_Instance_t
            ) RETURN NUMBER

    , MEMBER FUNCTION dup_with(
              new_id IN NUMBER
            , new_subj_grades IN V2u_Subj_20Grades_t := NULL
            , new_tr_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Instance_t

    , MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
            , new_subj_grades IN V2u_Subj_20Grades_t := NULL
            , new_tr_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Instance_t
    );

-- vim: set ft=sql ts=4 sw=4 et:
