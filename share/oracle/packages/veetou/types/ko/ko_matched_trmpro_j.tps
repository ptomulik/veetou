CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpro_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_I_t
    ( subj_grade_date VARCHAR2(10 CHAR)
    , subject_map_id NUMBER(38)
    , classes_map_id NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)
    , nr NUMBER(10)
    , data_zwrotu DATE

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade_date IN VARCHAR2
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade_date IN VARCHAR2
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpros_J_t
    AS TABLE OF V2u_Ko_Matched_Trmpro_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
