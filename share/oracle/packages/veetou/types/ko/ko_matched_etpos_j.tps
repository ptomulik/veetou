CREATE OR REPLACE TYPE V2u_Ko_Matched_Etpos_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_J_t
    ( etpos_id NUMBER(10)
    , prgos_id NUMBER(10)
    , specialty_map_id NUMBER(38)
    , etp_kod_missmatch VARCHAR2(32 CHAR)
    , st_id NUMBER(10)
    , os_id NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            , etpos IN V2u_Dz_Etap_Osoby_t
            , prgos IN V2u_Dz_Program_Osoby_t
            , specialty_map IN V2u_Ko_Specialty_Map_J_t
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            , etpos IN V2u_Dz_Etap_Osoby_t
            , prgos IN V2u_Dz_Program_Osoby_t
            , specialty_map IN V2u_Ko_Specialty_Map_J_t
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Etposes_J_t
    AS TABLE OF V2u_Ko_Matched_Etpos_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
