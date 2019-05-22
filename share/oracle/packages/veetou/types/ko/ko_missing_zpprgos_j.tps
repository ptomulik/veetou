CREATE OR REPLACE TYPE V2u_Ko_Missing_Zpprgos_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( student_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , specialty_map_ids V2u_20Ids_t
    , semester_code VARCHAR2(20 CHAR)
    , map_subj_code VARCHAR2(20 CHAR)
    , os_id NUMBER(10)
    , prgos_id NUMBER(10)
    , prgos_ids V2u_Dz_20Ids_t
    , etpos_id NUMBER(10)
    , etpos_ids V2u_Dz_20Ids_t
    , reason VARCHAR2(300 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zpprgos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_ids IN V2u_20Ids_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , prgos_id IN NUMBER
            , prgos_ids IN V2u_Dz_20Ids_t
            , etpos_id IN NUMBER
            , etpos_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_ids IN V2u_20Ids_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , prgos_id IN NUMBER
            , prgos_ids IN V2u_Dz_20Ids_t
            , etpos_id IN NUMBER
            , etpos_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Zpprgoses_J_t
    AS TABLE OF V2u_Ko_Missing_Zpprgos_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
