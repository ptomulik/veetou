CREATE OR REPLACE TYPE V2u_Ko_Missing_Zalprz_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( student_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , semester_code VARCHAR2(20 CHAR)
    , map_subj_code VARCHAR2(20 CHAR)
    , os_id NUMBER(10)
    , reason VARCHAR2(300 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zalprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zalprz_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zalprz_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Zalprzes_J_t
    AS TABLE OF V2u_Ko_Missing_Zalprz_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
