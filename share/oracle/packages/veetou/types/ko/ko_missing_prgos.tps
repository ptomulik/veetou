CREATE OR REPLACE TYPE V2u_Ko_Missing_Prgos_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_t
    ( tried_specialty_map_ids V2u_5Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Prgos_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Prgoses_t
    AS TABLE OF V2u_Ko_Missing_Prgos_t;

-- vim: set ft=sql ts=4 sw=4 et:
