CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Przcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , reason => reason
            , tried_map_subj_code => tried_map_subj_code
            , istniejace_cdyd_kody => istniejace_cdyd_kody
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            )
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
          , reason => reason
          , tried_map_subj_code => tried_map_subj_code
        );
        SELF.istniejace_cdyd_kody := istniejace_cdyd_kody;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
