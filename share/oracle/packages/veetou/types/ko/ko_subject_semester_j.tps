CREATE OR REPLACE TYPE V2u_Ko_Subject_Semester_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( subj_code VARCHAR2(32 CHAR)
    , map_subj_code VARCHAR2(20 CHAR)
    , semester_code VARCHAR2(6 CHAR)
    , subj_grades V2u_Subj_20Grades_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , semester_code IN VARCHAR2
            , subj_grades IN V2u_Subj_20Grades_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , semester_code IN VARCHAR2
            , subj_grades IN V2u_Subj_20Grades_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Subject_Semesters_J_t
    AS TABLE OF V2u_Ko_Subject_Semester_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
