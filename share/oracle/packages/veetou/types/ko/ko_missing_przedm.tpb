CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Przedm_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przedm_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
          , subject_map_ids => subject_map_ids
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_ids IN V2u_5Ids_t
            )
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
        );
        SELF.subject_map_ids := subject_map_ids;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
