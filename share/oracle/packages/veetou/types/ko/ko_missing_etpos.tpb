CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Etpos_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_t(
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
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
          , tried_specialty_map_ids => tried_specialty_map_ids
          , prgos_ids_all_semesters => prgos_ids_all_semesters
          , all_etpos_ids_for_semester => all_etpos_ids_for_semester
          , tried_program_codes => tried_program_codes
          , all_etpos_progs_for_semester => all_etpos_progs_for_semester
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
          , tried_specialty_map_ids => tried_specialty_map_ids
        );
        SELF.prgos_ids_all_semesters := prgos_ids_all_semesters;
        SELF.all_etpos_ids_for_semester := all_etpos_ids_for_semester;
        SELF.tried_program_codes := tried_program_codes;
        SELF.all_etpos_progs_for_semester := all_etpos_progs_for_semester;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
