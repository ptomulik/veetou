CREATE OR REPLACE TYPE V2u_Ko_Matched_Prgos_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_I_t
    ( ects_attained NUMBER(4)
    , specialty_map_id NUMBER(38)
    , prgos_id NUMBER(10)
    , prg_kod VARCHAR2(20 CHAR)
    , st_id NUMBER(10)
    , os_id NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Prgoses_J_t
    AS TABLE OF V2u_Ko_Matched_Prgos_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
