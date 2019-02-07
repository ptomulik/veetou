CREATE OR REPLACE TYPE V2u_Ko_Missing_Prgos_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_t
    ( specialty_map_Ids V2u_Ids_t

--    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Prgos_t(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
--            , job_uuid IN RAW
--            , student_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , student_index VARCHAR2
--            , student_name VARCHAR2
--            , first_name VARCHAR2
--            , last_name VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_number IN NUMBER
--            , semester_code IN VARCHAR2
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            , ects_attained IN NUMBER
--            , prgos_ids IN V2u_Dz_Ids_t
--            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Prgos_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_ids IN V2u_Ids_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_ids IN V2u_Ids_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Prgoses_t
    AS TABLE OF V2u_Ko_Missing_Prgos_t;

-- vim: set ft=sql ts=4 sw=4 et:
