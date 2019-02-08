CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedm_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_t
    ( subject_map_Ids V2u_5Ids_t


    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przedm_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedms_t
    AS TABLE OF V2u_Ko_Missing_Przedm_t;

-- vim: set ft=sql ts=4 sw=4 et:
