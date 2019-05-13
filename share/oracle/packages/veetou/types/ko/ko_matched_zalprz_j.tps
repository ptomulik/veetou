CREATE OR REPLACE TYPE V2u_Ko_Matched_Zalprz_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( student_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , st_id NUMBER(10)
    , os_id NUMBER(10)
    , cdyd_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zalprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zalprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , st_id IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zalprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , st_id IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Zalprzes_J_t
    AS TABLE OF V2u_Ko_Matched_Zalprz_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
