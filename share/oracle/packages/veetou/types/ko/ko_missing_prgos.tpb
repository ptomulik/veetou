CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Prgos_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Prgos_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
          , tried_specialty_map_ids => tried_specialty_map_ids
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Prgos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , tried_specialty_map_ids IN V2u_5Ids_t
            )
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
        );
        SELF.tried_specialty_map_ids := tried_specialty_map_ids;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
