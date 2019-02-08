CREATE OR REPLACE TYPE V2u_Ko_Missing_Etpos_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Missing_Prgos_t
    ( prgos_ids_all_semesters V2u_Dz_5Ids_t
    , all_etpos_ids_for_semester V2u_Dz_5Ids_t
    , tried_program_codes V2u_Program_5Codes_t
    , all_etpos_progs_for_semester V2u_Program_5Codes_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            , prgos_ids_all_semesters IN V2u_Dz_5Ids_t
            , all_etpos_ids_for_semester IN V2u_Dz_5Ids_t
            , tried_program_codes IN V2u_Program_5Codes_t
            , all_etpos_progs_for_semester IN V2u_Program_5Codes_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            , prgos_ids_all_semesters IN V2u_Dz_5Ids_t
            , all_etpos_ids_for_semester IN V2u_Dz_5Ids_t
            , tried_program_codes IN V2u_Program_5Codes_t
            , all_etpos_progs_for_semester IN V2u_Program_5Codes_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Etposes_t
    AS TABLE OF V2u_Ko_Missing_Etpos_t;

-- vim: set ft=sql ts=4 sw=4 et:
