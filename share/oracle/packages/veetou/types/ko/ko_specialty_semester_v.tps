CREATE OR REPLACE TYPE V2u_Ko_Specialty_Semester_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , semester_number NUMBER(2)
    , semester_code VARCHAR2(5 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    )
NOT FINAL
;
/
CREATE OR REPLACE TYPE V2u_Ko_Specialty_Semesters_V_t
    AS TABLE OF V2u_Ko_Specialty_Semester_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
