CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Przcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            , tried_map_subj_codes IN V2u_Subj_5Codes_t
            , istniejace_przedmioty_kod IN V2u_Subj_5Codes_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
          , subject_map_ids => subject_map_ids
          , tried_map_subj_codes => tried_map_subj_codes
          , istniejace_przedmioty_kod => istniejace_przedmioty_kod
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            , tried_map_subj_codes IN V2u_Subj_5Codes_t
            , istniejace_przedmioty_kod IN V2u_Subj_5Codes_t
            )
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
          , subject_map_ids => subject_map_ids
          , tried_map_subj_codes => tried_map_subj_codes
        );
        SELF.istniejace_przedmioty_kod := istniejace_przedmioty_kod;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
